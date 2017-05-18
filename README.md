# PackageBuilder
PackageBuilder builds a simple command-line application by SwiftPM. Inspired by https://github.com/JohnSundell/SwiftPlate

```console
$ packagebuilder

PackageBuilder
--------------
PackageBuilder builds a simple command-line structure by SwiftPM.
.
├── {PROJECT_NAME}.xcodeproj
├── Package.swift
├── Sources
│   ├── {PROJECT_NAME}
│   │  └── main.swift
│   └── {PROJECT_NAME}Core
│       └── {PROJECT_NAME}.swift
└── Tests
     └── {PROJECT_NAME}Tests
         └── {PROJECT_NAME}Tests.swift
--------------
Based on https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager
Examples:
$ packagebuilder {PROJECT_NAME}
```

## Installation

### Makefile

```console
$ git clone git@github.com:pixyzehn/PackageBuilder.git
$ cd PackageBuilder
$ make
```

### SwiftPM

```console
$ git clone git@github.com:pixyzehn/PackageBuilder.git
$ swift build
$ ./.build/debug/PackageBuilder
```

## Usage

```console
$ packagebuilder {PROJECT_NAME}
```

## Contributing

1. Fork it ( https://github.com/pixyzehn/PackageBuilder )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request

