# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils toolchain-funcs versionator

MY_P="${PN}-$(replace_version_separator 2 '.')"
SAGE_P="sage-5.5"

DESCRIPTION="Conductor and Reduction Types for Genus 2 Curves"
HOMEPAGE="http://www.math.u-bordeaux.fr/~liu/G2R/"
SRC_URI="http://sage.math.washington.edu/home/release/${SAGE_P}/${SAGE_P}/spkg/standard/${MY_P}.spkg -> ${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RESTRICT="mirror"

RDEPEND=">=sci-mathematics/pari-2.5.0"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}/src

src_prepare() {
	epatch "${FILESDIR}"/${MY_P}-pari.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}.c -lpari -lgmp -lm \
		|| die "compilation of source failed"
}

src_install() {
	dobin ${PN}
	dodoc README RELEASE.NOTES WARNING
}
