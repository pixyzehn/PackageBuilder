/**
 *  PackageBuilder
 *  Copyright (c) Hiroki Nagasawa 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "PackageBuilder",
    targets: [
        Target(
            name: "PackageBuilder",
            dependencies: ["PackageBuilderCore"]
        ),
        Target(name: "PackageBuilderCore")
    ],
    dependencies: [
        .Package(url: "https://github.com/JohnSundell/Files.git", majorVersion: 1),
        .Package(url: "https://github.com/JohnSundell/ShellOut.git", majorVersion: 1),
    ]
)
