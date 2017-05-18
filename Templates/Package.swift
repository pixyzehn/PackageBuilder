import PackageDescription

let package = Package(
    name: "{PROJECT_NAME}",
    targets: [
        Target(
            name: "{PROJECT_NAME}",
            dependencies: ["{PROJECT_NAME}Core"]
        ),
        Target(name: "{PROJECT_NAME}Core")
    ]
)
