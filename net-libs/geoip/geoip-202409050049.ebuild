# Copyright 2021-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="GeoIP for V2Ray."
HOMEPAGE="https://github.com/v2fly/geoip"
SRC_URI="https://github.com/v2fly/${PN}/releases/download/${PV}/${PN}.dat"

LICENSE="CC-BY-SA-4.0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"
SLOT="0"

RESTRICT="mirror"

S="${WORKDIR}"

src_install() {
	insinto /usr/share/v2fly/
	newins "${DISTDIR}/${PN}.dat" geoip.dat
}
