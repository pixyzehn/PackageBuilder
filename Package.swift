// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "PackageBuilder",
    dependencies: [
        .package(url: "https://github.com/JohnSundell/Files.git", from: "3.1.0"),
        .package(url: "https://github.com/JohnSundell/ShellOut.git", .branch("master"))
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
