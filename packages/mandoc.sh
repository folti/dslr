PACKAGE_VERSION="1.13.1"
PACKAGE_SOURCES="http://mdocml.bsd.lv/snapshots/mdocml-$PACKAGE_VERSION.tar.gz"
PACKAGE_DESC="A man page formatting tool"

mandoc_build() {
	[ -d mdocml-$PACKAGE_VERSION ] && rm -rf mdocml-$PACKAGE_VERSION
	tar -xzvf mdocml-$PACKAGE_VERSION.tar.gz
	cd mdocml-$PACKAGE_VERSION

	patch -p 1 < "$BASE_DIR/patches/mandoc-musl.patch"

	$MAKE CC="$CC" \
	      CFLAGS="-D__BEGIN_DECLS=\; -D__END_DECLS=\; -DVERSION=\'\"$PACKAGE_VERSION\"\' $CFLAGS" \
	      mandoc
}

mandoc_package() {
	install -D -m 755 mandoc "$1/bin/mandoc"
	install -D -m 644 mandoc.1 "$1/usr/share/man/man1/mandoc.1"
	install -D -m 644 NEWS "$1/usr/share/doc/mandoc/NEWS"
	install -m 644 LICENSE "$1/usr/share/doc/mandoc/LICENSE"
}
