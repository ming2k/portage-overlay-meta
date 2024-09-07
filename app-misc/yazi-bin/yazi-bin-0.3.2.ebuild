EAPI=8

# Package description and metadata
DESCRIPTION="Blazing fast terminal file manager written in Rust, based on async I/O."
HOMEPAGE="https://github.com/sxyazi/yazi"
SRC_URI="https://github.com/sxyazi/yazi/releases/download/v${PV}/yazi-x86_64-unknown-linux-gnu.zip"
S="${WORKDIR}/yazi-x86_64-unknown-linux-gnu"

LICENSE="MIT"  # Replace with the actual license
SLOT="0"
KEYWORDS="~amd64"  # Adjust based on architecture support

# Dependencies
RDEPEND=""

# Optional: Dependencies only needed during build time
DEPEND=""

# Optional: Patch sources after unpacking
src_unpack() {
    default
}

# Prepare the package for installation
src_install() {
        local opt_dir="/opt/${P}"
        insinto "${opt_dir}"
        doins -r "${S}"/*
        fperms +x "${opt_dir}/yazi"
        dosym "${opt_dir}/yazi" /usr/bin/ya
        dosym "${opt_dir}/yazi" /usr/bin/yazi
}

