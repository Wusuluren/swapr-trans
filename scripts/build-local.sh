#!/usr/bin/env bash
# 本机直接编译脚本：绕过 SwiftPM（本机 CLT 的 PackageDescription 模块损坏），
# 用 swiftc 一把编译 SwaprTransKit + SwaprTrans 全部源码并打包成 .app。
# 适用于 macOS 12 (Monterey) + Command Line Tools 13.x / Swift 5.7 工具链。
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

VERSION="${1:-1.0.0}"
VERSION="${VERSION#v}"
BUILD_NUMBER="${2:-1}"

ARCH="$(uname -m)"
TARGET="${ARCH}-apple-macos12.0"

BUILD_DIR="$ROOT/.build/direct"
APP="$BUILD_DIR/SwaprTrans.app"
CONTENTS="$APP/Contents"
MACOS="$CONTENTS/MacOS"
RESOURCES="$CONTENTS/Resources"

echo "=========================================="
echo "  🔨 Building SwaprTrans.app (v${VERSION}) for ${TARGET}"
echo "=========================================="

rm -rf "$APP"
mkdir -p "$MACOS" "$RESOURCES"
mkdir -p "$BUILD_DIR/modules"

SDK="$(xcrun --show-sdk-path)"
FRAMEWORKS=(-framework AppKit -framework SwiftUI -framework CoreGraphics -framework ApplicationServices -framework AVFoundation -framework Combine -framework Foundation)

KIT_SOURCES=$(find "$ROOT/Sources/SwaprTransKit" -name '*.swift' | sort)
APP_SOURCES=$(find "$ROOT/Sources/SwaprTrans" -name '*.swift' | sort)

# 1. SwaprTransKit 编译为独立模块（静态库 + swiftmodule）
echo "--> Compiling SwaprTransKit module..."
# shellcheck disable=SC2086
swiftc \
  -target "$TARGET" \
  -sdk "$SDK" \
  -O \
  -module-name SwaprTransKit \
  -emit-library -static \
  -emit-module -emit-module-path "$BUILD_DIR/modules/SwaprTransKit.swiftmodule" \
  "${FRAMEWORKS[@]}" \
  -o "$BUILD_DIR/modules/libSwaprTransKit.a" \
  $KIT_SOURCES

# 2. 可执行目标编译并链接
echo "--> Linking SwaprTrans executable..."
# shellcheck disable=SC2086
swiftc \
  -target "$TARGET" \
  -sdk "$SDK" \
  -O \
  -parse-as-library \
  -I "$BUILD_DIR/modules" \
  "${FRAMEWORKS[@]}" \
  -L "$BUILD_DIR/modules" -lSwaprTransKit \
  -o "$MACOS/SwaprTrans" \
  $APP_SOURCES

if [ -f "$ROOT/assets/AppIcon.icns" ]; then
  cp -f "$ROOT/assets/AppIcon.icns" "$RESOURCES/AppIcon.icns"
fi

GIT_COMMIT=$(git rev-parse --short HEAD 2>/dev/null || echo "dev")
GIT_DATE=$(git log -1 --format="%cd" --date=short 2>/dev/null || echo "")

cat <<INFOEOF > "$CONTENTS/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>SwaprTrans</string>
    <key>CFBundleIdentifier</key>
    <string>com.linrol.SwaprTrans</string>
    <key>CFBundleName</key>
    <string>SwaprTrans</string>
    <key>CFBundleDisplayName</key>
    <string>SwaprTrans</string>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>${VERSION}</string>
    <key>CFBundleVersion</key>
    <string>${BUILD_NUMBER}</string>
    <key>GitCommit</key>
    <string>${GIT_COMMIT}</string>
    <key>GitCommitDate</key>
    <string>${GIT_DATE}</string>
    <key>LSMinimumSystemVersion</key>
    <string>12.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>NSSupportsAutomaticTermination</key>
    <false/>
    <key>NSSupportsSuddenTermination</key>
    <false/>
</dict>
</plist>
INFOEOF

xattr -cr "$APP"
codesign --force --deep --sign - "$APP" 2>/dev/null || true
xattr -cr "$APP"

echo "✅ Successfully built: $APP"
