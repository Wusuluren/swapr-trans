import SwiftUI
import AppKit
import SwaprTransKit

struct StandaloneMenuBarPopup: View {
    @ObservedObject var config = SwaprTransConfig.shared

    var body: some View {
        VStack(spacing: 12) {
            // Header
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "translate")
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
