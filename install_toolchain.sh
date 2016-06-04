#!/bin/sh -e
# [TODO] reset後にauto実行するとinstall_native_binutilsあたりでハングする問題の調査・解決
# [TODO] install_native_gitがperl.makのPM.stampとかでmake allがこける問題。
# [TODO] libboostが非root時に、再配置がどうのこうのでインストールできない。
# [TODO] libxml2が非rootでinstall-stripできない問題の解決。/usr/libに書き込もうとする問題。

# [TODO] mingw
# [TODO] export不使用にする。C_INCLUDE_PATHも。
# [TODO] bash, python, perl, LLD, LLDB, Polly, MySQL
# [TODO] 作成したクロスコンパイラで、C/C++/Goのネイティブコンパイラ作ってみる。
# [TODO] linux-2.6.18, glibc-2.16.0の組み合わせを試す。
# [TODO] install_native_xmltoのリファクタリング。
#        -> xmltoの障害のせいで、gitとgiflibのmakeに障害あり。
# [TODO] install_native_clang_extra()のテスト実行が未完了。
# [TODO] install_native_global時、libcursesがnot foundになる問題。
# [TODO] native用とcross用にkernelとglibcのバージョンを同時に指定・最初に一括ダウンロードできるようにする。

: ${tar_ver:=1.29}
: ${xz_ver:=5.2.2}
: ${bzip2_ver:=1.0.6}
: ${gzip_ver:=1.8}
: ${wget_ver:=1.17.1}
: ${coreutils_ver:=8.25}
: ${bison_ver:=3.0.4}
: ${flex_ver:=2.6.0}
: ${m4_ver:=1.4.17}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.15}
: ${libtool_ver:=2.4.6}
: ${sed_ver:=4.2.2}
: ${gawk_ver:=4.1.3}
: ${make_ver:=4.2}
: ${binutils_ver:=2.26}
: ${kernel_ver:=3.18.13}
: ${gperf_ver:=3.0.4}
: ${glibc_ver:=2.23}
: ${gmp_ver:=6.1.0}
: ${mpfr_ver:=3.1.4}
: ${mpc_ver:=1.0.3}
: ${gcc_ver:=6.1.0}
: ${ncurses_ver:=6.0}
: ${gdb_ver:=7.11}
: ${zlib_ver:=1.2.8}
: ${libpng_ver:=1.6.21}
: ${libtiff_ver:=4.0.6}
: ${libjpeg_ver:=v9b}
: ${giflib_ver:=5.1.4}
: ${emacs_ver:=24.5}
: ${vim_ver:=7.4.1849}
: ${grep_ver:=2.25}
: ${global_ver:=6.5.4}
: ${diffutils_ver:=3.3}
: ${patch_ver:=2.7.5}
: ${findutils_ver:=4.6.0}
: ${screen_ver:=4.3.1}
: ${zsh_ver:=5.2}
: ${openssl_ver:=1.0.2f}
: ${curl_ver:=7.49.0}
: ${asciidoc_ver:=8.6.9}
: ${xmlto_ver:=0.0.28}
: ${libxml2_ver:=2.9.4}
: ${libxslt_ver:=1.1.29}
: ${gettext_ver:=0.19.7}
: ${git_ver:=2.8.3}
: ${cmake_ver:=3.5.2}
: ${llvm_ver:=3.8.0}
: ${boost_ver:=1_61_0}
: ${mingw_w64_ver:=4.0.6}

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
		Target-triplet of new toolchain, currently '${target}'.
		ex. armv7l-linux-gnueabihf
			x86_64-linux-gnu
			i686-unknown-linux
			microblaze-none-linux
	-j jobs
		The number of processes invoked simultaneously by 'make', currently '${jobs}'.
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
	tar_ver
		Specify the version of GNU tar you want, currently '${tar_ver}'.
	xz_ver
		Specify the version of xz utils, currently '${xz_ver}'.
	bzip2_ver
		Specify the version of bzip2 you want, currently '${bzip2_ver}'.
	gzip_ver
		Specify the version of GNU gzip you want, currently '${gzip_ver}'.
	wget_ver
		Specify the version of GNU wget you want, currently '${wget_ver}'.
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
	emacs_ver
		Specify the version of GNU Emacs you want, currently '${emacs_ver}'.
	vim_ver
		Specify the version of Vim, currently '${vim_ver}'.
	grep_ver
		Specify the version of GNU Grep you want, currently '${grep_ver}'.
	global_ver
		Specify the version of GNU Global you want, currently '${global_ver}'.
	diffutils_ver
		Specify the version of GNU diffutils you want, currently '${diffutils_ver}'.
	patch_ver
		Specify the version of GNU Patch you want, currently '${patch_ver}'.
	findutils_ver
		Specify the version of GNU findutils you want, currently'${findutils_ver}'.
	screen_ver
		Specify the version of GNU Screen you want, currently '${screen_ver}'.
	zsh_ver
		Specify the version of Zsh you want, currently '${zsh_ver}'.
	openssl_ver
		Specify the version of openssl you want, currently '${openssl_ver}'.
	curl_ver
		Specify the version of Curl you want, currently '${libcur_ver}'.
	asciidoc_ver
		Specify the version of asciidoc you want, currently '${asciidoc_ver}'.
	xmlto_ver
		Specify the version of xmlto you want, currently '${xmlto_ver}'.
	libxml2_ver
		Specify the version of libxml2 you want, currently '${libxml2_ver}'.
	libxslt_ver
		Specify the version of libxslt you want, currently '${libxslt_ver}'.
	gettext_ver
		Specify the version of gettext you want, currently '${gettext_ver}'.
	git_ver
		Specify the version of Git you want, currently '${git_ver}'.
	cmake_ver
		Specify the version of Cmake you want, currently '${cmake_ver}'.
	llvm_ver
		Specify the version of llvm you want, currently '${llvm_ver}'.
	boost_ver
		Specify the version of boost you want, currently '${boost_ver}'.
	mingw_w64_ver
		Specify the version of mingw-w64 you want, currently '${mingw_w64_ver}'.

[Examples]
	For Raspberry pi2
	# $0 -p /toolchains -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 kernel_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 cross

	For microblaze
	# $0 -p /toolchains -t microblaze-linux-gnu -j 8 binutils_ver=2.25 kernel_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 cross

EOF
}

native()
# Install native GNU Toolchain, such as GNU binutils, GNU C/C++/Go compiler, GDB(running on and compiles for '${build}').
{
	install_native_binutils || return 1
	install_native_gcc || return 1
	install_native_gdb || return 1
}

cross()
# Install cross GNU Toolchain, such as GNU binutils, GNU C/C++/Go compiler, GDB(running on '${build}', compiles for '${target}').
{
	install_cross_binutils || return 1
	install_cross_gcc || return 1
	install_cross_gdb || return 1
}

all()
# Both of 'native' and 'cross'.
{
	native || return 1
	cross || return 1
}

full()
# Install native/cross GNU toolchain and other tools. as many as possible.
{
	full_native || return 1
	full_cross || return 1
}

auto()
# Perform auto installation for all available toolchains and other tools.
{
	prepare || return 1
	full || return 1
	clean || return 1
	strip || return 1
	archive || return 1
}

prepare()
# Prepare all source files.
{
	for prepare_command in `grep -e '^prepare_.\+_source()$' $0 | sed -e 's/()$//'`; do ${prepare_command} || return 1; done
}

clean()
# Delete no longer required source trees.
{
	rm -rf \
		${tar_org_src_dir} \
		${xz_org_src_dir} \
		${bzip2_org_src_dir} \
		${gzip_org_src_dir} \
		${wget_org_src_dir} \
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
		${kernel_org_src_dir} ${kernel_src_dir_ntv} ${kernel_src_dir_crs} \
		${gperf_org_src_dir} \
		${glibc_org_src_dir} ${glibc_bld_dir_ntv} ${glibc_src_dir_ntv} \
		${glibc_bld_dir_crs_hdr} ${glibc_bld_dir_crs_1st} ${glibc_src_dir_crs_hdr} ${glibc_src_dir_crs_1st} \
		${gmp_src_dir_ntv} ${gmp_src_dir_crs_ntv} \
		${mpfr_src_dir_ntv} ${mpfr_src_dir_crs_ntv} \
		${mpc_src_dir_ntv} ${mpc_src_dir_crs_ntv} \
		${gcc_org_src_dir} ${gcc_bld_dir_ntv} \
		${gcc_bld_dir_crs_1st} ${gcc_bld_dir_crs_2nd} ${gcc_bld_dir_crs_3rd} \
		${gcc_bld_dir_crs_ntv} \
		${ncurses_org_src_dir} \
		${gdb_org_src_dir} ${gdb_bld_dir_ntv} ${gdb_bld_dir_crs} \
		${libpng_src_dir_ntv} ${libpng_src_dir_crs_ntv} \
		${libtiff_src_dir_ntv} ${libtiff_src_dir_crs_ntv} \
		${libjpeg_src_dir_ntv} \
		${giflib_src_dir_ntv} \
		${emacs_org_src_dir} \
		${vim_org_src_dir} \
		${grep_org_src_dir} \
		${global_org_src_dir} \
		${diffutils_org_src_dir} \
		${patch_org_src_dir} \
		${findutils_org_src_dir} \
		${screen_org_src_dir} \
		${zsh_org_src_dir} \
		${openssl_org_src_dir} \
		${curl_org_src_dir} \
		${asciidoc_org_src_dir} \
		${xmlto_org_src_dir} \
		${libxml2_org_src_dir} \
		${libxslt_org_src_dir} \
		${gettext_org_src_dir} \
		${git_org_src_dir} \
		${zlib_src_dir_ntv} ${zlib_src_dir_crs_ntv} \
		${cmake_org_src_dir} \
		${llvm_org_src_dir} ${llvm_bld_dir} \
		${clang_org_src_dir} ${clang_bld_dir} \
		${clang_rt_org_src_dir} ${clang_rt_bld_dir} \
		${libcxx_org_src_dir} ${libcxx_bld_dir} \
		${libcxxabi_org_src_dir} ${libcxxabi_bld_dir} \
		${clang_extra_org_src_dir} ${clang_extra_bld_dir} \
		${lld_org_src_dir} ${lld_bld_dir} \
		${lldb_org_src_dir} ${lldb_bld_dir} \
		${boost_org_src_dir} \
		${mingw_w64_org_src_dir} ${mingw_w64_bld_dir_hdr} ${mingw_w64_bld_dir_1st} ${mingw_w64_src_dir_hdr} ${mingw_w64_src_dir_1st}
}

