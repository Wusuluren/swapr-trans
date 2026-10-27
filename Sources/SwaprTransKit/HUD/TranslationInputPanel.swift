import SwiftUI
import AppKit

/// Key-capable panel: unlike the HUD it must accept keyboard input, but still
/// avoids activating the app so the previous frontmost app keeps its state.
final class InputKeyPanel: NSPanel {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }
}

@MainActor
final class InputPanelModel: ObservableObject {
    @Published var text: String = ""
    @Published var hint: String? = nil
    var onSubmit: ((String) -> Void)?
}

struct TranslationInputView: View {
    @ObservedObject var model: InputPanelModel

    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "text.magnifyingglass")
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)

                TextField("输入要翻译的文字…", text: $model.text)
                    .textFieldStyle(.plain)
                    .font(.system(size: 14))
                    .onSubmit {
                        let trimmed = model.text.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !trimmed.isEmpty {
                            model.onSubmit?(trimmed)
                        }
                    }
            }

            HStack {
                Text(model.hint ?? "")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
                Spacer()
                Text("⏎ 翻译 · ⎋ 关闭")
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
        }
        .padding(14)
        .frame(width: 380)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.ultraThinMaterial)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color.primary.opacity(0.12), lineWidth: 1)
        )
    }
}

/// Spotlight-style manual input window: hotkey -> type text -> Enter -> HUD shows translation
@MainActor
public final class TranslationInputPanelController: NSObject, NSWindowDelegate {
    public static let shared = TranslationInputPanelController()

    private var panel: InputKeyPanel?
    private let model = InputPanelModel()
    private var escMonitor: Any?
    private var frontPid: pid_t = 0

    private override init() {
        super.init()
        model.onSubmit = { [weak self] text in
            self?.submit(text: text)
        }
    }

    public func toggle(frontPid: pid_t) {
        if let p = panel, p.isVisible {
            hide()
        } else {
            show(frontPid: frontPid)
        }
    }

    public func show(frontPid: pid_t) {
        self.frontPid = frontPid
        TranslateMonitor.isHudVisible = false
        TranslationHudController.shared.hide()

        if panel == nil {
            let p = InputKeyPanel(
                contentRect: NSRect(x: 0, y: 0, width: 380, height: 90),
                styleMask: [.nonactivatingPanel, .fullSizeContentView, .titled, .closable],
                backing: .buffered,
                defer: false
            )
            p.titlebarAppearsTransparent = true
            p.titleVisibility = .hidden
            p.isOpaque = false
            p.backgroundColor = .clear
            p.hasShadow = true
            p.level = .floating
            p.hidesOnDeactivate = false
            p.isMovableByWindowBackground = true
            p.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            p.delegate = self
            p.contentView = NSHostingView(rootView: TranslationInputView(model: model))
            self.panel = p
        }

        // Center horizontally, upper third of the screen (Spotlight habit)
        if let p = panel, let screen = NSScreen.main {
            let f = p.frame
            let x = screen.frame.midX - f.width / 2
            let y = screen.frame.minY + screen.frame.height * 0.62
            p.setFrameOrigin(NSPoint(x: x, y: y))
        }

        TranslateMonitor.isInputPanelActive = true
        panel?.makeKeyAndOrderFront(nil)

        // Grab first text field inside the SwiftUI hosting view so typing starts immediately
        DispatchQueue.main.async { [weak self] in
            guard let self = self, let p = self.panel else { return }
            if let tf = Self.firstTextField(in: p.contentView) {
                p.makeFirstResponder(tf)
            }
        }

        if escMonitor == nil {
            escMonitor = NSEvent.addLocalMonitorForEvents(matching: .keyDown) { [weak self] event in
                if event.keyCode == 53 { // Esc
                    self?.hide()
                    return nil
                }
                return event
            }
        }
    }

    public func hide() {
        panel?.orderOut(nil)
        TranslateMonitor.isInputPanelActive = false
        if let m = escMonitor {
            NSEvent.removeMonitor(m)
            escMonitor = nil
        }
    }

    private func submit(text: String) {
        hide()
        TranslateMonitor.shared.triggerDirectTranslation(text: text, frontPid: frontPid)
    }

    // Close when the user clicks away, mirroring Spotlight behavior
    public func windowDidResignKey(_ notification: Notification) {
        hide()
    }

    private static func firstTextField(in view: NSView?) -> NSView? {
        guard let view = view else { return nil }
        for sub in view.subviews {
            if sub is NSTextField || sub is NSTextView {
                return sub
            }
            if let found = firstTextField(in: sub) {
                return found
            }
        }
        return nil
    }
}
