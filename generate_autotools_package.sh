#!/bin/sh

: ${package_name:=sample}

mkdir -p${verbose:+v} include src || return
[ -f src/main.cpp ] || cat << EOF > src/main.cpp || return
#include "config.h"

int main(void)
{
    return 0;
}
EOF

autoscan ${verbose:+-v} || return
sed -e '
    /^AC_INIT/{
        s/FULL-PACKAGE-NAME/'${package_name}'/
        s/VERSION/0.0.1/
        aAC_CONFIG_AUX_DIR([config])
        aAM_INIT_AUTOMAKE
    }
    /^# Checks for programs\.$/{
        aAC_PROG_INSTALL
        aAC_PROG_LIBTOOL
    }
    ${
        iAC_CONFIG_MACRO_DIR([m4])
        iAC_CONFIG_FILES([Makefile include/Makefile src/Makefile])
    }
' configure.scan > configure.ac || return
rm ${verbose:+-v} configure.scan || return

cat << EOF > Makefile.am || return
SUBDIRS = include src
ACLOCAL_AMFLAGS = -I m4
EOF
touch include/Makefile.am || return
cat << EOF > src/Makefile.am || return
bin_PROGRAMS = ${package_name}
${package_name}_SOURCES = main.cpp
EOF

libtoolize -c || return
aclocal ${verbose:+--verbose} || return
autoheader ${verbose:+-v} || return

mkdir -p${verbose:+v} config || return
touch NEWS README AUTHORS ChangeLog COPYING || return
automake -ac${verbose:+v} || return

autoconf ${verbose:+-v} || return

which git > /dev/null 2>&1 && {
    cat << EOF > .gitignore || return
*.o
*.swp
*~
.deps
.libs
Makefile
Makefile.in
aclocal.m4
autom4te.cache
autoscan.log
config.h
config.h.in
config.log
config.status
configure
stamp-h1
EOF
    git rev-parse > /dev/null 2>&1 || git init . || return
    git add .gitignore || return
    git add config m4 || return
    git add AUTHORS COPYING ChangeLog INSTALL NEWS README || return
    git add configure.ac Makefile.am include/Makefile.am src/Makefile.am src/main.cpp || return
}

# vim: set expandtab shiftwidth=0 tabstop=4 :
