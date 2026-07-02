// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "FlybyNighter",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "FlybyNighterCore",
            targets: ["FlybyNighterCore"]
        ),
        .library(
            name: "FlybyNighterSpriteKit",
            targets: ["FlybyNighterSpriteKit"]
        ),
        .executable(
            name: "FlybyNighterMac",
            targets: ["FlybyNighterMac"]
        ),
        .executable(
            name: "FlybyNighterApp",
            targets: ["FlybyNighterApp"]
        )
    ],
    targets: [
        .target(
            name: "FlybyNighterCore"
        ),
        .target(
            name: "FlybyNighterSpriteKit",
            dependencies: ["FlybyNighterCore"]
        ),
        .executableTarget(
            name: "FlybyNighterMac",
            dependencies: [
                "FlybyNighterCore",
                "FlybyNighterSpriteKit"
            ]
        ),
        .executableTarget(
            name: "FlybyNighterApp",
            dependencies: [
                "FlybyNighterSpriteKit"
            ]
        ),
        .testTarget(
            name: "FlybyNighterCoreTests",
            dependencies: ["FlybyNighterCore"]
        )
    ]
)
