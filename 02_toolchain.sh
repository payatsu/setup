#!/bin/sh -e

# [TODO] linux-2.6.18, glibc-2.16.0の組み合わせを試す。
# [TODO] 作成したクロスコンパイラで、C/C++/Goのネイティブコンパイラ作ってみる。
# [TODO] wget, bash, tar, diff, patch, find, xsltproc, xmllint
# [TODO] gettext #for git

: ${coreutils_ver:=8.24}
: ${bison_ver:=3.0.4}
: ${flex_ver:=2.6.0}
: ${m4_ver:=1.4.17}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.15}
: ${libtool_ver:=2.4.6}
: ${sed_ver:=4.2.2}
: ${gawk_ver:=4.1.3}
: ${make_ver:=4.1}
: ${binutils_ver:=2.25.1}
: ${kernel_ver:=3.18.13}
: ${gperf_ver:=3.0.4}
: ${glibc_ver:=2.22}
: ${gmp_ver:=6.1.0}
: ${mpfr_ver:=3.1.3}
: ${mpc_ver:=1.0.3}
: ${gcc_ver:=5.3.0}
: ${ncurses_ver:=6.0}
: ${gdb_ver:=7.10.1}
: ${emacs_ver:=24.5}
: ${global_ver:=6.5.2}
: ${screen_ver:=4.3.1}
: ${zsh_ver:=5.2}
: ${curl_ver:=7.46.0}
: ${asciidoc_ver:=8.6.9}
: ${xmlto_ver:=0.0.28}
: ${libxml2_ver:=2.9.3}
: ${git_ver:=2.7.0}
: ${zlib_ver:=1.2.8}
: ${libpng_ver:=1.6.20}
: ${libtiff_ver:=4.0.6}
: ${libjpeg_ver:=v9b}
: ${giflib_ver:=5.1.2}

: ${prefix:=/toolchains}
: ${target:=`uname -m`-linux-gnu}

usage()
# Show usage.
{
	cat <<EOF
[Usage]
	$0 [-p prefix] [-t target] [-j jobs] [-h] [variable=value]... tags...

[Options]
	-p prefix
		Installation directory, currently '${prefix}'.
		'/usr/local' is NOT strongly recommended.
	-t target
		Target-triplet of new compiler, currently '${target}'.
		ex. armv7l-linux-gnueabihf
			x86_64-linux-gnu
			i686-unknown-linux
			microblaze-none-linux
	-j jobs
		The number of process run simultaneously by 'make', currently '${jobs}'.
		Recommended not to be more than the number of CPU cores.
	-h
		Show detailed help.

EOF
	list_major_tags
	echo
}

help()
# Show detailed help.
{
	usage
	cat <<EOF
[Environmental variables]
	coreutils_ver
		Specify the version of GNU Coreutils you want, currently '${coreutils_ver}'.
	bison_ver
		Specify the version of GNU Bison you want, currently '${bison_ver}'.
	flex_ver
		Specify the version of flex you want, currently '${flex_ver}'.
	m4_ver
		Specify the version of GNU M4 you want, currently '${m4_ver}'.
	autoconf_ver
		Specify the version of GNU Autoconf you want, currently '${autoconf_ver}'.
	automake_ver
		Specify the version of GNU Automake you want, currently '${automake_ver}'.
	libtool_ver
		Specify the version of GNU Libtool you want, currently '${libtool_ver}'.
	sed_ver
		Specify the version of GNU sed you want, currently '${sed_ver}'.
	gawk_ver
		Specify the version of GNU awk you want, currently '${gawk_ver}'.
	make_ver
		Specify the version of GNU Make you want, currently '${make_ver}'.
	binutils_ver
		Specify the version of GNU Binutils you want, currently '${binutils_ver}'.
	kernel_ver
		Specify the version of Linux kernel you want, currently '${kernel_ver}'.
	gperf_ver
		Specify the version of gperf you want, currently '${gperf_ver}'.
	glibc_ver
		Specify the version of GNU C Library you want, currently '${glibc_ver}'.
	gmp_ver
		Specify the version of GNU MP Bignum Library you want, currently '${gmp_ver}'.
	mpfr_ver
		Specify the version of GNU MPFR Library you want, currently '${mpfr_ver}'.
	mpc_ver
		Specify the version of GNU MPC Library you want, currently '${mpc_ver}'.
	gcc_ver
		Specify the version of GNU Compiler Collection you want, currently '${gcc_ver}'.
	ncurses_ver
		Specify the version of ncurses you want, currently '${ncurses_ver}'.
	gdb_ver
		Specify the version of GNU Debugger you want, currently '${gdb_ver}'.
	emacs_ver
		Specify the version of GNU Emacs you want, currently '${emacs_ver}'.
	global_ver
		Specify the version of GNU Global you want, currently '${global_ver}'.
	screen_ver
		Specify the version of GNU Screen you want, currently '${screen_ver}'.
	zsh_ver
		Specify the version of Zsh you want, currently '${zsh_ver}'.
	curl_ver
		Specify the version of Curl you want, currently '${libcur_ver}'.
	asciidoc_ver
		Specify the version of asciidoc you want, currently '${asciidoc_ver}'.
	xmlto_ver
		Specify the version of xmlto you want, currently '${xmlto_ver}'.
	libxml2_ver
		Specify the version of libxml2 you want, currently '${libxml2_ver}'.
	git_ver
		Specify the version of Git you want, currently '${git_ver}'.
	zlib_ver
		Specify the version of zlib you want, currently '${zlib_ver}'.
	libpng_ver
		Specify the version of libpng you want, currently '${libpng_ver}'.
	libtiff_ver
		Specify the version of libtiff you want, currently '${libtiff_ver}'.
	libjpeg_ver
		Specify the version of libjpeg you want, currently '${libjpeg_ver}'.
	giflib_ver
		Specify the version of giflib you want, currently '${giflib_ver}'.

[Examples]
	For Raspberry pi2
	# $0 -p /toolchains -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 kernel_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 cross

	For microblaze
	# $0 -p /toolchains -t microblaze-linux-gnu -j 8 binutils_ver=2.25 kernel_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 cross

EOF
}

native()
# Install native GNU binutils, GNU C/C++/Go compiler, GDB(running on and compiles for '${build}').
{
	install_prerequisites || return 1
	install_native_binutils || return 1
	install_native_gcc || return 1
	install_native_gdb || return 1
	clean
}

cross()
# Install cross GNU binutils, GNU C/C++/Go compiler, GDB(running on '${build}', compiles for '${target}').
{
	install_prerequisites || return 1
	install_cross_gcc || return 1
	install_cross_gdb || return 1
	clean
}

all()
# Install native/cross GNU Toolchains.
{
	install_prerequisites || return 1
	native
	cross
	clean
}

full()
# Install all of the available software packages.
{
	install_prerequisites || return 1
	full_native || return 1
	full_cross || return 1
	clean
}

