// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MauriUtils",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MauriUtils",
            targets: ["MauriUtils"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "MauriUtils"),
        .testTarget(
            name: "MauriUtilsTests",
            dependencies: ["MauriUtils"],
            resources: [
                // Process file in Sources/Tests/MauriUtilsTests/Resources/*
                .process("Resources")
            ]
        )
    ]
)