strip()
# Strip all binary files.
{
	for strip in strip ${target}-strip; do
		find ${prefix} -type f -perm /111 | xargs file | grep 'not stripped' | cut -f1 -d: | xargs ${strip} || true
	done
}

archive()
# Archive related files.
{
	[ ${prefix}/src = `dirname $0` ] || cp -vf $0 ${prefix}/src || return 1
	convert_archives || return 1
	tar cJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz -C `dirname ${prefix}` `basename ${prefix}` || return 1
}

deploy()
# Deploy related files.
{
	tar xJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz --no-same-owner --no-same-permissions -C `dirname ${prefix}` || return 1
	update_search_path || return 1
	echo Please add ${prefix}/bin to PATH
}

list()
# List all tags, which include the ones not listed here.
{
	list_all
}

reset()
# Reset 'prefix' except 'prefix/src/'.
{
	clean
	find ${prefix} -mindepth 1 -maxdepth 1 ! -name src -exec rm -rf '{}' +
	rm  -f /etc/ld.so.conf.d/`basename ${prefix}`.conf
	ldconfig || true
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

set_variables()
{
	prefix=`readlink -m ${prefix}`
	: ${sysroot:=${prefix}/${target}/sysroot}
	: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
	build=`uname -m`-linux-gnu
	os=`head -1 /etc/issue | cut -d ' ' -f 1`

	case ${build} in
	arm*)        native_linux_arch=arm;;
	i?86*)       native_linux_arch=x86;;
	microblaze*) native_linux_arch=microblaze;;
	x86_64*)     native_linux_arch=x86;;
	*) echo Unknown build architecture: ${build} >&2; return 1;;
	esac
	case ${target} in
	arm*)        cross_linux_arch=arm;;
	i?86*)       cross_linux_arch=x86;;
	microblaze*) cross_linux_arch=microblaze;;
	x86_64*)     cross_linux_arch=x86;;
	*) echo Unknown target architecture: ${target} >&2; return 1;;
	esac

	tar_name=tar-${tar_ver}
	tar_src_base=${prefix}/src/tar
	tar_org_src_dir=${tar_src_base}/${tar_name}

	xz_name=xz-${xz_ver}
	xz_src_base=${prefix}/src/xz
	xz_org_src_dir=${xz_src_base}/${xz_name}

	bzip2_name=bzip2-${bzip2_ver}
	bzip2_src_base=${prefix}/src/bzip2
	bzip2_org_src_dir=${bzip2_src_base}/${bzip2_name}

	gzip_name=gzip-${gzip_ver}
	gzip_src_base=${prefix}/src/gzip
	gzip_org_src_dir=${gzip_src_base}/${gzip_name}

	wget_name=wget-${wget_ver}
	wget_src_base=${prefix}/src/wget
	wget_org_src_dir=${wget_src_base}/${wget_name}

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
	kernel_src_dir_ntv=${kernel_src_base}/${kernel_name}-ntv
	kernel_src_dir_crs=${kernel_src_base}/${target}-${kernel_name}

	gperf_name=gperf-${gperf_ver}
	gperf_src_base=${prefix}/src/gperf
	gperf_org_src_dir=${gperf_src_base}/${gperf_name}

	glibc_name=glibc-${glibc_ver}
	glibc_src_base=${prefix}/src/glibc
	glibc_org_src_dir=${glibc_src_base}/${glibc_name}
	glibc_bld_dir_ntv=${glibc_src_base}/${glibc_name}-bld
	glibc_src_dir_ntv=${glibc_src_base}/${glibc_name}-src
	glibc_bld_dir_crs_hdr=${glibc_src_base}/${target}-${glibc_name}-bld-hdr
	glibc_bld_dir_crs_1st=${glibc_src_base}/${target}-${glibc_name}-bld-1st
	glibc_src_dir_crs_hdr=${glibc_src_base}/${target}-${glibc_name}-src-hdr
	glibc_src_dir_crs_1st=${glibc_src_base}/${target}-${glibc_name}-src-1st

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

	emacs_name=emacs-${emacs_ver}
	emacs_src_base=${prefix}/src/emacs
	emacs_org_src_dir=${emacs_src_base}/${emacs_name}

	vim_name=vim-${vim_ver}
	vim_src_base=${prefix}/src/vim
	vim_org_src_dir=${vim_src_base}/${vim_name}

	grep_name=grep-${grep_ver}
	grep_src_base=${prefix}/src/grep
	grep_org_src_dir=${grep_src_base}/${grep_name}

	global_name=global-${global_ver}
	global_src_base=${prefix}/src/global
	global_org_src_dir=${global_src_base}/${global_name}

	diffutils_name=diffutils-${diffutils_ver}
	diffutils_src_base=${prefix}/src/diffutils
	diffutils_org_src_dir=${diffutils_src_base}/${diffutils_name}

	patch_name=patch-${patch_ver}
	patch_src_base=${prefix}/src/patch
	patch_org_src_dir=${patch_src_base}/${patch_name}

	findutils_name=findutils-${findutils_ver}
	findutils_src_base=${prefix}/src/findutils
	findutils_org_src_dir=${findutils_src_base}/${findutils_name}

	screen_name=screen-${screen_ver}
	screen_src_base=${prefix}/src/screen
	screen_org_src_dir=${screen_src_base}/${screen_name}

	zsh_name=zsh-${zsh_ver}
	zsh_src_base=${prefix}/src/zsh
	zsh_org_src_dir=${zsh_src_base}/${zsh_name}

	openssl_name=openssl-${openssl_ver}
	openssl_src_base=${prefix}/src/openssl
	openssl_org_src_dir=${openssl_src_base}/${openssl_name}

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

	libxslt_name=libxslt-${libxslt_ver}
	libxslt_src_base=${prefix}/src/libxslt
	libxslt_org_src_dir=${libxslt_src_base}/${libxslt_name}

	gettext_name=gettext-${gettext_ver}
	gettext_src_base=${prefix}/src/gettext
	gettext_org_src_dir=${gettext_src_base}/${gettext_name}

	git_name=git-${git_ver}
	git_src_base=${prefix}/src/git
	git_org_src_dir=${git_src_base}/${git_name}

	cmake_name=cmake-${cmake_ver}
	cmake_src_base=${prefix}/src/cmake
	cmake_org_src_dir=${cmake_src_base}/${cmake_name}

	llvm_name=llvm-${llvm_ver}.src
	llvm_src_base=${prefix}/src/llvm
	llvm_org_src_dir=${llvm_src_base}/${llvm_name}
	llvm_bld_dir=${llvm_src_base}/${llvm_name}-build

	libcxx_name=libcxx-${llvm_ver}.src
	libcxx_src_base=${prefix}/src/libc++
	libcxx_org_src_dir=${libcxx_src_base}/${libcxx_name}
	libcxx_bld_dir=${libcxx_src_base}/${libcxx_name}-build

	libcxxabi_name=libcxxabi-${llvm_ver}.src
	libcxxabi_src_base=${prefix}/src/libc++abi
	libcxxabi_org_src_dir=${libcxxabi_src_base}/${libcxxabi_name}
	libcxxabi_bld_dir=${libcxxabi_src_base}/${libcxxabi_name}-build

	clang_rt_name=compiler-rt-${llvm_ver}.src
	clang_rt_src_base=${prefix}/src/clang-rt
	clang_rt_org_src_dir=${clang_rt_src_base}/${clang_rt_name}
	clang_rt_bld_dir=${clang_rt_src_base}/${clang_rt_name}-build

	clang_name=cfe-${llvm_ver}.src
	clang_src_base=${prefix}/src/clang
	clang_org_src_dir=${clang_src_base}/${clang_name}
	clang_bld_dir=${clang_src_base}/${clang_name}-build

	clang_extra_name=clang-tools-extra-${llvm_ver}.src
	clang_extra_src_base=${prefix}/src/clang-tools-extra
	clang_extra_org_src_dir=${clang_extra_src_base}/${clang_extra_name}
	clang_extra_bld_dir=${clang_extra_src_base}/${clang_extra_name}-build

	lld_name=lld-${llvm_ver}.src
	lld_src_base=${prefix}/src/lld
	lld_org_src_dir=${lld_src_base}/${lld_name}
	lld_bld_dir=${lld_src_base}/${lld_name}-build

	lldb_name=lldb-${llvm_ver}.src
	lldb_src_base=${prefix}/src/lldb
	lldb_org_src_dir=${lldb_src_base}/${lldb_name}
	lldb_bld_dir=${lldb_src_base}/${lldb_name}-build

	boost_name=boost_${boost_ver}
	boost_src_base=${prefix}/src/boost
	boost_org_src_dir=${boost_src_base}/${boost_name}

	mingw_w64_name=mingw-w64-v${mingw_w64_ver}
	mingw_w64_src_base=${prefix}/src/mingw-w64
	mingw_w64_org_src_dir=${mingw_w64_src_base}/${mingw_w64_name}
	mingw_w64_bld_dir_hdr=${mingw_w64_src_base}/${mingw_w64_name}-bld-hdr
	mingw_w64_bld_dir_1st=${mingw_w64_src_base}/${mingw_w64_name}-bld-1st
	mingw_w64_src_dir_hdr=${mingw_w64_src_base}/${mingw_w64_name}-src-hdr
	mingw_w64_src_dir_1st=${mingw_w64_src_base}/${mingw_w64_name}-src-1st

	echo ${PATH} | tr : '\n' | grep -q -e ^${prefix}/bin\$ || PATH=${prefix}/bin:${PATH}
	echo ${PATH} | tr : '\n' | grep -q -e ^/sbin\$         || PATH=/sbin:${PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -q -e ^${prefix}/lib64\$ || LD_LIBRARY_PATH=${prefix}/lib64:${LD_LIBRARY_PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -q -e ^${prefix}/lib\$   || LD_LIBRARY_PATH=${prefix}/lib:${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH
}

convert_archives()
{
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.gz'  -execdir sh -c '[ -f `basename {} .gz`.xz      ] && exit 0; gzip  -cdv {} | xz -c > `basename {} .gz`.xz'  \; -delete || return 1
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.bz2' -execdir sh -c '[ -f `basename {} .bz2`.xz     ] && exit 0; bzip2 -cdv {} | xz -c > `basename {} .bz2`.xz' \; -delete || return 1
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.zip'     -execdir sh -c '[ -f `basename {} .zip`.tar.xz ] && exit 0; unzip      {} && tar cJvf `basename {} .zip`.tar.xz `basename {} .zip`' \; -delete || return 1
}

archive_sources()
{
	prepare || return 1
	clean
	convert_archives || return 1
	tar cJvf ${prefix}/src.tar.xz -C ${prefix} src
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

update_search_path()
{
	[ `id -ur` !=  0 ] && return 0
	[ -f /etc/ld.so.conf.d/`basename ${prefix}`.conf ] ||
		echo \
"${prefix}/lib
${prefix}/lib64
${prefix}/lib32" > /etc/ld.so.conf.d/`basename ${prefix}`.conf || return 1
	ldconfig || return 1
	# grep -q -e ${prefix}/share/man /etc/manpath.config || sed -e "\$s+\$+\nMANDATORY_MANPATH ${prefix}/share/man+" -i /etc/manpath.config || return 1
}

search_library()
{
	ldconfig -p | grep -q -e "\<$1\>"
}

search_header()
{
	for dir in ${prefix}/include /usr/local/include /opt/include /usr/include; do
		[ -d ${dir}/$2 ] &&  [ `find ${dir}/$2 -type f -name "$1" | wc -l` != 0 ] && return 0
	done
	return 1
}

install_prerequisites()
{
	[ -n "${prerequisites_have_been_already_installed}" ] && return 0
	case ${os} in
	Debian|Ubuntu|Raspbian)
		apt-get install -y make gcc g++ texinfo || return 1
		apt-get install -y unifdef || return 1 # for linux kernel(microblaze)
		apt-get install -y libgtk-3-dev || return 1 # for emacs
		apt-get install -y python2.7-dev || return 1 # for gdb
		apt-get install -y libperl-dev python-dev python3-dev ruby-dev || return 1 # for vim
		apt-get install -y ruby || return 1 # for vim
		apt-get install -y lua5.2 liblua5.2-dev || return 1 # for vim
		apt-get install -y luajit libluajit-5.1 || return 1 # for vim
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ texinfo || return 1
		yum install -y unifdef || return 1
		yum install -y gtk3-devel || return 1
		yum install -y python-devel || return 1
		yum install -y perl-devel python-devel python3-devel ruby-devel || return 1
		yum install -y ruby || return 1
		yum install -y lua lua-devel || return 1
		yum install -y luajit luajit-devel || return 1
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1 ;;
	esac
	prerequisites_have_been_already_installed=yes
}

check_archive()
{
	[ -f $1.tar.gz  ] && return 0
	[ -f $1.tar.bz2 ] && return 0
	[ -f $1.tar.xz  ] && return 0
	[ -f $1.zip     ] && return 0
	return 1
}

unpack_archive()
{
	[ -d $1 ] && return 0
	[ -f $1.tar.gz  ] && tar xzvf $1.tar.gz  --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.tar.bz2 ] && tar xjvf $1.tar.bz2 --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.tar.xz  ] && tar xJvf $1.tar.xz  --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.zip     ] && unzip -d $2 $1.zip         && return 0
	return 1
}