experimental()
# Install some packages experimentally.
{
	install_crossed_native_binutils || return 1
	install_crossed_native_gmp_mpfr_mpc || return 1
	install_crossed_native_gcc || return 1
	install_crossed_native_zlib || return 1
	install_crossed_native_libpng || return 1
	install_crossed_native_libtiff || return 1
}

clean()
# Delete no longer required source trees.
{
	rm -rf \
		${coreutils_org_src_dir} \
		${bison_org_src_dir} \
		${flex_org_src_dir} \
		${m4_org_src_dir} \
		${autoconf_org_src_dir} \
		${automake_org_src_dir} \
		${libtool_org_src_dir} \
		${sed_org_src_dir} \
		${gawk_org_src_dir} \
		${make_org_src_dir} \
		${binutils_org_src_dir} ${binutils_src_dir_ntv} ${binutils_src_dir_crs} ${binutils_src_dir_crs_ntv} \
		${kernel_org_src_dir} ${kernel_src_dir} \
		${gperf_org_src_dir} \
		${glibc_org_src_dir} ${glibc_bld_dir_hdr} ${glibc_bld_dir_1st} \
		${glibc_src_dir_hdr} ${glibc_src_dir_1st} \
		${gmp_src_dir_ntv} ${gmp_src_dir_crs_ntv} ${mpfr_src_dir_ntv} ${mpfr_src_dir_crs_ntv} ${mpc_src_dir_ntv} ${mpc_src_dir_crs_ntv} \
		${gcc_org_src_dir} ${gcc_bld_dir_ntv} ${gcc_bld_dir_crs_1st} ${gcc_bld_dir_crs_2nd} ${gcc_bld_dir_crs_3rd} ${gcc_bld_dir_crs_ntv} \
		${ncurses_org_src_dir} \
		${gdb_org_src_dir} ${gdb_bld_dir_ntv} ${gdb_bld_dir_crs} \
		${emacs_org_src_dir} \
		${global_org_src_dir} \
		${screen_org_src_dir} \
		${zsh_org_src_dir} \
		${curl_org_src_dir} \
		${asciidoc_org_src_dir} \
		${xmlto_org_src_dir} \
		${libxml2_org_src_dir} \
		${git_org_src_dir} \
		${zlib_src_dir_ntv} ${zlib_src_dir_crs_ntv} \
		${libpng_src_dir_ntv} ${libpng_src_dir_crs_ntv} \
		${libtiff_src_dir_ntv} ${libtiff_src_dir_crs_ntv} \
		${libjpeg_src_dir_ntv} \
		${giflib_src_dir_ntv}
}

list()
# List all tags, which include the ones not listed here.
{
	list_all
}

