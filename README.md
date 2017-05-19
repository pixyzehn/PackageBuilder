# PackageBuilder
[![Swift 3.1](https://img.shields.io/badge/swift-3.1-orange.svg?style=flat)](#)
[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager)

PackageBuilder builds a simple command-line structure by SwiftPM. Inspired by [JohnSundell/SwiftPlate](https://github.com/JohnSundell/SwiftPlate).  
See also [Building a command line tool using the Swift Package Manager](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager).

```console
$ packagebuilder

PackageBuilder
--------------
PackageBuilder builds a simple command-line structure by SwiftPM.
.
├── {PACKAGE_NAME}.xcodeproj
├── Package.swift
├── Sources
│   ├── {PACKAGE_NAME}
│   │   └── main.swift
│   └── {PACKAGE_NAME}Core
│       └── {PACKAGE_NAME}.swift
└── Tests
     ├── {PACKAGE_NAME}Tests
     │   └── {PACKAGE_NAME}Tests.swift
     └── LinuxMain.swift
--------------
Examples:
- packagebuilder {PACKAGE_NAME}
- packagebuilder {PACKAGE_NAME} --path ~/Developer
```

## Installation

### Makefile

```console
$ git clone git@github.com:pixyzehn/PackageBuilder.git && cd PackageBuilder
$ make
```

### SwiftPM

```console
$ git clone git@github.com:pixyzehn/PackageBuilder.git && cd PackageBuilder
$ swift build -c release -Xswiftc -static-stdlib
$ cp -f .build/release/PackageBuilder /usr/local/bin/PackageBuilder
```

## Usage

```console
$ packagebuilder {PACKAGE_NAME}
$ packagebuilder {PACKAGE_NAME} --path ~/Developer/project
```

## Contributing

1. Fork it ( https://github.com/pixyzehn/PackageBuilder )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request
