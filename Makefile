INSTALL_PATH = /usr/local/bin/PackageBuilder

install:
	swift package --enable-prefetching update
	swift build --enable-prefetching -c release -Xswiftc -static-stdlib
	cp -f .build/release/PackageBuilder $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
