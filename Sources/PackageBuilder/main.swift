/**
 *  PackageBuilder
 *  Copyright (c) Hiroki Nagasawa 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import PackageBuilderCore

do {
    try PackageBuilder().run()
} catch {
    print("An error occurred: \(error)")
}
