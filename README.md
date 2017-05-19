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
├── {PROJECT_NAME}.xcodeproj
├── Package.swift
├── Sources
│   ├── {PROJECT_NAME}
│   │   └── main.swift
│   └── {PROJECT_NAME}Core
│       └── {PROJECT_NAME}.swift
└── Tests
     └── {PROJECT_NAME}Tests
         └── {PROJECT_NAME}Tests.swift
--------------
Examples:
$ packagebuilder {PROJECT_NAME}
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
$ packagebuilder {PROJECT_NAME}
$ packagebuilder {PROJECT_NAME} --path ~/Developer/project
```

## Contributing

1. Fork it ( https://github.com/pixyzehn/PackageBuilder )
2. Create your feature branch (`git checkout -b new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin new-feature`)
5. Create a new Pull Request
