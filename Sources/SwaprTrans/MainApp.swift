import SwiftUI
import AppKit
import SwaprTransKit

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    private var statusController: StatusItemController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Run as an accessory app: no Dock icon, stays in the menu bar
        NSApp.setActivationPolicy(.accessory)
        ProcessInfo.processInfo.disableAutomaticTermination("SwaprTrans MenuBar Daemon")
        ProcessInfo.processInfo.disableSuddenTermination()
        statusController = StatusItemController()
    }
}

@main
struct SwaprTransMain {
    static func main() {
        let app = NSApplication.shared
        let delegate = AppDelegate()
        app.delegate = delegate
        app.run()
    }
}
