# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module systemd

DESCRIPTION="Xray, Penetrates Everything. Also the best v2ray-core, with XTLS support."
HOMEPAGE="https://xtls.github.io/ https://github.com/XTLS/Xray-core"
SRC_URI="https://github.com/XTLS/${PN}/archive/refs/tags/v${PV}.tar.gz
        https://github.com/ming2k/overlay-misc-host/releases/download/${P}-vendor/${P}-vendor.tar.xz"

S="${WORKDIR}/${P}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"

RESTRICT="mirror"

DEPEND="net-libs/geoip
        net-libs/domain-list-community"

RDEPEND="${DEPEND}"
BDEPEND=">=dev-lang/go-1.22"

src_compile() {
	ego build -o xray -trimpath -ldflags "-w -s -X 'github.com/XTLS/Xray-core/core.build=${PV}'" ./main
}

src_install() {
	dobin xray
	newinitd "${FILESDIR}/xray.initd" xray
	systemd_dounit "${FILESDIR}/xray.service"
	systemd_newunit "${FILESDIR}/xray_at.service" xray@.service
	dosym -r /usr/share/v2fly/geoip.dat /usr/share/xray/geoip.dat
   	dosym -r /usr/share/v2fly/geosite.dat /usr/share/xray/geosite.dat
	keepdir /etc/xray
}

