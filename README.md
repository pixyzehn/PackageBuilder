# PackageBuilder
PackageBuilder builds a simple command-line application by SwiftPM. Inspired by https://github.com/JohnSundell/SwiftPlate

```console
$ packagebuilder
Welcome to the PackageBuilder that builds a command line tool using the Swift Package Manager
.
├── {PROJECT_NAME}.xcodeproj
├── Package.swift
├── Sources
│   ├── {PROJECT_NAME}
│   │   └── main.swift
│   └── {PROJECT_NAME}Core
│       └── {PROJECT_NAME}.swift
└── Tests
     └── {PROJECT_NAME}Tests
         └── {PROJECT_NAME}Tests.swift
Based on https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager
Please add your command line tool name. ex. `PackageBuilder {PROJECT_NAME}`
```
