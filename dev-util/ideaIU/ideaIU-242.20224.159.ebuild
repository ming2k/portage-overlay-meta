# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 wrapper

# Define the ebuild metadata
HOMEPAGE="https://www.jetbrains.com/idea/preview/"
DESCRIPTION="IntelliJ IDEA Early Access Program"
SRC_URI="https://download.jetbrains.com/idea/ideaIU-${PV}.tar.gz"
LICENSE="IntelliJ-IDEA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="wayland"

# Define the version
S="${WORKDIR}/idea-IU-${PV}"

RDEPEND="
        virtual/jre
        sys-process/audit
"

src_unpack() {
    # Extract the source tarball
    unpack ${A}
}

src_install() {
    local dir="/opt/${PN}"
    # Install the application to the correct location
    # Create the installation directory
    insinto ${dir}
    if use wayland; then
        # Copy pre-configured idea64.vmoptions
        cp -f "${FILESDIR}/idea64.vmoptions" "bin/idea64.vmoptions"
    fi
    # Copy all files to the installation directory
    doins -r ${S}/*

    # Ensure idea.sh is executable
    fperms 755 "${dir}/bin/repair"
	fperms 755 "${dir}/bin/ltedit.sh"
	fperms 755 "${dir}/bin/idea.sh"
	fperms 755 "${dir}/bin/fsnotifier"
	fperms 755 "${dir}/bin/inspect.sh"
	fperms 755 "${dir}/bin/remote-dev-server"
	fperms 755 "${dir}/bin/remote-dev-server.sh"
	fperms 755 "${dir}/bin/restarter"
	fperms 755 "${dir}/bin/format.sh"

    # Make all files in the JBR directory executable
    fperms -R 755 "${dir}/jbr/bin/"
   	fperms -R 755 "${dir}/jbr/lib/chrome-sandbox"
	fperms -R 755 "${dir}/jbr/lib/jcef_helper"
	fperms -R 755 "${dir}/jbr/lib/jexec"
	fperms -R 755 "${dir}/jbr/lib/jspawnhelper"


    # Install pre-configured idea64.vmoptions if the wayland USE flag is enabled

    # Create a symlink for easy execution
    dosym ${dir}/bin/idea.sh /usr/bin/idea

    # Create desktop entry
   	newicon "bin/idea.png" "${P}.png"
    make_wrapper "${P}" "${dir}/bin/idea.sh"
   	make_desktop_entry ${P} "IntelliJ IDEA ${PV}" "${P}" "Development;IDE"
}

# Ensure proper cleanup
pkg_postinst() {
    elog "IntelliJ IDEA IU has been installed."
    elog "You can launch it using the 'idea' command."
}

