# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit autotools-utils flag-o-matic

MY_P="lib${P}"

DESCRIPTION="fpLLL contains several algorithms on lattices"
HOMEPAGE="http://perso.ens-lyon.fr/damien.stehle/"
SRC_URI="http://perso.ens-lyon.fr/damien.stehle/downloads/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

RESTRICT="mirror"

DEPEND=">=dev-libs/gmp-4.2.0
	>=dev-libs/mpfr-2.3.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

AUTOTOOLS_IN_SOURCE_BUILD="1"
DOCS=( AUTHORS NEWS README )

myeconfargs=(
	# place headers into a subdirectory where it cannot conflict with others
	--includedir="${EPREFIX}"/usr/include/fplll
	# .. and rename 'generate' to 'matrix_generate' (bug #449116)
	--program-transform-name='s/generate/generate_matrix/'
)

src_prepare() {
	# -O3 hangs up the compiler. See issue #66 at
	# https://github.com/cschwan/sage-on-gentoo/issues/66
	replace-flags -O3 -O2

	# rename 'generate' in README as well
	sed -i 's/generate /generate_matrix /' README \
		|| die "failed to patch README"

	autotools-utils_src_prepare

	# Replace deprecated gmp functions which are removed with mpir-1.3.0
	sed -i "s:mpz_div_2exp:mpz_tdiv_q_2exp:g" src/nr.cpp src/util.h \
		|| die "failed to patch depracated gmp function calls"
}
