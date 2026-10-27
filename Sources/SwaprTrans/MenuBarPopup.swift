import SwiftUI
import AppKit
import Combine
import SwaprTransKit

/// "translate" requires SF Symbols 4 (macOS 14+); use "textformat.abc" on older systems
enum AppIconSymbol {
    static var name: String {
        if #available(macOS 14.0, *) { return "translate" }
        return "textformat.abc"
    }
}

struct StandaloneMenuBarPopup: View {
    @ObservedObject var config = SwaprTransConfig.shared

    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: AppIconSymbol.name)
                        .foregroundColor(.accentColor)
                        .font(.system(size: 14, weight: .bold))
                    Text("SwaprTrans")
                        .font(.system(size: 13, weight: .bold))
                }

                Spacer()

                Circle()
                    .fill(config.isEnabled && config.hasAccessibilityPermission ? Color.green : Color.secondary.opacity(0.5))
                    .frame(width: 8, height: 8)
                Text(config.isEnabled && config.hasAccessibilityPermission ? "Active" : "Idle")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }

            // Accessibility permission banner if not granted
            if !config.hasAccessibilityPermission {
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                        .font(.system(size: 13))

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Accessibility Permission Needed")
                            .font(.system(size: 11, weight: .semibold))
                        Text("Required to detect selected text across apps and perform in-place text overwrite.")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button("Grant") {
                        config.requestPermission()
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.mini)
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.orange.opacity(0.12))
                )
            }

            // Core Translation Settings Card
            SwaprTransSettingsView()

            Divider()
                .opacity(0.5)

            // Bottom action row
            HStack {
                Button(action: {
                    if let url = URL(string: "https://gitee.com/linrol/swapr-trans") {
                        NSWorkspace.shared.open(url)
                    }
                }) {
                    Text("GitHub / Gitee")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                .buttonStyle(.plain)

                Spacer()

                Button("输入翻译") {
                    NotificationCenter.default.post(name: .swaprOpenInputPanel, object: nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 11))
                .foregroundColor(.secondary)

                Spacer()

                Button("Quit") {
                    NSApp.terminate(nil)
                }
                .buttonStyle(.plain)
                .font(.system(size: 11))
                .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 320)
        .onAppear {
            config.checkPermission()
        }
    }
}

/// Posted by the popup footer so StatusItemController can close the popover before opening the panel
extension Notification.Name {
    static let swaprOpenInputPanel = Notification.Name("SwaprOpenInputPanel")
}

/// Menu bar status item + popover, replacing MenuBarExtra (macOS 13+) so the app runs on macOS 12
@MainActor
final class StatusItemController: NSObject, NSPopoverDelegate {
    private var statusItem: NSStatusItem!
    private let popover = NSPopover()
    /// Invisible anchor window: required for popover positioning when the status button has no own window
    private var anchorWindow: NSWindow?
    private var cancellables: [Cancellable] = []
    private var eventMonitor: Any?

    override init() {
        super.init()

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let img = StatusItemController.makeIcon() {
            statusItem.button?.image = img
            statusItem.button?.image?.isTemplate = true
        } else {
            statusItem.button?.title = "文A" // last-resort text icon so the item is never invisible
        }
        statusItem.button?.target = self
        statusItem.button?.action = #selector(togglePopover)

        popover.contentSize = NSSize(width: 320, height: 360)
        popover.behavior = .transient
        popover.delegate = self
        popover.contentViewController = NSHostingController(rootView: StandaloneMenuBarPopup())

        // Reflect Active/Idle state on the menu bar icon
        let config = SwaprTransConfig.shared
        cancellables = [
            config.$isEnabled.sink { [weak self] _ in self?.refreshIcon() },
            config.$hasAccessibilityPermission.sink { [weak self] _ in self?.refreshIcon() }
        ]

        NotificationCenter.default.addObserver(forName: .swaprOpenInputPanel, object: nil, queue: .main) { _ in
            Task { @MainActor in
                self.closePopover()
                TranslationInputPanelController.shared.toggle(frontPid: 0)
            }
        }
    }

    private func refreshIcon() {
        if let img = StatusItemController.makeIcon() {
            statusItem.button?.image = img
            statusItem.button?.image?.isTemplate = true
            statusItem.button?.title = ""
        }
    }

    private static func makeIcon() -> NSImage? {
        if #available(macOS 11.0, *) {
            // "translate" only exists in SF Symbols 4+ (macOS 14); fall back progressively
            for name in ["translate", "textformat.abc", "globe"] {
                if let img = NSImage(systemSymbolName: name, accessibilityDescription: "SwaprTrans") {
                    return img
                }
            }
        }
        return nil
    }

    @objc private func togglePopover() {
        if popover.isShown {
            closePopover()
            return
        }
        guard let button = statusItem.button else { return }

        // Align an invisible borderless window with the status button so the
        // popover has a valid positioning window in accessory (no-Dock) apps
        if let buttonFrame = button.window?.convertToScreen(button.convert(button.bounds, to: nil)) {
            let win = anchorWindow ?? NSWindow(
                contentRect: .zero,
                styleMask: [.borderless],
                backing: .buffered,
                defer: false
            )
            win.contentView = NSView(frame: .zero)
            win.alphaValue = 0
            win.ignoresMouseEvents = true
            win.isExcludedFromWindowsMenu = true
            win.setFrame(NSRect(origin: buttonFrame.origin, size: NSSize(width: 1, height: buttonFrame.height)), display: false)
            win.orderFrontRegardless()
            anchorWindow = win
            popover.show(relativeTo: win.contentView!.bounds, of: win.contentView!, preferredEdge: .minY)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }

        // Keep popover clickable while the app stays in the background
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] _ in
            self?.closePopover()
        }
        popover.contentViewController?.view.window?.makeKey()
    }

    private func closePopover() {
        popover.performClose(nil)
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }
        anchorWindow?.orderOut(nil)
    }

    func popoverDidClose(_ notification: Notification) {
        closePopover()
    }
}
