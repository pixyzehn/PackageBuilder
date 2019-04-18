# PackageBuilder
[![SPM](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://github.com/apple/swift-package-manager)
[![Build Status](https://travis-ci.org/pixyzehn/PackageBuilder.svg?branch=master)](https://travis-ci.org/pixyzehn/PackageBuilder)

PackageBuilder builds a simple command-line structure by SwiftPM. Inspired by [JohnSundell/SwiftPlate](https://github.com/JohnSundell/SwiftPlate).  
PackageBuilder originally created by using PackageBuilder.  
See also [Building a command line tool using the Swift Package Manager](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager).

```console
$ packagebuilder

PackageBuilder
--------------
PackageBuilder builds a simple command-line structure by SwiftPM.
.
├── LICENSE
├── Package.swift
├── README.md
├── Makefile
├── {PACKAGE_NAME}.xcodeproj
├── Sources
│   ├── {PACKAGE_NAME}
│   │   └── main.swift
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

## Requirements

PackageBuilder requires / supports the following environments:

- Git

## Installation

On macOS

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

### [Mint](https://github.com/yonaskolb/mint)
```console
$ mint run pixyzehn/PackageBuilder
```

On Linux

```console
$ git clone git@github.com:pixyzehn/PackageBuilder.git && cd PackageBuilder
$ swift build -c release
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

## License
[MIT License](https://github.com/pixyzehn/PackageBuilder/blob/master/LICENSE)
