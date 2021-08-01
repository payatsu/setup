#!/bin/sh

: ${package_name:=`basename \`pwd\``}

mkdir -p${verbose:+v} src tests || return
cat << EOF > src/${package_name}.cpp || return
#include "config.h"

int main(void)
{
	return 0;
}
EOF
cat << EOF > tests/test.cpp || return
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
		aAM_INIT_AUTOMAKE([foreign subdir-objects])
		aAM_SILENT_RULES([yes])
		aAC_LANG([C++])
	}
	/^# Checks for programs\.$/{
		aAC_PROG_INSTALL
		aAC_PROG_GREP
		aAC_PROG_SED
		# aLT_INIT
	}
	/^# Checks for libraries\.$/{
		aAC_CHECK_LIB([pthread], [main]) # Google Test requires pthread on POSIX system.
	}
	${
		iAC_CONFIG_MACRO_DIR([m4])
		iAC_CONFIG_FILES([Makefile src/Makefile tests/Makefile])
		i[warning_options="-Wextra -Wcast-align -Wstrict-aliasing -Wshadow "\\
		i`LANG=C ${CXX} -fsyntax-only -Q --help=warnings,^joined,^separate,common --help=warnings,^joined,^separate,c++ |
		i${GREP} -v '\''\\@<:@enabled\\@:>@\\|-Wabi\\|-Waggregate-return\\|-Wchkp\\|-Wc90-c99-compat\\|-Wnamespaces\\|-Wredundant-tags\\|-Wsuggest-attribute=const\\|-Wsystem-headers\\|-Wtemplates\\|-Wtraditional@<:@^-@:>@'\'' |
		i${GREP} -oe '\''-W@<:@@<:@:graph:@:>@@:>@\\+'\'' |
		i${SED} -e '\''s/<@<:@0-9,@:>@\\+>//'\'' |
		i${SED} -e '\''$!s/$/ \\\\\\\\/'\''`]
		iAC_SUBST([warning_options])
		i[system_include_dirs=`LANG=C ${CPP} ${CPPFLAGS} -v -x c /dev/null -o /dev/null 2>&1 |
		i${SED} -e '\''/^#include "/,/^End of search list\\.$/p;d'\'' |
		i${SED} -e '\''/^ /{s///;s/$/\\/\\\\\\\\*/;p};d'\'' |
		i${SED} -e '\''$!s/$/ \\\\\\\\/'\''`]
		iAC_SUBST([system_include_dirs])
		iAC_ARG_ENABLE([sanitizer],
		i\	[AS_HELP_STRING([--enable-sanitizer], [enable sanitizer])],
		i\	[AS_VAR_IF([enable_sanitizer], [yes],
		i\	\	[sanitizer_flags='\''-static-libasan -static-liblsan -static-libubsan'\''])
		i\	AC_SUBST([sanitizer_flags])])
	}
' configure.scan > configure.ac || return
rm ${verbose:+-v} configure.scan || return

cat << EOF > Makefile.am || return
SUBDIRS = src tests
ACLOCAL_AMFLAGS = -I m4
EOF
cat << EOF > src/Makefile.am || return
bin_PROGRAMS = ${package_name}
${package_name}_SOURCES = ${package_name}.cpp
${package_name}_CXXFLAGS = -std=c++17 \$(warning_options)

.PHONY: list-warning-options
list-warning-options:
	\$(AM_V_CXX)LANG=C \$(CXX) -Q --help=warnings,^joined,^separate,common --help=warnings,^joined,^separate,c++ \$(warning_options) -x c++ -o /dev/null /dev/null
EOF
cat << EOF > tests/Makefile.am || return
noinst_PROGRAMS = testsuite
testsuite_SOURCES = test.cpp
nodist_testsuite_SOURCES = gtest/gtest.h gtest/gtest-all.cc
testsuite_CPPFLAGS = -I../src
testsuite_CXXFLAGS = -std=c++17 --coverage \$(warning_options) \$(sanitizer_flags)
## XXX: Warning suppresions(workaround) for Google Test header("gtest/gtest.h").
testsuite_CXXFLAGS += -Wno-ctor-dtor-privacy -Wno-duplicated-branches \\
-Wno-effc++ -Wno-inline -Wno-missing-declarations -Wno-multiple-inheritance \\
-Wno-namespaces -Wno-null-dereference -Wno-sign-conversion -Wno-suggest-attribute=format \\
-Wno-suggest-attribute=noreturn -Wno-suggest-attribute=pure -Wno-suggest-final-methods \\
-Wno-suggest-final-types -Wno-suggest-override -Wno-padded -Wno-switch-default \\
-Wno-switch-enum -Wno-templates -Wno-undef -Wno-unused-const-variable \\
-Wno-unused-macros -Wno-useless-cast -Wno-zero-as-null-pointer-constant
testsuite_LDADD = @LIBS@

gtest_ver = release-1.10.0

\$(testsuite_SOURCES) gtest/gtest-all.cc: gtest/gtest.h
gtest/gtest.h: googletest-\$(gtest_ver)
	\$^/googletest/scripts/fuse_gtest_files.py \$^/googletest .

googletest-\$(gtest_ver):
	wget -nv -O - https://github.com/google/googletest/archive/\$(gtest_ver).tar.gz | tar xzvf -

check:
	./testsuite\$(EXEEXT)
	lcov -c -d . -o @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	lcov -r @PACKAGE_NAME@-@PACKAGE_VERSION@.info \$(system_include_dirs) \`pwd\`/gtest/\* -o @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	genhtml -p \`cd ..; pwd\` -o html -s @PACKAGE_NAME@-@PACKAGE_VERSION@.info
	\$(RM) @PACKAGE_NAME@-@PACKAGE_VERSION@.info *.gcda

clean-local:
	\$(RM) -r html *.gcda *.gcno
EOF

mkdir -p${verbose:+v} config m4 || return

# libtoolize -c || return
aclocal ${verbose:+--verbose} -W all || return
autoheader ${verbose:+-v} -W all || return

touch README.md || return
ln -s${verbose:+v} README.md README || return

automake -ac${verbose:+v} -W all || return
autoconf ${verbose:+-v} -W all || return

! which git > /dev/null 2>&1 && return

echo '*.gcda' '*.gcno' '*.la' '*.lo' '*.o' '*.swp' '*~' .deps .libs \
	GTAGS GRTAGS GPATH \
	Makefile Makefile.in aclocal.m4 autom4te.cache autoscan.log \
	config.h config.h.in config.log config.status \
	configure libtool stamp-h1 tags \
	src/${package_name} \
	tests/googletest-release-*/ \
	tests/gtest/ \
	tests/testsuite \
	| tr ' ' '\n' > .gitignore || return

git rev-parse > /dev/null 2>&1 || git init . || return
git add .gitignore || return
git add config m4 || return
git add README README.md || return
git add configure.ac Makefile.am src/Makefile.am src/${package_name}.cpp tests/Makefile.am tests/test.cpp || return
