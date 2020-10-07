# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Library to load, handle and manipulate images in the PGF format"
HOMEPAGE="https://www.libpgf.org/"
SRC_URI="https://downloads.sourceforge.net/project/libpgf/libpgf/${PV}-latest/libPGF-codec-and-console-src.zip -> ${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

BDEPEND="
	app-arch/unzip
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/libPGF-codec-and-console-src/PGF/Codec"

src_prepare() {
	default

	# configure.ac has wrong version number
	sed -i 's/7.15.32/7.19.3/g' configure.ac || die

	if ! use doc; then
		sed -i -e "/HAS_DOXYGEN/{N;N;d}" Makefile.am || die
	fi

	eautoreconf
}

src_configure() {
	econf --disable-static
}
