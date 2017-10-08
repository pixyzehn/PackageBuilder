// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "{PACKAGE_NAME}",
    dependencies: [],
    targets: [
        .target(
            name: "{PACKAGE_NAME}",
            dependencies: ["{PACKAGE_NAME}Core"]),
        .target(
            name: "{PACKAGE_NAME}Core",
            dependencies: []),
        .testTarget(
            name: "{PACKAGE_NAME}Tests",
            dependencies: ["{PACKAGE_NAME}Core"])
    ]
)
