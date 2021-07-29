// swift-tools-version:5.3
// Copyright © 2021 Brian Drelling. All rights reserved.

import PackageDescription

let package = Package(
    name: "DiceKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "DiceKit", targets: ["DiceKit"]),
        .library(name: "YachtKit", targets: ["YachtKit"]),
    ],
    dependencies: [],
    targets: [
        // Targets
        .target(
            name: "DiceKit",
            dependencies: []
        ),
        .target(
            name: "YachtKit",
            dependencies: [
                .target(name: "DiceKit"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "DiceKitTests",
            dependencies: [
                .target(name: "DiceKit"),
            ]
        ),
        .testTarget(
            name: "YachtKitTests",
            dependencies: [
                .target(name: "YachtKit"),
            ]
        ),
    ]
)