prepare_tar_source()
{
	mkdir -p ${tar_src_base}
	check_archive ${tar_org_src_dir} ||
		wget -O ${tar_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/tar/${tar_name}.tar.bz2 || return 1
}

prepare_xz_source()
{
	mkdir -p ${xz_src_base}
	check_archive ${xz_org_src_dir} ||
		wget -O ${xz_org_src_dir}.tar.bz2 \
			http://tukaani.org/xz/${xz_name}.tar.bz2 || return 1
}

prepare_bzip2_source()
{
	mkdir -p ${bzip2_src_base}
	check_archive ${bzip2_org_src_dir} ||
		wget -O ${bzip2_org_src_dir}.tar.gz \
			http://www.bzip.org/${bzip2_ver}/${bzip2_name}.tar.gz || return 1
}

prepare_gzip_source()
{
	mkdir -p ${gzip_src_base}
	check_archive ${gzip_org_src_dir} ||
		wget -O ${gzip_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gzip/${gzip_name}.tar.xz || return 1
}

prepare_wget_source()
{
	mkdir -p ${wget_src_base}
	check_archive ${wget_org_src_dir} ||
		wget -O ${wget_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/wget/${wget_name}.tar.xz || return 1
}

prepare_coreutils_source()
{
	mkdir -p ${coreutils_src_base}
	check_archive ${coreutils_org_src_dir} ||
		wget -O ${coreutils_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/coreutils/${coreutils_name}.tar.xz || return 1
}

prepare_bison_source()
{
	mkdir -p ${bison_src_base}
	check_archive ${bison_org_src_dir} ||
		wget -O ${bison_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/bison/${bison_name}.tar.xz || return 1
}

prepare_flex_source()
{
	mkdir -p ${flex_src_base}
	check_archive ${flex_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${flex_org_src_dir}.tar.xz \
			https://sourceforge.net/projects/flex/files/${flex_name}.tar.xz/download || return 1
}

prepare_m4_source()
{
	mkdir -p ${m4_src_base}
	check_archive ${m4_org_src_dir} ||
		wget -O ${m4_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/m4/${m4_name}.tar.xz || return 1
}

prepare_autoconf_source()
{
	mkdir -p ${autoconf_src_base}
	check_archive ${autoconf_org_src_dir} ||
		wget -O ${autoconf_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/autoconf/${autoconf_name}.tar.xz || return 1
}

prepare_automake_source()
{
	mkdir -p ${automake_src_base}
	check_archive ${automake_org_src_dir} ||
		wget -O ${automake_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/automake/${automake_name}.tar.xz || return 1
}

prepare_libtool_source()
{
	mkdir -p ${libtool_src_base}
	check_archive ${libtool_org_src_dir} ||
		wget -O ${libtool_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/libtool/${libtool_name}.tar.xz || return 1
}

prepare_sed_source()
{
	mkdir -p ${sed_src_base}
	check_archive ${sed_org_src_dir} ||
		wget -O ${sed_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/sed/${sed_name}.tar.bz2 || return 1
}

prepare_gawk_source()
{
	mkdir -p ${gawk_src_base}
	check_archive ${gawk_org_src_dir} ||
		wget -O ${gawk_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gawk/${gawk_name}.tar.xz || return 1
}

prepare_make_source()
{
	mkdir -p ${make_src_base}
	check_archive ${make_org_src_dir} ||
		wget -O ${make_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/make/${make_name}.tar.bz2 || return 1
}

prepare_binutils_source()
{
	mkdir -p ${binutils_src_base}
	check_archive ${binutils_org_src_dir} ||
		wget -O ${binutils_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/binutils/${binutils_name}.tar.bz2 || return 1
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
	check_archive ${kernel_org_src_dir} ||
		wget --no-check-certificate -O ${kernel_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/kernel/${dir}/${kernel_name}.tar.xz || return 1
}

prepare_gperf_source()
{
	mkdir -p ${gperf_src_base}
	check_archive ${gperf_org_src_dir} ||
		wget -O ${gperf_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/gperf/${gperf_name}.tar.gz || return 1
}

prepare_glibc_source()
{
	mkdir -p ${glibc_src_base}
	check_archive ${glibc_org_src_dir} ||
		wget -O ${glibc_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/glibc/${glibc_name}.tar.xz || return 1
}

prepare_gmp_mpfr_mpc_source()
{
	mkdir -p ${gmp_src_base}
	check_archive ${gmp_org_src_dir} ||
		wget -O ${gmp_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gmp/${gmp_name}.tar.xz || return 1
	mkdir -p ${mpfr_src_base}
	check_archive ${mpfr_org_src_dir} ||
		wget -O ${mpfr_org_src_dir}.tar.xz \
			http://www.mpfr.org/${mpfr_name}/${mpfr_name}.tar.xz || return 1
	mkdir -p ${mpc_src_base}
	check_archive ${mpc_org_src_dir} ||
		wget -O ${mpc_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/mpc/${mpc_name}.tar.gz || return 1
}

prepare_gcc_source()
{
	mkdir -p ${gcc_src_base}
	check_archive ${gcc_org_src_dir} ||
		wget -O ${gcc_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.bz2 || return 1
}

prepare_ncurses_source()
{
	mkdir -p ${ncurses_src_base}
	check_archive ${ncurses_org_src_dir} ||
		wget -O ${ncurses_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/ncurses/${ncurses_name}.tar.gz || return 1
}

prepare_gdb_source()
{
	mkdir -p ${gdb_src_base}
	check_archive ${gdb_org_src_dir} ||
		wget -O ${gdb_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gdb/${gdb_name}.tar.xz || return 1
}

prepare_zlib_source()
{
	mkdir -p ${zlib_src_base}
	check_archive ${zlib_org_src_dir} ||
		wget -O ${zlib_org_src_dir}.tar.xz \
			http://zlib.net/${zlib_name}.tar.xz || return 1
}

prepare_libpng_source()
{
	mkdir -p ${libpng_src_base}
	check_archive ${libpng_org_src_dir} ||
		wget --trust-server-names -O ${libpng_org_src_dir}.tar.xz \
			http://download.sourceforge.net/libpng/${libpng_name}.tar.xz || return 1
}

prepare_libtiff_source()
{
	mkdir -p ${libtiff_src_base}
	check_archive ${libtiff_org_src_dir} ||
		wget -O ${libtiff_org_src_dir}.tar.gz \
			ftp://ftp.remotesensing.org/pub/libtiff/${libtiff_name}.tar.gz || return 1
}

prepare_libjpeg_source()
{
	mkdir -p ${libjpeg_src_base}
	check_archive ${libjpeg_org_src_dir} ||
		wget -O ${libjpeg_org_src_dir}.tar.gz \
			http://www.ijg.org/files/${libjpeg_name}.tar.gz || return 1
}

prepare_giflib_source()
{
	mkdir -p ${giflib_src_base}
	check_archive ${giflib_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${giflib_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/giflib/files/${giflib_name}.tar.bz2/download || return 1
}

prepare_emacs_source()
{
	mkdir -p ${emacs_src_base}
	check_archive ${emacs_org_src_dir} ||
		wget -O ${emacs_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/emacs/${emacs_name}.tar.xz || return 1
}

prepare_vim_source()
{
	mkdir -p ${vim_src_base}
	check_archive ${vim_org_src_dir} ||
		wget --no-check-certificate -O ${vim_org_src_dir}.tar.gz \
			http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return 1
}

prepare_grep_source()
{
	mkdir -p ${grep_src_base}
	check_archive ${grep_org_src_dir} ||
		wget -O ${grep_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/grep/${grep_name}.tar.xz || return 1
}

prepare_global_source()
{
	mkdir -p ${global_src_base}
	check_archive ${global_org_src_dir} ||
		wget -O ${global_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/global/${global_name}.tar.gz || return 1
}

prepare_diffutils_source()
{
	mkdir -p ${diffutils_src_base}
	check_archive ${diffutils_org_src_dir} ||
		wget -O ${diffutils_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/diffutils/${diffutils_name}.tar.xz || return 1
}

prepare_patch_source()
{
	mkdir -p ${patch_src_base}
	check_archive ${patch_org_src_dir} ||
		wget -O ${patch_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/patch/${patch_name}.tar.xz || return 1
}

prepare_findutils_source()
{
	mkdir -p ${findutils_src_base}
	check_archive ${findutils_org_src_dir} ||
		wget -O ${findutils_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/findutils/${findutils_name}.tar.gz || return 1
}

prepare_screen_source()
{
	mkdir -p ${screen_src_base}
	check_archive ${screen_org_src_dir} ||
		wget -O ${screen_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/screen/${screen_name}.tar.gz || return 1
}

prepare_zsh_source()
{
	mkdir -p ${zsh_src_base}
	check_archive ${zsh_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${zsh_org_src_dir}.tar.xz \
			https://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.xz/download || return 1
}

prepare_openssl_source()
{
	mkdir -p ${openssl_src_base}
	check_archive ${openssl_org_src_dir} ||
		wget --no-check-certificate -O ${openssl_org_src_dir}.tar.gz \
			http://www.openssl.org/source/old/`echo ${openssl_ver} | sed -e 's/[a-z]//g'`/${openssl_name}.tar.gz || return 1
}

prepare_curl_source()
{
	mkdir -p ${curl_src_base}
	check_archive ${curl_org_src_dir} ||
		wget --no-check-certificate -O ${curl_org_src_dir}.tar.bz2 \
			https://curl.haxx.se/download/${curl_name}.tar.bz2 || return 1
}

prepare_asciidoc_source()
{
	mkdir -p ${asciidoc_src_base}
	check_archive ${asciidoc_org_src_dir} ||
		wget --no-check-certificate -O ${asciidoc_org_src_dir}.tar.gz \
			https://sourceforge.net/projects/asciidoc/files/asciidoc/${asciidoc_ver}/${asciidoc_name}.tar.gz/download || return 1
}

prepare_xmlto_source()
{
	mkdir -p ${xmlto_src_base}
	check_archive ${xmlto_org_src_dir} ||
		wget --no-check-certificate -O ${xmlto_org_src_dir}.tar.bz2 \
			https://fedorahosted.org/releases/x/m/xmlto/${xmlto_name}.tar.bz2 || return 1
}

prepare_libxml2_source()
{
	mkdir -p ${libxml2_src_base}
	check_archive ${libxml2_org_src_dir} ||
		wget -O ${libxml2_org_src_dir}.tar.gz \
			ftp://xmlsoft.org/libxml2/${libxml2_name}.tar.gz || return 1
}

prepare_libxslt_source()
{
	mkdir -p ${libxslt_src_base}
	check_archive ${libxslt_org_src_dir} ||
		wget -O ${libxslt_org_src_dir}.tar.gz \
			ftp://xmlsoft.org/libxml2/${libxslt_name}.tar.gz || return 1
}

prepare_gettext_source()
{
	mkdir -p ${gettext_src_base}
	check_archive ${gettext_org_src_dir} ||
		wget -O ${gettext_org_src_dir}.tar.xz \
			http://ftp.gnu.org/pub/gnu/gettext/${gettext_name}.tar.xz || return 1
}

prepare_git_source()
{
	mkdir -p ${git_src_base}
	check_archive ${git_org_src_dir} ||
		wget --no-check-certificate -O ${git_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return 1
}

prepare_cmake_source()
{
	mkdir -p ${cmake_src_base}
	check_archive ${cmake_org_src_dir} ||
		wget --no-check-certificate -O ${cmake_org_src_dir}.tar.gz \
			https://cmake.org/files/v`echo ${cmake_ver} | cut -f1,2 -d.`/${cmake_name}.tar.gz || return 1
}

prepare_llvm_source()
{
	mkdir -p ${llvm_src_base}
	check_archive ${llvm_org_src_dir} ||
		wget -O ${llvm_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${llvm_name}.tar.xz || return 1
}

prepare_libcxx_source()
{
	mkdir -p ${libcxx_src_base}
	check_archive ${libcxx_org_src_dir} ||
		wget -O ${libcxx_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${libcxx_name}.tar.xz || return 1
}

prepare_libcxxabi_source()
{
	mkdir -p ${libcxxabi_src_base}
	check_archive ${libcxxabi_org_src_dir} ||
		wget -O ${libcxxabi_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${libcxxabi_name}.tar.xz || return 1
}

prepare_clang_rt_source()
{
	mkdir -p ${clang_rt_src_base}
	check_archive ${clang_rt_org_src_dir} ||
		wget -O ${clang_rt_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${clang_rt_name}.tar.xz || return 1
}

prepare_clang_source()
{
	mkdir -p ${clang_src_base}
	check_archive ${clang_org_src_dir} ||
		wget -O ${clang_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${clang_name}.tar.xz || return 1
}

prepare_clang_extra_source()
{
	mkdir -p ${clang_extra_src_base}
	check_archive ${clang_extra_org_src_dir} ||
		wget -O ${clang_extra_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${clang_extra_name}.tar.xz || return 1
}

prepare_lld_source()
{
	mkdir -p ${lld_src_base}
	check_archive ${lld_org_src_dir} ||
		wget -O ${lld_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${lld_name}.tar.xz || return 1
}

prepare_lldb_source()
{
	mkdir -p ${lldb_src_base}
	check_archive ${lldb_org_src_dir} ||
		wget -O ${lldb_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${lldb_name}.tar.xz || return 1
}

prepare_boost_source()
{
	mkdir -p ${boost_src_base}
	check_archive ${boost_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${boost_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/boost/files/boost/`echo ${boost_ver} | tr _ .`/${boost_name}.tar.bz2/download || return 1
}

prepare_mingw_w64_source()
{
	mkdir -p ${mingw_w64_src_base}
	check_archive ${mingw_w64_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${mingw_w64_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v${mingw_w64_ver}.tar.bz2/download || return 1
}

install_native_tar()
{
	[ -x ${prefix}/bin/tar -a -z "${force_install}" ] && return 0
	which xz > /dev/null || install_native_xz || return 1
	prepare_tar_source || return 1
	unpack_archive ${tar_org_src_dir} ${tar_src_base} || return 1
	[ -f ${tar_org_src_dir}/Makefile ] ||
		(cd ${tar_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${tar_org_src_dir} -j ${jobs} || return 1
	make -C ${tar_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_xz()
{
	[ -x ${prefix}/bin/xz -a -z "${force_install}" ] && return 0
	prepare_xz_source || return 1
	unpack_archive ${xz_org_src_dir} ${xz_src_base} || return 1
	[ -f ${xz_org_src_dir}/Makefile ] ||
		(cd ${xz_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${xz_org_src_dir} -j ${jobs} || return 1
	make -C ${xz_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_bzip2()
{
	[ -x ${prefix}/bin/bzip2 -a -z "${force_install}" ] && return 0
	prepare_bzip2_source || return 1
	unpack_archive ${bzip2_org_src_dir} ${bzip2_src_base} || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return 1
}

install_native_gzip()
{
	[ -x ${prefix}/bin/gzip -a -z "${force_install}" ] && return 0
	prepare_gzip_source || return 1
	unpack_archive ${gzip_org_src_dir} ${gzip_src_base} || return 1
	[ -f ${gzip_org_src_dir}/Makefile ] ||
		(cd ${gzip_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gzip_org_src_dir} -j ${jobs} || return 1
	make -C ${gzip_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_wget()
{
	[ -x ${prefix}/bin/wget -a -z "${force_install}" ] && return 0
	search_header ssl.h || install_native_openssl || return 1
	prepare_wget_source || return 1
	unpack_archive ${wget_org_src_dir} ${wget_src_base} || return 1
	[ -f ${wget_org_src_dir}/Makefile ] ||
		(cd ${wget_org_src_dir}
		OPENSSL_CFLAGS="-I${prefix}/include -L${prefix}/lib" OPENSSL_LIBS='-lssl -lcrypto' \
			./configure --prefix=${prefix} --build=${build} --with-ssl=openssl) || return 1
	make -C ${wget_org_src_dir} -j ${jobs} || return 1
	make -C ${wget_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_coreutils()
{
	[ -x ${prefix}/bin/cat -a -z "${force_install}" ] && return 0
	prepare_coreutils_source || return 1
	unpack_archive ${coreutils_org_src_dir} ${coreutils_src_base} || return 1
	[ -f ${coreutils_org_src_dir}/Makefile ] ||
		(cd ${coreutils_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_bison()
{
	[ -x ${prefix}/bin/bison -a -z "${force_install}" ] && return 0
	prepare_bison_source || return 1
	unpack_archive ${bison_org_src_dir} ${bison_src_base} || return 1
	[ -f ${bison_org_src_dir}/Makefile ] ||
		(cd ${bison_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${bison_org_src_dir} -j ${jobs} || return 1
	make -C ${bison_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_flex()
{
	[ -x ${prefix}/bin/flex -a -z "${force_install}" ] && return 0
	which yacc > /dev/null || install_native_bison || return 1
	prepare_flex_source || return 1
	unpack_archive ${flex_org_src_dir} ${flex_src_base} || return 1
	[ -f ${flex_org_src_dir}/Makefile ] ||
		(cd ${flex_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${flex_org_src_dir} -j ${jobs} || return 1
	make -C ${flex_org_src_dir} -j ${jobs} install-strip install-man || return 1
	update_search_path || return 1
}

install_native_m4()
{
	[ -x ${prefix}/bin/m4 -a -z "${force_install}" ] && return 0
	prepare_m4_source || return 1
	unpack_archive ${m4_org_src_dir} ${m4_src_base} || return 1
	[ -f ${m4_org_src_dir}/Makefile ] ||
		(cd ${m4_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${m4_org_src_dir} -j ${jobs} || return 1
	make -C ${m4_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_autoconf()
{
	[ -x ${prefix}/bin/autoconf -a -z "${force_install}" ] && return 0
	prepare_autoconf_source || return 1
	unpack_archive ${autoconf_org_src_dir} ${autoconf_src_base} || return 1
	[ -f ${autoconf_org_src_dir}/Makefile ] ||
		(cd ${autoconf_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} install || return 1
}

install_native_automake()
{
	[ -x ${prefix}/bin/automake -a -z "${force_install}" ] && return 0
	which autoconf > /dev/null || install_native_autoconf || return 1
	prepare_automake_source || return 1
	unpack_archive ${automake_org_src_dir} ${automake_src_base} || return 1
	[ -f ${automake_org_src_dir}/Makefile ] ||
		(cd ${automake_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${automake_org_src_dir} -j ${jobs} || return 1
	make -C ${automake_org_src_dir} -j ${jobs} install || return 1
}

install_native_libtool()
{
	[ -x ${prefix}/bin/libtool -a -z "${force_install}" ] && return 0
	which flex > /dev/null || install_native_flex || return 1
	prepare_libtool_source || return 1
	unpack_archive ${libtool_org_src_dir} ${libtool_src_base} || return 1
	[ -f ${libtool_org_src_dir}/Makefile ] ||
		(cd ${libtool_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} install || return 1
}

install_native_sed()
{
	[ -x ${prefix}/bin/sed -a -z "${force_install}" ] && return 0
	prepare_sed_source || return 1
	unpack_archive ${sed_org_src_dir} ${sed_src_base} || return 1
	[ -f ${sed_org_src_dir}/Makefile ] ||
		(cd ${sed_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${sed_org_src_dir} -j ${jobs} || return 1
	make -C ${sed_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_gawk()
{
	[ -x ${prefix}/bin/gawk -a -z "${force_install}" ] && return 0
	prepare_gawk_source || return 1
	unpack_archive ${gawk_org_src_dir} ${gawk_src_base} || return 1
	[ -f ${gawk_org_src_dir}/Makefile ] ||
		(cd ${gawk_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_make()
{
	[ -x ${prefix}/bin/make -a -z "${force_install}" ] && return 0
	prepare_make_source || return 1
	unpack_archive ${make_org_src_dir} ${make_src_base} || return 1
	[ -f ${make_org_src_dir}/Makefile ] ||
		(cd ${make_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --host=${build}) || return 1
	make -C ${make_org_src_dir} -j ${jobs} || return 1
	make -C ${make_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_binutils()
{
	[ -x ${prefix}/bin/as -a -z "${force_install}" ] && return 0
	which yacc > /dev/null || install_native_bison || return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_ntv} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return 1
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-sysroot=/ --enable-64-bit-bfd --enable-gold \
			# CFLAGS="${CFLAGS} -Wno-error=unused-const-variable" CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function"
		) || return 1
	make -C ${binutils_src_dir_ntv} -j ${jobs} || return 1
	make -C ${binutils_src_dir_ntv} -j ${jobs} install-strip || return 1
}

install_native_kernel_header()
{
	prepare_kernel_source || return 1
	[ -d ${kernel_src_dir_ntv} ] ||
		(unpack_archive ${kernel_org_src_dir} ${kernel_src_base} &&
			mv ${kernel_org_src_dir} ${kernel_src_dir_ntv}) || return 1
	make -C ${kernel_src_dir_ntv} -j ${jobs} mrproper || return 1
	make -C ${kernel_src_dir_ntv} -j ${jobs} \
		ARCH=${native_linux_arch} INSTALL_HDR_PATH=${prefix} headers_install || return 1
}

install_native_gperf()
{
	[ -x ${prefix}/bin/gperf -a -z "${force_install}" ] && return 0
	prepare_gperf_source || return 1
	unpack_archive ${gperf_org_src_dir} ${gperf_src_base} || return 1
	[ -f ${gperf_org_src_dir}/Makefile ] ||
		(cd ${gperf_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} install || return 1
}

install_native_glibc()
{
	[ -e ${prefix}/lib/libc.so -a -z "${force_install}" ] && return 0
	install_native_kernel_header || return 1
	which gperf > /dev/null || install_native_gperf || return 1
	prepare_glibc_source || return 1
	[ -d ${glibc_src_dir_ntv} ] ||
		(unpack_archive ${glibc_org_src_dir} ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_ntv}) || return 1

	mkdir -p ${glibc_bld_dir_ntv}
	[ -f ${glibc_bld_dir_ntv}/Makefile ] ||
		(cd ${glibc_bld_dir_ntv}
		LD_LIBRARY_PATH='' ${glibc_src_dir_ntv}/configure --prefix=${prefix} --build=${build} \
			--with-headers=/usr/include CPPFLAGS="${CPPFLAGS} -I/usr/include/${build} -D_LIBC") || return 1
	C_INCLUDE_PATH=/usr/include/${build} make -C ${glibc_bld_dir_ntv} -j ${jobs} install-headers || return 1
	C_INCLUDE_PATH=/usr/include/${build} make -C ${glibc_bld_dir_ntv} -j ${jobs} || return 1
	C_INCLUDE_PATH=/usr/include/${build} make -C ${glibc_bld_dir_ntv} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_gmp_mpfr_mpc()
{
	[ -e ${prefix}/lib/libgmp.so -a -e ${prefix}/lib/libmpfr.so -a -e ${prefix}/lib/libmpc.so -a -z "${force_install}" ] && return 0
	prepare_gmp_mpfr_mpc_source || return 1

	[ -d ${gmp_src_dir_ntv} ] ||
		(unpack_archive ${gmp_org_src_dir} ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return 1
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		./configure --prefix=${prefix} --enable-cxx) || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} install-strip || return 1

	[ -d ${mpfr_src_dir_ntv} ] ||
		(unpack_archive ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return 1
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		./configure --prefix=${prefix} --with-gmp=${prefix}) || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} install-strip || return 1

	[ -d ${mpc_src_dir_ntv} ] ||
		(unpack_archive ${mpc_org_src_dir} ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return 1
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		./configure --prefix=${prefix} --with-gmp=${prefix} --with-mpfr=${prefix}) || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} install-strip || return 1

	update_search_path || return 1
}

make_symbolic_links()
{
	case ${os} in
	Debian|Ubuntu|Raspbian)
		for dir in asm bits gnu sys; do
			[ -d /usr/include/${dir} ] || ln -s ./${build}/${dir} /usr/include/${dir} || return 1
		done
		for obj in crt1.o crti.o crtn.o; do
			[ -f /usr/lib/${obj} ] || ln -s ./${build}/${obj} /usr/lib/${obj} || return 1
		done
		;;
	esac
}

install_native_gcc()
{
	[ -x ${prefix}/bin/gcc -a -z "${force_install}" ] && return 0
# install_native_glibc || return 1 # DANGEROUS!! pay attention to glibc version(compatibility)
	search_header zlib.h || install_native_zlib || return 1
	search_header mpc.h || install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	make_symbolic_links || return 1
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_ntv}
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c,c++,go --disable-multilib --without-isl --with-system-zlib) || return 1 # ARMの場合右記オプションが必要。--with-arch=armv6 --with-fpu=vfp --with-float=hard
	make -C ${gcc_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_ntv} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_ncurses()
{
	[ -e ${prefix}/lib/libncurses.so -a -z "${force_install}" ] && return 0
	prepare_ncurses_source || return 1
	unpack_archive ${ncurses_org_src_dir} ${ncurses_src_base} || return 1

	# workaround for GCC 5.x
	patch -N -p0 -d ${ncurses_org_src_dir} <<EOF || [ $? = 1 ]  || return 1
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
		./configure --prefix=${prefix} --with-shared --with-cxx-shared) || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_gdb()
{
	[ -x ${prefix}/bin/gdb -a -z "${force_install}" ] && return 0
	search_header curses.h || install_native_ncurses || return 1
	prepare_gdb_source || return 1
	unpack_archive ${gdb_org_src_dir} ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_ntv}
	[ -f ${gdb_bld_dir_ntv}/Makefile ] ||
		(cd ${gdb_bld_dir_ntv}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} --enable-tui --with-python) || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} install || return 1
}

install_native_zlib()
{
	[ -e ${prefix}/lib/libz.so -a -z "${force_install}" ] && return 0
	prepare_zlib_source || return 1
	[ -d ${zlib_src_dir_ntv} ] ||
		(unpack_archive ${zlib_org_src_dir} ${zlib_src_base} &&
			mv ${zlib_org_src_dir} ${zlib_src_dir_ntv}) || return 1
	(cd ${zlib_src_dir_ntv}
	./configure --prefix=${prefix}) || return 1
	make -C ${zlib_src_dir_ntv} -j ${jobs} || return 1
	make -C ${zlib_src_dir_ntv} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_libpng()
{
	[ -e ${prefix}/lib/libpng.so -a -z "${force_install}" ] && return 0
	search_header zlib.h || install_native_zlib || return 1
	prepare_libpng_source || return 1
	[ -d ${libpng_src_dir_ntv} ] ||
		(unpack_archive ${libpng_org_src_dir} ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_ntv}) || return 1
	[ -f ${libpng_src_dir_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	C_INCLUDE_PATH=${prefix}/include make -C ${libpng_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_ntv} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_libtiff()
{
	[ -e ${prefix}/lib/libtiff.so -a -z "${force_install}" ] && return 0
	prepare_libtiff_source || return 1
	[ -d ${libtiff_src_dir_ntv} ] ||
		(unpack_archive ${libtiff_org_src_dir} ${libtiff_src_base} &&
			mv ${libtiff_org_src_dir} ${libtiff_src_dir_ntv}) || return 1
	[ -f ${libtiff_src_dir_ntv}/Makefile ] ||
		(cd ${libtiff_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libtiff_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libtiff_src_dir_ntv} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_libjpeg()
{
	[ -e ${prefix}/lib/libjpeg.so -a -z "${force_install}" ] && return 0
	prepare_libjpeg_source || return 1
	[ -d ${libjpeg_src_dir_ntv} ] ||
		(unpack_archive ${libjpeg_org_src_dir} ${libjpeg_src_base} &&
			mv ${libjpeg_org_src_dir} ${libjpeg_src_dir_ntv}) || return 1
	[ -f ${libjpeg_src_dir_ntv}/Makefile ] ||
		(cd ${libjpeg_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libjpeg_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libjpeg_src_dir_ntv} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_giflib()
{
	[ -e ${prefix}/lib/libgif.so -a -z "${force_install}" ] && return 0
	prepare_giflib_source || return 1
	[ -d ${giflib_src_dir_ntv} ] ||
		(unpack_archive ${giflib_org_src_dir} ${giflib_src_base} &&
			mv ${giflib_org_src_dir} ${giflib_src_dir_ntv}) || return 1
	[ -f ${giflib_src_dir_ntv}/Makefile ] ||
		(cd ${giflib_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_emacs()
{
	[ -x ${prefix}/bin/emacs -a -z "${force_install}" ] && return 0
	search_header curses.h || install_native_ncurses || return 1
	search_header zlib.h || install_native_zlib || return 1
	search_header png.h || install_native_libpng || return 1
	search_header tiff.h || install_native_libtiff || return 1
	search_header jpeglib.h || install_native_libjpeg || return 1
	search_header gif_lib.h || install_native_giflib || return 1
	prepare_emacs_source || return 1
	unpack_archive ${emacs_org_src_dir} ${emacs_src_base} || return 1
	[ -f ${emacs_org_src_dir}/Makefile ] ||
		(cd ${emacs_org_src_dir}
		CPPFLAGS="${CPPFLAGS} -I${prefix}/include" LDFLAGS="${LDFLAGS} -L${prefix}/lib" \
			./configure --prefix=${prefix} --without-xpm) || return 1
	make -C ${emacs_org_src_dir} -j ${jobs} || return 1 # LDFLAGS=-L${prefix}/lib 
	make -C ${emacs_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_vim()
{
	[ -x ${prefix}/bin/vim -a -z "${force_install}" ] && return 0
	search_header curses.h || install_native_ncurses || return 1
	which gettext > /dev/null || install_native_gettext || return 1
	prepare_vim_source || return 1
	unpack_archive ${vim_org_src_dir} ${vim_src_base} || return 1
	(cd ${vim_org_src_dir}
	./configure --prefix=${prefix} --with-features=huge --enable-fail-if-missing \
		--enable-perlinterp=dynamic --enable-pythoninterp=dynamic --enable-python3interp=dynamic --enable-rubyinterp=dynamic \
		--enable-luainterp=dynamic --with-luajit \
		--enable-cscope --enable-multibyte --enable-xim \
		# --with-x --enable-fontset --enable-gui=gtk3
	) || return 1
	make -C ${vim_org_src_dir} -j ${jobs} || return 1
	make -C ${vim_org_src_dir} -j ${jobs} install || return 1
}

install_native_grep()
{
	[ -x ${prefix}/bin/grep -a -z "${force_install}" ] && return 0
	prepare_grep_source || return 1
	unpack_archive ${grep_org_src_dir} ${grep_src_base} || return 1
	[ -f ${grep_org_src_dir}/Makefile ] ||
		(cd ${grep_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${grep_org_src_dir} -j ${jobs} || return 1
	make -C ${grep_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_global()
{
	[ -x ${prefix}/bin/global -a -z "${force_install}" ] && return 0
	prepare_global_source || return 1
	unpack_archive ${global_org_src_dir} ${global_src_base} || return 1
	[ -f ${global_org_src_dir}/Makefile ] ||
		(cd ${global_org_src_dir}
		./configure --prefix=${prefix} --disable-gtagscscope CPPFLAGS="${CPPFLAGS} -I${prefix}/include/ncurses") || return 1
	make -C ${global_org_src_dir} -j ${jobs} || return 1
	make -C ${global_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_diffutils()
{
	[ -x ${prefix}/bin/diff -a -z "${force_install}" ] && return 0
	prepare_diffutils_source || return 1
	unpack_archive ${diffutils_org_src_dir} ${diffutils_src_base} || return 1
	[ -f ${diffutils_org_src_dir}/Makefile ] ||
		(cd ${diffutils_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${diffutils_org_src_dir} -j ${jobs} || return 1
	make -C ${diffutils_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_patch()
{
	[ -x ${prefix}/bin/patch -a -z "${force_install}" ] && return 0
	prepare_patch_source || return 1
	unpack_archive ${patch_org_src_dir} ${patch_src_base} || return 1
	[ -f ${patch_org_src_dir}/Makefile ] ||
		(cd ${patch_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${patch_org_src_dir} -j ${jobs} || return 1
	make -C ${patch_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_findutils()
{
	[ -x ${prefix}/bin/find -a -z "${force_install}" ] && return 0
	prepare_findutils_source || return 1
	unpack_archive ${findutils_org_src_dir} ${findutils_src_base} || return 1
	[ -f ${findutils_org_src_dir}/Makefile ] ||
		(cd ${findutils_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${findutils_org_src_dir} -j ${jobs} || return 1
	make -C ${findutils_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_screen()
{
	[ -x ${prefix}/bin/screen -a -z "${force_install}" ] && return 0
	prepare_screen_source || return 1
	unpack_archive ${screen_org_src_dir} ${screen_src_base} || return 1
	[ -f ${screen_org_src_dir}/Makefile ] ||
		(cd ${screen_org_src_dir}
		./configure --prefix=${prefix} --enable-colors256 --enable-rxvt_osc) || return 1
	make -C ${screen_org_src_dir} -j ${jobs} || return 1
	mkdir -p ${prefix}/share/screen/utf8encodings || return 1
	make -C ${screen_org_src_dir} -j ${jobs} install || return 1
}

install_native_zsh()
{
	[ -x ${prefix}/bin/zsh -a -z "${force_install}" ] && return 0
	search_header curses.h || install_native_ncurses || return 1
	prepare_zsh_source || return 1
	unpack_archive ${zsh_org_src_dir} ${zsh_src_base} || return 1
	[ -f ${zsh_org_src_dir}/Makefile ] ||
		(cd ${zsh_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --host=${build}) || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} install || return 1
}

install_native_openssl()
{
	[ \( -e ${prefix}/lib/libssl.so -o -e ${prefix}/lib64/libssl.so \) -a -z "${force_install}" ] && return 0
	prepare_openssl_source || return 1
	unpack_archive ${openssl_org_src_dir} ${openssl_src_base} || return 1
	(cd ${openssl_org_src_dir}
	./config --prefix=${prefix} shared) || return 1
	make -C ${openssl_org_src_dir} -j ${jobs} || return 1
	make -C ${openssl_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_curl()
{
	[ -x ${prefix}/bin/curl -a -z "${force_install}" ] && return 0
	search_header ssl.h || install_native_openssl || return 1
	prepare_curl_source || return 1
	unpack_archive ${curl_org_src_dir} ${curl_src_base} || return 1
	(cd ${curl_org_src_dir}
	./configure --prefix=${prefix} --build=${build} --host=${build} --enable-optimize --enable-ipv6 --with-ssl) || return 1
	make -C ${curl_org_src_dir} -j ${jobs} || return 1
	make -C ${curl_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_asciidoc()
{
	[ -x ${prefix}/bin/asciidoc -a -z "${force_install}" ] && return 0
	prepare_asciidoc_source || return 1
	unpack_archive ${asciidoc_org_src_dir} ${asciidoc_src_base} || return 1
	[ -f ${asciidoc_org_src_dir}/Makefile ] ||
		(cd ${asciidoc_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} install || return 1
}

install_native_xmlto()
{
	[ -x ${prefix}/bin/xmlto -a -z "${force_install}" ] && return 0
	prepare_xmlto_source || return 1
	unpack_archive ${xmlto_org_src_dir} ${xmlto_src_base} || return 1
	[ -f ${xmlto_org_src_dir}/Makefile ] ||
		(cd ${xmlto_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} install || return 1

# FIXME
# [ -d ${prefix}/share/docbook-xsl-1.79.1 ] || wget --trust-server-names -O- http://sourceforge.net/projects/docbook/files/docbook-xsl/1.79.1/docbook-xsl-1.79.1.tar.bz2/download | tar xjvf - -C ${prefix}/share
# [ -f ${prefix}/share/catalog.xml ] || (wget -O /tmp/hoge.zip http://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip && unzip -d ${prefix}/share /tmp/hoge.zip)
# export XML_CATALOG_FILES="${prefix}/share/catalog.xml ${prefix}/share/docbook-xsl-1.79.1/catalog.xml"
}

install_native_libxml2()
{
	[ -e ${prefix}/lib/libxml2.so -a -z "${force_install}" ] && return 0
	prepare_libxml2_source || return 1
	unpack_archive ${libxml2_org_src_dir} ${libxml2_src_base} || return 1
	[ -f ${libxml2_org_src_dir}/Makefile ] ||
		(cd ${libxml2_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_libxslt()
{
	[ -e ${prefix}/lib/libxslt.so -a -z "${force_install}" ] && return 0
	search_header xmlversion.h || install_native_libxml2 || return 1
	prepare_libxslt_source || return 1
	unpack_archive ${libxslt_org_src_dir} ${libxslt_src_base} || return 1
	[ -f ${libxslt_org_src_dir}/Makefile ] ||
		(cd ${libxslt_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libxslt_org_src_dir} -j ${jobs} || return 1
	make -C ${libxslt_org_src_dir} -j ${jobs} install-strip || return 1
}

install_native_gettext()
{
	[ -x ${prefix}/bin/gettext -a -z "${force_install}" ] && return 0
	prepare_gettext_source || return 1
	unpack_archive ${gettext_org_src_dir} ${gettext_src_base} || return 1
	[ -f ${gettext_org_src_dir}/Makefile ] ||
		(cd ${gettext_org_src_dir}
		./configure --prefix=${prefix}) || return 1
	make -C ${gettext_org_src_dir} -j ${jobs} || return 1
	make -C ${gettext_org_src_dir} -j ${jobs} install-strip || return 1
	update_search_path || return 1
}

install_native_git()
{
	[ -x ${prefix}/bin/git -a -z "${force_install}" ] && return 0
	which autoconf > /dev/null || install_native_autoconf || return 1
	search_header zlib.h || install_native_zlib || return 1
	search_header ssl.h || install_native_openssl || return 1
	search_header curl.h curl || install_native_curl || return 1
	which asciidoc > /dev/null || install_native_asciidoc || return 1
	which xmlto > /dev/null || install_native_xmlto || return 1
	search_header xmlversion.h || install_native_libxml2 || return 1
	search_header xslt.h || install_native_libxslt || return 1
	which gettext > /dev/null || install_native_gettext || return 1
	prepare_git_source || return 1
	unpack_archive ${git_org_src_dir} ${git_src_base} || return 1
	make -C ${git_org_src_dir} -j ${jobs} configure || return 1
	(cd ${git_org_src_dir}
	./configure --prefix=${prefix} --without-tcltk) || return 1
	sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_org_src_dir}/Makefile || return 1
	make -C ${git_org_src_dir} -j ${jobs} V=1 LDFLAGS="${LDFLAGS} -ldl" all || return 1 # doc
	make -C ${git_org_src_dir} -j ${jobs} V=1 strip install || return 1 # install-doc install-html
}

install_native_cmake()
{
	[ -x ${prefix}/bin/cmake -a -z "${force_install}" ] && return 0
	prepare_cmake_source || return 1
	unpack_archive ${cmake_org_src_dir} ${cmake_src_base} || return 1
	[ -f ${cmake_org_src_dir}/Makefile ] ||
		(cd ${cmake_org_src_dir}
		./bootstrap --prefix=${prefix} --parallel=${jobs}) || return 1
	make -C ${cmake_org_src_dir} -j ${jobs} || return 1
	make -C ${cmake_org_src_dir} -j ${jobs} install/strip || return 1
}

install_native_llvm()
{
	[ -e ${prefix}/lib/libLLVMCore.a -a -z "${force_install}" ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	prepare_llvm_source || return 1
	unpack_archive ${llvm_org_src_dir} ${llvm_src_base} || return 1
	mkdir -p ${llvm_bld_dir}
	(cd ${llvm_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${llvm_org_src_dir}) || return 1 # CXXFLAGS="${CXXFLAGS} -mfpu=neon -mhard-float" LD_LIBRARY_PATH=${prefix}/lib
	make -C ${llvm_bld_dir} -j ${jobs} || return 1
	make -C ${llvm_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_libcxx()
{
	[ -e ${prefix}/lib/libc++.so -a -z "${force_install}" ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	prepare_libcxx_source || return 1
	unpack_archive ${libcxx_org_src_dir} ${libcxx_src_base} || return 1
	mkdir -p ${libcxx_bld_dir}
	(cd ${libcxx_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${libcxx_org_src_dir}) || return 1
	make -C ${libcxx_bld_dir} -j ${jobs} || return 1
	make -C ${libcxx_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_libcxxabi()
{
	[ -e ${prefix}/lib/libc++abi.so -a -z "${force_install}" ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h || install_native_llvm || return 1
	search_header iostream c++/v1 || install_native_libcxx || return 1
	prepare_libcxxabi_source || return 1
	unpack_archive ${libcxxabi_org_src_dir} ${libcxxabi_src_base} || return 1
	mkdir -p ${libcxxabi_bld_dir}
	(cd ${libcxxabi_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${libcxxabi_org_src_dir}) || return 1
	make -C ${libcxxabi_bld_dir} -j ${jobs} || return 1
	make -C ${libcxxabi_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_clang_rt()
{
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h || install_native_llvm || return 1
	prepare_clang_rt_source || return 1
	unpack_archive ${clang_rt_org_src_dir} ${clang_rt_src_base} || return 1
	mkdir -p ${clang_rt_bld_dir}
	(cd ${clang_rt_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${clang_rt_org_src_dir}) || return 1
	make -C ${clang_rt_bld_dir} -j ${jobs} || return 1
	make -C ${clang_rt_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_clang()
{
	[ -x ${prefix}/bin/clang -a -z "${force_install}" ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h || install_native_llvm || return 1
	search_header iostream c++/v1 || install_native_libcxx || return 1
	search_header ABI.h clang/Basic || install_native_libcxxabi || return 1
	search_header allocator_interface.h sanitizer || install_native_clang_rt || return 1
	prepare_clang_source || return 1
	unpack_archive ${clang_org_src_dir} ${clang_src_base} || return 1
	mkdir -p ${clang_bld_dir}
	(cd ${clang_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${clang_org_src_dir}) || return 1
	make -C ${clang_bld_dir} -j ${jobs} || return 1
	make -C ${clang_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_clang_extra()
{
	which cmake > /dev/null || install_native_cmake || return 1
	prepare_clang_extra_source || return 1
	unpack_archive ${clang_extra_org_src_dir} ${clang_extra_src_base} || return 1
	mkdir -p ${clang_extra_bld_dir}
	(cd ${clang_extra_bld_dir}
	cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${clang_extra_org_src_dir}) || return 1
	make -C ${clang_extra_bld_dir} -j ${jobs} || return 1
	make -C ${clang_extra_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_lld()
{
	which cmake > /dev/null || install_native_cmake || return 1
	prepare_lld_source || return 1
	unpack_archive ${lld_org_src_dir} ${lld_src_base} || return 1
	mkdir -p ${lld_bld_dir}
	(cd ${lld_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=${prefix} ${lld_org_src_dir}) || return 1
	make -C ${lld_bld_dir} -j ${jobs} || return 1
	make -C ${lld_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_lldb()
{
	which cmake > /dev/null || install_native_cmake || return 1
	prepare_lldb_source || return 1
	unpack_archive ${lldb_org_src_dir} ${lldb_src_base} || return 1
	mkdir -p ${lldb_bld_dir}
	(cd ${lldb_bld_dir}
	cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ \
		-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREIFX=${prefix} ${lldb_org_src_dir}) || return 1
	make -C ${lldb_bld_dir} -j ${jobs} || return 1
	make -C ${lldb_bld_dir} -j ${jobs} install/strip || return 1
}

install_native_boost()
{
	[ -d ${prefix}/include/boost -a -z "${force_install}" ] && return 0
	prepare_boost_source || return 1
	unpack_archive ${boost_org_src_dir} ${boost_src_base} || return 1
	(cd ${boost_org_src_dir}
	./bootstrap.sh --prefix=${prefix} || return 1
	./b2 --prefix=${prefix} -j ${jobs}
	./b2 --prefix=${prefix} install) || true # XXX boostはインストール完了しても終了ステータスが0でないことに対するWA.
}

full_native()
{
	install_native_tar || return 1
	install_native_xz || return 1
	install_native_bzip2 || return 1
	install_native_gzip || return 1
	install_native_wget || return 1
	install_native_coreutils || return 1
	install_native_bison || return 1
	install_native_flex || return 1
	install_native_m4 || return 1
	install_native_autoconf || return 1
	install_native_automake || return 1
	install_native_libtool || return 1
	install_native_sed || return 1
	install_native_gawk || return 1
	install_native_make || return 1
	install_native_binutils || return 1
	install_native_gperf || return 1
	install_native_gmp_mpfr_mpc || return 1
	install_native_gcc || return 1
	install_native_ncurses || return 1
	install_native_gdb || return 1
	install_native_zlib || return 1
	install_native_libpng || return 1
	install_native_libtiff || return 1
	install_native_libjpeg || return 1
	install_native_giflib || return 1
	install_native_emacs || return 1
	install_native_vim || return 1
	install_native_grep || return 1
	install_native_global || return 1
	install_native_diffutils || return 1
	install_native_patch || return 1
	install_native_findutils || return 1
	install_native_screen || return 1
	install_native_zsh || return 1
	install_native_openssl || return 1
	install_native_curl || return 1
	install_native_asciidoc || return 1
	install_native_xmlto || return 1
	install_native_libxml2 || return 1
	install_native_libxslt || return 1
	install_native_gettext || return 1
	install_native_git || return 1
	install_native_cmake || return 1
	install_native_llvm || return 1
	install_native_libcxx || return 1
	install_native_libcxxabi || return 1
	install_native_clang_rt || return 1
	install_native_clang || return 1
	install_native_boost || return 1
}

install_cross_binutils()
{
	[ -e ${prefix}/bin/${target}-as -a -z "${force_install}" ] && return 0
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_crs} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_crs}) || return 1
	[ -f ${binutils_src_dir_crs}/Makefile ] ||
		(cd ${binutils_src_dir_crs}
		./configure --prefix=${prefix} --target=${target} --with-sysroot=${sysroot} --enable-gold \
			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable" CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return 1
	make -C ${binutils_src_dir_crs} -j ${jobs} || return 1
	make -C ${binutils_src_dir_crs} -j ${jobs} install-strip || return 1
}

install_cross_gcc_without_headers()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_1st}
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c --disable-multilib --with-system-zlib --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	LD_LIBRARY_PATH=${prefix}/lib make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return 1
}

install_cross_kernel_header()
{
	prepare_kernel_source || return 1
	[ -d ${kernel_src_dir_crs} ] ||
		(unpack_archive ${kernel_org_src_dir} ${kernel_src_base} &&
			mv ${kernel_org_src_dir} ${kernel_src_dir_crs}) || return 1
	make -C ${kernel_src_dir_crs} -j ${jobs} mrproper || return 1
	make -C ${kernel_src_dir_crs} -j ${jobs} \
		ARCH=${cross_linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return 1
}

install_cross_glibc_headers()
{
	which awk > /dev/null || install_native_gawk || return 1
	which gperf > /dev/null || install_native_gperf || return 1
	prepare_glibc_source || return 1
	[ -d ${glibc_src_dir_crs_hdr} ] ||
		(unpack_archive ${glibc_org_src_dir} ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_crs_hdr}) || return 1
	mkdir -p ${glibc_bld_dir_crs_hdr}
	[ -f ${glibc_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${glibc_bld_dir_crs_hdr}
		LD_LIBRARY_PATH='' ${glibc_src_dir_crs_hdr}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return 1
	make -C ${glibc_bld_dir_crs_hdr} -j ${jobs} DESTDIR=${sysroot} install-headers || return 1
}

install_cross_gcc_with_glibc_headers()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c --disable-multilib --with-system-zlib --with-sysroot=${sysroot} --with-newlib \
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

install_cross_1st_glibc()
{
	[ -d ${glibc_src_dir_crs_1st} ] ||
		(unpack_archive ${glibc_org_src_dir} ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_crs_1st}) || return 1

	[ ${cross_linux_arch} = microblaze ] && (cd ${glibc_src_dir_crs_1st}; patch -N -p0 -d ${glibc_src_dir_crs_1st} <<EOF || [ $? = 1 ] || return 1
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

	mkdir -p ${glibc_bld_dir_crs_1st}
	[ -f ${glibc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${glibc_bld_dir_crs_1st}
		LD_LIBRARY_PATH='' ${glibc_src_dir_crs_1st}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			CFLAGS="${CFLAGS} -Wno-error=parentheses -O2" \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return 1
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} || return 1
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install || return 1
}

install_cross_gcc_with_c_cxx_go_functionality()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_3rd}
	[ -f ${gcc_bld_dir_crs_3rd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_3rd}
		LIBS=-lgcc_s ${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c,c++,go --disable-multilib --with-system-zlib --with-sysroot=${sysroot}) || return 1
	LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} || return 1
	LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} -k install-strip || true # XXX -stripをgotools以外に関して強制的に成功させるため、-kと|| trueで暫定対応(WA)
}

install_cross_gcc()
{
	which ${target}-as > /dev/null || install_cross_binutils || return 1
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	search_header mpc.h || install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_cross_kernel_header || return 1
	install_cross_glibc_headers || return 1
	install_cross_gcc_with_glibc_headers || return 1
	install_cross_1st_glibc || return 1
	install_cross_gcc_with_c_cxx_go_functionality || return 1
}

install_cross_gdb()
{
	[ -e ${prefix}/bin/${target}-gdb -a -z "${force_install}" ] && return 0
	prepare_gdb_source || return 1
	unpack_archive ${gdb_org_src_dir} ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_crs}
	[ -f ${gdb_bld_dir_crs}/Makefile ] ||
		(cd ${gdb_bld_dir_crs}
		${gdb_org_src_dir}/configure --prefix=${prefix} --target=${target} --enable-tui --with-python --with-sysroot=${sysroot}) || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} install || return 1
}

install_mingw_w64_header()
{
	prepare_mingw_w64_source || return 1
	[ -d ${mingw_w64_src_dir_hdr} ] ||
		(unpack_archive ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_hdr}) || return 1
	mkdir -p ${mingw_w64_bld_dir_hdr}
	[ -f ${mingw_w64_bld_dir_hdr}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_hdr}
		${mingw_w64_src_dir_hdr}/configure --prefix=${sysroot} --with-sysroot=${sysroot} --build=${build} --host=${target} \
			--disable-multilib --without-crt) || return 1
	make -C ${mingw_w64_bld_dir_hdr} -j ${jobs} || return 1
	make -C ${mingw_w64_bld_dir_hdr} -j ${jobs} install || return 1
	mkdir -p ${sysroot}/${target}/lib
	ln -sf ./${target} ${sysroot}/mingw
	ln -sf ./lib ${sysroot}/${target}/lib64
}

install_mingw_w64_gcc_with_mingw_w64_header()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		CFLAGS="${CFLAGS} -D_WIN32" ${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c --disable-multilib --with-system-zlib --with-sysroot=${sysroot} \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-gcc || return 1
#	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-target-libgcc || return 1
#	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-target-libgcc || return 1
}

install_mingw_w64_crt()
{
	[ -d ${mingw_w64_src_dir_1st} ] ||
		(unpack_archive ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_1st}) || return 1
	mkdir -p ${mingw_w64_bld_dir_1st}
	[ -f ${mingw_w64_bld_dir_1st}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_1st}
		${mingw_w64_src_dir_1st}/configure --prefix=${sysroot} --with-sysroot=${sysroot} --build=${build} --host=${target} \
			--disable-multilib --without-header) || return 1
	make -C ${mingw_w64_bld_dir_1st} -j ${jobs} || return 1
	make -C ${mingw_w64_bld_dir_1st} -j ${jobs} install || return 1
}

install_mingw_w64_gcc()
{
	which ${target}-as > /dev/null || install_cross_binutils || return 1
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	search_header mpc.h || install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_mingw_w64_header || return 1
	install_mingw_w64_gcc_with_mingw_w64_header || return 1
	install_mingw_w64_crt || return  1
	install_cross_gcc_with_c_cxx_go_functionality || return 1
}

full_cross()
{
	install_cross_gcc || return 1
	install_cross_gdb || return 1
}

install_crossed_native_binutils()
{
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_crs_ntv} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
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
		(unpack_archive ${gmp_org_src_dir} ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return 1
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --enable-cxx) || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1

# XXX クロス先のネイティブ環境用なので、with-gmp, --with-mpfrの指定が間違ってるかも。

	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(unpack_archive ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return 1
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr) || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1

	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(unpack_archive ${mpc_org_src_dir} ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return 1
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		./configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr) || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_gcc()
{
	install_crossed_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
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
	prepare_zlib_source || return 1
	[ -d ${zlib_src_dir_crs_ntv} ] ||
		(unpack_archive ${zlib_org_src_dir} ${zlib_src_base} &&
			mv ${zlib_org_src_dir} ${zlib_src_dir_crs_ntv}) || return 1
	(cd ${zlib_src_dir_crs_ntv}
	CC=${target}-gcc ./configure --prefix=${sysroot}/usr) || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} install || return 1
}

install_crossed_native_libpng()
{
	install_crossed_native_zlib || return 1
	prepare_libpng_source || return 1
	[ -d ${libpng_src_dir_crs_ntv} ] ||
		(unpack_archive ${libpng_org_src_dir} ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_crs_ntv}) || return 1
	[ -f ${libpng_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_crs_ntv}
		./configure --prefix=${sysroot}/usr --host=${target}) || return 1
	C_INCLUDE_PATH=${sysroot}/include make -C ${libpng_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} install-strip || return 1
}

install_crossed_native_libtiff()
{
	prepare_libtiff_source || return 1
	[ -d ${libtiff_src_dir_crs_ntv} ] ||
		(unpack_archive ${libtiff_org_src_dir} ${libtiff_src_base} &&
			mv ${libtiff_org_src_dir} ${libtiff_src_dir_crs_ntv}) || return 1
	[ -f ${libtiff_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libtiff_src_dir_crs_ntv}
		CC=${target}-gcc CXX=${target}-g++ ./configure --prefix=${sysroot}/usr --host=`echo ${target} | sed -e 's/arm[^-]\+/arm/'`) || return 1
	CC=${target}-gcc CXX=${target}-g++ make -C ${libtiff_src_dir_crs_ntv} -j ${jobs} || return 1
	CC=${target}-gcc CXX=${target}-g++ make -C ${libtiff_src_dir_crs_ntv} -j ${jobs} install-strip || return 1
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
[ ${count} -eq 0 ] && usage || exit 0
