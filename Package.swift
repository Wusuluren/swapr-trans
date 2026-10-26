// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SwaprTrans",
    platforms: [
        .macOS("12.0")
    ],
    products: [
        .library(
            name: "SwaprTransKit",
            targets: ["SwaprTransKit"]
        ),
        .executable(
            name: "SwaprTrans",
            targets: ["SwaprTrans"]
        )
    ],
    targets: [
        .target(
            name: "SwaprTransKit",
            path: "Sources/SwaprTransKit",
            linkerSettings: [
                .linkedFramework("CoreGraphics"),
                .linkedFramework("AppKit"),
                .linkedFramework("ApplicationServices"),
                .linkedFramework("AVFoundation")
            ]
        ),
        .executableTarget(
            name: "SwaprTrans",
            dependencies: [
                "SwaprTransKit"
            ],
            path: "Sources/SwaprTrans"
        )
    ]
)
