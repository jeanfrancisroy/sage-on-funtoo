# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

SAGE_VERSION=4.3.2
SAGE_PACKAGE=sagetex-${PV}

inherit distutils latex-package sage

DESCRIPTION="SageTeX package allows you to embed code from the Sage mathematics
software suite into LaTeX documents"
# HOMEPAGE=""
# SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror"

# TODO: Check dependencies

DEPEND=">=dev-tex/tkz-berge-2.8"
RDEPEND="${DEPEND}"

src_prepare() {
	# 
	epatch "${FILESDIR}"/${P}-install-python-files-only.patch

	# 
	sed -i "s:share/texmf/tex/generic/sagetex:share/texmf/tex/latex/${PN}:g" \
		setup.py || die "sed failed"

	distutils_src_prepare
}

src_compile() {
	latex-package_src_compile
	distutils_src_compile
}

src_install() {
	latex-package_src_install
	distutils_src_install
}