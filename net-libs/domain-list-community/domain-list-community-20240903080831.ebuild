# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Community managed domain list."
HOMEPAGE="https://github.com/v2fly/domain-list-community"
SRC_URI="https://github.com/v2fly/${PN}/releases/download/${PV}/dlc.dat -> geosite.dat"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

RESTRICT="mirror"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/v2fly/
	newins "${DISTDIR}/geosite.dat" geosite.dat
}
