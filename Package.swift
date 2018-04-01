// swift-tools-version:4.1

import PackageDescription

let package = Package(
    name: "PackageBuilder",
    dependencies: [
        .package(url: "https://github.com/pixyzehn/Files.git", from: "1.14.0"),
        .package(url: "https://github.com/pixyzehn/ShellOut.git", from: "1.4.0")
    ],
    targets: [
        .target(
            name: "PackageBuilder",
            dependencies: ["PackageBuilderCore"]),
        .target(
            name: "PackageBuilderCore",
            dependencies: ["Files", "ShellOut"]),
        .testTarget(
            name: "PackageBuilderTests",
            dependencies: ["PackageBuilderCore"])
    ]
)
