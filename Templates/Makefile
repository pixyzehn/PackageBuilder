INSTALL_PATH = /usr/local/bin/{PACKAGE_NAME}

install:
        swift package --enable-prefetching update
        swift build --enable-prefetching -c release
        cp -f .build/release/{PACKAGE_NAME} $(INSTALL_PATH)

uninstall:
        rm -f $(INSTALL_PATH)
