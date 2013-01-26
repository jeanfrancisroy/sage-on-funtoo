# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils flag-o-matic versionator

MY_P="rubiks-$(replace_version_separator 1 '.')"

DESCRIPTION="Dik T. Winter's rubik's cube solver and related tools"
HOMEPAGE="http://www.sagemath.org"
SRC_URI="mirror://sagemath/${MY_P}.spkg -> ${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}/src/dik

src_prepare() {
	# fixes a lot of QA warnings
	epatch "${FILESDIR}"/${PN}-20070912_p10-fix-missing-includes.patch
}

src_compile() {
	append-cflags -DLARGE_MEM -DVERBOSE

	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" all
}

src_install() {
	dobin dikcube size222 size333c sizesquare sizedom sizekoc1 sizekoc2
	dodoc README
}
