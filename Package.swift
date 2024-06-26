// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Solo Leveling",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Solo Leveling",
            targets: ["AppModule"],
            bundleIdentifier: "com.imagine.sololeveling",
            teamIdentifier: "A642FFR346",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .incomingNetworkConnections(),
                .outgoingNetworkConnections()
            ],
            appCategory: .healthcareFitness
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "."
        )
    ]
)