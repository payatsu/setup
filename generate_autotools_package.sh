#!/bin/sh

: ${package_name:=sample}

mkdir -p${verbose:+v} include src test || return
cat << EOF > src/main.cpp || return
#include "config.h"

int main(void)
{
	return 0;
}
EOF
cat << EOF > test/test.cpp || return
#include "config.h"
#include "gtest/gtest.h"
int main(int argc, char* argv[])
{
	::testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
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
		iAC_CONFIG_FILES([Makefile include/Makefile src/Makefile test/Makefile])
	}
' configure.scan > configure.ac || return
rm ${verbose:+-v} configure.scan || return

cat << EOF > Makefile.am || return
SUBDIRS = include src test
ACLOCAL_AMFLAGS = -I m4
EOF
touch include/Makefile.am || return
cat << EOF > src/Makefile.am || return
bin_PROGRAMS = ${package_name}
${package_name}_SOURCES = main.cpp
EOF
cat << EOF > test/Makefile.am || return
noinst_PROGRAMS = testsuite
testsuite_SOURCES = test.cpp
nodist_testsuite_SOURCES  = gtest/gtest.h gtest/gtest-all.cc
testsuite_CPPFLAGS = -I../src
testsuite_CXXFLAGS = -std=c++11 -Wall -Wextra --coverage
testsuite_LDFLAGS = -lpthread

gtest_ver = release-1.8.0

gtest/gtest.h gtest/gtest-all.cc: googletest-\$(gtest_ver)
	\$^/googletest/scripts/fuse_gtest_files.py \$^/googletest .

googletest-\$(gtest_ver):
	wget --no-check-certificate -O - https://github.com/google/googletest/archive/\$(gtest_ver).tar.gz | tar xzvf -

check:
	./testsuite
	lcov -c -d . -o tracefile.info
	genhtml -p \$(dir \$(CURDIR)) -o html -s tracefile.info
	\$(RM) tracefile.info *.gcda

.PHONY: myclean
clean: myclean
	\$(RM) -r html *.gcda *.gcno
EOF

libtoolize -c || return
aclocal ${verbose:+--verbose} || return
autoheader ${verbose:+-v} || return

touch NEWS README AUTHORS ChangeLog COPYING || return
automake -ac${verbose:+v} || return

autoconf ${verbose:+-v} || return

! which git > /dev/null 2>&1 && return

cat << EOF > .gitignore || return
*.gcda
*.gcno
*.la
*.lo
*.o
*.swp
*~
.deps
.libs
GTAGS
GRTAGS
GPATH
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
libtool
stamp-h1
tags
EOF
git rev-parse > /dev/null 2>&1 || git init . || return
git add .gitignore || return
git add config m4 || return
git add AUTHORS COPYING ChangeLog INSTALL NEWS README || return
git add configure.ac Makefile.am include/Makefile.am src/Makefile.am src/main.cpp test/Makefile.am test/test.cpp || return
