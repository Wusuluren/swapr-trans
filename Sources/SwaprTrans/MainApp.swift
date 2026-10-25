import SwiftUI
import AppKit
import SwaprTransKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Run as an accessory app: no Dock icon, stays in the menu bar
        NSApp.setActivationPolicy(.accessory)
    }
}

@main
struct SwaprTransApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var config = SwaprTransConfig.shared

    var body: some Scene {
        MenuBarExtra {
            StandaloneMenuBarPopup()
        } label: {
            if config.isEnabled && config.hasAccessibilityPermission {
                Image(systemName: "character.book.closed.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(Color.white, Color.cyan)
            } else {
                Image(systemName: "character.book.closed")
            }
        }
        .menuBarExtraStyle(.window)
    }
}
