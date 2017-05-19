/**
 *  {PACKAGE_NAME}
 *  Copyright (c) {YOUR_NAME} {THIS_YEAR}
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageDescription

let package = Package(
    name: "{PACKAGE_NAME}",
    targets: [
        Target(
            name: "{PACKAGE_NAME}",
            dependencies: ["{PACKAGE_NAME}Core"]
        ),
        Target(name: "{PACKAGE_NAME}Core")
    ]
)
