INSTALL_PATH = /usr/local/bin/PackageBuilder

install:
	swift package update
	swift build -c release
	cp -f .build/release/PackageBuilder $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
