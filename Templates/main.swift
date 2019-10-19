import {PACKAGE_NAME}Core

do {
    try {PACKAGE_NAME}().run()
} catch {
    print("An error occurred: \(error)")
}
