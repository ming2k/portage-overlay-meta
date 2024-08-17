# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# execute the following command to get all crates needed by the project
# awk -F '= ' '/^name/ {name=$2} /^version/ {version=$2; gsub(/"/, "", name); gsub(/"/, "", version); print name "@" version}' Cargo.lock
# delete the yazi-* crates
CRATES="
windows-targets@v0.52.6
redox_syscall@v0.5.2
iana-time-zone-haiku@v0.1.2
fsevent-sys@v4.1.0
android_system_properties@v0.1.5
interpolate_name@v0.2.4
windows-targets@v0.48.5
redox_users@v0.4.5
zerocopy-derive@v0.7.35
clipboard-win@v5.4.0
hermit-abi@v0.3.9
anstyle-wincon@v3.0.3
kqueue@v1.0.8
windows-result@v0.1.2
windows-implement@v0.56.0
objc-sys@v0.3.5
system-deps@v6.2.2
wasi@v0.11.0+wasi-snapshot-preview1
encode_unicode@v0.3.6
windows-core@v0.52.0
cfg-expr@v0.15.8
kqueue-sys@v1.0.4
crunchy@v0.2.2
libredox@v0.1.3
crossterm_winapi@v0.9.1
version-compare@v0.2.0
windows-interface@v0.56.0
android-tzdata@v0.1.1
error-code@v3.2.0
winapi-util@v0.1.8
arbitrary@v1.3.2
target-lexicon@v0.12.15
block2@v0.5.1
objc2-encode@v4.0.3
valuable@v0.1.0
redox_syscall@v0.4.1
core-foundation-sys@v0.8.6
windows-core@v0.56.0
libfuzzer-sys@v0.4.7
js-sys@v0.3.69
objc2@v0.5.2
objc2-foundation@v0.2.2
windows_x86_64_gnullvm@v0.52.6
windows_aarch64_gnullvm@v0.52.6
windows_aarch64_gnullvm@v0.48.5
winsafe@v0.0.19
windows_i686_gnullvm@v0.52.6
windows_x86_64_gnullvm@v0.48.5
windows_x86_64_msvc@v0.48.5
windows_x86_64_gnu@v0.48.5
windows_i686_msvc@v0.52.6
windows_x86_64_msvc@v0.52.6
windows_aarch64_msvc@v0.52.6
windows_x86_64_gnu@v0.52.6
windows_aarch64_msvc@v0.48.5
windows_i686_gnu@v0.48.5
windows_i686_gnu@v0.52.6
windows_i686_msvc@v0.48.5
winapi@v0.3.9
windows-sys@v0.59.0
windows-sys@v0.48.0
windows-sys@v0.52.0
winapi-x86_64-pc-windows-gnu@v0.4.0
winapi-i686-pc-windows-gnu@v0.4.0
windows@v0.56.0
"

inherit cargo desktop shell-completion

DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O."
HOMEPAGE="https://yazi-rs.github.io/"
SRC_URI="
	https://github.com/sxyazi/yazi/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+="
	Apache-2.0 BSD-2 BSD Boost-1.0 CC0-1.0 ISC MIT MPL-2.0
	Unicode-DFS-2016
"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="usr/bin/${PN}"

DOCS=(
	README.md
)

src_prepare() {
	export YAZI_GEN_COMPLETIONS=true
	sed -i -r 's/strip\s+= true/strip = false/' Cargo.toml || die "Sed failed!"
	eapply_user
}

src_install() {
	dobin target/$(usex debug debug release)/yazi

	newbashcomp "${S}/yazi-boot/completions/${PN}.bash" "${PN}"
	dozshcomp "${S}/yazi-boot/completions/_${PN}"
	dofishcomp "${S}/yazi-boot/completions/${PN}.fish"

	domenu "assets/${PN}.desktop"
	einstalldocs
}