list_major_tags()
{
	echo '[Available tags]'
	eval "`grep -A 1 -e '^[[:alnum:]]\+()$' $0 |
		sed -e '/^--$/d; /^{$/d; s/()$//; s/^# /\t/; s/^/\t/; 1s/^/echo "/; $s/$/"/'`"
}

list_all()
{
	cat <<EOF
[All tags]
#: major tags, -: internal tags(for debugging use)
EOF
	grep -e '^[_[:alnum:]]*[[:alnum:]]\+()$' $0 | sed -e 's/^/\t- /; s/()$//; s/- \([[:alnum:]]\+\)$/# \1/'
}

set_variables()
{
	: ${sysroot:=${prefix}/${target}/sysroot}
	: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
	build=`uname -m`-linux-gnu
	os=`head -1 /etc/issue | cut -d ' ' -f 1`

	case ${target} in
	arm*)        linux_arch=arm;;
	i?86*)       linux_arch=x86;;
	microblaze*) linux_arch=microblaze;;
	x86_64*)     linux_arch=x86;;
	*) echo Unknown architecture: ${target} >&2; return 1;;
	esac

	coreutils_name=coreutils-${coreutils_ver}
	coreutils_src_base=${prefix}/src/coreutils
	coreutils_org_src_dir=${coreutils_src_base}/${coreutils_name}

	bison_name=bison-${bison_ver}
	bison_src_base=${prefix}/src/bison
	bison_org_src_dir=${bison_src_base}/${bison_name}

	flex_name=flex-${flex_ver}
	flex_src_base=${prefix}/src/flex
	flex_org_src_dir=${flex_src_base}/${flex_name}

	m4_name=m4-${m4_ver}
	m4_src_base=${prefix}/src/m4
	m4_org_src_dir=${m4_src_base}/${m4_name}

	autoconf_name=autoconf-${autoconf_ver}
	autoconf_src_base=${prefix}/src/autoconf
	autoconf_org_src_dir=${autoconf_src_base}/${autoconf_name}

	automake_name=automake-${automake_ver}
	automake_src_base=${prefix}/src/automake
	automake_org_src_dir=${automake_src_base}/${automake_name}

	libtool_name=libtool-${libtool_ver}
	libtool_src_base=${prefix}/src/libtool
	libtool_org_src_dir=${libtool_src_base}/${libtool_name}

	sed_name=sed-${sed_ver}
	sed_src_base=${prefix}/src/sed
	sed_org_src_dir=${sed_src_base}/${sed_name}

	gawk_name=gawk-${gawk_ver}
	gawk_src_base=${prefix}/src/gawk
	gawk_org_src_dir=${gawk_src_base}/${gawk_name}

	make_name=make-${make_ver}
	make_src_base=${prefix}/src/make
	make_org_src_dir=${make_src_base}/${make_name}

	binutils_name=binutils-${binutils_ver}
	binutils_src_base=${prefix}/src/binutils
	binutils_org_src_dir=${binutils_src_base}/${binutils_name}
	binutils_src_dir_ntv=${binutils_src_base}/${binutils_name}-ntv
	binutils_src_dir_crs=${binutils_src_base}/${target}-${binutils_name}-crs
	binutils_src_dir_crs_ntv=${binutils_src_base}/${target}-${binutils_name}-crs-ntv

	kernel_name=linux-${kernel_ver}
	kernel_src_base=${prefix}/src/linux
	kernel_org_src_dir=${kernel_src_base}/${kernel_name}
	kernel_src_dir=${kernel_src_base}/${target}-${kernel_name}

	gperf_name=gperf-${gperf_ver}
	gperf_src_base=${prefix}/src/gperf
	gperf_org_src_dir=${gperf_src_base}/${gperf_name}

	glibc_name=glibc-${glibc_ver}
	glibc_src_base=${prefix}/src/glibc
	glibc_org_src_dir=${glibc_src_base}/${glibc_name}
	glibc_bld_dir_hdr=${glibc_src_base}/${target}-${glibc_name}-header
	glibc_bld_dir_1st=${glibc_src_base}/${target}-${glibc_name}-1st
	glibc_src_dir_hdr=${glibc_src_base}/${target}-${glibc_name}-header-src
	glibc_src_dir_1st=${glibc_src_base}/${target}-${glibc_name}-1st-src

	gmp_name=gmp-${gmp_ver}
	gmp_src_base=${prefix}/src/gmp
	gmp_org_src_dir=${gmp_src_base}/${gmp_name}
	gmp_src_dir_ntv=${gmp_src_base}/${gmp_name}-ntv
	gmp_src_dir_crs_ntv=${gmp_src_base}/${target}-${gmp_name}-crs-ntv

	mpfr_name=mpfr-${mpfr_ver}
	mpfr_src_base=${prefix}/src/mpfr
	mpfr_org_src_dir=${mpfr_src_base}/${mpfr_name}
	mpfr_src_dir_ntv=${mpfr_src_base}/${mpfr_name}-ntv
	mpfr_src_dir_crs_ntv=${mpfr_src_base}/${target}-${mpfr_name}-crs-ntv

	mpc_name=mpc-${mpc_ver}
	mpc_src_base=${prefix}/src/mpc
	mpc_org_src_dir=${mpc_src_base}/${mpc_name}
	mpc_src_dir_ntv=${mpc_src_base}/${mpc_name}-ntv
	mpc_src_dir_crs_ntv=${mpc_src_base}/${target}-${mpc_name}-crs-ntv

	gcc_name=gcc-${gcc_ver}
	gcc_src_base=${prefix}/src/gcc
	gcc_org_src_dir=${gcc_src_base}/${gcc_name}
	gcc_bld_dir_ntv=${gcc_src_base}/${gcc_name}-ntv
	gcc_bld_dir_crs_1st=${gcc_src_base}/${target}-${gcc_name}-1st
	gcc_bld_dir_crs_2nd=${gcc_src_base}/${target}-${gcc_name}-2nd
	gcc_bld_dir_crs_3rd=${gcc_src_base}/${target}-${gcc_name}-3rd
	gcc_bld_dir_crs_ntv=${gcc_src_base}/${target}-${gcc_name}-crs-ntv

	ncurses_name=ncurses-${ncurses_ver}
	ncurses_src_base=${prefix}/src/ncurses
	ncurses_org_src_dir=${ncurses_src_base}/${ncurses_name}

	gdb_name=gdb-${gdb_ver}
	gdb_src_base=${prefix}/src/gdb
	gdb_org_src_dir=${gdb_src_base}/${gdb_name}
	gdb_bld_dir_ntv=${gdb_src_base}/${gdb_name}-ntv
	gdb_bld_dir_crs=${gdb_src_base}/${target}-${gdb_name}-crs

	emacs_name=emacs-${emacs_ver}
	emacs_src_base=${prefix}/src/emacs
	emacs_org_src_dir=${emacs_src_base}/${emacs_name}

	global_name=global-${global_ver}
	global_src_base=${prefix}/src/global
	global_org_src_dir=${global_src_base}/${global_name}

	screen_name=screen-${screen_ver}
	screen_src_base=${prefix}/src/screen
	screen_org_src_dir=${screen_src_base}/${screen_name}

	zsh_name=zsh-${zsh_ver}
	zsh_src_base=${prefix}/src/zsh
	zsh_org_src_dir=${zsh_src_base}/${zsh_name}

	curl_name=curl-${curl_ver}
	curl_src_base=${prefix}/src/curl
	curl_org_src_dir=${curl_src_base}/${curl_name}

	asciidoc_name=asciidoc-${asciidoc_ver}
	asciidoc_src_base=${prefix}/src/asciidoc
	asciidoc_org_src_dir=${asciidoc_src_base}/${asciidoc_name}

	xmlto_name=xmlto-${xmlto_ver}
	xmlto_src_base=${prefix}/src/xmlto
	xmlto_org_src_dir=${xmlto_src_base}/${xmlto_name}

	libxml2_name=libxml2-${libxml2_ver}
	libxml2_src_base=${prefix}/src/libxml2
	libxml2_org_src_dir=${libxml2_src_base}/${libxml2_name}

	git_name=git-${git_ver}
	git_src_base=${prefix}/src/git
	git_org_src_dir=${git_src_base}/${git_name}

	zlib_name=zlib-${zlib_ver}
	zlib_src_base=${prefix}/src/zlib
	zlib_org_src_dir=${zlib_src_base}/${zlib_name}
	zlib_src_dir_ntv=${zlib_src_base}/${zlib_name}-ntv
	zlib_src_dir_crs_ntv=${zlib_src_base}/${target}-${zlib_name}-crs-ntv

	libpng_name=libpng-${libpng_ver}
	libpng_src_base=${prefix}/src/libpng
	libpng_org_src_dir=${libpng_src_base}/${libpng_name}
	libpng_src_dir_ntv=${libpng_src_base}/${libpng_name}-ntv
	libpng_src_dir_crs_ntv=${libpng_src_base}/${target}-${libpng_name}-crs-ntv

	libtiff_name=tiff-${libtiff_ver}
	libtiff_src_base=${prefix}/src/libtiff
	libtiff_org_src_dir=${libtiff_src_base}/${libtiff_name}
	libtiff_src_dir_ntv=${libtiff_src_base}/${libtiff_name}-ntv
	libtiff_src_dir_crs_ntv=${libtiff_src_base}/${target}-${libtiff_name}-crs-ntv

	libjpeg_name=jpegsrc.${libjpeg_ver}
	libjpeg_src_base=${prefix}/src/libjpeg
	libjpeg_org_src_dir=${libjpeg_src_base}/jpeg-`echo ${libjpeg_ver} | sed -e s/^v//`
	libjpeg_src_dir_ntv=${libjpeg_src_base}/jpeg-`echo ${libjpeg_ver} | sed -e s/^v//`-ntv

	giflib_name=giflib-${giflib_ver}
	giflib_src_base=${prefix}/src/giflib
	giflib_org_src_dir=${giflib_src_base}/${giflib_name}
	giflib_src_dir_ntv=${giflib_src_base}/${giflib_name}-ntv

	echo ${PATH} | grep -q ${prefix}/bin || PATH=${prefix}/bin:${PATH}
}

install_prerequisites()
{
	[ -n "${prerequisites_have_been_already_installed}" ] && return 0
	case ${os} in
	Debian|Ubuntu)
		apt-get install -y make gcc g++ texinfo
		apt-get install -y unifdef # for linux kernel
		apt-get install -y libgtk-3-dev libxpm-dev # for emacs
		apt-get install -y python2.7-dev # for gdb
		apt-get install -y xsltproc libxml2-utils # for git
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ texinfo
		yum install -y glibc-devel.i686 libstdc++-devel.i686
		yum install -y unifdef
		yum install -y gtk3-devel libXpm-devel
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1 ;;
	esac
	prerequisites_have_been_already_installed=true
}

