/**
 *  {PACKAGE_NAME}
 *  Copyright (c) {YOUR_NAME} {THIS_YEAR}
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public final class {PACKAGE_NAME} {
    private let arguments: [String]

    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }

    public func run() throws {
        print("Hello world")
    }
}
