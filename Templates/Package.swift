/**
 *  {PROJECT_NAME}
 *  Copyright (c) {YOUR_NAME} {THIS_YEAR}
 *  Licensed under the MIT license. See LICENSE file.
 */

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
