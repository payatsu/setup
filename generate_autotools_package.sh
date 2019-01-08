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
		aAM_INIT_AUTOMAKE([subdir-objects])
		aAM_SILENT_RULES([yes])
		aAC_LANG([C++])
	}
	/^# Checks for programs\.$/{
		aAC_PROG_INSTALL
		aAC_PROG_LIBTOOL
	}
	/^# Checks for libraries\.$/{
		aAC_CHECK_LIB([pthread], [main]) # Google Test requires pthread on POSIX system.
	}
	${
		iAC_CONFIG_MACRO_DIR([m4])
		iAC_CONFIG_FILES([Makefile include/Makefile src/Makefile test/Makefile])
		i[warning_options="-Wextra -Wcast-align -Wstrict-aliasing -Wshadow "\\
		i`LANG=C ${CXX} -fsyntax-only -Q --help=warnings,^joined,^separate,c++ |
		igrep -v '\''\\@<:@enabled\\@:>@\\|-Wabi@<:@^-@:>@\\|-Wc90-c99-compat\\|-Wsystem-headers\\|-Wtemplates\\|-Wtraditional@<:@^-@:>@'\'' | grep -oe '\''-W@<:@@<:@:graph:@:>@@:>@\\+'\'' | sed -e '\''s/<@<:@0-9,@:>@\\+>//'\'' | sed -e '\''$!s/$/ \\\\\\\\/'\''`]
		iAC_SUBST([warning_options])
		i[system_include_dirs=`LANG=C ${CPP} ${CPPFLAGS} -v -x c /dev/null -o /dev/null 2>&1 | sed -e '\''/^#include "/,/^End of search list\\.$/p;d'\'' | sed -e '\''/^ /{s///;s/$/\\/\\\\\\\\*/;p};d'\'' | sed -e '\''$!s/$/ \\\\\\\\/'\''`]
		iAC_SUBST([system_include_dirs])
		iAC_ARG_ENABLE([sanitizer], [AC_HELP_STRING([--enable-sanitizer], [enable sanitizer])], [AS_VAR_IF([enable_sanitizer], [yes], [sanitizer_flags='\''-static-libasan -static-liblsan -static-libubsan'\'']) AC_SUBST([sanitizer_flags])])
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
${package_name}_CXXFLAGS = -std=c++11 \$(warning_options)
EOF
cat << EOF > test/Makefile.am || return
noinst_PROGRAMS = testsuite
testsuite_SOURCES = test.cpp
nodist_testsuite_SOURCES = gtest/gtest.h gtest/gtest-all.cc
testsuite_CPPFLAGS = -I../src
testsuite_CXXFLAGS = -std=c++11 --coverage \$(warning_options) \$(sanitizer_flags)
## XXX: Warning suppresions(workaround) for Google Test header("gtest/gtest.h").
testsuite_CXXFLAGS += -Wno-abi-tag -Wno-ctor-dtor-privacy -Wno-duplicated-branches \\
-Wno-effc++ -Wno-missing-declarations -Wno-multiple-inheritance -Wno-namespaces \\
-Wno-sign-conversion -Wno-suggest-attribute=format -Wno-suggest-override \\
-Wno-switch-default -Wno-switch-enum -Wno-templates -Wno-undef -Wno-unused-const-variable \\
-Wno-unused-macros -Wno-useless-cast -Wno-zero-as-null-pointer-constant
testsuite_LDFLAGS = @LIBS@

gtest_ver = release-1.8.1

\$(testsuite_SOURCES) gtest/gtest-all.cc: gtest/gtest.h
gtest/gtest.h: googletest-\$(gtest_ver)
	\$^/googletest/scripts/fuse_gtest_files.py \$^/googletest .

googletest-\$(gtest_ver):
	wget --no-check-certificate -nv -O - https://github.com/google/googletest/archive/\$(gtest_ver).tar.gz | tar xzvf -

check:
	./testsuite\$(EXEEXT)
	lcov -c -d . -o @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	lcov -r @PACKAGE_NAME@-@PACKAGE_VERSION@.info \$(system_include_dirs) \`pwd\`/gtest/\* -o @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	genhtml -p \`cd ..; pwd\` -o html -s @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	\$(RM) @PACKAGE_NAME@-@PACKAGE_VERSION@.info *.gcda

.PHONY: myclean
clean: clean-am myclean
distclean: distclean-am myclean
myclean:
	\$(RM) -r html *.gcda *.gcno
EOF

libtoolize -c || return
aclocal ${verbose:+--verbose} || return
autoheader ${verbose:+-v} || return

touch NEWS README AUTHORS ChangeLog COPYING || return
automake -ac${verbose:+v} || return

autoconf ${verbose:+-v} || return

! which git > /dev/null 2>&1 && return

echo '*.gcda' '*.gcno' '*.la' '*.lo' '*.o' '*.swp' '*~' .deps .libs \
	GTAGS GRTAGS GPATH \
	Makefile Makefile.in aclocal.m4 autom4te.cache autoscan.log \
	config.h config.h.in config.log config.status \
	configure libtool stamp-h1 tags | tr ' ' '\n' > .gitignore || return

git rev-parse > /dev/null 2>&1 || git init . || return
git add .gitignore || return
git add config m4 || return
git add AUTHORS COPYING ChangeLog INSTALL NEWS README || return
git add configure.ac Makefile.am include/Makefile.am src/Makefile.am src/main.cpp test/Makefile.am test/test.cpp || return
