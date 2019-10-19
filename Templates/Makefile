INSTALL_PATH = /usr/local/bin/{PACKAGE_NAME}

install:
	swift package update
	swift build -c release
	cp -f .build/release/{PACKAGE_NAME} $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