prepare_coreutils_source()
{
	mkdir -p ${coreutils_src_base}
	[ -f ${coreutils_org_src_dir}.tar.xz ] ||
		wget -nv -O ${coreutils_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/coreutils/${coreutils_name}.tar.xz || return 1
}

prepare_bison_source()
{
	mkdir -p ${bison_src_base}
	[ -f ${bison_org_src_dir}.tar.xz ] ||
		wget -nv -O ${bison_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/bison/${bison_name}.tar.xz || return 1
}

prepare_flex_source()
{
	mkdir -p ${flex_src_base}
	[ -f ${flex_org_src_dir}.tar.xz ] ||
		wget -nv --trust-server-names -O ${flex_org_src_dir}.tar.xz \
			http://sourceforge.net/projects/flex/files/${flex_name}.tar.xz/download || return 1
}

prepare_m4_source()
{
	mkdir -p ${m4_src_base}
	[ -f ${m4_org_src_dir}.tar.xz ] ||
		wget -nv -O ${m4_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/m4/${m4_name}.tar.xz || return 1
}

prepare_autoconf_source()
{
	mkdir -p ${autoconf_src_base}
	[ -f ${autoconf_org_src_dir}.tar.xz ] ||
		wget -nv -O ${autoconf_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/autoconf/${autoconf_name}.tar.xz || return 1
}

prepare_automake_source()
{
	mkdir -p ${automake_src_base}
	[ -f ${automake_org_src_dir}.tar.xz ] ||
		wget -nv -O ${automake_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/automake/${automake_name}.tar.xz || return 1
}

prepare_libtool_source()
{
	mkdir -p ${libtool_src_base}
	[ -f ${libtool_org_src_dir}.tar.xz ] ||
		wget -nv -O ${libtool_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/libtool/${libtool_name}.tar.xz || return 1
}

prepare_sed_source()
{
	mkdir -p ${sed_src_base}
	[ -f ${sed_org_src_dir}.tar.bz2 ] ||
		wget -nv -O ${sed_org_src_dir}.tar.bz2 \
			https://ftp.gnu.org/gnu/sed/${sed_name}.tar.bz2 || return 1
}

prepare_gawk_source()
{
	mkdir -p ${gawk_src_base}
	[ -f ${gawk_org_src_dir}.tar.xz ] ||
		wget -nv -O ${gawk_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gawk/${gawk_name}.tar.xz || return 1
}

prepare_make_source()
{
	mkdir -p ${make_src_base}
	[ -f ${make_org_src_dir}.tar.gz ] ||
		wget -nv -O ${make_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/make/${make_name}.tar.gz || return 1
}

prepare_binutils_source()
{
	mkdir -p ${binutils_src_base}
	[ -f ${binutils_org_src_dir}.tar.gz ] ||
		wget -nv -O ${binutils_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/binutils/${binutils_name}.tar.gz || return 1
}

prepare_kernel_source()
{
	case `echo ${kernel_ver} | cut -f 1,2 -d .` in
		2.6) dir=v2.6;;
		3.*) dir=v3.x;;
		4.*) dir=v4.x;;
		*)   echo unsupported kernel version >&2; return 1;;
	esac
	mkdir -p ${kernel_src_base}
	[ -f ${kernel_org_src_dir}.tar.xz ] ||
		wget -nv -O ${kernel_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/kernel/${dir}/${kernel_name}.tar.xz || return 1
}

prepare_gperf_source()
{
	mkdir -p ${gperf_src_base}
	[ -f ${gperf_org_src_dir}.tar.gz ] ||
		wget -nv -O ${gperf_org_src_dir}.tar.gz \
			https://ftp.gnu.org/gnu/gperf/${gperf_name}.tar.gz || return 1
}

prepare_glibc_source()
{
	mkdir -p ${glibc_src_base}
	[ -f ${glibc_org_src_dir}.tar.xz ] ||
		wget -nv -O ${glibc_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/glibc/${glibc_name}.tar.xz || return 1
}

prepare_gmp_mpfr_mpc_source()
{
	mkdir -p ${gmp_src_base}
	[ -f ${gmp_org_src_dir}.tar.bz2 ] ||
		wget -nv -O ${gmp_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/gmp/${gmp_name}.tar.bz2 || return 1
	mkdir -p ${mpfr_src_base}
	[ -f ${mpfr_org_src_dir}.tar.gz ] ||
		wget -nv -O ${mpfr_org_src_dir}.tar.gz \
			http://www.mpfr.org/${mpfr_name}/${mpfr_name}.tar.gz || return 1
	mkdir -p ${mpc_src_base}
	[ -f ${mpc_org_src_dir}.tar.gz ] ||
		wget -nv -O ${mpc_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/mpc/${mpc_name}.tar.gz || return 1
}

prepare_gcc_source()
{
	mkdir -p ${gcc_src_base}
	[ -f ${gcc_org_src_dir}.tar.gz ] ||
		wget -nv -O ${gcc_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.gz || return 1
}

prepare_ncurses_source()
{
	mkdir -p ${ncurses_src_base}
	[ -f ${ncurses_org_src_dir}.tar.gz ] ||
		wget -nv -O ${ncurses_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/ncurses/${ncurses_name}.tar.gz || return 1
}

prepare_gdb_source()
{
	mkdir -p ${gdb_src_base}
	[ -f ${gdb_org_src_dir}.tar.xz ] ||
		wget -nv -O ${gdb_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gdb/${gdb_name}.tar.xz || return 1
}

prepare_emacs_source()
{
	mkdir -p ${emacs_src_base}
	[ -f ${emacs_org_src_dir}.tar.xz ] ||
		wget -nv -O ${emacs_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/emacs/${emacs_name}.tar.xz || return 1
}

prepare_global_source()
{
	mkdir -p ${global_src_base}
	[ -f ${global_org_src_dir}.tar.gz ] ||
		wget -nv -O ${global_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/global/${global_name}.tar.gz || return 1
}

prepare_screen_source()
{
	mkdir -p ${screen_src_base}
	[ -f ${screen_org_src_dir}.tar.gz ] ||
		wget -nv -O ${screen_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/screen/${screen_name}.tar.gz || return 1
}

prepare_zsh_source()
{
	mkdir -p ${zsh_src_base}
	[ -f ${zsh_org_src_dir}.tar.gz ] ||
		wget -nv --trust-server-names -O ${zsh_org_src_dir}.tar.gz \
			http://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.gz/download || return 1
}

prepare_curl_source()
{
	mkdir -p ${curl_src_base}
	[ -f ${curl_org_src_dir}.tar.bz2 ] ||
		wget -nv -O ${curl_org_src_dir}.tar.bz2 \
			http://curl.haxx.se/download/${curl_name}.tar.bz2 || return 1
}

prepare_asciidoc_source()
{
	mkdir -p ${asciidoc_src_base}
	[ -f ${asciidoc_org_src_dir}.zip ] ||
		wget -nv -O ${asciidoc_org_src_dir}.zip \
			http://sourceforge.net/projects/asciidoc/files/asciidoc/${asciidoc_ver}/${asciidoc_name}.zip/download || return 1
}

prepare_xmlto_source()
{
	mkdir -p ${xmlto_src_base}
	[ -f ${xmlto_org_src_dir}.tar.bz2 ] ||
		wget -nv -O ${xmlto_org_src_dir}.tar.bz2 \
			https://fedorahosted.org/releases/x/m/xmlto/${xmlto_name}.tar.bz2 || return 1
}

prepare_libxml2_source()
{
	mkdir -p ${libxml2_src_base}
	[ -f ${libxml2_org_src_dir}.tar.gz ] ||
		wget -nv -O ${libxml2_org_src_dir}.tar.gz \
			ftp://xmlsoft.org/libxml2/${libxml2_name}.tar.gz || return 1
}

prepare_git_source()
{
	mkdir -p ${git_src_base}
	[ -f ${git_org_src_dir}.tar.xz ] ||
		wget -nv -O ${git_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return 1
}

prepare_zlib_source()
{
	mkdir -p ${zlib_src_base}
	[ -f ${zlib_org_src_dir}.tar.gz ] ||
		wget -nv -O ${zlib_org_src_dir}.tar.gz \
			http://zlib.net/${zlib_name}.tar.gz || return 1
}

prepare_libpng_source()
{
	mkdir -p ${libpng_src_base}
	[ -f ${libpng_org_src_dir}.tar.gz ] ||
		wget -nv --trust-server-names -O ${libpng_org_src_dir}.tar.gz \
			http://download.sourceforge.net/libpng/${libpng_name}.tar.gz || return 1
}

prepare_libtiff_source()
{
	mkdir -p ${libtiff_src_base}
	[ -f ${libtiff_org_src_dir}.zip ] ||
		wget -nv -O ${libtiff_org_src_dir}.zip \
			ftp://ftp.remotesensing.org/pub/libtiff/${libtiff_name}.zip || return 1
}

prepare_libjpeg_source()
{
	mkdir -p ${libjpeg_src_base}
	[ -f ${libjpeg_org_src_dir}.tar.gz ] ||
		wget -nv -O ${libjpeg_org_src_dir}.tar.gz \
			http://www.ijg.org/files/${libjpeg_name}.tar.gz || return 1
}

prepare_giflib_source()
{
	mkdir -p ${giflib_src_base}
	[ -f ${giflib_org_src_dir}.tar.bz2 ] ||
		wget -nv --trust-server-names -O ${giflib_org_src_dir}.tar.bz2 \
			http://sourceforge.net/projects/giflib/files/${giflib_name}.tar.bz2/download || return 1
}

install_native_coreutils()
{
	install_prerequisites || return 1
	prepare_coreutils_source || return 1
	[ -d ${coreutils_org_src_dir} ] ||
		tar xJvf ${coreutils_org_src_dir}.tar.xz -C ${coreutils_src_base} || return 1
	[ -f ${coreutils_org_src_dir}/Makefile ] ||
		(cd ${coreutils_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_bison()
{
	install_prerequisites || return 1
	prepare_bison_source || return 1
	[ -d ${bison_org_src_dir} ] ||
		tar xJvf ${bison_org_src_dir}.tar.xz -C ${bison_src_base} || return 1
	[ -f ${bison_org_src_dir}/Makefile ] ||
		(cd ${bison_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${bison_org_src_dir} -j ${jobs} || return 1
	make -C ${bison_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_flex()
{
	install_prerequisites || return 1
	install_native_bison || return 1
	prepare_flex_source || return 1
	[ -d ${flex_org_src_dir} ] ||
		tar xJvf ${flex_org_src_dir}.tar.xz -C ${flex_src_base} || return 1
	[ -f ${flex_org_src_dir}/Makefile ] ||
		(cd ${flex_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${flex_org_src_dir} -j ${jobs} || return 1
	make -C ${flex_org_src_dir} -j ${jobs} install-strip install-man || return 1
	echo ${prefix}/lib > /etc/ld.so.conf.d/libfl.conf
	ldconfig
}

install_native_m4()
{
	install_prerequisites || return 1
	prepare_m4_source || return 1
	[ -d ${m4_org_src_dir} ] ||
		tar xJvf ${m4_org_src_dir}.tar.xz -C ${m4_src_base} || return 1
	[ -f ${m4_org_src_dir}/Makefile ] ||
		(cd ${m4_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${m4_org_src_dir} -j ${jobs} || return 1
	make -C ${m4_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_autoconf()
{
	install_prerequisites || return 1
	prepare_autoconf_source || return 1
	[ -d ${autoconf_org_src_dir} ] ||
		tar xJvf ${autoconf_org_src_dir}.tar.xz -C ${autoconf_src_base} || return 1
	[ -f ${autoconf_org_src_dir}/Makefile ] ||
		(cd ${autoconf_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} install || return 1
}

install_native_automake()
{
	install_prerequisites || return 1
	prepare_automake_source || return 1
	[ -d ${automake_org_src_dir} ] ||
		tar xJvf ${automake_org_src_dir}.tar.xz -C ${automake_src_base} || return 1
	[ -f ${automake_org_src_dir}/Makefile ] ||
		(cd ${automake_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${automake_org_src_dir} -j ${jobs} || return 1
	make -C ${automake_org_src_dir} -j ${jobs} install || return 1
}

install_native_libtool()
{
	install_prerequisites || return 1
	install_native_flex || return 1
	prepare_libtool_source || return 1
	[ -d ${libtool_org_src_dir} ] ||
		tar xJvf ${libtool_org_src_dir}.tar.xz -C ${libtool_src_base} || return 1
	[ -f ${libtool_org_src_dir}/Makefile ] ||
		(cd ${libtool_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} install || return 1
}

install_native_sed()
{
	install_prerequisites || return 1
	prepare_sed_source || return 1
	[ -d ${sed_org_src_dir} ] ||
		tar xjvf ${sed_org_src_dir}.tar.bz2 -C ${sed_src_base} || return 1
	[ -f ${sed_org_src_dir}/Makefile ] ||
		(cd ${sed_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${sed_org_src_dir} -j ${jobs} || return 1
	make -C ${sed_org_src_dir} -j ${jobs} install || return 1
}

install_native_gawk()
{
	install_prerequisites || return 1
	prepare_gawk_source || return 1
	[ -d ${gawk_org_src_dir} ] ||
		tar xJvf ${gawk_org_src_dir}.tar.xz -C ${gawk_src_base} || return 1
	[ -f ${gawk_org_src_dir}/Makefile ] ||
		(cd ${gawk_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} install || return 1
}

install_native_make()
{
	install_prerequisites || return 1
	prepare_make_source || return 1
	[ -d ${make_org_src_dir} ] ||
		tar xzvf ${make_org_src_dir}.tar.gz -C ${make_src_base} || return 1
	[ -f ${make_org_src_dir}/Makefile ] ||
		(cd ${make_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${make_org_src_dir} -j ${jobs} || return 1
	make -C ${make_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_binutils()
{
	install_prerequisites || return 1
	install_native_bison || return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_ntv} ] ||
		(tar xzvf ${binutils_org_src_dir}.tar.gz -C ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return 1
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-sysroot=/ --enable-gold) || return 1
	make -C ${binutils_src_dir_ntv} -j ${jobs} || return 1
	make -C ${binutils_src_dir_ntv} -j ${jobs} install-strip || return 1
}

install_native_gperf()
{
	install_prerequisites || return 1
	prepare_gperf_source || return 1
	[ -d ${gperf_org_src_dir} ] ||
		tar xzvf ${gperf_org_src_dir}.tar.gz -C ${gperf_src_base} || return 1
	[ -f ${gperf_org_src_dir}/Makefile ] ||
		(cd ${gperf_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} install || return 1
}

install_native_gmp_mpfr_mpc()
{
	prepare_gmp_mpfr_mpc_source || return 1

	[ -d ${gmp_src_dir_ntv} ] ||
		(tar xjvf ${gmp_org_src_dir}.tar.bz2 -C ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return 1
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		./configure --prefix=${prefix}) || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} install-strip || return 1

	[ -d ${mpfr_src_dir_ntv} ] ||
		(tar xzvf ${mpfr_org_src_dir}.tar.gz -C ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return 1
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		./configure --prefix=${prefix} --with-gmp=${prefix}) || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} install-strip || return 1

	[ -d ${mpc_src_dir_ntv} ] ||
		(tar xzvf ${mpc_org_src_dir}.tar.gz -C ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return 1
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		./configure --prefix=${prefix} --with-gmp=${prefix} --with-mpfr=${prefix}) || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} install-strip || return 1
}

make_symbolic_links()
{
	case ${os} in
	Debian|Ubuntu)
		for dir in asm bits gnu sys; do
			ln -sf ./x86_64-linux-gnu/${dir} /usr/include/${dir}
		done
		for obj in crt1.o crti.o crtn.o; do
			ln -sf ./x86_64-linux-gnu/${obj} /usr/lib/${obj}
		done
		;;
	esac
}

install_native_gcc()
{
	install_prerequisites || return 1
	install_native_zlib || return 1
	install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	make_symbolic_links || return 1
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_ntv}
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			 --enable-languages=c,c++,go --disable-multilib --without-isl --with-system-zlib) || return 1
	make -C ${gcc_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_ntv} -j ${jobs} install-strip || return 1
	echo "${prefix}/lib64\n${prefix}/lib32" > /etc/ld.so.conf.d/${target}-${gcc_name}.conf
	ldconfig
}

install_native_ncurses()
{
	install_prerequisites || return 1
	prepare_ncurses_source || return 1
	[ -d ${ncurses_org_src_dir} ] ||
		tar xzvf ${ncurses_org_src_dir}.tar.gz -C ${ncurses_src_base} || return 1

	# workaround for GCC 5.x
	patch -p0 -d ${ncurses_org_src_dir} <<EOF || return 1
--- ncurses/base/MKlib_gen.sh
+++ ncurses/base/MKlib_gen.sh
@@ -491,11 +491,18 @@
 	-e 's/gen_\$//' \\
 	-e 's/  / /g' >>\$TMP
 
+cat >\$ED1 <<EOF
+s/  / /g
+s/^ //
+s/ \$//
+s/P_NCURSES_BOOL/NCURSES_BOOL/g
+EOF
+
+sed -e 's/bool/P_NCURSES_BOOL/g' \$TMP > \$ED2
+cat \$ED2 >\$TMP
+
 \$preprocessor \$TMP 2>/dev/null \\
-| sed \\
-	-e 's/  / /g' \\
-	-e 's/^ //' \\
-	-e 's/_Bool/NCURSES_BOOL/g' \\
+| sed -f \$ED1 \\
 | \$AWK -f \$AW2 \\
 | sed -f \$ED3 \\
 | sed \\
EOF

	[ -f ${ncurses_org_src_dir}/Makefile ] ||
		(cd ${ncurses_org_src_dir}
		./configure --prefix=${prefix} --with-shared --with-cxx-shared --enable-widec) || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} install || return 1
}

install_native_gdb()
{
	install_prerequisites || return 1
	install_native_ncurses || return 1
	prepare_gdb_source || return 1
	[ -d ${gdb_org_src_dir} ] ||
		tar xJvf ${gdb_org_src_dir}.tar.xz -C ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_ntv}
	[ -f ${gdb_bld_dir_ntv}/Makefile ] ||
		(cd ${gdb_bld_dir_ntv}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} --enable-tui --with-python) || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} install || return 1
}

install_native_zlib()
{
	install_prerequisites || return 1
	prepare_zlib_source || return 1
	[ -d ${zlib_src_dir_ntv} ] ||
		(tar xzvf ${zlib_org_src_dir}.tar.gz -C ${zlib_src_base} &&
			mv ${zlib_org_src_dir} ${zlib_src_dir_ntv}) || return 1
	(cd ${zlib_src_dir_ntv}
	./configure --prefix=${prefix}) || return 1
	make -C ${zlib_src_dir_ntv} -j ${jobs} || return 1
	make -C ${zlib_src_dir_ntv} -j ${jobs} install || return 1
}

install_native_libpng()
{
	install_prerequisites || return 1
	install_native_zlib || return 1
	prepare_libpng_source || return 1
	[ -d ${libpng_src_dir_ntv} ] ||
		(tar xzvf ${libpng_org_src_dir}.tar.gz -C ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_ntv}) || return 1
	[ -f ${libpng_src_dir_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	C_INCLUDE_PATH=${prefix}/include make -C ${libpng_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_ntv} -j ${jobs} install || return 1
}

install_native_libtiff()
{
	install_prerequisites || return 1
	prepare_libtiff_source || return 1
	[ -d ${libtiff_src_dir_ntv} ] ||
		(unzip -d ${libtiff_src_base} ${libtiff_org_src_dir}.zip &&
			mv ${libtiff_org_src_dir} ${libtiff_src_dir_ntv}) || return 1
	[ -f ${libtiff_src_dir_ntv}/Makefile ] ||
		(cd ${libtiff_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libtiff_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libtiff_src_dir_ntv} -j ${jobs} install || return 1
}

install_native_libjpeg()
{
	install_prerequisites || return 1
	prepare_libjpeg_source || return 1
	[ -d ${libjpeg_src_dir_ntv} ] ||
		(tar xzvf ${libjpeg_org_src_dir}.tar.gz -C ${libjpeg_src_base} &&
			mv ${libjpeg_org_src_dir} ${libjpeg_src_dir_ntv}) || return 1
	[ -f ${libjpeg_src_dir_ntv}/Makefile ] ||
		(cd ${libjpeg_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libjpeg_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libjpeg_src_dir_ntv} -j ${jobs} install || return 1
}

install_native_giflib()
{
	install_prerequisites || return 1
	prepare_giflib_source || return 1
	[ -d ${giflib_src_dir_ntv} ] ||
		(tar xjvf ${giflib_org_src_dir}.tar.bz2 -C ${giflib_src_base} &&
			mv ${giflib_org_src_dir} ${giflib_src_dir_ntv}) || return 1
	[ -f ${giflib_src_dir_ntv}/Makefile ] ||
		(cd ${giflib_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} install || return 1
}

install_native_emacs()
{
	install_prerequisites || return 1
	install_native_zlib || return 1
	install_native_libpng || return 1
	install_native_libtiff || return 1
	install_native_libjpeg || return 1
	install_native_giflib || return 1
	prepare_emacs_source || return 1
	[ -d ${emacs_org_src_dir} ] ||
		tar xJvf ${emacs_org_src_dir}.tar.xz -C ${emacs_src_base} || return 1
	[ -f ${emacs_org_src_dir}/Makefile ] ||
		(cd ${emacs_org_src_dir}
		./configure --prefix=${prefix} --without-xpm) || return 1
	make -C ${emacs_org_src_dir} -j ${jobs} || return 1
	make -C ${emacs_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_global()
{
	install_prerequisites || return 1
	prepare_global_source || return 1
	[ -d ${global_org_src_dir} ] ||
		tar xzvf ${global_org_src_dir}.tar.gz -C ${global_src_base} || return 1
	[ -f ${global_org_src_dir}/Makefile ] ||
		(cd ${global_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${global_org_src_dir} -j ${jobs} || return 1
	make -C ${global_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_screen()
{
	install_prerequisites || return 1
	prepare_screen_source || return 1
	[ -d ${screen_org_src_dir} ] ||
		tar xzvf ${screen_org_src_dir}.tar.gz -C ${screen_src_base} || return 1
	[ -f ${screen_org_src_dir}/Makefile ] ||
		(cd ${screen_org_src_dir}
		./configure --prefix=${prefix} --enable-color256 --enable-rxvt_osc) || return 1
	make -C ${screen_org_src_dir} -j ${jobs} || return 1
	make -C ${screen_org_src_dir} -j ${jobs} install || return 1
}

install_native_zsh()
{
	install_prerequisites || return 1
	prepare_zsh_source || return 1
	[ -d ${zsh_org_src_dir} ] ||
		tar xzvf ${zsh_org_src_dir}.tar.gz -C ${zsh_src_base} || return 1
	[ -f ${zsh_org_src_dir}/Makefile ] ||
		(cd ${zsh_org_src_dir}
		./configure --prefix=${prefix} --host=${build}) || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} install || return 1
}

install_native_curl()
{
	install_prerequisites || return 1
	prepare_curl_source || return 1
	[ -d ${curl_org_src_dir} ] ||
		tar xjvf ${curl_org_src_dir}.tar.bz2 -C ${curl_src_base} || return 1
	[ -f ${curl_org_src_dir}/Makefile ] ||
		(cd ${curl_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${curl_org_src_dir} -j ${jobs} || return 1
	make -C ${curl_org_src_dir} -j ${jobs} install || return 1
}

install_native_asciidoc()
{
	install_prerequisites || return 1
	prepare_asciidoc_source || return 1
	[ -d ${asciidoc_org_src_dir} ] ||
		unzip -d ${asciidoc_src_base} ${asciidoc_org_src_dir}.zip || return 1
	[ -f ${asciidoc_org_src_dir}/Makefile ] ||
		(cd ${asciidoc_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} install || return 1
}

install_native_xmlto()
{
	install_prerequisites || return 1
	prepare_xmlto_source || return 1
	[ -d ${xmlto_org_src_dir} ] ||
		tar xjvf ${xmlto_org_src_dir}.tar.bz2 -C ${xmlto_src_base} || return 1
	[ -f ${xmlto_org_src_dir}/Makefile ] ||
		(cd ${xmlto_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} install || return 1
}

install_native_libxml2()
{
	install_prerequisites || return 1
	prepare_libxml2_source || return 1
	[ -d ${libxml2_org_src_dir} ] ||
		tar xzvf ${libxml2_org_src_dir}.tar.gz -C ${libxml2_src_base} || return 1
	[ -f ${libxml2_org_src_dir}/Makefile ] ||
		(cd ${libxml2_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} install || return 1
}

install_native_git()
{
	install_prerequisites || return 1
	install_native_curl || return 1
	install_native_asciidoc || return 1
	install_native_xmlto || return 1
	prepare_git_source || return 1
	[ -d ${git_org_src_dir} ] ||
		tar xJvf ${git_org_src_dir}.tar.xz -C ${git_src_base} || return 1
	make -C ${git_org_src_dir} -j ${jobs} configure || return 1
	(cd ${git_org_src_dir}
	./configure --prefix=${prefix}) || return 1
	make -C ${git_org_src_dir} -j ${jobs} all doc || return 1
	make -C ${git_org_src_dir} -j ${jobs} install install-doc install-html || return 1
}

full_native()
{
	install_native_coreutils || return 1
	install_native_m4 || return 1
	install_native_autoconf || return 1
	install_native_automake || return 1
	install_native_libtool || return 1
	install_native_make || return 1
	install_native_binutils || return 1
	install_native_gcc || return 1
	install_native_gdb || return 1
	install_native_emacs || return 1
	install_native_screen || return 1
	install_native_zsh || return 1
	install_native_git || return 1
}

install_cross_binutils()
{
	install_prerequisites || return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_crs} ] ||
		(tar xzvf ${binutils_org_src_dir}.tar.gz -C ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_crs}) || return 1
	[ -f ${binutils_src_dir_crs}/Makefile ] ||
		(cd ${binutils_src_dir_crs}
		./configure --prefix=${prefix} --target=${target} --with-sysroot=${sysroot} --enable-gold) || return 1
	make -C ${binutils_src_dir_crs} -j ${jobs} || return 1
	make -C ${binutils_src_dir_crs} -j ${jobs} install-strip || return 1
}

install_cross_gcc_without_headers()
{
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_1st}
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return 1
}

install_kernel_header()
{
	prepare_kernel_source || return 1
	[ -d ${kernel_src_dir} ] ||
		(tar xJvf ${kernel_org_src_dir}.tar.xz -C ${kernel_src_base} &&
			mv ${kernel_org_src_dir} ${kernel_src_dir}) || return 1
	make -C ${kernel_src_dir} -j ${jobs} mrproper || return 1
	make -C ${kernel_src_dir} -j ${jobs} \
		ARCH=${linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return 1
}

install_glibc_headers()
{
	install_native_gawk || return 1
	install_native_gperf || return 1
	prepare_glibc_source || return 1
	[ -d ${glibc_src_dir_hdr} ] ||
		(tar xJvf ${glibc_org_src_dir}.tar.xz -C ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_hdr}) || return 1
	mkdir -p ${glibc_bld_dir_hdr}
	[ -f ${glibc_bld_dir_hdr}/Makefile ] ||
		(cd ${glibc_bld_dir_hdr}
		${glibc_src_dir_hdr}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes \
		) || return 1
	make -C ${glibc_bld_dir_hdr} -j ${jobs} DESTDIR=${sysroot} install-headers || return 1
}

install_cross_gcc_with_glibc_headers()
{
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c --with-sysroot=${sysroot} --with-newlib \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-gcc || return 1
	touch ${sysroot}/usr/include/gnu/stubs.h
	touch ${sysroot}/usr/include/gnu/stubs-soft.h
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-target-libgcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-target-libgcc || return 1
}

install_1st_glibc()
{
	[ -d ${glibc_src_dir_1st} ] ||
		(tar xJvf ${glibc_org_src_dir}.tar.xz -C ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_1st}) || return 1

	[ ${linux_arch} = microblaze ] && (cd ${glibc_src_dir_1st}; patch -p0 -d ${glibc_src_dir_1st} <<EOF || return 1
--- sysdeps/unix/sysv/linux/microblaze/sysdep.h
+++ sysdeps/unix/sysv/linux/microblaze/sysdep.h
@@ -16,8 +16,11 @@
    License along with the GNU C Library; if not, see
    <http://www.gnu.org/licenses/>.  */
 
+#ifndef _LINUX_MICROBLAZE_SYSDEP_H
+#define _LINUX_MICROBLAZE_SYSDEP_H 1
+
+#include <sysdeps/unix/sysdep.h>
 #include <sysdeps/microblaze/sysdep.h>
-#include <sys/syscall.h>
 
 /* Defines RTLD_PRIVATE_ERRNO.  */
 #include <dl-sysdep>
@@ -305,3 +308,5 @@
 # define PTR_DEMANGLE(var) (void) (var)
 
 #endif /* not __ASSEMBLER__ */
+
+#endif /* _LINUX_MICROBLAZE_SYSDEP_H */
EOF
)

	mkdir -p ${glibc_bld_dir_1st}
	[ -f ${glibc_bld_dir_1st}/Makefile ] ||
		(cd ${glibc_bld_dir_1st}
		${glibc_src_dir_1st}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes \
		) || return 1
	make -C ${glibc_bld_dir_1st} -j ${jobs} DESTDIR=${sysroot} || return 1
	make -C ${glibc_bld_dir_1st} -j ${jobs} DESTDIR=${sysroot} install || return 1
}

install_cross_gcc_with_c_cxx_go_functionality()
{
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_3rd}
	export LIBS=-lgcc_s
	[ -f ${gcc_bld_dir_crs_3rd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_3rd}
		 ${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c,c++,go --with-sysroot=${sysroot}) || return 1
	make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} install || return 1
}

install_cross_gcc()
{
	install_cross_binutils || return 1
	install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_kernel_header || return 1
	install_glibc_headers || return 1
	install_cross_gcc_with_glibc_headers || return 1
	install_1st_glibc || return 1
	install_cross_gcc_with_c_cxx_go_functionality || return 1
}

install_cross_gdb()
{
	install_prerequisites || return 1
	prepare_gdb_source || return 1
	[ -d ${gdb_org_src_dir} ] ||
		tar xJvf ${gdb_org_src_dir}.tar.xz -C ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_crs}
	[ -f ${gdb_bld_dir_crs}/Makefile ] ||
		(cd ${gdb_bld_dir_crs}
		${gdb_org_src_dir}/configure --prefix=${prefix} --target=${target} --enable-tui --with-python --with-sysroot=${sysroot}) || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} install || return 1
}

full_cross()
{
	install_cross_gcc || return 1
	install_cross_gdb || return 1
}

install_crossed_native_binutils()
{
	install_prerequisites || return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_crs_ntv} ] ||
		(tar xzvf ${binutils_org_src_dir}.tar.gz -C ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_crs_ntv}) || return 1
	[ -f ${binutils_src_dir_crs_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --with-sysroot=/) || return 1
	make -C ${binutils_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${binutils_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_gmp_mpfr_mpc()
{
	prepare_gmp_mpfr_mpc_source || return 1

	[ -d ${gmp_src_dir_crs_ntv} ] ||
		(tar xjvf ${gmp_org_src_dir}.tar.bz2 -C ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return 1
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target}) || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1

# XXX クロス先のネイティブ環境用なので、with-gmp, --with-mpfrの指定が間違ってるかも。

	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(tar xzvf ${mpfr_org_src_dir}.tar.gz -C ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return 1
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr) || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1

	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(tar xzvf ${mpc_org_src_dir}.tar.gz -C ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return 1
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr) || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_gcc()
{
	install_prerequisites || return 1
	install_crossed_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_ntv}
	export CC_FOR_TARGET=${prefix}/bin/${target}-gcc
	export CXX_FOR_TARGET=${prefix}/bin/${target}-g++
	export GOC_FOR_TARGET=${prefix}/bin/${target}-gccgo
	[ -f ${gcc_bld_dir_crs_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_ntv}
		${gcc_org_src_dir}/configure --prefix=/usr --build=${build} --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr --with-mpc=${sysroot}/usr \
			 --enable-languages=c,c++,go --with-sysroot=/ --without-isl) || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_zlib()
{
	install_prerequisites || return 1
	prepare_zlib_source || return 1
	[ -d ${zlib_src_dir_crs_ntv} ] ||
		(tar xzvf ${zlib_org_src_dir}.tar.gz -C ${zlib_src_base} &&
			mv ${zlib_org_src_dir} ${zlib_src_dir_crs_ntv}) || return 1
	(cd ${zlib_src_dir_crs_ntv}
	CC=${target}-gcc ./configure --prefix=${sysroot}/usr) || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} install || return 1
}

install_crossed_native_libpng()
{
	install_prerequisites || return 1
	install_crossed_native_zlib || return 1
	prepare_libpng_source || return 1
	[ -d ${libpng_src_dir_crs_ntv} ] ||
		(tar xzvf ${libpng_org_src_dir}.tar.gz -C ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_crs_ntv}) || return 1
	[ -f ${libpng_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_crs_ntv}
		./configure --prefix=${sysroot}/usr --host=${target}) || return 1
	C_INCLUDE_PATH=${sysroot}/include make -C ${libpng_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} install || return 1
}

install_crossed_native_libtiff()
{
	install_prerequisites || return 1
	prepare_libtiff_source || return 1
	[ -d ${libtiff_src_dir_crs_ntv} ] ||
		(unzip -d ${libtiff_src_base} ${libtiff_org_src_dir}.zip &&
			mv ${libtiff_org_src_dir} ${libtiff_src_dir_crs_ntv}) || return 1
	[ -f ${libtiff_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libtiff_src_dir_crs_ntv}
		CC=${target}-gcc CXX=${target}-g++ ./configure --prefix=${sysroot}/usr --host=`echo ${target} | sed -e 's/arm[^-]\+/arm/'`) || return 1
	CC=${target}-gcc CXX=${target}-g++ make -C ${libtiff_src_dir_crs_ntv} -j ${jobs} || return 1
	CC=${target}-gcc CXX=${target}-g++ make -C ${libtiff_src_dir_crs_ntv} -j ${jobs} install || return 1
}

while getopts p:t:j:h arg; do
	case ${arg} in
	p)  prefix=${OPTARG};;
	t)  target=${OPTARG};;
	j)  jobs=${OPTARG};;
	h)  set_variables || true; help; exit 0;;
	\?) set_variables || true; usage >&2; exit 1;;
	esac
done
shift `expr ${OPTIND} - 1`

set_variables

count=0
while [ $# -gt 0 ]; do
	case $1 in
	debug) shift; [ $# -eq 0 ] && while true; do read -p 'debug> ' cmd; eval ${cmd} || true; done; eval $1;;
	*=*)   eval $1; set_variables;;
	*)     eval $1 || exit 1; count=`expr ${count} + 1`;;
	esac
	shift
done
[ ${count} -eq 0 ] && usage
