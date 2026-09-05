TERMUX_PKG_HOMEPAGE=http://www.bzip.org/
TERMUX_PKG_DESCRIPTION="Tools for working with bzip2 compression"
TERMUX_PKG_LICENSE="BSD"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=1.0.8
TERMUX_PKG_REVISION=8
TERMUX_PKG_SRCURL=https://fossies.org/linux/misc/bzip2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=47fd74b2ff83effad0ddf62074e6fad1f6b4a77a96e121ab421c20a216371a1f
TERMUX_PKG_DEPENDS="libbz2"
TERMUX_PKG_ESSENTIAL=true
TERMUX_PKG_EXTRA_MAKE_ARGS="PREFIX=$TERMUX_PREFIX"
TERMUX_PKG_BUILD_IN_SRC=true
# Keep lib/ and include/ out: they belong to the libbz2 package.
TERMUX_PKG_RM_AFTER_INSTALL="lib/ include/"

termux_step_configure() {
	# bzip2 does not use configure. But place man pages at correct path:
	sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" $TERMUX_PKG_SRCDIR/Makefile
}

termux_step_make() {
	make CC="$CC" CFLAGS="$CFLAGS $CPPFLAGS" LDFLAGS="$LDFLAGS" -j"$TERMUX_PKG_MAKE_PROCESSES" bzip2 bzip2recover
}

termux_step_make_install() {
	make $TERMUX_PKG_EXTRA_MAKE_ARGS install
}
