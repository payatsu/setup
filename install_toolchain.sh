#!/bin/sh -e
# [TODO] ホームディレクトリにusr/ができてしますバグ。
# [TODO] X window system関係のライブラリ何かを入れると、OS起動時GUIが立ち上がらなくなる。
# [TODO] install_native_xmltoのリファクタリング。
#        -> xmltoの障害のせいで、gitのmakeに障害あり。
# [TODO] haskell(stack<-(ghc, cabal))
# [TODO] X11, gtk周りのインストールが未完成＆不安定
# [TODO] libav<-
# [TODO] webkitgtk<-libsoup
# [TODO] libmount, dtrace (GLib)
# [TODO] tcl/tk
# [TODO] rsvg, imagemagick
# [TODO] LLDB, Polly, MySQL, expat, Guile
# [TODO] update-alternatives
# [TODO] linux-2.6.18, glibc-2.16.0の組み合わせを試す。
# [TODO] install_native_clang_tools_extra()のテスト実行が未完了。

: ${tar_ver:=1.29}
: ${xz_ver:=5.2.2}
: ${bzip2_ver:=1.0.6}
: ${gzip_ver:=1.8}
: ${wget_ver:=1.17.1}
: ${pkg_config_ver:=0.29.1}
: ${texinfo_ver:=6.1}
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
: ${binutils_ver:=2.27}
: ${linux_ver:=3.18.13}
: ${gperf_ver:=3.0.4}
: ${glibc_ver:=2.23}
: ${gmp_ver:=6.1.0}
: ${mpfr_ver:=3.1.4}
: ${mpc_ver:=1.0.3}
: ${gcc_ver:=6.2.0}
: ${readline_ver:=7.0}
: ${ncurses_ver:=6.0}
: ${gdb_ver:=7.11.1}
: ${zlib_ver:=1.2.8}
: ${libpng_ver:=1.6.21}
: ${tiff_ver:=4.0.6}
: ${jpeg_ver:=v9b}
: ${giflib_ver:=5.1.4}
: ${libXpm_ver:=3.5.11}
: ${libwebp_ver:=0.5.1}
: ${libffi_ver:=3.2.1}
: ${glib_ver:=2.50.0}
: ${cairo_ver:=1.14.6}
: ${pixman_ver:=0.34.0}
: ${pango_ver:=1.40.3}
: ${gdk_pixbuf_ver:=2.36.0}
: ${atk_ver:=2.22.0}
: ${gobject_introspection_ver:=1.50.0}
: ${inputproto_ver:=2.3}
: ${xtrans_ver:=1.3.5}
: ${libX11_ver:=1.6.3}
: ${libxcb_ver:=1.12}
: ${xcb_proto_ver:=1.12}
: ${xextproto_ver:=7.3.0}
: ${libXext_ver:=1.3.3}
: ${fixesproto_ver:=5.0}
: ${libXfixes_ver:=5.0.2}
: ${damageproto_ver:=1.2.1}
: ${libXdamage_ver:=1.1.4}
: ${libXt_ver:=1.1.5}
: ${xproto_ver:=7.0.31}
: ${kbproto_ver:=1.0.7}
: ${glproto_ver:=1.4.17}
: ${libpciaccess_ver:=0.13.4}
: ${libdrm_ver:=2.4.70}
: ${dri2proto_ver:=2.8}
: ${dri3proto_ver:=1.0}
: ${presentproto_ver:=1.0}
: ${libxshmfence_ver:=1.2}
: ${mesa_ver:=12.0.3}
: ${libepoxy_ver:=1.3.1}
: ${gtk_ver:=3.22.0}
: ${webkitgtk_ver:=2.14.0}
: ${emacs_ver:=25.1}
: ${vim_ver:=8.0.0003}
: ${ctags_ver:=5.8}
: ${grep_ver:=2.25}
: ${global_ver:=6.5.5}
: ${pcre2_ver:=10.22}
: ${the_silver_searcher_ver:=0.32.0}
: ${graphviz_ver:=2.38.0}
: ${doxygen_ver:=1.8.12}
: ${diffutils_ver:=3.3}
: ${patch_ver:=2.7.5}
: ${findutils_ver:=4.6.0}
: ${screen_ver:=4.3.1}
: ${libevent_ver:=2.0.22}
: ${tmux_ver:=2.2}
: ${zsh_ver:=5.2}
: ${bash_ver:=4.4}
: ${openssl_ver:=1.1.0a}
: ${openssh_ver:=7.3p1}
: ${curl_ver:=7.49.0}
: ${asciidoc_ver:=8.6.9}
: ${xmlto_ver:=0.0.28}
: ${libxml2_ver:=2.9.4}
: ${libxslt_ver:=1.1.29}
: ${gettext_ver:=0.19.7}
: ${git_ver:=2.10.1}
: ${mercurial_ver:=3.8.3}
: ${sqlite_autoconf_ver:=3140100}
: ${apr_ver:=1.5.2}
: ${apr_util_ver:=1.5.4}
: ${subversion_ver:=1.9.4}
: ${cmake_ver:=3.5.2}
: ${libedit_ver:=20160903-3.1}
: ${swig_ver:=3.0.10}
: ${llvm_ver:=3.9.0}
: ${boost_ver:=1_62_0}
: ${mingw_w64_ver:=4.0.6}
: ${Python_ver:=3.5.2}
: ${ruby_ver:=2.3.1}
: ${go_ver:=1.7}
: ${perl_ver:=5.24.0}
: ${yasm_ver:=1.3.0}
: ${x264_ver:=last-stable}
: ${x265_ver:=2.0}
: ${libav_ver:=11.7}
: ${opencv_ver:=3.1.0}
: ${opencv_contrib_ver:=3.1.0}

: ${prefix:=/toolchains}
: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
: ${build:=`uname -m`-linux-gnu}
: ${target:=`uname -m`-linux-gnu}
: ${languages:=c,c++,go}

: ${strip=strip}
: ${cmake_build_type:=Release}

usage()
# Show usage.
{
	cat <<EOF
[Usage]
	$0 [-p prefix] [-t target] [-j jobs] [-h] [variable=value]... commands...

[Options]
	-p prefix
		Installation directory, currently '${prefix}'.
		'/usr/local' is NOT strongly recommended.
	-t target
		Target-triplet of new cross toolchain, currently '${target}'.
		ex.
			armv7l-linux-gnueabihf
			x86_64-linux-gnu
			i686-unknown-linux
			microblaze-none-linux
			nios2-none-linux (linux_ver=4.8.1)
	-j jobs
		The number of processes invoked simultaneously by 'make', currently '${jobs}'.
		Recommended not to be more than the number of CPU cores.
	-h
		Show detailed help.

EOF
	list_major_commands
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
	pkg_config_ver
		Specify the version of pkg-config you want, currently '${pkg_config_ver}'.
	texinfo_ver
		Specify the version of GNU Texinfo you want, currently '${texinfo_ver}'.
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
	linux_ver
		Specify the version of Linux kernel you want, currently '${linux_ver}'.
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
	readline_ver
		Specify the version of GNU Readline Library you want, currently '${readline_ver}'.
	ncurses_ver
		Specify the version of ncurses you want, currently '${ncurses_ver}'.
	gdb_ver
		Specify the version of GNU Debugger you want, currently '${gdb_ver}'.
	zlib_ver
		Specify the version of zlib you want, currently '${zlib_ver}'.
	libpng_ver
		Specify the version of libpng you want, currently '${libpng_ver}'.
	tiff_ver
		Specify the version of libtiff you want, currently '${tiff_ver}'.
	jpeg_ver
		Specify the version of libjpeg you want, currently '${jpeg_ver}'.
	giflib_ver
		Specify the version of giflib you want, currently '${giflib_ver}'.
	libXpm_ver
		Specify the version of libXpm you want, currently '${libXpm_ver}'.
	libwebp_ver
		Specify the version of libwebp you want, currently '${libwebp_ver}'.
	libffi_ver
		Specify the version of libffi you want, currently '${libffi_ver}'.
	glib_ver
		Specify the version of GLib you want, currently '${glib_ver}'.
	cairo_ver
		Specify the version of cairo you want, currently '${cair_ver}'.
	pixman_ver
		Specify the version of pixman you want, currently '${pixman_ver}'.
	pango_ver
		Specify the version of Pango you want, currently '${pango_ver}'.
	gdk_pixbuf_ver
		Specify the version of Gdk-Pixbuf you want, currently '${gdk_pixbuf_ver}'.
	atk_ver
		Specify the version of ATK you want, currently '${atk_ver}'.
	gobject_introspection_ver
		Specify the version of GObject-Introspection you want, currently '${gobject_introspection_ver}'.
	inputproto_ver
		Specify the version of inputproto you want, currently '${inputproto_ver}'.
	xtrans_ver
		Specify the version of xtrans you want, currently '${xtrans_ver}'
	libX11_ver
		Specify the version of libX11 you want, currently '${libX11_ver}'
	libxcb_ver
		Specify the version of libxcb you want, currently '${libxcb_ver}'.
	xcb_proto_ver
		Specify the version of xcb-proto you want, currently '${xcb_proto_ver}'.
	xextproto_ver
		Specify the version of xextproto you want, currenetly '${xextproto_ver}'.
	libXext_ver
		Specify the version of libXext you want, currently '${libXext_ver}'.
	fixesproto_ver
		Specify the version of fixesproto you want, currently '${fixesproto_ver}'.
	libXfixes_ver
		Specify the version of libXfixes you want, currently '${libXfixes_ver}'.
	damageproto_ver
		Specify the version of damageproto you want, currently '${damageproto_ver}'.
	libXdamage_ver
		Specify the version of libXdamage you want, currently '${libXdamage_ver}'.
	libXt_ver
		Specify the version of X11 Toolkit you want, currently '${libXt_ver}'.
	xproto_ver
		Specify the version of xproto you want, currently '${xproto_ver}'.
	kbproto_ver
		Specify the version of kbproto you want, currently '${kbproto_ver}'.
	glproto_ver
		Specify the version of glproto you want, currently '${glproto_ver}'.
	libpciaccess_ver
		Specify the verrsion of libpciaccess you want, currently '${libpciaccess_ver}'.
	libdrm_ver
		Specify the version of libdrm you want, currently '${libdrm_ver}'.
	dri2proto_ver
		Specify the version of dri2proto you want, currently '${dri2proto_ver}'.
	dri3proto_ver
		Specify the version of dri3proto you want, currently '${dri3proto_ver}'.
	presentproto_ver
		Specify the version of presentproto you want, currently '${presentproto_ver}'.
	libxshmfence_ver
		Specify the version of libxshmfence you want, currently '${libxshmfence_ver}'.
	mesa_ver
		Specify the version of mesa you want, currently '${mesa_ver}'.
	libepoxy_ver
		Specify the version of libepoxy you want, currently '${libepoxy_ver}'.
	gtk_ver
		Specify the version of GTK+ you want, currently '${gtk_ver}'.
	webkitgtk_ver
		Specify the version of WebKitGTK+ you want, currenty '${webkitgtk_ver}'.
	emacs_ver
		Specify the version of GNU Emacs you want, currently '${emacs_ver}'.
	vim_ver
		Specify the version of Vim you want, currently '${vim_ver}'.
	ctags_ver
		Specify the version of ctags you want, currently '${ctags_ver}'.
	grep_ver
		Specify the version of GNU Grep you want, currently '${grep_ver}'.
	global_ver
		Specify the version of GNU Global you want, currently '${global_ver}'.
	pcre2_ver
		Specify the version of PCRE2 you want, currently '${pcre2_ver}'.
	the_silver_searcher_ver
		Specify the version of the silver searcher you want, currently '${the_silver_searcher_ver}'.
	graphviz_ver
		Specify the version of Graphviz you want, currently '${graphviz_ver}'.
	doxygen_ver
		Specify the version of Doxygen you want, currently '${doxygen_ver}'.
	diffutils_ver
		Specify the version of GNU diffutils you want, currently '${diffutils_ver}'.
	patch_ver
		Specify the version of GNU Patch you want, currently '${patch_ver}'.
	findutils_ver
		Specify the version of GNU findutils you want, currently'${findutils_ver}'.
	screen_ver
		Specify the version of GNU Screen you want, currently '${screen_ver}'.
	libevent_ver
		Specify the version of libevent you want, currently '${libevent_ver}'.
	tmux_ver
		Specify the version of tmux you want, currently '${tmux_ver}'.
	zsh_ver
		Specify the version of Zsh you want, currently '${zsh_ver}'.
	bash_ver
		Specify the version of Bash you want, currently '${bash_ver}'.
	openssl_ver
		Specify the version of openssl you want, currently '${openssl_ver}'.
	openssh_ver
		Specify the version of openssh you want, currently '${openssh_ver}'.
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
	mercurial_ver
		Specify the version of Mercurial you want, currently '${mercurial_ver}'.
	sqlite_autoconf_ver
		Specify the version of SQLite you want, currently '${sqlite_autoconf_ver}'.
	apr_ver
		Specify the version of apr you want, currently '${apr_ver}'.
	apr_util_ver
		Specify the version of apr-util you want, currently '${apr_util_ver}'.
	subversion_ver
		Specify the version of Subversion you want, currently '${subversion_ver}'.
	cmake_ver
		Specify the version of Cmake you want, currently '${cmake_ver}'.
	libedit_ver
		Specify the version of libedit you want, currently '${libedit_ver}'.
	swig_ver
		Specify the version of SWIG you want, currently '${swig_ver}'.
	llvm_ver
		Specify the version of llvm you want, currently '${llvm_ver}'.
	boost_ver
		Specify the version of boost you want, currently '${boost_ver}'.
	mingw_w64_ver
		Specify the version of mingw-w64 you want, currently '${mingw_w64_ver}'.
	Python_ver
		Specify the version of python you want, currently '${Python_ver}'.
	ruby_ver
		Specify the version of ruby you want, currently '${ruby_ver}'.
	go_ver
		Specify the version of go you want, currently '${go_ver}'.
	perl_ver
		Specify the version of perl you want, currently '${perl_ver}'.
	yasm_ver
		Specify the version of YASM you want, currently '${yasm_ver}'.
	x264_ver
		Specify the version of x264 you want, currently '${x264_ver}'.
	x265_ver
		Specify the version of x265 you want, currently '${x265_ver}'.
	libav_ver
		Specify the version of Livav you want, currently '${libav_ver}'.
	opencv_ver
		Specify the version of OpenCV you want, currently '${opencv_ver}'.
	opencv_contrib_ver
		Specify the version of OpenCV contrib you want, currently '${opencv_contrib_ver}'.

[Examples]
	For everything which this tool can install
	# $0 -p /toolchains -t armv7l-linux-gnueabihf -j 8 auto

	For Raspberry pi2 cross compiler
	# $0 -p /toolchains -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 linux_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 cross

	For microblaze cross compiler
	# $0 -p /toolchains -t microblaze-linux-gnu -j 8 binutils_ver=2.25 linux_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 cross

EOF
}

auto()
# Perform auto installation for all available toolchains and other tools.
{
	fetch || return 1
	full || return 1
	clean || return 1
#	strip || return 1 # [TODO] crtbegin.oをstripすると、gccでコンパイルしたバイナリがsegfaultするようになる。
	archive || return 1
}

fetch()
# Fetch all source files.
{
	for fetch_command in `grep -e '^fetch_.\+_source()$' $0 | sed -e 's/()$//'`; do
		${fetch_command} || return 1
	done
}

unpack()
# Unpack all source files.
{
	clean
	for f in `find ${prefix}/src -name '*.tar.gz' -o -name '*.tar.bz2' -o -name '*.tar.xz' -o -name '*.zip'`; do
		unpack_archive `echo $f | sed -e 's/\.tar\.gz$//;s/\.tar\.bz2$//;s/\.tar\.xz$//;s/\.zip$//'` `dirname $f`
	done
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
	full_mingw_w64 || return 1
	full_crossed_native || return 1
}

crossed()
# Install crossed native apps.
{
	install_crossed_native_binutils || return 1
	install_crossed_native_gcc || return 1
}

clean()
# Delete no longer required source trees.
{
	find ${prefix}/src -mindepth 2 -maxdepth 2 \
		! -name '*.tar.gz' ! -name '*.tar.bz2' ! -name '*.tar.xz' ! -name '*.zip' -exec rm -rf {} +
}

strip()
# Strip all binary files.
{
	for strip_command in strip ${target}-strip x86_64-w64-mingw32-strip; do
		find ${prefix} -type f \( -perm /111 -o -name '*.o' -o -name '*.a' -o -name '*.so' -o -name '*.gox' \) \
			| xargs file | grep 'not stripped' | cut -f1 -d: | xargs -I "{}" sh -c "chmod u+w {}; ${strip_command} {}" || true
	done
}

archive()
# Archive related files.
{
	[ ${prefix}/src = `dirname $0` ] || cp -vf $0 ${prefix}/src || return 1
	convert_archives || return 1
	tar cJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		-C `dirname ${prefix}` `basename ${prefix}` || return 1
}

deploy()
# Deploy related files.
{
	tar xJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		--no-same-owner --no-same-permissions -C `dirname ${prefix}` || return 1
	update_search_path || return 1
	echo Please add ${prefix}/bin to PATH
}

list()
# List all commands, which include the ones not listed here.
{
	list_all_commands
}

reset()
# Reset '${prefix}' except '${prefix}/src/'.
{
	clean
	find ${prefix} -mindepth 1 -maxdepth 1 ! -name src ! -name .git -exec rm -rf '{}' +
	[ `whoami` = root ] && rm  -f /etc/ld.so.conf.d/`basename ${prefix}`.conf
	[ `whoami` = root ] && ldconfig || return 0
}

debug()
# Enter debug mode.
{
	prev_set=$-; set -e
	while true; do read ${BASH:+-e} -p "$1> " cmd; eval ${cmd} || true; done
	set +e; set -${prev_set}
}

set_src_directory()
{
	_1=`echo ${1} | tr - _`

	case ${1} in
	llvm|libcxx|libcxxabi|compiler-rt|cfe|clang-tools-extra|lld|lldb)
		eval ${_1}_name=${1}-${llvm_ver}.src
		eval ${_1}_src_base=${prefix}/src/${1}
		eval ${_1}_org_src_dir=\${${_1}_src_base}/\${${_1}_name}
		eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-bld
		return 0
		;;
	esac

	case ${1} in
	jpeg)
		eval ${_1}_name=${1}src.\${${_1}_ver};;
	gtk)
		eval ${_1}_name=${1}+-\${${_1}_ver};;
	boost)
		eval ${_1}_name=${1}_\${${_1}_ver};;
	mingw-w64)
		eval ${_1}_name=${1}-v\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac

	eval ${_1}_src_base=${prefix}/src/${1}
	eval ${_1}_org_src_dir=\${${_1}_src_base}/\${${_1}_name}

	case ${1} in
	glibc|mingw-w64)
		eval ${_1}_bld_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-bld
		eval ${_1}_src_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-src
		eval ${_1}_bld_dir_crs_hdr=\${${_1}_src_base}/${target}-\${${_1}_name}-bld-hdr
		eval ${_1}_bld_dir_crs_1st=\${${_1}_src_base}/${target}-\${${_1}_name}-bld-1st
		eval ${_1}_src_dir_crs_hdr=\${${_1}_src_base}/${target}-\${${_1}_name}-src-hdr
		eval ${_1}_src_dir_crs_1st=\${${_1}_src_base}/${target}-\${${_1}_name}-src-1st
		;;
	gcc)
		eval ${_1}_bld_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-bld
		eval ${_1}_bld_dir_crs_1st=\${${_1}_src_base}/${target}-\${${_1}_name}-1st
		eval ${_1}_bld_dir_crs_2nd=\${${_1}_src_base}/${target}-\${${_1}_name}-2nd
		eval ${_1}_bld_dir_crs_3rd=\${${_1}_src_base}/${target}-\${${_1}_name}-3rd
		eval ${_1}_bld_dir_crs_ntv=\${${_1}_src_base}/${target}-\${${_1}_name}-crs-ntv
		;;
	gdb)
		eval ${_1}_bld_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-bld
		eval ${_1}_bld_dir_crs=\${${_1}_src_base}/${target}-\${${_1}_name}-bld
		;;
	jpeg)
		eval ${_1}_org_src_dir=\${${_1}_src_base}/${_1}-\`echo \${${_1}_ver} \| sed -e 's/^v//'\`
		eval ${_1}_src_dir_ntv=\${${_1}_src_base}/${_1}-\`echo \${${_1}_ver} \| sed -e 's/^v//'\`-ntv
		;;
	*)
		eval ${_1}_bld_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-bld
		eval ${_1}_src_dir_ntv=\${${_1}_src_base}/\${${_1}_name}-src
		eval ${_1}_src_dir_crs=\${${_1}_src_base}/${target}-\${${_1}_name}-src
		eval ${_1}_src_dir_crs_ntv=\${${_1}_src_base}/${target}-\${${_1}_name}-crs-ntv
		;;
	esac
}

set_variables()
{
	prefix=`readlink -m ${prefix}`
	sysroot=${prefix}/${target}/sysroot
	os=`head -1 /etc/issue | cut -d ' ' -f 1`
	[ "${strip}" = strip ] || cmake_build_type=Debug

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
	nios2*)      cross_linux_arch=nios2;;
	x86_64*)     cross_linux_arch=x86;;
	*) echo Unknown target architecture: ${target} >&2; return 1;;
	esac

	case `echo ${linux_ver} | cut -f 1,2 -d .` in
	2.6) kernel_major_ver=v2.6;;
	3.*) kernel_major_ver=v3.x;;
	4.*) kernel_major_ver=v4.x;;
	*)   echo unsupported kernel version >&2; return 1;;
	esac

	for pkg in tar xz bzip2 gzip wget pkg-config texinfo coreutils bison flex \
		m4 autoconf automake libtool sed gawk make binutils linux gperf glibc \
		gmp mpfr mpc gcc readline ncurses gdb zlib libpng tiff jpeg giflib libXpm libwebp libffi \
		glib cairo pixman pango gdk-pixbuf atk gobject-introspection inputproto xtrans libX11 libxcb xcb-proto \
		xextproto fixesproto libXfixes libXext damageproto libXdamage libXt \
		xproto kbproto glproto libpciaccess libdrm dri2proto dri3proto presentproto libxshmfence mesa \
		libepoxy gtk webkitgtk emacs vim ctags grep global pcre2 the_silver_searcher \
		graphviz doxygen diffutils patch findutils screen libevent tmux zsh bash \
		openssl openssh curl asciidoc xmlto libxml2 libxslt gettext \
		git mercurial sqlite-autoconf apr apr-util subversion cmake libedit \
		swig llvm libcxx libcxxabi compiler-rt cfe clang-tools-extra lld lldb boost mingw-w64 \
		Python ruby go perl yasm x264 x265 libav opencv opencv_contrib; do
		set_src_directory ${pkg}
	done

	echo ${PATH} | tr : '\n' | grep -q -e ^${prefix}/bin\$ \
		|| PATH=${prefix}/bin:${PATH} \
		&& PATH=${prefix}/bin:`echo ${PATH} | sed -e "s+\(^\|:\)${prefix}/bin\(\$\|:\)+\1\2+g;s/::/:/g;s/^://;s/:\$//"`
	echo ${PATH} | tr : '\n' | grep -q -e ^/sbin\$ || PATH=/sbin:${PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -q -e ^${prefix}/lib64\$ || LD_LIBRARY_PATH=${prefix}/lib64:${LD_LIBRARY_PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -q -e ^${prefix}/lib\$   || LD_LIBRARY_PATH=${prefix}/lib:${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH
	update_pkg_config_path
}

convert_archives()
{
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.gz'  -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.gz\$/.xz/"`;  [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; gzip  -cd {} | xz -cv > ${xzfile}' \; -delete || return 1
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.bz2' -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.bz2\$/.xz/"`; [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; bzip2 -cd {} | xz -cv > ${xzfile}' \; -delete || return 1
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.zip'  -execdir sh -c '[ -f `basename {} .zip`.tar.xz ] && exit 0; unzip {} && tar cJvf `basename {} .zip`.tar.xz `basename {} .zip`' \; -delete || return 1
}

archive_sources()
{
	fetch || return 1
	clean
	convert_archives || return 1
	tar cJvf ${prefix}/src.tar.xz -C ${prefix} src
}

list_major_commands()
{
	echo '[Available commands]'
	eval "`grep -A 1 -e '^[[:alnum:]]\+()$' $0 |
		sed -e '/^--$/d; /^{$/d; s/()$//; s/^# /\t/; s/^/\t/; 1s/^/echo "/; $s/$/"/'`"
}

list_all_commands()
{
	cat <<EOF
[All commands]
#: major commands, -: internal commands(for debugging use)
EOF
	commands=`grep -e '^[_[:alnum:]]*[[:alnum:]]\+()$' $0 | sed -e 's/^/- /;s/()$//;s/- \([[:alnum:]]\+\)$/# \1/'`

	lines=`echo "${commands}" | wc -l`
	n=3
	column1_end=`expr \`expr ${lines} / ${n}\` + \`expr ${lines} % ${n}\``
	column2_begin=`expr ${column1_end} + 1`
	column2_end=`expr \`expr ${lines} / ${n}\` + ${column1_end}`
	column3_begin=`expr ${column2_end} + 1`

	column1=`echo "${commands}" | sed -e "1,${column1_end}p;d"`
	column2=`echo "${commands}" | sed -e "${column2_begin},${column2_end}p;d"`
	column3=`echo "${commands}" | sed -e "${column3_begin},\\$p;d"`

	width=36
	for i in `seq ${column1_end}`; do
		printf " %c %-${width}s" `echo "${column1}" | sed -e "${i}p;d"`
		printf " %c %-${width}s" `echo "${column2}" | sed -e "${i}p;d"`
		printf " %c %-${width}s" `echo "${column3}" | sed -e "${i}p;d"`
		echo
	done
}

list_repositories()
{
	cat <<EOF
[All repositories]
EOF
	eval echo `grep -e '^[[:space:]]\+\(https\?\|ftp\)://.\+/' $0 | sed -e 's/ || return 1$//;s/^[[:space:]]\+//'` | tr ' ' '\n'
}

update_search_path()
{
	[ `whoami` != root ] && return 0
	[ -f /etc/ld.so.conf.d/`basename ${prefix}`.conf ] ||
		echo \
"${prefix}/lib
${prefix}/lib64
${prefix}/lib32" > /etc/ld.so.conf.d/`basename ${prefix}`.conf || return 1
	ldconfig || return 1
}

update_pkg_config_path()
{
	PKG_CONFIG_PATH=`([ -d ${prefix}/lib ] && find ${prefix}/lib -type d -name pkgconfig
						[ -d ${prefix}/share ] && find ${prefix}/share -type d -name pkgconfig
						find /usr/lib -type d -name pkgconfig) | tr '\n' : | sed -e 's/:$//'`
	export PKG_CONFIG_PATH
}

search_library()
{
	for dir in ${prefix}/lib64 ${prefix}/lib `LANG=C ${CC:-gcc} -print-search-dirs |
		sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs readlink -m`; do
		[ -f ${dir}/$1 ] && echo ${dir}/$1 && return 0
	done
	return 1
}

search_library_dir()
{
	path=`search_library $@`
	[ $? = 0 ] && dirname ${path} || return 1
}

search_header()
{
	for dir in ${prefix}/include ${prefix}/lib/libffi-*/include /usr/local/include /opt/include /usr/include; do
		[ -d ${dir}${2:+/$2} ] || continue
		candidates=`find ${dir}${2:+/$2} -type f -name $1`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return 0
	done
	return 1
}

get_prefix()
{
	path=`search_header $@`
	[ $? = 0 ] && echo ${path} | sed -e 's/\/include\/.\+//' || return 1
}

install_prerequisites()
{
	[ -n "${prerequisites_have_been_already_installed}" ] && return 0
	case ${os} in
	Debian|Ubuntu|Raspbian)
		apt-get install -y make gcc g++ || return 1
		apt-get install -y unifdef || return 1 # for linux kernel(microblaze)
		apt-get install -y libgtk-3-dev libgnome2-dev libgnomeui-dev libx11-dev || return 1 # for emacs
		apt-get install -y libudev-dev || return 1 # for webkitgtk
		apt-get install -y libwebkitgtk-3.0-dev python-dev # libicu-dev # for emacs(xwidgets)
		apt-get install -y lua5.2 liblua5.2-dev || return 1 # for vim
		apt-get install -y luajit libluajit-5.1 || return 1 # for vim
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ || return 1
		yum install -y unifdef || return 1
		yum install -y gtk3-devel || return 1
		yum install -y lua lua-devel || return 1
		yum install -y luajit luajit-devel || return 1
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1 ;;
	esac
	prerequisites_have_been_already_installed=yes
}

check_archive()
{
	[ -f $1.tar.gz  -a -s $1.tar.gz  ] && return 0
	[ -f $1.tar.bz2 -a -s $1.tar.bz2 ] && return 0
	[ -f $1.tar.xz  -a -s $1.tar.xz  ] && return 0
	[ -f $1.zip     -a -s $1.zip     ] && return 0
	return 1
}

unpack_archive()
{
	[ -d $1 ] && return 0
	[ -f $1.tar.gz  -a -s $1.tar.gz  ] && tar xzvf $1.tar.gz  --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.tar.bz2 -a -s $1.tar.bz2 ] && tar xjvf $1.tar.bz2 --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.tar.xz  -a -s $1.tar.xz  ] && tar xJvf $1.tar.xz  --no-same-owner --no-same-permissions -C $2 && return 0
	[ -f $1.zip     -a -s $1.zip     ] && unzip -d $2 $1.zip && return 0
	return 1
}

fetch_tar_source()
{
	mkdir -p ${tar_src_base}
	check_archive ${tar_org_src_dir} ||
		wget -O ${tar_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/tar/${tar_name}.tar.bz2 || return 1
}

fetch_xz_source()
{
	mkdir -p ${xz_src_base}
	check_archive ${xz_org_src_dir} ||
		wget -O ${xz_org_src_dir}.tar.bz2 \
			http://tukaani.org/xz/${xz_name}.tar.bz2 || return 1
}

fetch_bzip2_source()
{
	mkdir -p ${bzip2_src_base}
	check_archive ${bzip2_org_src_dir} ||
		wget -O ${bzip2_org_src_dir}.tar.gz \
			http://www.bzip.org/${bzip2_ver}/${bzip2_name}.tar.gz || return 1
}

fetch_gzip_source()
{
	mkdir -p ${gzip_src_base}
	check_archive ${gzip_org_src_dir} ||
		wget -O ${gzip_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gzip/${gzip_name}.tar.xz || return 1
}

fetch_wget_source()
{
	mkdir -p ${wget_src_base}
	check_archive ${wget_org_src_dir} ||
		wget -O ${wget_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/wget/${wget_name}.tar.xz || return 1
}

fetch_pkg_config_source()
{
	mkdir -p ${pkg_config_src_base}
	check_archive ${pkg_config_org_src_dir} ||
		wget --no-check-certificate -O ${pkg_config_org_src_dir}.tar.gz \
			https://pkg-config.freedesktop.org/releases/${pkg_config_name}.tar.gz || return 1
}

fetch_texinfo_source()
{
	mkdir -p ${texinfo_src_base}
	check_archive ${texinfo_org_src_dir} ||
		wget -O ${texinfo_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/texinfo/${texinfo_name}.tar.xz || return 1
}

fetch_coreutils_source()
{
	mkdir -p ${coreutils_src_base}
	check_archive ${coreutils_org_src_dir} ||
		wget -O ${coreutils_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/coreutils/${coreutils_name}.tar.xz || return 1
}

fetch_bison_source()
{
	mkdir -p ${bison_src_base}
	check_archive ${bison_org_src_dir} ||
		wget -O ${bison_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/bison/${bison_name}.tar.xz || return 1
}

fetch_flex_source()
{
	mkdir -p ${flex_src_base}
	check_archive ${flex_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${flex_org_src_dir}.tar.xz \
			https://sourceforge.net/projects/flex/files/${flex_name}.tar.xz/download || return 1
}

fetch_m4_source()
{
	mkdir -p ${m4_src_base}
	check_archive ${m4_org_src_dir} ||
		wget -O ${m4_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/m4/${m4_name}.tar.xz || return 1
}

fetch_autoconf_source()
{
	mkdir -p ${autoconf_src_base}
	check_archive ${autoconf_org_src_dir} ||
		wget -O ${autoconf_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/autoconf/${autoconf_name}.tar.xz || return 1
}

fetch_automake_source()
{
	mkdir -p ${automake_src_base}
	check_archive ${automake_org_src_dir} ||
		wget -O ${automake_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/automake/${automake_name}.tar.xz || return 1
}

fetch_libtool_source()
{
	mkdir -p ${libtool_src_base}
	check_archive ${libtool_org_src_dir} ||
		wget -O ${libtool_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/libtool/${libtool_name}.tar.xz || return 1
}

fetch_sed_source()
{
	mkdir -p ${sed_src_base}
	check_archive ${sed_org_src_dir} ||
		wget -O ${sed_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/sed/${sed_name}.tar.bz2 || return 1
}

fetch_gawk_source()
{
	mkdir -p ${gawk_src_base}
	check_archive ${gawk_org_src_dir} ||
		wget -O ${gawk_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gawk/${gawk_name}.tar.xz || return 1
}

fetch_make_source()
{
	mkdir -p ${make_src_base}
	check_archive ${make_org_src_dir} ||
		wget -O ${make_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/make/${make_name}.tar.bz2 || return 1
}

fetch_binutils_source()
{
	mkdir -p ${binutils_src_base}
	check_archive ${binutils_org_src_dir} ||
		wget -O ${binutils_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/binutils/${binutils_name}.tar.bz2 || return 1
}

fetch_kernel_source()
{
	mkdir -p ${linux_src_base}
	check_archive ${linux_org_src_dir} ||
		wget --no-check-certificate -O ${linux_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/kernel/${kernel_major_ver}/${linux_name}.tar.xz || return 1
}

fetch_gperf_source()
{
	mkdir -p ${gperf_src_base}
	check_archive ${gperf_org_src_dir} ||
		wget -O ${gperf_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/gperf/${gperf_name}.tar.gz || return 1
}

fetch_glibc_source()
{
	mkdir -p ${glibc_src_base}
	check_archive ${glibc_org_src_dir} ||
		wget -O ${glibc_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/glibc/${glibc_name}.tar.xz || return 1
}

fetch_gmp_source()
{
	mkdir -p ${gmp_src_base}
	check_archive ${gmp_org_src_dir} ||
		wget -O ${gmp_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gmp/${gmp_name}.tar.xz || return 1
}

fetch_mpfr_source()
{
	mkdir -p ${mpfr_src_base}
	check_archive ${mpfr_org_src_dir} ||
		wget -O ${mpfr_org_src_dir}.tar.xz \
			http://www.mpfr.org/${mpfr_name}/${mpfr_name}.tar.xz || return 1
}

fetch_mpc_source()
{
	mkdir -p ${mpc_src_base}
	check_archive ${mpc_org_src_dir} ||
		wget -O ${mpc_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/mpc/${mpc_name}.tar.gz || return 1
}

fetch_gmp_mpfr_mpc_source()
{
	fetch_gmp_source || return 1
	fetch_mpfr_source || return 1
	fetch_mpc_source || return 1
}

fetch_gcc_source()
{
	mkdir -p ${gcc_src_base}
	check_archive ${gcc_org_src_dir} ||
		wget -O ${gcc_org_src_dir}.tar.bz2 \
			http://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.bz2 || return 1
}

fetch_readline_source()
{
	mkdir -p ${readline_src_base}
	check_archive ${readline_org_src_dir} ||
		wget -O ${readline_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/readline/${readline_name}.tar.gz || return 1
}

fetch_ncurses_source()
{
	mkdir -p ${ncurses_src_base}
	check_archive ${ncurses_org_src_dir} ||
		wget -O ${ncurses_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/ncurses/${ncurses_name}.tar.gz || return 1
}

fetch_gdb_source()
{
	mkdir -p ${gdb_src_base}
	check_archive ${gdb_org_src_dir} ||
		wget -O ${gdb_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/gdb/${gdb_name}.tar.xz || return 1
}

fetch_zlib_source()
{
	mkdir -p ${zlib_src_base}
	check_archive ${zlib_org_src_dir} ||
		wget -O ${zlib_org_src_dir}.tar.xz \
			http://zlib.net/${zlib_name}.tar.xz || return 1
}

fetch_libpng_source()
{
	mkdir -p ${libpng_src_base}
	check_archive ${libpng_org_src_dir} ||
		wget --trust-server-names -O ${libpng_org_src_dir}.tar.xz \
			http://download.sourceforge.net/libpng/${libpng_name}.tar.xz || return 1
}

fetch_libtiff_source()
{
	mkdir -p ${tiff_src_base}
	check_archive ${tiff_org_src_dir} ||
		wget -O ${tiff_org_src_dir}.tar.gz \
			ftp://ftp.remotesensing.org/pub/libtiff/${tiff_name}.tar.gz || return 1
}

fetch_libjpeg_source()
{
	mkdir -p ${jpeg_src_base}
	check_archive ${jpeg_org_src_dir} ||
		wget -O ${jpeg_org_src_dir}.tar.gz \
			http://www.ijg.org/files/${jpeg_name}.tar.gz || return 1
}

fetch_giflib_source()
{
	mkdir -p ${giflib_src_base}
	check_archive ${giflib_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${giflib_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/giflib/files/${giflib_name}.tar.bz2/download || return 1
}

fetch_libXpm_source()
{
	mkdir -p ${libXpm_src_base}
	check_archive ${libXpm_org_src_dir} ||
		wget --no-check-certificate -O ${libXpm_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/lib/${libXpm_name}.tar.bz2 || return 1
}

fetch_libwebp_source()
{
	mkdir -p ${libwebp_src_base}
	check_archive ${libwebp_org_src_dir} ||
		wget --no-check-certificate -O ${libwebp_org_src_dir}.tar.gz \
			https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${libwebp_name}.tar.gz || return 1
}

fetch_libffi_source()
{
	mkdir -p ${libffi_src_base}
	check_archive ${libffi_org_src_dir} ||
		wget -O ${libffi_org_src_dir}.tar.gz \
			ftp://sourceware.org/pub/libffi/${libffi_name}.tar.gz || return 1
}

fetch_glib_source()
{
	mkdir -p ${glib_src_base}
	check_archive ${glib_org_src_dir} ||
		wget -O ${glib_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/glib/`echo ${glib_ver} | cut -f-2 -d.`/${glib_name}.tar.xz || return 1
}

fetch_cairo_source()
{
	mkdir -p ${cairo_src_base}
	check_archive ${cairo_org_src_dir} ||
		wget --no-check-certificate -O ${cairo_org_src_dir}.tar.xz \
			https://www.cairographics.org/releases/${cairo_name}.tar.xz || return 1
}

fetch_pixman_source()
{
	mkdir -p ${pixman_src_base}
	check_archive ${pixman_org_src_dir} ||
		wget --no-check-certificate -O ${pixman_org_src_dir}.tar.gz \
			https://www.cairographics.org/releases/${pixman_name}.tar.gz || return 1
}

fetch_pango_source()
{
	mkdir -p ${pango_src_base}
	check_archive ${pango_org_src_dir} ||
		wget -O ${pango_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/pango/`echo ${pango_ver} | cut -f-2 -d.`/${pango_name}.tar.xz || return 1
}

fetch_gdk_pixbuf_source()
{
	mkdir -p ${gdk_pixbuf_src_base}
	check_archive ${gdk_pixbuf_org_src_dir} ||
		wget -O ${gdk_pixbuf_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/`echo ${gdk_pixbuf_ver} | cut -f-2 -d.`/${gdk_pixbuf_name}.tar.xz || return 1
}

fetch_atk_source()
{
	mkdir -p ${atk_src_base}
	check_archive ${atk_org_src_dir} ||
		wget -O ${atk_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/atk/`echo ${atk_ver} | cut -f-2 -d.`/${atk_name}.tar.xz || return 1
}

fetch_gobject_introspection_source()
{
	mkdir -p ${gobject_introspection_src_base}
	check_archive ${gobject_introspection_org_src_dir} ||
		wget -O ${gobject_introspection_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/gobject-introspection/`echo ${gobject_introspection_ver} | cut -f-2 -d.`/${gobject_introspection_name}.tar.xz || return 1
}

fetch_inputproto_source()
{
	mkdir -p ${inputproto_src_base}
	check_archive ${inputproto_org_src_dir} ||
		wget --no-check-certificate -O ${inputproto_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/proto/${inputproto_name}.tar.bz2 || return 1
}

fetch_xtrans_source()
{
	mkdir -p ${xtrans_src_base}
	check_archive ${xtrans_org_src_dir} ||
		wget --no-check-certificate -O ${xtrans_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/lib/${xtrans_name}.tar.bz2 || return 1
}

fetch_libX11_source()
{
	mkdir -p ${libX11_src_base}
	check_archive ${libX11_org_src_dir} ||
		wget --no-check-certificate -O ${libX11_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/lib/${libX11_name}.tar.bz2 || return 1
}

fetch_libxcb_source()
{
	mkdir -p ${libxcb_src_base}
	check_archive ${libxcb_org_src_dir} ||
		wget --no-check-certificate -O ${libxcb_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/xcb/${libxcb_name}.tar.bz2 || return 1
}

fetch_xcb_proto_source()
{
	mkdir -p ${xcb_proto_src_base}
	check_archive ${xcb_proto_org_src_dir} ||
		wget --no-check-certificate -O ${xcb_proto_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/xcb/${xcb_proto_name}.tar.bz2 || return 1
}

fetch_xextproto_source()
{
	mkdir -p ${xextproto_src_base}
	check_archive ${xextproto_org_src_dir} ||
		wget --no-check-certificate -O ${xextproto_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/proto/${xextproto_name}.tar.bz2 || return 1
}

fetch_libXext_source()
{
	mkdir -p ${libXext_src_base}
	check_archive ${libXext_org_src_dir} ||
		wget -O ${libXext_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/lib/${libXext_name}.tar.bz2 || return 1
}

fetch_fixesproto_source()
{
	mkdir -p ${fixesproto_src_base}
	check_archive ${fixesproto_org_src_dir} ||
		wget --no-check-certificate -O ${fixesproto_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/proto/${fixesproto_name}.tar.bz2 || return 1
}

fetch_libXfixes_source()
{
	mkdir -p ${libXfixes_src_base}
	check_archive ${libXfixes_org_src_dir} ||
		wget -O ${libXfixes_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/lib/${libXfixes_name}.tar.bz2 || return 1
}

fetch_damageproto_source()
{
	mkdir -p ${damageproto_src_base}
	check_archive ${damageproto_org_src_dir} ||
		wget --no-check-certificate -O ${damageproto_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/proto/${damageproto_name}.tar.bz2 || return 1
}

fetch_libXdamage_source()
{
	mkdir -p ${libXdamage_src_base}
	check_archive ${libXdamage_org_src_dir} ||
		wget -O ${libXdamage_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/lib/${libXdamage_name}.tar.bz2 || return 1
}

fetch_libXt_source()
{
	mkdir -p ${libXt_src_base}
	check_archive ${libXt_org_src_dir} ||
		wget --no-check-certificate -O ${libXt_org_src_dir}.tar.bz2 \
			https://www.x.org/releases/individual/lib/${libXt_name}.tar.bz2 || return 1
}

fetch_xproto_source()
{
	mkdir -p ${xproto_src_base}
	check_archive ${xproto_org_src_dir} ||
		wget -O ${xproto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${xproto_name}.tar.bz2 || return 1
}

fetch_kbproto_source()
{
	mkdir -p ${kbproto_src_base}
	check_archive ${kbproto_org_src_dir} ||
		wget -O ${kbproto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${kbproto_name}.tar.bz2 || return 1
}

fetch_glproto_source()
{
	mkdir -p ${glproto_src_base}
	check_archive ${glproto_org_src_dir} ||
		wget -O ${glproto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${glproto_name}.tar.bz2 || return 1
}

fetch_libpciaccess_source()
{
	mkdir -p ${libpciaccess_src_base}
	check_archive ${libpciaccess_org_src_dir} ||
		wget -O ${libpciaccess_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/lib/${libpciaccess_name}.tar.bz2 || return 1
}

fetch_libdrm_source()
{
	mkdir -p ${libdrm_src_base}
	check_archive ${libdrm_org_src_dir} ||
		wget --no-check-certificate -O ${libdrm_org_src_dir}.tar.bz2 \
			https://dri.freedesktop.org/libdrm/${libdrm_name}.tar.bz2 || return 1
}

fetch_dri2proto_source()
{
	mkdir -p ${dri2proto_src_base}
	check_archive ${dri2proto_org_src_dir} ||
		wget -O ${dri2proto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${dri2proto_name}.tar.bz2 || return 1
}

fetch_dri3proto_source()
{
	mkdir -p ${dri3proto_src_base}
	check_archive ${dri3proto_org_src_dir} ||
		wget -O ${dri3proto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${dri3proto_name}.tar.bz2 || return 1
}

fetch_presentproto_source()
{
	mkdir -p ${presentproto_src_base}
	check_archive ${presentproto_org_src_dir} ||
		wget -O ${presentproto_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/proto/${presentproto_name}.tar.bz2 || return 1
}

fetch_libxshmfence_source()
{
	mkdir -p ${libxshmfence_src_base}
	check_archive ${libxshmfence_org_src_dir} ||
		wget -O ${libxshmfence_org_src_dir}.tar.bz2 \
			ftp://ftp.freedesktop.org/pub/individual/lib/${libxshmfence_name}.tar.bz2 || return 1
}

fetch_mesa_source()
{
	mkdir -p ${mesa_src_base}
	check_archive ${mesa_org_src_dir} ||
		wget -O ${mesa_org_src_dir}.tar.xz \
			ftp://ftp.freedesktop.org/pub/mesa/${mesa_ver}/${mesa_name}.tar.xz || return 1
}

fetch_libepoxy_source()
{
	mkdir -p ${libepoxy_src_base}
	check_archive ${libepoxy_org_src_dir} ||
		wget --no-check-certificate -O ${libepoxy_org_src_dir}.tar.bz2 \
			https://github.com/anholt/libepoxy/releases/download/v${libepoxy_ver}/${libepoxy_name}.tar.bz2 || return 1
}

fetch_gtk_source()
{
	mkdir -p ${gtk_src_base}
	check_archive ${gtk_org_src_dir} ||
		wget -O ${gtk_org_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/gtk+/`echo ${gtk_ver} | cut -f-2 -d.`/${gtk_name}.tar.xz || return 1
}

fetch_webkitgtk_source()
{
	mkdir -p ${webkitgtk_src_base}
	check_archive ${webkitgtk_org_src_dir} ||
		wget --no-check-certificate -O ${webkitgtk_org_src_dir}.tar.xz \
			https://webkitgtk.org/releases/${webkitgtk_name}.tar.xz || return 1
}

fetch_emacs_source()
{
	mkdir -p ${emacs_src_base}
	check_archive ${emacs_org_src_dir} ||
		wget -O ${emacs_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/emacs/${emacs_name}.tar.xz || return 1
}

fetch_vim_source()
{
	mkdir -p ${vim_src_base}
	check_archive ${vim_org_src_dir} ||
		wget --no-check-certificate -O ${vim_org_src_dir}.tar.gz \
			http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return 1
}

fetch_ctags_source()
{
	mkdir -p ${ctags_src_base}
	check_archive ${ctags_org_src_dir} ||
		wget --trust-server-names -O ${ctags_org_src_dir}.tar.gz \
			http://prdownloads.sourceforge.net/ctags/${ctags_name}.tar.gz || return 1
}

fetch_grep_source()
{
	mkdir -p ${grep_src_base}
	check_archive ${grep_org_src_dir} ||
		wget -O ${grep_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/grep/${grep_name}.tar.xz || return 1
}

fetch_global_source()
{
	mkdir -p ${global_src_base}
	check_archive ${global_org_src_dir} ||
		wget -O ${global_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/global/${global_name}.tar.gz || return 1
}

fetch_pcre2_source()
{
	mkdir -p ${pcre2_src_base}
	check_archive ${pcre2_org_src_dir} ||
		wget -O ${pcre2_org_src_dir}.tar.bz2 \
			ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/${pcre2_name}.tar.bz2 || return 1
}

fetch_the_silver_searcher_source()
{
	mkdir -p ${the_silver_searcher_src_base}
	check_archive ${the_silver_searcher_org_src_dir} ||
		wget -O ${the_silver_searcher_org_src_dir}.tar.gz \
			http://geoff.greer.fm/ag/releases/${the_silver_searcher_name}.tar.gz || return 1
}

fetch_graphviz_source()
{
	mkdir -p ${graphviz_src_base}
	check_archive ${graphviz_org_src_dir} ||
		wget -O ${graphviz_org_src_dir}.tar.gz \
			http://www.graphviz.org/pub/graphviz/stable/SOURCES/${graphviz_name}.tar.gz || return 1
}

fetch_doxygen_source()
{
	mkdir -p ${doxygen_src_base}
	check_archive ${doxygen_org_src_dir} ||
		wget -O ${doxygen_org_src_dir}.tar.gz \
			http://ftp.stack.nl/pub/users/dimitri/${doxygen_name}.src.tar.gz || return 1
}

fetch_diffutils_source()
{
	mkdir -p ${diffutils_src_base}
	check_archive ${diffutils_org_src_dir} ||
		wget -O ${diffutils_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/diffutils/${diffutils_name}.tar.xz || return 1
}

fetch_patch_source()
{
	mkdir -p ${patch_src_base}
	check_archive ${patch_org_src_dir} ||
		wget -O ${patch_org_src_dir}.tar.xz \
			http://ftp.gnu.org/gnu/patch/${patch_name}.tar.xz || return 1
}

fetch_findutils_source()
{
	mkdir -p ${findutils_src_base}
	check_archive ${findutils_org_src_dir} ||
		wget -O ${findutils_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/findutils/${findutils_name}.tar.gz || return 1
}

fetch_screen_source()
{
	mkdir -p ${screen_src_base}
	check_archive ${screen_org_src_dir} ||
		wget -O ${screen_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/screen/${screen_name}.tar.gz || return 1
}

fetch_libevent_source()
{
	mkdir -p ${libevent_src_base}
	check_archive ${libevent_org_src_dir}-stable ||
		wget --no-check-certificate -O ${libevent_org_src_dir}-stable.tar.gz \
			https://github.com/libevent/libevent/releases/download/release-${libevent_ver}-stable/${libevent_name}-stable.tar.gz || return 1
}

fetch_tmux_source()
{
	mkdir -p ${tmux_src_base}
	check_archive ${tmux_org_src_dir} ||
		wget --no-check-certificate -O ${tmux_org_src_dir}.tar.gz \
			https://github.com/tmux/tmux/releases/download/${tmux_ver}/${tmux_name}.tar.gz || return 1
}

fetch_zsh_source()
{
	mkdir -p ${zsh_src_base}
	check_archive ${zsh_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${zsh_org_src_dir}.tar.xz \
			https://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.xz/download || return 1
}

fetch_bash_source()
{
	mkdir -p ${bash_src_base}
	check_archive ${bash_org_src_dir} ||
		wget -O ${bash_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/bash/${bash_name}.tar.gz || return 1
}

fetch_openssl_source()
{
	mkdir -p ${openssl_src_base}
	check_archive ${openssl_org_src_dir} ||
		wget --no-check-certificate -O ${openssl_org_src_dir}.tar.gz \
			http://www.openssl.org/source/old/`echo ${openssl_ver} | sed -e 's/[a-z]//g'`/${openssl_name}.tar.gz || return 1
}

fetch_openssh_source()
{
	mkdir -p ${openssh_src_base}
	check_archive ${openssh_org_src_dir} ||
		wget -O ${openssh_org_src_dir}.tar.gz \
			http://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/${openssh_name}.tar.gz || return 1
}

fetch_curl_source()
{
	mkdir -p ${curl_src_base}
	check_archive ${curl_org_src_dir} ||
		wget --no-check-certificate -O ${curl_org_src_dir}.tar.bz2 \
			https://curl.haxx.se/download/${curl_name}.tar.bz2 || return 1
}

fetch_asciidoc_source()
{
	mkdir -p ${asciidoc_src_base}
	check_archive ${asciidoc_org_src_dir} ||
		wget --no-check-certificate -O ${asciidoc_org_src_dir}.tar.gz \
			https://sourceforge.net/projects/asciidoc/files/asciidoc/${asciidoc_ver}/${asciidoc_name}.tar.gz/download || return 1
}

fetch_xmlto_source()
{
	mkdir -p ${xmlto_src_base}
	check_archive ${xmlto_org_src_dir} ||
		wget --no-check-certificate -O ${xmlto_org_src_dir}.tar.bz2 \
			https://fedorahosted.org/releases/x/m/xmlto/${xmlto_name}.tar.bz2 || return 1
}

fetch_libxml2_source()
{
	mkdir -p ${libxml2_src_base}
	check_archive ${libxml2_org_src_dir} ||
		wget -O ${libxml2_org_src_dir}.tar.gz \
			ftp://xmlsoft.org/libxml2/${libxml2_name}.tar.gz || return 1
}

fetch_libxslt_source()
{
	mkdir -p ${libxslt_src_base}
	check_archive ${libxslt_org_src_dir} ||
		wget -O ${libxslt_org_src_dir}.tar.gz \
			ftp://xmlsoft.org/libxml2/${libxslt_name}.tar.gz || return 1
}

fetch_gettext_source()
{
	mkdir -p ${gettext_src_base}
	check_archive ${gettext_org_src_dir} ||
		wget -O ${gettext_org_src_dir}.tar.xz \
			http://ftp.gnu.org/pub/gnu/gettext/${gettext_name}.tar.xz || return 1
}

fetch_git_source()
{
	mkdir -p ${git_src_base}
	check_archive ${git_org_src_dir} ||
		wget --no-check-certificate -O ${git_org_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return 1
}

fetch_mercurial_source()
{
	mkdir -p ${mercurial_src_base}
	check_archive ${mercurial_org_src_dir} ||
		wget --no-check-certificate -O ${mercurial_org_src_dir}.tar.gz \
			https://www.mercurial-scm.org/release/${mercurial_name}.tar.gz || return 1
}

fetch_sqlite_source()
{
	mkdir -p ${sqlite_autoconf_src_base}
	check_archive ${sqlite_autoconf_org_src_dir} ||
		wget --no-check-certificate -O ${sqlite_autoconf_org_src_dir}.tar.gz \
			https://www.sqlite.org/2016/${sqlite_autoconf_name}.tar.gz || return 1
}

fetch_apr_source()
{
	mkdir -p ${apr_src_base}
	check_archive ${apr_org_src_dir} ||
		wget -O ${apr_org_src_dir}.tar.bz2 \
			http://ftp.tsukuba.wide.ad.jp/software/apache/apr/${apr_name}.tar.bz2 || return 1
}

fetch_apr_util_source()
{
	mkdir -p ${apr_util_src_base}
	check_archive ${apr_util_org_src_dir} ||
		wget -O ${apr_util_org_src_dir}.tar.bz2 \
			http://ftp.tsukuba.wide.ad.jp/software/apache/apr/${apr_util_name}.tar.bz2 || return 1
}

fetch_subversion_source()
{
	mkdir -p ${subversion_src_base}
	check_archive ${subversion_org_src_dir} ||
		wget -O ${subversion_org_src_dir}.tar.bz2 \
			http://ftp.tsukuba.wide.ad.jp/software/apache/subversion/${subversion_name}.tar.bz2 || return 1
}

fetch_cmake_source()
{
	mkdir -p ${cmake_src_base}
	check_archive ${cmake_org_src_dir} ||
		wget --no-check-certificate -O ${cmake_org_src_dir}.tar.gz \
			https://cmake.org/files/v`echo ${cmake_ver} | cut -f1,2 -d.`/${cmake_name}.tar.gz || return 1
}

fetch_libedit_source()
{
	mkdir -p ${libedit_src_base}
	check_archive ${libedit_org_src_dir} ||
		wget -O ${libedit_org_src_dir}.tar.gz \
			http://thrysoee.dk/editline/${libedit_name}.tar.gz || return 1
}

fetch_swig_source()
{
	mkdir -p ${swig_src_base}
	check_archive ${swig_org_src_dir} ||
		wget --no-check-certificate --trust-server-names -O ${swig_org_src_dir}.tar.gz \
			https://sourceforge.net/projects/swig/files/swig/${swig_name}/${swig_name}.tar.gz/download || return 1
}

fetch_llvm_source()
{
	mkdir -p ${llvm_src_base}
	check_archive ${llvm_org_src_dir} ||
		wget -O ${llvm_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${llvm_name}.tar.xz || return 1
}

fetch_libcxx_source()
{
	mkdir -p ${libcxx_src_base}
	check_archive ${libcxx_org_src_dir} ||
		wget -O ${libcxx_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${libcxx_name}.tar.xz || return 1
}

fetch_libcxxabi_source()
{
	mkdir -p ${libcxxabi_src_base}
	check_archive ${libcxxabi_org_src_dir} ||
		wget -O ${libcxxabi_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${libcxxabi_name}.tar.xz || return 1
}

fetch_compiler_rt_source()
{
	mkdir -p ${compiler_rt_src_base}
	check_archive ${compiler_rt_org_src_dir} ||
		wget -O ${compiler_rt_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${compiler_rt_name}.tar.xz || return 1
}

fetch_cfe_source()
{
	mkdir -p ${cfe_src_base}
	check_archive ${cfe_org_src_dir} ||
		wget -O ${cfe_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${cfe_name}.tar.xz || return 1
}

fetch_clang_tools_extra_source()
{
	mkdir -p ${clang_tools_extra_src_base}
	check_archive ${clang_tools_extra_org_src_dir} ||
		wget -O ${clang_tools_extra_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${clang_tools_extra_name}.tar.xz || return 1
}

fetch_lld_source()
{
	mkdir -p ${lld_src_base}
	check_archive ${lld_org_src_dir} ||
		wget -O ${lld_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${lld_name}.tar.xz || return 1
}

fetch_lldb_source()
{
	mkdir -p ${lldb_src_base}
	check_archive ${lldb_org_src_dir} ||
		wget -O ${lldb_org_src_dir}.tar.xz \
			http://llvm.org/releases/${llvm_ver}/${lldb_name}.tar.xz || return 1
}

fetch_boost_source()
{
	mkdir -p ${boost_src_base}
	check_archive ${boost_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${boost_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/boost/files/boost/`echo ${boost_ver} | tr _ .`/${boost_name}.tar.bz2/download || return 1
}

fetch_mingw_w64_source()
{
	mkdir -p ${mingw_w64_src_base}
	check_archive ${mingw_w64_org_src_dir} ||
		wget --trust-server-names --no-check-certificate -O ${mingw_w64_org_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v${mingw_w64_ver}.tar.bz2/download || return 1
}

fetch_python_source()
{
	mkdir -p ${Python_src_base}
	check_archive ${Python_org_src_dir} ||
		wget --no-check-certificate -O ${Python_org_src_dir}.tar.xz \
			https://www.python.org/ftp/python/${Python_ver}/${Python_name}.tar.xz || return 1
}

fetch_ruby_source()
{
	mkdir -p ${ruby_src_base}
	check_archive ${ruby_org_src_dir} ||
		wget -O ${ruby_org_src_dir}.tar.xz \
			http://cache.ruby-lang.org/pub/ruby/${ruby_name}.tar.xz || return 1
}

fetch_go_source()
{
	mkdir -p ${go_src_base}
	check_archive ${go_src_base}/go${go_ver}.src ||
		wget --no-check-certificate -O ${go_src_base}/go${go_ver}.src.tar.gz \
			https://storage.googleapis.com/golang/go${go_ver}.src.tar.gz || return 1
}

fetch_perl_source()
{
	mkdir -p ${perl_src_base}
	check_archive ${perl_org_src_dir} ||
		wget -O ${perl_org_src_dir}.tar.gz \
			http://www.cpan.org/src/5.0/${perl_name}.tar.gz || return 1
}

fetch_yasm_source()
{
	mkdir -p ${yasm_src_base}
	check_archive ${yasm_org_src_dir} ||
		wget -O ${yasm_org_src_dir}.tar.gz \
			http://www.tortall.net/projects/yasm/releases/${yasm_name}.tar.gz || return 1
}

fetch_x264_source()
{
	mkdir -p ${x264_src_base}
	check_archive ${x264_org_src_dir} ||
		wget -O ${x264_org_src_dir}.tar.bz2 \
			ftp://ftp.videolan.org/pub/x264/snapshots/`echo ${x264_ver} | tr - _`_x264.tar.bz2 || return 1
}

fetch_x265_source()
{
	mkdir -p ${x265_src_base}
	check_archive ${x265_org_src_dir} ||
		wget -O ${x265_org_src_dir}.tar.gz \
			http://ftp.videolan.org/pub/videolan/x265/x265_${x265_ver}.tar.gz || return 1
}

fetch_libav_source()
{
	mkdir -p ${libav_src_base}
	check_archive ${libav_org_src_dir} ||
		wget --no-check-certificate -O ${libav_org_src_dir}.tar.xz \
			https://libav.org/releases/${libav_name}.tar.xz || return 1
}

fetch_opencv_source()
{
	mkdir -p ${opencv_src_base}
	check_archive ${opencv_org_src_dir} ||
		wget --no-check-certificate -O ${opencv_org_src_dir}.tar.gz \
			https://github.com/opencv/opencv/archive/${opencv_ver}.tar.gz || return 1
}

fetch_opencv_contrib_source()
{
	mkdir -p ${opencv_contrib_src_base}
	check_archive ${opencv_contrib_org_src_dir} ||
		wget --no-check-certificate -O ${opencv_contrib_org_src_dir}.tar.gz \
			https://github.com/opencv/opencv_contrib/archive/${opencv_ver}.tar.gz || return 1
}

install_native_tar()
{
	[ -x ${prefix}/bin/tar -a "${force_install}" != yes ] && return 0
	which xz > /dev/null || install_native_xz || return 1
	fetch_tar_source || return 1
	unpack_archive ${tar_org_src_dir} ${tar_src_base} || return 1
	[ -f ${tar_org_src_dir}/Makefile ] ||
		(cd ${tar_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} \
			--build=${build} --disable-silent-rules) || return 1
	make -C ${tar_org_src_dir} -j ${jobs} || return 1
	make -C ${tar_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_xz()
{
	[ -x ${prefix}/bin/xz -a "${force_install}" != yes ] && return 0
	fetch_xz_source || return 1
	unpack_archive ${xz_org_src_dir} ${xz_src_base} || return 1
	[ -f ${xz_org_src_dir}/Makefile ] ||
		(cd ${xz_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${xz_org_src_dir} -j ${jobs} || return 1
	make -C ${xz_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_bzip2()
{
	[ -x ${prefix}/bin/bzip2 -a "${force_install}" != yes ] && return 0
	fetch_bzip2_source || return 1
	unpack_archive ${bzip2_org_src_dir} ${bzip2_src_base} || return 1
	sed -i -e \
			'/^CFLAGS=/{
				s/ -fPIC//g
				s/$/ -fPIC/
			}
			s/ln -s -f \$(PREFIX)\/bin\//ln -s -f /' ${bzip2_org_src_dir}/Makefile || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} clean || return 1
	make -C ${bzip2_org_src_dir} -j ${jobs} -f Makefile-libbz2_so || return 1
	cp -f ${bzip2_org_src_dir}/libbz2.so.${bzip2_ver} ${prefix}/lib || return 1
	chmod a+r ${prefix}/lib/libbz2.so.${bzip2_ver} || return 1
	ln -sf ./libbz2.so.${bzip2_ver} ${prefix}/lib/libbz2.so.`echo ${bzip2_ver} | cut -d. -f-2` || return 1
	cp -f ${bzip2_org_src_dir}/bzlib.h ${prefix}/include || return 1
	cp -f ${bzip2_org_src_dir}/bzlib_private.h ${prefix}/include || return 1
	update_search_path || return 1
}

install_native_gzip()
{
	[ -x ${prefix}/bin/gzip -a "${force_install}" != yes ] && return 0
	fetch_gzip_source || return 1
	unpack_archive ${gzip_org_src_dir} ${gzip_src_base} || return 1
	[ -f ${gzip_org_src_dir}/Makefile ] ||
		(cd ${gzip_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${gzip_org_src_dir} -j ${jobs} || return 1
	make -C ${gzip_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_wget()
{
	[ -x ${prefix}/bin/wget -a "${force_install}" != yes ] && return 0
	search_header ssl.h openssl > /dev/null || install_native_openssl || return 1
	fetch_wget_source || return 1
	unpack_archive ${wget_org_src_dir} ${wget_src_base} || return 1
	[ -f ${wget_org_src_dir}/Makefile ] ||
		(cd ${wget_org_src_dir}
		OPENSSL_CFLAGS="-I${prefix}/include -L${prefix}/lib" OPENSSL_LIBS='-lssl -lcrypto' \
			./configure --prefix=${prefix} --build=${build} --with-ssl=openssl) || return 1
	make -C ${wget_org_src_dir} -j ${jobs} || return 1
	make -C ${wget_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_pkg_config()
{
	[ -x ${prefix}/bin/pkg-config -a "${force_install}" != yes ] && return 0
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return 1
	fetch_pkg_config_source || return 1
	unpack_archive ${pkg_config_org_src_dir} ${pkg_config_src_base} || return 1
	[ -f ${pkg_config_org_src_dir}/Makefile ] ||
		(cd ${pkg_config_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${pkg_config_org_src_dir} -j ${jobs} || return 1
	make -C ${pkg_config_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_texinfo()
{
	[ -x ${prefix}/bin/makeinfo -a "${force_install}" != yes ] && return 0
	fetch_texinfo_source || return 1
	unpack_archive ${texinfo_org_src_dir} ${texinfo_src_base} || return 1
	[ -f ${texinfo_org_src_dir}/Makefile ] ||
		(cd ${texinfo_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${texinfo_org_src_dir} -j ${jobs} || return 1
	make -C ${texinfo_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_coreutils()
{
	[ -x ${prefix}/bin/cat -a "${force_install}" != yes ] && return 0
	fetch_coreutils_source || return 1
	unpack_archive ${coreutils_org_src_dir} ${coreutils_src_base} || return 1
	[ -f ${coreutils_org_src_dir}/Makefile ] ||
		(cd ${coreutils_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} \
			--build=${build} --disable-silent-rules) || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} || return 1
	make -C ${coreutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_bison()
{
	[ -x ${prefix}/bin/bison -a "${force_install}" != yes ] && return 0
	fetch_bison_source || return 1
	unpack_archive ${bison_org_src_dir} ${bison_src_base} || return 1
	[ -f ${bison_org_src_dir}/Makefile ] ||
		(cd ${bison_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${bison_org_src_dir} -j ${jobs} || return 1
	make -C ${bison_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_flex()
{
	[ -x ${prefix}/bin/flex -a "${force_install}" != yes ] && return 0
	which yacc > /dev/null || install_native_bison || return 1
	fetch_flex_source || return 1
	unpack_archive ${flex_org_src_dir} ${flex_src_base} || return 1
	[ -f ${flex_org_src_dir}/Makefile ] ||
		(cd ${flex_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${flex_org_src_dir} -j ${jobs} || return 1
	make -C ${flex_org_src_dir} -j ${jobs} install${strip:+-${strip}} install-man || return 1
	update_search_path || return 1
}

install_native_m4()
{
	[ -x ${prefix}/bin/m4 -a "${force_install}" != yes ] && return 0
	fetch_m4_source || return 1
	unpack_archive ${m4_org_src_dir} ${m4_src_base} || return 1
	[ -f ${m4_org_src_dir}/Makefile ] ||
		(cd ${m4_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${m4_org_src_dir} -j ${jobs} || return 1
	make -C ${m4_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_autoconf()
{
	[ -x ${prefix}/bin/autoconf -a "${force_install}" != yes ] && return 0
	fetch_autoconf_source || return 1
	unpack_archive ${autoconf_org_src_dir} ${autoconf_src_base} || return 1
	[ -f ${autoconf_org_src_dir}/Makefile ] ||
		(cd ${autoconf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} || return 1
	make -C ${autoconf_org_src_dir} -j ${jobs} install || return 1
}

install_native_automake()
{
	[ -x ${prefix}/bin/automake -a "${force_install}" != yes ] && return 0
	which autoconf > /dev/null || install_native_autoconf || return 1
	fetch_automake_source || return 1
	unpack_archive ${automake_org_src_dir} ${automake_src_base} || return 1
	[ -f ${automake_org_src_dir}/Makefile ] ||
		(cd ${automake_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${automake_org_src_dir} -j ${jobs} || return 1
	make -C ${automake_org_src_dir} -j ${jobs} install || return 1
}

install_native_libtool()
{
	[ -x ${prefix}/bin/libtool -a "${force_install}" != yes ] && return 0
	which flex > /dev/null || install_native_flex || return 1
	fetch_libtool_source || return 1
	unpack_archive ${libtool_org_src_dir} ${libtool_src_base} || return 1
	[ -f ${libtool_org_src_dir}/Makefile ] ||
		(cd ${libtool_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} || return 1
	make -C ${libtool_org_src_dir} -j ${jobs} install || return 1
}

install_native_sed()
{
	[ -x ${prefix}/bin/sed -a "${force_install}" != yes ] && return 0
	fetch_sed_source || return 1
	unpack_archive ${sed_org_src_dir} ${sed_src_base} || return 1
	[ -f ${sed_org_src_dir}/Makefile ] ||
		(cd ${sed_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${sed_org_src_dir} -j ${jobs} || return 1
	make -C ${sed_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_gawk()
{
	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return 0
	fetch_gawk_source || return 1
	unpack_archive ${gawk_org_src_dir} ${gawk_src_base} || return 1
	[ -f ${gawk_org_src_dir}/Makefile ] ||
		(cd ${gawk_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} || return 1
	make -C ${gawk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_make()
{
	[ -x ${prefix}/bin/make -a "${force_install}" != yes ] && return 0
	fetch_make_source || return 1
	unpack_archive ${make_org_src_dir} ${make_src_base} || return 1
	[ -f ${make_org_src_dir}/Makefile ] ||
		(cd ${make_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --host=${build}) || return 1
	make -C ${make_org_src_dir} -j ${jobs} || return 1
	make -C ${make_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_binutils()
{
	[ -x ${prefix}/bin/as -a "${force_install}" != yes ] && return 0
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	which yacc > /dev/null || install_native_bison || return 1
	fetch_binutils_source || return 1
	[ -d ${binutils_src_dir_ntv} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return 1
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-sysroot=/ \
			--enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
#			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
#			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function"
		) || return 1
	make -C ${binutils_src_dir_ntv} -j 1 || return 1
	make -C ${binutils_src_dir_ntv} -j 1 install${strip:+-${strip}} || return 1
}

install_native_kernel_header()
{
	fetch_kernel_source || return 1
	[ -d ${linux_src_dir_ntv} ] ||
		(unpack_archive ${linux_org_src_dir} ${linux_src_base} &&
			mv ${linux_org_src_dir} ${linux_src_dir_ntv}) || return 1
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 mrproper || return 1
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 \
		ARCH=${native_linux_arch} INSTALL_HDR_PATH=${prefix} headers_install || return 1
}

install_native_gperf()
{
	[ -x ${prefix}/bin/gperf -a "${force_install}" != yes ] && return 0
	fetch_gperf_source || return 1
	unpack_archive ${gperf_org_src_dir} ${gperf_src_base} || return 1
	[ -f ${gperf_org_src_dir}/Makefile ] ||
		(cd ${gperf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} || return 1
	make -C ${gperf_org_src_dir} -j ${jobs} install || return 1
}

install_native_glibc()
{
	[ -e ${prefix}/lib/libc.so -a "${force_install}" != yes ] && return 0
	install_native_kernel_header || return 1
	which awk > /dev/null || install_native_gawk || return 1
	which gperf > /dev/null || install_native_gperf || return 1
	fetch_glibc_source || return 1
	[ -d ${glibc_src_dir_ntv} ] ||
		(unpack_archive ${glibc_org_src_dir} ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_ntv}) || return 1
	mkdir -p ${glibc_bld_dir_ntv}
	[ -f ${glibc_bld_dir_ntv}/Makefile ] ||
		(cd ${glibc_bld_dir_ntv}
		LD_LIBRARY_PATH='' ${glibc_src_dir_ntv}/configure \
			--prefix=${prefix} --build=${build} \
			--with-headers=${prefix}/include --without-selinux --enable-add-ons \
			CPPFLAGS="${CPPFLAGS} -I${prefix}/include -D_LIBC") || return 1
	make -C ${glibc_bld_dir_ntv} -j ${jobs} install-headers || return 1
	make -C ${glibc_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${glibc_bld_dir_ntv} -j ${jobs} install || return 1
	make -C ${glibc_bld_dir_ntv} -j ${jobs} localedata/install-locales || return 1
	update_search_path || return 1
}

install_native_gmp()
{
	[ -f ${prefix}/include/gmp.h -a "${force_install}" != yes ] && return 0
	fetch_gmp_source || return 1
	[ -d ${gmp_src_dir_ntv} ] ||
		(unpack_archive ${gmp_org_src_dir} ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return 1
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --enable-cxx) || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_mpfr()
{
	[ -f ${prefix}/include/mpfr.h -a "${force_install}" != yes ] && return 0
	search_header gmp.h > /dev/null || install_native_gmp || return 1
	fetch_mpfr_source || return 1
	[ -d ${mpfr_src_dir_ntv} ] ||
		(unpack_archive ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return 1
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-gmp=`get_prefix gmp.h`) || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_mpc()
{
	[ -f ${prefix}/include/mpc.h -a "${force_install}" != yes ] && return 0
	search_header mpfr.h > /dev/null || install_native_mpfr || return 1
	fetch_mpc_source || return 1
	[ -d ${mpc_src_dir_ntv} ] ||
		(unpack_archive ${mpc_org_src_dir} ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return 1
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h`) || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_gcc()
{
	[ -x ${prefix}/bin/gcc -a "${force_install}" != yes ] && return 0
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header gmp.h > /dev/null || install_native_gmp || return 1
	search_header mpfr.h > /dev/null || install_native_mpfr || return 1
	search_header mpc.h > /dev/null || install_native_mpc || return 1
	which perl > /dev/null || install_native_perl || return 1
	fetch_gcc_source || return 1
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_ntv}
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=${languages} --disable-multilib --without-isl --with-system-zlib \
			--enable-libstdcxx-debug \
		) || return 1
	make -C ${gcc_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_readline()
{
	[ -f ${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return 0
	fetch_readline_source || return 1
	unpack_archive ${readline_org_src_dir} ${readline_src_base} || return 1
	[ -f ${readline_org_src_dir}/Makefile ] ||
		(cd ${readline_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${readline_org_src_dir} -j ${jobs} || return 1
	make -C ${readline_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_ncurses()
{
	[ -f ${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return 0
	fetch_ncurses_source || return 1
	unpack_archive ${ncurses_org_src_dir} ${ncurses_src_base} || return 1

	# [XXX] workaround for GCC 5.x
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
		./configure --prefix=${prefix} --build=${build} \
			--with-libtool --with-shared --with-cxx-shared) || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} || return 1
	make -C ${ncurses_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_gdb()
{
	[ -x ${prefix}/bin/gdb -a "${force_install}" != yes ] && return 0
	search_header readline.h readline > /dev/null || install_native_readline || return 1
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	search_header Python.h > /dev/null || install_native_python || return 1
	fetch_gdb_source || return 1
	unpack_archive ${gdb_org_src_dir} ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_ntv}
	[ -f ${gdb_bld_dir_ntv}/Makefile ] ||
		(cd ${gdb_bld_dir_ntv}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--enable-targets=all --enable-tui --with-python=python3 \
			--with-system-zlib --with-system-readline) || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_ntv} -j ${jobs} install || return 1
	make -C ${gdb_bld_dir_ntv}/gdb -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_zlib()
{
	[ -f ${prefix}/include/zlib.h -a "${force_install}" != yes ] && return 0
	fetch_zlib_source || return 1
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
	[ -f ${prefix}/include/png.h -a "${force_install}" != yes ] && return 0
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	fetch_libpng_source || return 1
	[ -d ${libpng_src_dir_ntv} ] ||
		(unpack_archive ${libpng_org_src_dir} ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_ntv}) || return 1
	[ -f ${libpng_src_dir_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libpng_src_dir_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libtiff()
{
	[ -f ${prefix}/include/tiffio.h -a "${force_install}" != yes ] && return 0
	fetch_libtiff_source || return 1
	[ -d ${tiff_src_dir_ntv} ] ||
		(unpack_archive ${tiff_org_src_dir} ${tiff_src_base} &&
			mv ${tiff_org_src_dir} ${tiff_src_dir_ntv}) || return 1
	[ -f ${tiff_src_dir_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${tiff_src_dir_ntv} -j ${jobs} || return 1
	make -C ${tiff_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libjpeg()
{
	[ -f ${prefix}/include/jpeglib.h -a "${force_install}" != yes ] && return 0
	fetch_libjpeg_source || return 1
	[ -d ${jpeg_src_dir_ntv} ] ||
		(unpack_archive ${jpeg_org_src_dir} ${jpeg_src_base} &&
			mv ${jpeg_org_src_dir} ${jpeg_src_dir_ntv}) || return 1
	[ -f ${jpeg_src_dir_ntv}/Makefile ] ||
		(cd ${jpeg_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${jpeg_src_dir_ntv} -j ${jobs} || return 1
	make -C ${jpeg_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_giflib()
{
	[ -f ${prefix}/include/gif_lib.h -a "${force_install}" != yes ] && return 0
	which xmlto > /dev/null || install_native_xmlto || return 1
	fetch_giflib_source || return 1
	[ -d ${giflib_src_dir_ntv} ] ||
		(unpack_archive ${giflib_org_src_dir} ${giflib_src_base} &&
			mv ${giflib_org_src_dir} ${giflib_src_dir_ntv}) || return 1
	[ -f ${giflib_src_dir_ntv}/Makefile ] ||
		(cd ${giflib_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} || return 1
	make -C ${giflib_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libXpm()
{
	[ -f ${prefix}/include/X11/xpm.h -a "${force_install}" != yes ] && return 0
	search_header Xproto.h X11 > /dev/null || install_native_xproto || return 1
	search_header XKBproto.h X11 > /dev/null || install_native_kbproto || return 1
	search_header Xlib.h X11 > /dev/null || install_native_libX11 || return 1
	fetch_libXpm_source || return 1
	unpack_archive ${libXpm_org_src_dir} ${libXpm_src_base} || return 1
	[ -f ${libXpm_org_src_dir}/Makefile ] ||
		(cd ${libXpm_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libXpm_org_src_dir} -j ${jobs} || return 1
	make -C ${libXpm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libwebp()
{
	[ -f ${prefix}/include/webp/decode.h -a "${force_install}" != yes ] && return 0
	search_header png.h > /dev/null || install_native_libpng || return 1
	search_header tiff.h > /dev/null || install_native_libtiff || return 1
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return 1
	search_header gif_lib.h > /dev/null || install_native_giflib || return 1
	fetch_libwebp_source || return 1
	unpack_archive ${libwebp_org_src_dir} ${libwebp_src_base} || return 1
	[ -f ${libwebp_org_src_dir}/Makefile ] ||
		(cd ${libwebp_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libwebp_org_src_dir} -j ${jobs} || return 1
	make -C ${libwebp_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libffi()
{
	[ -f ${prefix}/lib/libffi-*/include/ffi.h -a "${force_install}" != yes ] && return 0
	fetch_libffi_source || return 1
	unpack_archive ${libffi_org_src_dir} ${libffi_src_base} || return 1
	[ -f ${libffi_org_src_dir}/Makefile ] ||
		(cd ${libffi_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libffi_org_src_dir} -j ${jobs} || return 1
	make -C ${libffi_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_glib()
{
	[ -f ${prefix}/include/glib-2.0/glib.h -a "${force_install}" != yes ] && return 0
	search_header ffi.h > /dev/null || install_native_libffi || return 1
	search_header pcre2.h > /dev/null || install_native_pcre2 || return 1
	fetch_glib_source || return 1
	unpack_archive ${glib_org_src_dir} ${glib_src_base} || return 1
	[ -f ${glib_org_src_dir}/Makefile ] ||
		(cd ${glib_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules --disable-libmount --disable-dtrace --enable-systemtap) || return 1
	make -C ${glib_org_src_dir} -j ${jobs} || return 1
	make -C ${glib_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_cairo()
{
	[ -f ${prefix}/include/cairo/cairo.h -a "${force_install}" != yes ] && return 0
	fetch_cairo_source || return 1
	unpack_archive ${cairo_org_src_dir} ${cairo_src_base} || return 1
	[ -f ${cairo_org_src_dir}/Makefile ] ||
		(cd ${cairo_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${cairo_org_src_dir} -j ${jobs} || return 1
	make -C ${cairo_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_pixman()
{
	[ -f ${prefix}/include/pixman-1.0/pixman.h -a "${force_install}" != yes ] && return 0
	fetch_pixman_source || return 1
	unpack_archive ${pixman_org_src_dir} ${pixman_src_base} || return 1
	[ -f ${pixman_org_src_dir}/Makefile ] ||
		(cd ${pixman_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${pixman_org_src_dir} -j ${jobs} || return 1
	make -C ${pixman_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_pango()
{
	[ -f ${prefix}/include/pango-1.0/pango/pango.h -a "${force_install}" != yes ] && return 0
	search_header cairo.h cairo > /dev/null || install_native_cairo || return 1
	search_header pixman.h pixman-1.0 > /dev/null || install_native_pixman || return 1
	fetch_pango_source || return 1
	unpack_archive ${pango_org_src_dir} ${pango_src_base} || return 1
	[ -f ${pango_org_src_dir}/Makefile ] ||
		(cd ${pango_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules) || return 1
	make -C ${pango_org_src_dir} -j ${jobs} || return 1
	make -C ${pango_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_gdk_pixbuf()
{
	[ -f ${prefix}/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf.h -a "${force_install}" != yes ] && return 0
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return 1
	fetch_gdk_pixbuf_source || return 1
	unpack_archive ${gdk_pixbuf_org_src_dir} ${gdk_pixbuf_src_base} || return 1
	[ -f ${gdk_pixbuf_org_src_dir}/Makefile ] ||
		(cd ${gdk_pixbuf_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules) || return 1
	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} || return 1
	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_atk()
{
	[ -f ${prefix}/include/atk-1.0/atk/atk.h -a "${force_install}" != yes ] && return 0
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return 1
	fetch_atk_source || return 1
	unpack_archive ${atk_org_src_dir} ${atk_src_base} || return 1
	[ -f ${atk_org_src_dir}/Makefile ] ||
		(cd ${atk_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules) || return 1
	make -C ${atk_org_src_dir} -j ${jobs} || return 1
	make -C ${atk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_gobject_introspection()
{
	[ -d ${prefix}/include/gobject-introspection-1.0 -a "${force_install}" != yes ] && return 0
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return 1
	fetch_gobject_introspection_source || return 1
	unpack_archive ${gobject_introspection_org_src_dir} ${gobject_introspection_src_base} || return 1
	[ -f ${gobject_introspection_org_src_dir}/Makefile ] ||
		(cd ${gobject_introspection_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules) || return 1
	make -C ${gobject_introspection_org_src_dir} -j ${jobs} || return 1
	make -C ${gobject_introspection_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_inputproto()
{
	[ -d ${prefix}/include/X11/extensions/XI.h -a "${force_install}" != yes ] && return 0
	fetch_inputproto_source || return 1
	unpack_archive ${inputproto_org_src_dir} ${inputproto_src_base} || return 1
	[ -f ${inputproto_org_src_dir}/Makefile ] ||
		(cd ${inputproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${inputproto_org_src_dir} -j ${jobs} || return 1
	make -C ${inputproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_xtrans()
{
	[ -f ${prefix}/include/X11/Xtrans/Xtrans.h -a "${force_install}" != yes ] && return 0
	fetch_xtrans_source || return 1
	unpack_archive ${xtrans_org_src_dir} ${xtrans_src_base} || return 1
	[ -f ${xtrans_org_src_dir}/Makefile ] ||
		(cd ${xtrans_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${xtrans_org_src_dir} -j ${jobs} || return 1
	make -C ${xtrans_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libX11()
{
	[ -f ${prefix}/include/X11/Xlib.h -a "${force_install}" != yes ] && return 0
	search_header XI.h X11/extensions > /dev/null || install_native_inputproto || return 1
	search_header Xtrans.h X11/Xtrans > /dev/null || install_native_xtrans || return 1
	search_header lbx.h X11/extensions > /dev/null || install_native_xextproto || return 1
	search_header xcb.h xcb > /dev/null || install_native_libxcb || return 1
	fetch_libX11_source || return 1
	unpack_archive ${libX11_org_src_dir} ${libX11_src_base} || return 1
	[ -f ${libX11_org_src_dir}/Makefile ] ||
		(cd ${libX11_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libX11_org_src_dir} -j ${jobs} || return 1
	make -C ${libX11_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libxcb()
{
	[ -f ${prefix}/include/xcb/xcb.h -a "${force_install}" != yes ] && return 0
	[ -d ${prefix}/share/xcb ] || install_native_xcb_proto || return 1
	fetch_libxcb_source || return 1
	unpack_archive ${libxcb_org_src_dir} ${libxcb_src_base} || return 1
	[ -f ${libxcb_org_src_dir}/Makefile ] ||
		(cd ${libxcb_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libxcb_org_src_dir} -j ${jobs} || return 1
	make -C ${libxcb_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_xcb_proto()
{
	[ -d ${prefix}/share/xcb -a "${force_install}" != yes ] && return 0
	fetch_xcb_proto_source || return 1
	unpack_archive ${xcb_proto_org_src_dir} ${xcb_proto_src_base} || return 1
	[ -f ${xcb_proto_org_src_dir}/Makefile ] ||
		(cd ${xcb_proto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${xcb_proto_org_src_dir} -j ${jobs} || return 1
	make -C ${xcb_proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_xextproto()
{
	[ -f ${prefix}/include/X11/extensions/lbx.h -a "${force_install}" != yes ] && return 0
	fetch_xextproto_source || return 1
	unpack_archive ${xextproto_org_src_dir} ${xextproto_src_base} || return 1
	[ -f ${xextproto_org_src_dir}/Makefile ] ||
		(cd ${xextproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${xextproto_org_src_dir} -j ${jobs} || return 1
	make -C ${xextproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libXext()
{
	[ -f ${prefix}/include/X11/extensions/Xext.h -a "${force_install}" != yes ] && return 0
	search_header lbx.h X11/extensions > /dev/null || install_native_xextproto || return 1
	fetch_libXext_source || return 1
	unpack_archive ${libXext_org_src_dir} ${libXext_src_base} || return 1
	[ -f ${libXext_org_src_dir}/Makefile ] ||
		(cd ${libXext_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libXext_org_src_dir} -j ${jobs} || return 1
	make -C ${libXext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_fixesproto()
{
	[ -f ${prefix}/include/X11/extensions/xfixesproto.h -a "${force_install}" != yes ] && return 0
	fetch_fixesproto_source || return 1
	unpack_archive ${fixesproto_org_src_dir} ${fixesproto_src_base} || return 1
	[ -f ${fixesproto_org_src_dir}/Makefile ] ||
		(cd ${fixesproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${fixesproto_org_src_dir} -j ${jobs} || return 1
	make -C ${fixesproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libXfixes()
{
	[ -f ${prefix}/include/X11/extensions/Xfixes.h -a "${force_install}" != yes ] && return 0
	search_header xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return 1
	fetch_libXfixes_source || return 1
	unpack_archive ${libXfixes_org_src_dir} ${libXfixes_src_base} || return 1
	[ -f ${libXfixes_org_src_dir}/Makefile ] ||
		(cd ${libXfixes_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libXfixes_org_src_dir} -j ${jobs} || return 1
	make -C ${libXfixes_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_damageproto()
{
	[ -f ${prefix}/include/X11/extensions/damageproto.h -a "${force_install}" != yes ] && return 0
	fetch_damageproto_source || return 1
	unpack_archive ${damageproto_org_src_dir} ${damageproto_src_base} || return 1
	[ -f ${damageproto_org_src_dir}/Makefile ] ||
		(cd ${damageproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${damageproto_org_src_dir} -j ${jobs} || return 1
	make -C ${damageproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libXdamage()
{
	[ -f ${prefix}/include/X11/extensions/Xdamage.h -a "${force_install}" != yes ] && return 0
	search_header damageproto.h X11/extensions > /dev/null || install_native_damageproto || return 1
	search_header Xfixes.h X11/extensions > /dev/null || install_native_libXfixes || return 1
	fetch_libXdamage_source || return 1
	unpack_archive ${libXdamage_org_src_dir} ${libXdamage_src_base} || return 1
	[ -f ${libXdamage_org_src_dir}/Makefile ] ||
		(cd ${libXdamage_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libXdamage_org_src_dir} -j ${jobs} || return 1
	make -C ${libXdamage_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libXt()
{
	[ -f ${prefix}/include/X11/Core.h -a "${force_install}" != yes ] && return 0
	fetch_libXt_source || return 1
	unpack_archive ${libXt_org_src_dir} ${libXt_src_base} || return 1
	[ -f ${libXt_org_src_dir}/Makefile ] ||
		(cd ${libXt_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libXt_org_src_dir} -j ${jobs} || return 1
	make -C ${libXt_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_xproto()
{
	[ -f ${prefix}/include/X11/Xproto.h -a "${force_install}" != yes ] && return 0
	fetch_xproto_source || return 1
	unpack_archive ${xproto_org_src_dir} ${xproto_src_base} || return 1
	[ -f ${xproto_org_src_dir}/Makefile ] ||
		(cd ${xproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${xproto_org_src_dir} -j ${jobs} || return 1
	make -C ${xproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_kbproto()
{
	[ -f ${prefix}/include/X11/XKBproto.h -a "${force_install}" != yes ] && return 0
	fetch_kbproto_source || return 1
	unpack_archive ${kbproto_org_src_dir} ${kbproto_src_base} || return 1
	[ -f ${kbproto_org_src_dir}/Makefile ] ||
		(cd ${kbproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${kbproto_org_src_dir} -j ${jobs} || return 1
	make -C ${kbproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_glproto()
{
	[ -f ${prefix}/include/GL/glxproto.h -a "${force_install}" != yes ] && return 0
	fetch_glproto_source || return 1
	unpack_archive ${glproto_org_src_dir} ${glproto_src_base} || return 1
	[ -f ${glproto_org_src_dir}/Makefile ] ||
		(cd ${glproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${glproto_org_src_dir} -j ${jobs} || return 1
	make -C ${glproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_libpciaccess()
{
	[ -f ${prefix}/include/pciaccess.h -a "${force_install}" != yes ] && return 0
	fetch_libpciaccess_source || return 1
	unpack_archive ${libpciaccess_org_src_dir} ${libpciaccess_src_base} || return 1
	[ -f ${libpciaccess_org_src_dir}/Makefile ] ||
		(cd ${libpciaccess_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libpciaccess_org_src_dir} -j ${jobs} || return 1
	make -C ${libpciaccess_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libdrm()
{
	[ -f ${prefix}/include/xf86drm.h -a "${force_install}" != yes ] && return 0
	search_header pciaccess.h > /dev/null || install_native_libpciaccess || return 1
	fetch_libdrm_source || return 1
	unpack_archive ${libdrm_org_src_dir} ${libdrm_src_base} || return 1
	[ -f ${libdrm_org_src_dir}/Makefile ] ||
		(cd ${libdrm_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-static) || return 1
	make -C ${libdrm_org_src_dir} -j ${jobs} || return 1
	make -C ${libdrm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_dri2proto()
{
	[ -f ${prefix}/include/X11/extensions/dri2proto.h -a "${force_install}" != yes ] && return 0
	fetch_dri2proto_source || return 1
	unpack_archive ${dri2proto_org_src_dir} ${dri2proto_src_base} || return 1
	[ -f ${dri2proto_org_src_dir}/Makefile ] ||
		(cd ${dri2proto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${dri2proto_org_src_dir} -j ${jobs} || return 1
	make -C ${dri2proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_dri3proto()
{
	[ -f ${prefix}/include/X11/extensions/dri3proto.h -a "${force_install}" != yes ] && return 0
	fetch_dri3proto_source || return 1
	unpack_archive ${dri3proto_org_src_dir} ${dri3proto_src_base} || return 1
	[ -f ${dri3proto_org_src_dir}/Makefile ] ||
		(cd ${dri3proto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${dri3proto_org_src_dir} -j ${jobs} || return 1
	make -C ${dri3proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_presentproto()
{
	[ -f ${prefix}/include/X11/extensions/presentproto.h -a "${force_install}" != yes ] && return 0
	fetch_presentproto_source || return 1
	unpack_archive ${presentproto_org_src_dir} ${presentproto_src_base} || return 1
	[ -f ${presentproto_org_src_dir}/Makefile ] ||
		(cd ${presentproto_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${presentproto_org_src_dir} -j ${jobs} || return 1
	make -C ${presentproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_libxshmfence()
{
	[ -f ${prefix}/include/X11/xshmfence.h -a "${force_install}" != yes ] && return 0
	fetch_libxshmfence_source || return 1
	unpack_archive ${libxshmfence_org_src_dir} ${libxshmfence_src_base} || return 1
	[ -f ${libxshmfence_org_src_dir}/Makefile ] ||
		(cd ${libxshmfence_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libxshmfence_org_src_dir} -j ${jobs} || return 1
	make -C ${libxshmfence_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_mesa()
{
	[ -f ${prefix}/include/GL/gl.h -a "${force_install}" != yes ] && return 0
	search_header glxproto.h GL > /dev/null || install_native_glproto || return 1
	search_header xf86drm.h > /dev/null || install_native_libdrm || return 1
	search_header dri2proto.h X11/extensions > /dev/null || install_native_dri2proto || return 1
	search_header dri3proto.h X11/extensions > /dev/null || install_native_dri3proto || return 1
	search_header presentproto.h X11/extensions > /dev/null || install_native_presentproto || return 1
	[ -d ${prefix}/share/xcb ] || install_native_xcb_proto || return 1
	search_header xcb.h xcb > /dev/null || install_native_libxcb || return 1
	search_header xshmfence.h X11 > /dev/null || install_native_libxshmfence || return 1
	search_header Xext.h X11/extensions > /dev/null || install_native_libXext || return 1
	search_header Xdamage.h X11/extensions > /dev/null || install_native_libXdamage || return 1
	search_header Xlib.h X11 > /dev/null || install_native_libX11 || return 1
	fetch_mesa_source || return 1
	unpack_archive ${mesa_org_src_dir} ${mesa_src_base} || return 1
	[ -f ${mesa_org_src_dir}/Makefile ] ||
		(cd ${mesa_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${mesa_org_src_dir} -j ${jobs} || return 1
	make -C ${mesa_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libepoxy()
{
	[ -f ${prefix}/include/epoxy/egl.h -a "${force_install}" != yes ] && return 0
	search_header Core.h X11 > /dev/null || install_native_libXt || return 1
	fetch_libepoxy_source || return 1
	unpack_archive ${libepoxy_org_src_dir} ${libepoxy_src_base} || return 1
	[ -f ${libepoxy_org_src_dir}/Makefile ] ||
		(cd ${libepoxy_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libepoxy_org_src_dir} -j ${jobs} || return 1
	make -C ${libepoxy_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_gtk()
{
	[ -f ${prefix}/include/gtk-3.0/gtk/gtk.h -a "${force_install}" != yes ] && return 0
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return 1
	search_header pango.h pango-1.0/pango > /dev/null || install_native_pango || return 1
	search_header gdk-pixbuf.h gdk-pixbuf-2.0/gdk-pixbuf > /dev/null || install_native_gdk_pixbuf || return 1
	search_header atk.h atk-1.0/atk > /dev/null || install_native_atk || return 1
	search_header giversionmacros.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return 1
	search_header egl.h epoxy > /dev/null || install_native_libepoxy || return 1
	fetch_gtk_source || return 1
	unpack_archive ${gtk_org_src_dir} ${gtk_src_base} || return 1
	[ -f ${gtk_org_src_dir}/Makefile ] ||
		(cd ${gtk_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules) || return 1
	make -C ${gtk_org_src_dir} -j ${jobs} || return 1
	make -C ${gtk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_webkitgtk()
{
#	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return 0
	search_header gtk.h gtk-3.0/gtk > /dev/null || install_native_gtk || return 1
	search_header sqlite3.h > /dev/null || install_native_sqlite || return 1
	search_header png.h > /dev/null || install_native_libpng || return 1
	search_header tiff.h > /dev/null || install_native_libtiff || return 1
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return 1
	search_header gif_lib.h > /dev/null || install_native_giflib || return 1
	search_header decode.h webp > /dev/null || install_native_libwebp || return 1
	fetch_webkitgtk_source || return 1
	unpack_archive ${webkitgtk_org_src_dir} ${webkitgtk_src_base} || return 1
	mkdir -p ${webkitgtk_bld_dir_ntv}
	[ -f ${webkitgtk_bld_dir_ntv}/Makefile ] ||
		(cd ${webkitgtk_bld_dir_ntv}
		update_pkg_config_path
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} -L${prefix}/lib" \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DPORT=GTK -DENABLE_CREDENTIAL_STORAGE=OFF \
			-DENABLE_SPELLCHECK=OFF -DENABLE_WEB_AUDIO=OFF -DENABLE_VIDEO=OFF \
			-DUSE_LIBNOTIFY=OFF -DUSE_LIBHYPHEN=OFF \
			${webkitgtk_org_src_dir}) || return 1
	make -C ${webkitgtk_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${webkitgtk_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_emacs()
{
	[ -x ${prefix}/bin/emacs -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header png.h > /dev/null || install_native_libpng || return 1
	search_header tiff.h > /dev/null || install_native_libtiff || return 1
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return 1
	search_header gif_lib.h > /dev/null || install_native_giflib || return 1
	search_header xpm.h X11 > /dev/null || install_native_libXpm || return 1
	fetch_emacs_source || return 1
	unpack_archive ${emacs_org_src_dir} ${emacs_src_base} || return 1
	[ -f ${emacs_org_src_dir}/Makefile ] ||
		(cd ${emacs_org_src_dir}
		CPPFLAGS="${CPPFLAGS} -I${prefix}/include" LDFLAGS="${LDFLAGS} -L${prefix}/lib" \
			./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--with-modules --with-xwidgets) || return 1
	make -C ${emacs_org_src_dir} -j ${jobs} || return 1
	make -C ${emacs_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_vim()
{
	[ -x ${prefix}/bin/vim -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	which gettext > /dev/null || install_native_gettext || return 1
	which perl > /dev/null || install_native_perl || return 1
	search_header Python.h > /dev/null || install_native_python || return 1
	search_header ruby.h > /dev/null || install_native_ruby || return 1
	fetch_vim_source || return 1
	unpack_archive ${vim_org_src_dir} ${vim_src_base} || return 1
	(cd ${vim_org_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--with-features=huge --enable-fail-if-missing \
		--enable-perlinterp=dynamic \
		--enable-python3interp=dynamic \
		--enable-rubyinterp=dynamic \
		--enable-luainterp=dynamic --with-luajit \
		--enable-cscope --enable-multibyte \
		--enable-gui=yes --enable-xim --enable-fontset \
#		--enable-dnd --enable-footer \
#		--enable-mouse_gpm --enable-mouse_jsbterm \
#		--enable-mouse_sysmouse \
#		--enable-xterm_save \
	) || return 1
	make -C ${vim_org_src_dir} -j ${jobs} || return 1
	make -C ${vim_org_src_dir} -j ${jobs} install || return 1
}

install_native_ctags()
{
	[ -x ${prefix}/bin/ctags -a "${force_install}" != yes ] && return 0
	fetch_ctags_source || return 1
	unpack_archive ${ctags_org_src_dir} ${ctags_src_base} || return 1
	[ -f ${ctags_org_src_dir}/Makefile ] ||
		(cd ${ctags_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${ctags_org_src_dir} -j ${jobs} || return 1
	make -C ${ctags_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_grep()
{
	[ -x ${prefix}/bin/grep -a "${force_install}" != yes ] && return 0
	fetch_grep_source || return 1
	unpack_archive ${grep_org_src_dir} ${grep_src_base} || return 1
	[ -f ${grep_org_src_dir}/Makefile ] ||
		(cd ${grep_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${grep_org_src_dir} -j ${jobs} || return 1
	make -C ${grep_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_global()
{
	[ -x ${prefix}/bin/global -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	fetch_global_source || return 1
	unpack_archive ${global_org_src_dir} ${global_src_base} || return 1
	[ -f ${global_org_src_dir}/Makefile ] ||
		(cd ${global_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--with-ncurses=`get_prefix curses.h ncurses` CPPFLAGS="${CPPFLAGS} -I${prefix}/include/ncurses") || return 1
	make -C ${global_org_src_dir} -j ${jobs} || return 1
	make -C ${global_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_pcre2()
{
	[ -f ${prefix}/include/pcre2.h -a "${force_install}" != yes ] && return 0
	fetch_pcre2_source || return 1
	unpack_archive ${pcre2_org_src_dir} ${pcre2_src_base} || return 1
	[ -f ${pcre2_org_src_dir}/Makefile ] ||
		(cd ${pcre2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${pcre2_org_src_dir} -j ${jobs} || return 1
	make -C ${pcre2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_the_silver_searcher()
{
	[ -x ${prefix}/bin/ag -a "${force_install}" != yes ] && return 0
	search_header pcre2.h > /dev/null || install_native_pcre2 || return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header lzma.h > /dev/null || install_native_xz || return 1
	fetch_the_silver_searcher_source || return 1
	unpack_archive ${the_silver_searcher_org_src_dir} ${the_silver_searcher_src_base} || return 1
	[ -f ${the_silver_searcher_org_src_dir}/Makefile ] ||
		(cd ${the_silver_searcher_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules) || return 1
	make -C ${the_silver_searcher_org_src_dir} -j ${jobs} || return 1
	make -C ${the_silver_searcher_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_graphviz()
{
	[ -x ${prefix}/bin/dot -a "${force_install}" != yes ] && return 0
	which swig > /dev/null || install_native_swig || return 1
	fetch_graphviz_source || return 1
	unpack_archive ${graphviz_org_src_dir} ${graphviz_src_base} || return 1
	[ -f ${graphviz_org_src_dir}/Makefile ] ||
		(cd ${graphviz_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-swig --enable-go --enable-perl --enable-python \
			--enable-ruby ) || return 1
	make -C ${graphviz_org_src_dir} -j ${jobs} || return 1
	make -C ${graphviz_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_doxygen()
{
	[ -x ${prefix}/bin/doxygen -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	which clang > /dev/null || install_native_cfe || return 1
	fetch_doxygen_source || return 1
	unpack_archive ${doxygen_org_src_dir} ${doxygen_src_base} || return 1
	mkdir -p ${doxygen_bld_dir_ntv}
	(cd ${doxygen_bld_dir_ntv}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-Dbuild_doc=ON -Duse_libclang=ON ${doxygen_org_src_dir}) || return 1 # [TODO] Xapian入れられたら、build_search=ONにする・・・かも。
	make -C ${doxygen_bld_dir_ntv} -j ${jobs} || return 1
#	make -C ${doxygen_bld_dir_ntv} -j ${jobs} docs || return 1
	make -C ${doxygen_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_diffutils()
{
	[ -x ${prefix}/bin/diff -a "${force_install}" != yes ] && return 0
	fetch_diffutils_source || return 1
	unpack_archive ${diffutils_org_src_dir} ${diffutils_src_base} || return 1
	[ -f ${diffutils_org_src_dir}/Makefile ] ||
		(cd ${diffutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${diffutils_org_src_dir} -j ${jobs} || return 1
	make -C ${diffutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_patch()
{
	[ -x ${prefix}/bin/patch -a "${force_install}" != yes ] && return 0
	fetch_patch_source || return 1
	unpack_archive ${patch_org_src_dir} ${patch_src_base} || return 1
	[ -f ${patch_org_src_dir}/Makefile ] ||
		(cd ${patch_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${patch_org_src_dir} -j ${jobs} || return 1
	make -C ${patch_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_findutils()
{
	[ -x ${prefix}/bin/find -a "${force_install}" != yes ] && return 0
	fetch_findutils_source || return 1
	unpack_archive ${findutils_org_src_dir} ${findutils_src_base} || return 1
	[ -f ${findutils_org_src_dir}/Makefile ] ||
		(cd ${findutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${findutils_org_src_dir} -j ${jobs} || return 1
	make -C ${findutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_screen()
{
	[ -x ${prefix}/bin/screen -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	fetch_screen_source || return 1
	unpack_archive ${screen_org_src_dir} ${screen_src_base} || return 1
	[ -f ${screen_org_src_dir}/Makefile ] ||
		(cd ${screen_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-colors256 --enable-rxvt_osc) || return 1
	make -C ${screen_org_src_dir} -j ${jobs} || return 1
	mkdir -p ${prefix}/share/screen/utf8encodings || return 1
	make -C ${screen_org_src_dir} -j ${jobs} install || return 1
}

install_native_libevent()
{
	[ -f ${prefix}/include/event2/event.h -a "${force_install}" != yes ] && return 0
	fetch_libevent_source || return 1
	unpack_archive ${libevent_org_src_dir}-stable ${libevent_src_base} || return 1
	[ -f ${libevent_org_src_dir}-stable/Makefile ] ||
		(cd ${libevent_org_src_dir}-stable
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${libevent_org_src_dir}-stable -j ${jobs} || return 1
	make -C ${libevent_org_src_dir}-stable -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_tmux()
{
	[ -x ${prefix}/bin/tmux -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	search_header event.h event2 > /dev/null || install_native_libevent || return 1
	fetch_tmux_source || return 1
	unpack_archive ${tmux_org_src_dir} ${tmux_src_base} || return 1
	[ -f ${tmux_org_src_dir}/Makefile ] ||
		(cd ${tmux_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			CPPFLAGS="${CPPFLAGS} -I${prefix}/include/ncurses") || return 1
	make -C ${tmux_org_src_dir} -j ${jobs} || return 1
	make -C ${tmux_org_src_dir} -j ${jobs} install || return 1
}

install_native_zsh()
{
	[ -x ${prefix}/bin/zsh -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	fetch_zsh_source || return 1
	unpack_archive ${zsh_org_src_dir} ${zsh_src_base} || return 1
	[ -f ${zsh_org_src_dir}/Makefile ] ||
		(cd ${zsh_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} || return 1
	make -C ${zsh_org_src_dir} -j ${jobs} install || return 1
}

install_native_bash()
{
	[ -x ${prefix}/bin/bash -a "${force_install}" != yes ] && return 0
	fetch_bash_source || return 1
	unpack_archive ${bash_org_src_dir} ${bash_src_base} || return 1
	[ -f ${bash_org_src_dir}/Makefile ] ||
		(cd ${bash_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${bash_org_src_dir} -j ${jobs} || return 1
	make -C ${bash_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_openssl()
{
	[ -d ${prefix}/include/openssl -a "${force_install}" != yes ] && return 0
	fetch_openssl_source || return 1
	unpack_archive ${openssl_org_src_dir} ${openssl_src_base} || return 1
	(cd ${openssl_org_src_dir}
	./config --prefix=${prefix} shared) || return 1
	make -C ${openssl_org_src_dir} -j ${jobs} || return 1
	make -C ${openssl_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_openssh()
{
	[ -x ${prefix}/bin/ssh -a "${force_install}" != yes ] && return 0
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header ssl.h openssl > /dev/null || install_native_openssl || return 1
	fetch_openssh_source || return 1
	unpack_archive ${openssh_org_src_dir} ${openssh_src_base} || return 1
	[ -f ${openssh_org_src_dir}/Makefile ] ||
		(cd ${openssh_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${openssh_org_src_dir} -j ${jobs} || return 1
	make -C ${openssh_org_src_dir} -j ${jobs} install || return 1
}

install_native_curl()
{
	[ -x ${prefix}/bin/curl -a "${force_install}" != yes ] && return 0
	search_header ssl.h openssl > /dev/null || install_native_openssl || return 1
	fetch_curl_source || return 1
	unpack_archive ${curl_org_src_dir} ${curl_src_base} || return 1
	(cd ${curl_org_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--enable-optimize --disable-silent-rules \
		--enable-http --enable-ftp --enable-file \
		--enable-ldap --enable-ldaps --enable-rtsp --enable-proxy \
		--enable-dict --enable-telnet --enable-tftp --enable-pop3 \
		--enable-imap --enable-smb --enable-smtp --enable-gopher \
		--enable-manual --enable-ipv6 --with-ssl) || return 1
	make -C ${curl_org_src_dir} -j ${jobs} || return 1
	make -C ${curl_org_src_dir} -j ${jobs} install || return 1
	update_search_path || return 1
}

install_native_asciidoc()
{
	[ -x ${prefix}/bin/asciidoc -a "${force_install}" != yes ] && return 0
	fetch_asciidoc_source || return 1
	unpack_archive ${asciidoc_org_src_dir} ${asciidoc_src_base} || return 1
	[ -f ${asciidoc_org_src_dir}/Makefile ] ||
		(cd ${asciidoc_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} || return 1
	make -C ${asciidoc_org_src_dir} -j ${jobs} install || return 1
}

install_native_xmlto()
{
	[ -x ${prefix}/bin/xmlto -a "${force_install}" != yes ] && return 0
	search_header xslt.h libxslt > /dev/null || install_native_libxslt || return 1
	fetch_xmlto_source || return 1
	unpack_archive ${xmlto_org_src_dir} ${xmlto_src_base} || return 1
	[ -f ${xmlto_org_src_dir}/Makefile ] ||
		(cd ${xmlto_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} || return 1
	make -C ${xmlto_org_src_dir} -j ${jobs} install || return 1

# FIXME
# [ -d ${prefix}/share/docbook-xsl-1.79.1 ] || wget --trust-server-names -O- http://sourceforge.net/projects/docbook/files/docbook-xsl/1.79.1/docbook-xsl-1.79.1.tar.bz2/download | tar xjvf - -C ${prefix}/share
# [ -f ${prefix}/share/catalog.xml ] || (wget -O /tmp/hoge.zip http://www.oasis-open.org/docbook/xml/4.2/docbook-xml-4.2.zip && unzip -d ${prefix}/share /tmp/hoge.zip)
# export XML_CATALOG_FILES="${prefix}/share/catalog.xml ${prefix}/share/docbook-xsl-1.79.1/catalog.xml"
}

install_native_libxml2()
{
	[ -d ${prefix}/include/libxml2 -a "${force_install}" != yes ] && return 0
	search_header Python.h > /dev/null || install_native_python || return 1
	fetch_libxml2_source || return 1
	unpack_archive ${libxml2_org_src_dir} ${libxml2_src_base} || return 1
	[ -f ${libxml2_org_src_dir}/Makefile ] ||
		(cd ${libxml2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--without-python --disable-silent-rules) || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} || return 1
	make -C ${libxml2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_libxslt()
{
	[ -d ${prefix}/include/libxslt -a "${force_install}" != yes ] && return 0
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return 1
	fetch_libxslt_source || return 1
	unpack_archive ${libxslt_org_src_dir} ${libxslt_src_base} || return 1
	[ -f ${libxslt_org_src_dir}/Makefile ] ||
		(cd ${libxslt_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return 1
	make -C ${libxslt_org_src_dir} -j ${jobs} || return 1
	make -C ${libxslt_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_gettext()
{
	[ -x ${prefix}/bin/gettext -a "${force_install}" != yes ] && return 0
	fetch_gettext_source || return 1
	unpack_archive ${gettext_org_src_dir} ${gettext_src_base} || return 1
	[ -f ${gettext_org_src_dir}/Makefile ] ||
		(cd ${gettext_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${gettext_org_src_dir} -j ${jobs} || return 1
	make -C ${gettext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
	update_search_path || return 1
}

install_native_git()
{
	[ -x ${prefix}/bin/git -a "${force_install}" != yes ] && return 0
	which autoconf > /dev/null || install_native_autoconf || return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header ssl.h openssl > /dev/null || install_native_openssl || return 1
	search_header curl.h curl > /dev/null || install_native_curl || return 1
	which asciidoc > /dev/null || install_native_asciidoc || return 1
	which xmlto > /dev/null || install_native_xmlto || return 1
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return 1
	search_header xslt.h libxslt > /dev/null || install_native_libxslt || return 1
	which msgfmt > /dev/null || install_native_gettext || return 1
	which perl > /dev/null || install_native_perl || return 1
	fetch_git_source || return 1
	unpack_archive ${git_org_src_dir} ${git_src_base} || return 1
	make -C ${git_org_src_dir} -j ${jobs} configure || return 1
	(cd ${git_org_src_dir}
	./configure --prefix=${prefix} --build=${build} --without-tcltk) || return 1
	sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_org_src_dir}/Makefile || return 1
	make -C ${git_org_src_dir} -j ${jobs} V=1 LDFLAGS="${LDFLAGS} -ldl" all || return 1 # [XXX] docターゲット入れたいけどエラー回避で外してる。
	make -C ${git_org_src_dir} -j ${jobs} V=1 ${strip} install || return 1 # [XXX] install-doc install-htmlターゲット入れたいけどエラー回避で外してる。
}

install_native_mercurial()
{
	[ -x ${prefix}/bin/hg -a "${force_install}" != yes ] && return 0
	which python3 > /dev/null || install_native_python || return 1
	fetch_mercurial_source || return 1
	unpack_archive ${mercurial_org_src_dir} ${mercurial_src_base} || return 1
	pip install docutils || return 1
	make -C ${mercurial_org_src_dir} -j ${jobs} PYTHON=python all || return 1
	make -C ${mercurial_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return 1
}

install_native_sqlite()
{
	[ -f ${prefix}/include/sqlite3.h -a "${force_install}" != yes ] && return 0
	fetch_sqlite_source || return 1
	unpack_archive ${sqlite_autoconf_org_src_dir} ${sqlite_autoconf_src_base} || return 1
	[ -f ${sqlite_autoconf_org_src_dir}/Makefile ] ||
		(cd ${sqlite_autoconf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${sqlite_autoconf_org_src_dir} -j ${jobs} || return 1
	make -C ${sqlite_autoconf_org_src_dir} -j ${jobs} install || return 1
}

install_native_apr()
{
	[ -d ${prefix}/include/apr-1 -a "${force_install}" != yes ] && return 0
	fetch_apr_source || return 1
	unpack_archive ${apr_org_src_dir} ${apr_src_base} || return 1
	[ -f ${apr_org_src_dir}/Makefile ] ||
		(cd ${apr_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-threads --enable-posix-shm --enable-other-child) || return 1
	make -C ${apr_org_src_dir} -j ${jobs} || return 1
	make -C ${apr_org_src_dir} -j ${jobs} install || return 1
}

install_native_apr_util()
{
	[ -f ${prefix}/include/apr-1/apu.h -a "${force_install}" != yes ] && return 0
	search_header apr.h apr-1 > /dev/null || install_native_apr || return 1
	search_header sqlite3.h > /dev/null || install_native_sqlite || return 1
	fetch_apr_util_source || return 1
	unpack_archive ${apr_util_org_src_dir} ${apr_util_src_base} || return 1
	[ -f ${apr_util_org_src_dir}/Makefile ] ||
		(cd ${apr_util_org_src_dir}
		./configure --prefix=${prefix} --with-apr=`get_prefix apr.h apr-1` \
			--with-crypto --with-openssl --with-sqlite3=`get_prefix sqlite3.h`) || return 1
	make -C ${apr_util_org_src_dir} -j ${jobs} || return 1
	make -C ${apr_util_org_src_dir} -j ${jobs} install || return 1
}

install_native_subversion()
{
	[ -x ${prefix}/bin/svn -a "${force_install}" != yes ] && return 0
	search_header apr.h apr-1 > /dev/null || install_native_apr || return 1
	search_header apu.h apr-1 > /dev/null || install_native_apr_util || return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header ssl.h openssl > /dev/null || install_native_openssl || return 1
	which python3 > /dev/null || install_native_python || return 1
	which perl > /dev/null || install_native_perl || return 1
	which ruby > /dev/null || install_native_ruby || return 1
	fetch_subversion_source || return 1
	unpack_archive ${subversion_org_src_dir} ${subversion_src_base} || return 1
	[ -f ${subversion_org_src_dir}/Makefile ] ||
		(cd ${subversion_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --with-zlib=`get_prefix zlib.h` \
			--with-sqlite=`get_prefix sqlite3.h` \
			${strip:+--enable-optimize}) || return 1 # [TODO] stripしないときは、--enable-debugつけてみたい。
	make -C ${subversion_org_src_dir} -j ${jobs} || return 1
	make -C ${subversion_org_src_dir} -j ${jobs} install || return 1
}

install_native_cmake()
{
	[ -x ${prefix}/bin/cmake -a "${force_install}" != yes ] && return 0
	search_header curl.h curl > /dev/null || install_native_curl || return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	search_header bzlib.h > /dev/null || install_native_bzip2 || return 1
	search_header lzma.h > /dev/null || install_native_xz || return 1
	fetch_cmake_source || return 1
	unpack_archive ${cmake_org_src_dir} ${cmake_src_base} || return 1
	[ -f ${cmake_org_src_dir}/Makefile ] ||
		(cd ${cmake_org_src_dir}
		./bootstrap --prefix=${prefix} --parallel=${jobs} \
			--system-curl --system-zlib --system-bzip2 --system-liblzma) || return 1
	make -C ${cmake_org_src_dir} -j ${jobs} || return 1
	make -C ${cmake_org_src_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_libedit()
{
	[ -f ${prefix}/include/histedit.h -a "${force_install}" != yes ] && return 0
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	fetch_libedit_source || return 1
	unpack_archive ${libedit_org_src_dir} ${libedit_src_base} || return 1
	[ -f ${libedit_org_src_dir}/Makefile ] ||
		(cd ${libedit_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules CFLAGS="${CFLAGS} -I${prefix}/include/ncurses") || return 1
	make -C ${libedit_org_src_dir} -j ${jobs} || return 1
	make -C ${libedit_org_src_dir} -j ${jobs} install || return 1
}

install_native_swig()
{
	[ -x ${prefix}/bin/swig -a "${force_install}" != yes ] && return 0
	fetch_swig_source || return 1
	unpack_archive ${swig_org_src_dir} ${swig_src_base} || return 1
	[ -f ${swig_org_src_dir}/Makefile ] ||
		(cd ${swig_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-cpp11-testing) || return 1
	make -C ${swig_org_src_dir} -j ${jobs} || return 1
	make -C ${swig_org_src_dir} -j ${jobs} install || return 1
}

install_native_llvm()
{
	[ -d ${prefix}/include/llvm -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	fetch_llvm_source || return 1
	unpack_archive ${llvm_org_src_dir} ${llvm_src_base} || return 1
	mkdir -p ${llvm_bld_dir}
	(cd ${llvm_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DLLVM_LINK_LLVM_DYLIB=ON ${llvm_org_src_dir}) || return 1
	make -C ${llvm_bld_dir} -j ${jobs} || return 1
	make -C ${llvm_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_libcxx()
{
	[ -e ${prefix}/lib/libc++.so -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	fetch_libcxx_source || return 1
	unpack_archive ${libcxx_org_src_dir} ${libcxx_src_base} || return 1
	mkdir -p ${libcxx_bld_dir}
	(cd ${libcxx_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DLLVM_LINK_LLVM_DYLIB=ON ${libcxx_org_src_dir}) || return 1
	make -C ${libcxx_bld_dir} -j ${jobs} || return 1
	make -C ${libcxx_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_libcxxabi()
{
	[ -e ${prefix}/lib/libc++abi.so -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return 1
	search_header iostream c++/v1 > /dev/null || install_native_libcxx || return 1
	fetch_libcxxabi_source || return 1
	unpack_archive ${libcxxabi_org_src_dir} ${libcxxabi_src_base} || return 1
	mkdir -p ${libcxxabi_bld_dir}
	(cd ${libcxxabi_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${libcxxabi_org_src_dir}) || return 1
	make -C ${libcxxabi_bld_dir} -j ${jobs} || return 1
	make -C ${libcxxabi_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_compiler_rt()
{
	[ -d ${prefix}/include/sanitizer -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return 1
	fetch_compiler_rt_source || return 1
	unpack_archive ${compiler_rt_org_src_dir} ${compiler_rt_src_base} || return 1
	mkdir -p ${compiler_rt_bld_dir}
	(cd ${compiler_rt_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${compiler_rt_org_src_dir}) || return 1
	make -C ${compiler_rt_bld_dir} -j ${jobs} || return 1
	make -C ${compiler_rt_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_cfe()
{
	[ -x ${prefix}/bin/clang -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return 1
	search_header iostream c++/v1 > /dev/null || install_native_libcxx || return 1
	search_header ABI.h clang/Basic > /dev/null || install_native_libcxxabi || return 1
	search_header allocator_interface.h sanitizer > /dev/null || install_native_compiler_rt || return 1
	fetch_cfe_source || return 1
	unpack_archive ${cfe_org_src_dir} ${cfe_src_base} || return 1
	mkdir -p ${cfe_bld_dir}
	(cd ${cfe_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${cfe_org_src_dir}) || return 1
	make -C ${cfe_bld_dir} -j ${jobs} || return 1
	make -C ${cfe_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_clang_tools_extra()
{
	which cmake > /dev/null || install_native_cmake || return 1
	fetch_clang_tools_extra_source || return 1
	unpack_archive ${clang_tools_extra_org_src_dir} ${clang_tools_extra_src_base} || return 1
	mkdir -p ${clang_tools_extra_bld_dir}
	(cd ${clang_tools_extra_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${clang_tools_extra_org_src_dir}) || return 1
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} || return 1
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_lld()
{
	[ -x ${prefix}/bin/lld -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	fetch_llvm_source || return 1
	unpack_archive ${llvm_org_src_dir} ${llvm_src_base} || return 1
	fetch_lld_source || return 1
	[ -d ${llvm_org_src_dir}/tools/lld ] ||
		(unpack_archive ${lld_org_src_dir} ${lld_src_base} &&
		mv ${lld_org_src_dir} ${llvm_org_src_dir}/tools/lld) || return 1
	mkdir -p ${lld_bld_dir}
	(cd ${lld_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${llvm_org_src_dir}) || return 1
	make -C ${lld_bld_dir} -j ${jobs} || return 1
	make -C ${lld_bld_dir} -j ${jobs} check-lld || return 1
	make -C ${lld_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_lldb()
{
	[ -x ${prefix}/bin/lldb -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header histedit.h > /dev/null || install_native_libedit || return 1
	which swig > /dev/null || install_native_swig || return 1
	fetch_llvm_source || return 1
	unpack_archive ${llvm_org_src_dir} ${llvm_src_base} || return 1
	fetch_lldb_source || return 1
	[ -d ${llvm_org_src_dir}/tools/lldb ] ||
		(unpack_archive ${lldb_org_src_dir} ${lldb_src_base} &&
		mv ${lldb_org_src_dir} ${llvm_org_src_dir}/tools/lldb) || return 1
	mkdir -p ${lldb_bld_dir}
	(cd ${lldb_bld_dir}
	cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREIFX=${prefix} ${llvm_org_src_dir}) || return 1
	make -C ${lldb_bld_dir} -j ${jobs} || return 1
	make -C ${lldb_bld_dir} -j ${jobs} check-lldb || return 1
	make -C ${lldb_bld_dir} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_native_boost()
{
	[ -d ${prefix}/include/boost -a "${force_install}" != yes ] && return 0
	search_header bzlib.h > /dev/null || install_native_bzip2 || return 1
	fetch_boost_source || return 1
	unpack_archive ${boost_org_src_dir} ${boost_src_base} || return 1
	(cd ${boost_org_src_dir}
	./bootstrap.sh --prefix=${prefix} --with-toolset=gcc &&
	./b2 --prefix=${prefix} --build-dir=${boost_bld_dir_ntv} \
		--layout=system --build-type=minimal -j ${jobs} -q \
		include=${prefix}/include library-path=${prefix}/lib install) || return 1
}

full_native()
{
	for f in `sed -e '/^install_native_[_[:alnum:]]\+()$/{s/()$//;
		s/install_native_kernel_header//;
		s/install_native_glibc//;
		p};d' $0`; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename $0` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename $0`
	done
	return 0
}

install_cross_binutils()
{
	[ -x ${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return 0
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	fetch_binutils_source || return 1
	[ -d ${binutils_src_dir_crs} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_crs}) || return 1
	[ -f ${binutils_src_dir_crs}/Makefile ] ||
		(cd ${binutils_src_dir_crs}
		./configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-sysroot=${sysroot} --enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return 1
	make -C ${binutils_src_dir_crs} -j 1 || return 1
	make -C ${binutils_src_dir_crs} -j 1 install${strip:+-${strip}} || return 1
}

install_cross_gcc_without_headers()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_1st}
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return 1
}

install_cross_kernel_header()
{
	fetch_kernel_source || return 1
	[ -d ${linux_src_dir_crs} ] ||
		(unpack_archive ${linux_org_src_dir} ${linux_src_base} &&
			mv ${linux_org_src_dir} ${linux_src_dir_crs}) || return 1
	make -C ${linux_src_dir_crs} -j ${jobs} mrproper || return 1
	make -C ${linux_src_dir_crs} -j ${jobs} \
		ARCH=${cross_linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return 1
}

install_cross_glibc_headers()
{
	which awk > /dev/null || install_native_gawk || return 1
	which gperf > /dev/null || install_native_gperf || return 1
	fetch_glibc_source || return 1
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
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib \
			--with-sysroot=${sysroot} --with-newlib \
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

	[ ${cross_linux_arch} = microblaze ] &&
		(cd ${glibc_src_dir_crs_1st}; patch -N -p0 -d ${glibc_src_dir_crs_1st} <<EOF || [ $? = 1 ] || return 1
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

install_cross_functional_gcc()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_3rd}
	[ -f ${gcc_bld_dir_crs_3rd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_3rd}
		LIBS=-lgcc_s ${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=${languages} --disable-multilib --without-isl --with-system-zlib \
			--enable-libstdcxx-debug --with-sysroot=${sysroot}) || return 1
	LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} || return 1
	LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} -k install${strip:+-${strip}} || true # [XXX] install-stripを強行する(現状gotoolsだけ失敗する)ため、-kと|| trueで暫定対応(WA)
}

install_cross_gcc()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return 0
	which ${target}-as > /dev/null || install_cross_binutils || return 1
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	search_header gmp.h > /dev/null || install_native_gmp || return 1
	search_header mpfr.h > /dev/null || install_native_mpfr || return 1
	search_header mpc.h > /dev/null || install_native_mpc || return 1
	which perl > /dev/null || install_native_perl || return 1
	fetch_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_cross_kernel_header || return 1
	install_cross_glibc_headers || return 1
	install_cross_gcc_with_glibc_headers || return 1
	install_cross_1st_glibc || return 1
	install_cross_functional_gcc || return 1
}

install_cross_gdb()
{
	[ -x ${prefix}/bin/${target}-gdb -a "${force_install}" != yes ] && return 0
	search_header readline.h readline > /dev/null || install_native_readline || return 1
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return 1
	search_header Python.h > /dev/null || install_native_python || return 1
	fetch_gdb_source || return 1
	unpack_archive ${gdb_org_src_dir} ${gdb_src_base} || return 1
	mkdir -p ${gdb_bld_dir_crs}
	[ -f ${gdb_bld_dir_crs}/Makefile ] ||
		(cd ${gdb_bld_dir_crs}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--enable-targets=all --enable-tui --with-python=python3 \
			--with-system-zlib --with-system-readline --with-sysroot=${sysroot}) || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} || return 1
	make -C ${gdb_bld_dir_crs} -j ${jobs} install || return 1
	make -C ${gdb_bld_dir_crs}/gdb -j ${jobs} install${strip:+-${strip}} || return 1
	make -C ${gdb_bld_dir_crs}/sim -j ${jobs} install${strip:+-${strip}} || return 1
}

full_cross()
{
	for f in install_cross_binutils install_cross_gcc install_cross_gdb; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename $0` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename $0`
	done
	return 0
}

install_mingw_w64_binutils()
{
	[ -x ${prefix}/bin/x86_64-w64-mingw32-as -a "${force_install}" != yes ] && return 0
	prev_target=${target}; target=x86_64-w64-mingw32
	set_variables || return 1
	install_cross_binutils || return 1
	target=${prev_target}
	set_variables || return 1
}

install_mingw_w64_header()
{
	fetch_mingw_w64_source || return 1
	[ -d ${mingw_w64_src_dir_crs_hdr} ] ||
		(unpack_archive ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_hdr}) || return 1
	mkdir -p ${mingw_w64_bld_dir_crs_hdr}
	[ -f ${mingw_w64_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_hdr}
		${mingw_w64_src_dir_crs_hdr}/configure --prefix=/mingw --build=${build} --host=${target} \
			--disable-multilib --without-crt --with-sysroot=${sysroot}) || return 1
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} || return 1
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} DESTDIR=${sysroot} install || return 1
}

install_mingw_w64_gcc_with_mingw_w64_header()
{
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib --with-sysroot=${sysroot} \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-gcc || return 1
}

install_mingw_w64_crt()
{
	[ -d ${mingw_w64_src_dir_crs_1st} ] ||
		(unpack_archive ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_1st}) || return 1
	mkdir -p ${mingw_w64_bld_dir_crs_1st}
	[ -f ${mingw_w64_bld_dir_crs_1st}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_1st}
		${mingw_w64_src_dir_crs_1st}/configure --prefix=/mingw --build=${build} --host=${target} \
			--disable-multilib --without-header --with-sysroot=${sysroot} \
		) || return 1
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} || return 1
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install || return 1
}

install_mingw_w64_gcc()
{
	[ -x ${prefix}/bin/x86_64-w64-mingw32-gcc -a "${force_install}" != yes ] && return 0
	prev_target=${target}; target=x86_64-w64-mingw32
	prev_languages=${languages}; languages=c,c++
	set_variables || return 1
	install_cross_binutils || return 1
	[ ${build} = ${target} ] && echo "target(${target}) must be different from build(${build})" && return 1
	search_header gmp.h > /dev/null || install_native_gmp || return 1
	search_header mpfr.h > /dev/null || install_native_mpfr || return 1
	search_header mpc.h > /dev/null || install_native_mpc || return 1
	which perl > /dev/null || install_native_perl || return 1
	fetch_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_mingw_w64_header || return 1
	install_mingw_w64_gcc_with_mingw_w64_header || return 1
	install_mingw_w64_crt || return  1
	install_cross_functional_gcc || return 1
	target=${prev_target}
	languages=${prev_languages}
	set_variables || return 1
}

full_mingw_w64()
{
	for f in install_mingw_w64_binutils install_mingw_w64_gcc; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename $0` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename $0`
	done
	return 0
}

install_native_python()
{
	[ -x ${prefix}/bin/python3 -a "${force_install}" != yes ] && return 0
	fetch_python_source || return 1
	unpack_archive ${Python_org_src_dir} ${Python_src_base} || return 1
	[ -f ${Python_org_src_dir}/Makefile ] ||
		(cd ${Python_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-shared --disable-ipv6 \
			--with-universal-archs=all --enable-universalsdk \
			--with-signal-module --with-threads --with-doc-strings \
			--with-tsc --with-pymalloc --with-ensurepip) || return 1 # --enable-ipv6 --with-address-sanitizer --with-system-expat --with-system-ffi
	make -C ${Python_org_src_dir} -j ${jobs} || return 1
	make -C ${Python_org_src_dir} -j ${jobs} install || return 1
}

install_native_ruby()
{
	[ -x ${prefix}/bin/ruby -a "${force_install}" != yes ] && return 0
	fetch_ruby_source || return 1
	unpack_archive ${ruby_org_src_dir} ${ruby_src_base} || return 1
	[ -f ${ruby_org_src_dir}/Makefile ] ||
		(cd ${ruby_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-multiarch --enable-shared --disable-silent-rules) || return 1
	make -C ${ruby_org_src_dir} -j ${jobs} || return 1
	make -C ${ruby_org_src_dir} -j ${jobs} install || return 1
}

install_native_go()
{
	[ -x ${prefix}/go/bin/go -a "${force_install}" != yes ] && return 0
	[ -z "${GOPATH}" ] && echo Error. GOPATH not set. >&2 && return 1
	which git > /dev/null || install_native_git || return 1
	fetch_go_source || return 1
	[ -d ${go_org_src_dir} ] || unpack_archive ${go_src_base}/go${go_ver}.src ${go_src_base} || return 1
	[ -d ${go_src_base}/go ] && mv ${go_src_base}/go ${go_org_src_dir}
	(cd ${go_org_src_dir}/src
	CGO_CPPFLAGS=-I${prefix}/include GOROOT_BOOTSTRAP=${prefix} \
		GOROOT=${go_org_src_dir} GOROOT_FINAL=${prefix}/go ${go_org_src_dir}/src/make.bash) || return 1
	[ ! -d ${prefix}/go ] || rm -rf ${prefix}/go || return 1
	mv ${go_org_src_dir} ${prefix}/go || return 1
	${prefix}/go/bin/go get golang.org/x/tools/cmd/... || return 1
}

install_native_perl()
{
	[ -x ${prefix}/bin/perl -a "${force_install}" != yes ] && return 0
	fetch_perl_source || return 1
	unpack_archive ${perl_org_src_dir} ${perl_src_base} || return 1
	(cd ${perl_org_src_dir}
	./Configure -de -Dprefix=${prefix} -Dcc=${CC:-gcc} \
		-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits \
		-Duseshrplib) || return 1
	make -C ${perl_org_src_dir} -j ${jobs} || return 1
	make -C ${perl_org_src_dir} -j ${jobs} test || return 1
	make -C ${perl_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_yasm()
{
	[ -x ${prefix}/bin/yasm -a "${force_install}" != yes ] && return 0
	fetch_yasm_source || return 1
	unpack_archive ${yasm_org_src_dir} ${yasm_src_base} || return 1
	[ -f ${yasm_org_src_dir}/Makefile ] ||
		(cd ${yasm_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return 1
	make -C ${yasm_org_src_dir} -j ${jobs} || return 1
	make -C ${yasm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return 1
}

install_native_x264()
{
	[ -x ${prefix}/bin/x264 -a "${force_install}" != yes ] && return 0
	which yasm > /dev/null || install_native_yasm || return 1
	fetch_x264_source || return 1
	[ -d ${x264_org_src_dir} ] ||
		(unpack_archive ${x264_org_src_dir} ${x264_src_base} &&
		mv ${x264_src_base}/x264-snapshot-* ${x264_org_src_dir}) || return 1
	(cd ${x264_org_src_dir}
	./configure --prefix=${prefix} \
		--enable-shared --enable-static \
		${strip:+--enable-strip}) || return 1
	make -C ${x264_org_src_dir} -j ${jobs} || return 1
	make -C ${x264_org_src_dir} -j ${jobs} install || return 1
}

install_native_x265()
{
	[ -x ${prefix}/bin/x265 -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	which yasm > /dev/null || install_native_yasm || return 1
	fetch_x265_source || return 1
	[ -d ${x265_org_src_dir} ] ||
		(unpack_archive ${x265_org_src_dir} ${x265_src_base} &&
		mv ${x265_src_base}/x265_${x265_ver} ${x265_org_src_dir}) || return 1
	(cd ${x265_org_src_dir}/source
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DNATIVE_BUILD=ON) || return 1
	make -C ${x265_org_src_dir}/source -j ${jobs} || return 1
	make -C ${x265_org_src_dir}/source -j ${jobs} install || return 1
}

install_native_libav()
{
	[ -x ${prefix}/bin/avconv -a "${force_install}" != yes ] && return 0
	which yasm > /dev/null || install_native_yasm || return 1
	search_header x264.h > /dev/null || install_native_x264 || return 1
	search_header x265.h > /dev/null || install_native_x265 || return 1
	fetch_libav_source || return 1
	[ -d ${libav_org_src_dir} ] ||
		unpack_archive ${libav_org_src_dir} ${libav_src_base} || return 1
	(cd ${libav_org_src_dir}
	./configure --prefix=${prefix} --enable-gpl --enable-version3 --enable-nonfree --enable-shared \
		--enable-gray \
		\
		--enable-bzlib \
		--enable-frei0r \
		--enable-libbs2b \
		--enable-libcdio \
		--enable-libdc1394 \
		--enable-libfaac \
		--enable-libfdk-aac \
		--enable-libfreetype \
		--enable-libgsm \
		--enable-libilbc \
		--enable-libmp3lame \
		--enable-libopencore-amrnb \
		--enable-libopencv \
		--enable-libopus \
		--enable-libpulse \
		--enable-librtmp \
		--enable-libschroedinger \
		--enable-libspeex \
		--enable-libtheora \
		--enable-libtwolame \
		--enable-libvo-aacenc \
		--enable-libvo-amrwbenc \
		--enable-libvorbis \
		--enable-libvpx \
		--enable-libwavpack \
		--enable-libwebp \
		--enable-libx264 \
		--enable-libx265 \
		--enable-libxavs \
		--enable-libxvid \
		--enable-openssl \
		--enable-zlib \
#		--enable-avisynth \
	) || return 1
	make -C ${libav_org_src_dir} -j ${jobs} || return 1
	make -C ${libav_org_src_dir} -j ${jobs} install || return 1
}

install_native_opencv()
{
	[ -f ${prefix}/include/opencv2/opencv.hpp -a "${force_install}" != yes ] && return 0
	which cmake > /dev/null || install_native_cmake || return 1
	search_header png.h > /dev/null || install_native_libpng || return 1 # systemのlibpngだと古くて新規インストール必須かも。
	search_header tiff.h > /dev/null || install_native_libtiff || return 1
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return 1 # systemのlibjpegだと古くて新規インストール必須かも。
	fetch_opencv_source || return 1
	unpack_archive ${opencv_org_src_dir} ${opencv_src_base} || return 1
	fetch_opencv_contrib_source || return 1
	unpack_archive ${opencv_contrib_org_src_dir} ${opencv_contrib_src_base} || return 1
	mkdir -p ${opencv_bld_dir_ntv}
	(cd ${opencv_bld_dir_ntv}
	libdirs="-L`search_library_dir libpng.so` -L`search_library_dir libtiff.so` -L`search_library_dir libjpeg.so` -L${prefix}/lib"
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_MODULE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DENABLE_PRECOMPILED_HEADERS=OFF \
		-DOPENCV_EXTRA_MODULES_PATH=${opencv_contrib_org_src_dir}/modules ${opencv_org_src_dir}) || return 1
	make -C ${opencv_bld_dir_ntv} -j ${jobs} -k || return 1 # make 一発じゃだめっぽいので2回。
	make -C ${opencv_bld_dir_ntv} -j ${jobs} || return 1
	make -C ${opencv_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return 1
}

install_crossed_native_binutils()
{
	[ -x ${sysroot}/usr/bin/as -a "${force_install}" != yes ] && return 0
	search_header zlib.h > /dev/null || install_native_zlib || return 1
	which yacc > /dev/null || install_native_bison || return 1
	fetch_binutils_source || return 1
	[ -d ${binutils_src_dir_crs_ntv} ] ||
		(unpack_archive ${binutils_org_src_dir} ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_crs_ntv}) || return 1
	[ -f ${binutils_src_dir_crs_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-sysroot=/ \
			--enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return 1
	make -C ${binutils_src_dir_crs_ntv} -j 1 || return 1
	make -C ${binutils_src_dir_crs_ntv} -j 1 DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

install_crossed_native_gmp()
{
	[ -f ${sysroot}/usr/include/gmp.h -a "${force_install}" != yes ] && return 0
	fetch_gmp_source || return 1
	[ -d ${gmp_src_dir_crs_ntv} ] ||
		(unpack_archive ${gmp_org_src_dir} ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return 1
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --enable-cxx) || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

install_crossed_native_mpfr()
{
	[ -f ${sysroot}/usr/include/mpfr.h -a "${force_install}" != yes ] && return 0
	fetch_mpfr_source || return 1
	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(unpack_archive ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return 1
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-gmp=${sysroot}/usr) || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
	sed -i -e /^dependency_libs=/s/\'.\*\'\$/\'\'/ ${sysroot}/usr/lib/libmpfr.la || return 1
	# [XXX] mpcビルド時に、mpfrが依存しているgmpを参照しようとしてlibmpfr.laの不整合に
	#       引っかからないようにするために、強行的にlibmpfr.la書き換えてる。
}

install_crossed_native_mpc()
{
	[ -f ${sysroot}/usr/include/mpc.h -a "${force_install}" != yes ] && return 0
	fetch_mpc_source || return 1
	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(unpack_archive ${mpc_org_src_dir} ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return 1
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr) || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

install_crossed_native_gcc()
{
	[ -x ${sysroot}/usr/bin/gcc -a "${force_install}" != yes ] && return 0
	install_crossed_native_zlib || return 1
	[ -f ${sysroot}/usr/include/gmp.h ] || install_crossed_native_gmp || return 1
	[ -f ${sysroot}/usr/include/mpfr.h ] || install_crossed_native_mpfr || return 1
	[ -f ${sysroot}/usr/include/mpc.h ] || install_crossed_native_mpc || return 1
	which perl > /dev/null || install_native_perl || return 1
	fetch_gcc_source || return 1
	unpack_archive ${gcc_org_src_dir} ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_ntv}
	[ -f ${gcc_bld_dir_crs_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_ntv}
		${gcc_org_src_dir}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr --with-mpc=${sysroot}/usr \
			--enable-languages=${languages} --with-sysroot=/ --without-isl --with-system-zlib \
			--enable-libstdcxx-debug \
			CC_FOR_TARGET=${target}-gcc CXX_FOR_TARGET=${target}-g++ GOC_FOR_TARGET=${target}-gccgo) || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

install_crossed_native_zlib()
{
	[ -f ${sysroot}/usr/include/zlib.h -a "${force_install}" != yes ] && return 0
	fetch_zlib_source || return 1
	[ -d ${zlib_src_dir_crs_ntv} ] ||
		(unpack_archive ${zlib_org_src_dir} ${zlib_src_base} &&
			mv ${zlib_org_src_dir} ${zlib_src_dir_crs_ntv}) || return 1
	(cd ${zlib_src_dir_crs_ntv}
	CC=${target}-gcc AR=${target}-ar RANLIB=${target}-ranlib ./configure --prefix=/usr) || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install || return 1
}

install_crossed_native_libpng()
{
	[ -f ${sysroot}/usr/include/png.h -a "${force_install}" != yes ] && return 0
	install_crossed_native_zlib || return 1
	fetch_libpng_source || return 1
	[ -d ${libpng_src_dir_crs_ntv} ] ||
		(unpack_archive ${libpng_org_src_dir} ${libpng_src_base} &&
			mv ${libpng_org_src_dir} ${libpng_src_dir_crs_ntv}) || return 1
	[ -f ${libpng_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} \
			CPPFLAGS="-I ${sysroot}/include ${CPPFLAGS}") || return 1
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

install_crossed_native_libtiff()
{
	[ -f ${sysroot}/usr/include/tiffio.h -a "${force_install}" != yes ] && return 0
	fetch_libtiff_source || return 1
	[ -d ${tiff_src_dir_crs_ntv} ] ||
		(unpack_archive ${tiff_org_src_dir} ${tiff_src_base} &&
			mv ${tiff_org_src_dir} ${tiff_src_dir_crs_ntv}) || return 1
	[ -f ${tiff_src_dir_crs_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=`echo ${target} | sed -e 's/arm[^-]\+/arm/'` \
			CC=${target}-gcc CXX=${target}-g++ AS=${target}-as STRIP=${target}-strip RANLIB=${target}-ranlib) || return 1
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} || return 1
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return 1
}

full_crossed_native()
{
	for f in `sed -e '/^install_crossed_native_[_[:alnum:]]\+()$/{s/()$//;p};d' $0`; do
		$f \
			&& echo \'$f\' succeeded.  | logger -p user.notice -t `basename $0` \
			|| echo \'$f\' failed.     | logger -p user.notice -t `basename $0`
	done
	return 0
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
	debug) $1 `[ -n "${BASH}" ] && echo shell || echo $1`;;
	shell) [ -n "${BASH}" ] \
				&& set placeholder debug \
				|| exec bash --noprofile --norc --posix -e $0 -p ${prefix} -t ${target} -j ${jobs} shell
		   count=`expr ${count} + 1`;;
	*=*)   eval export $1; set_variables;;
	*)     eval $1 || exit 1; count=`expr ${count} + 1`;;
	esac
	shift
done
[ ${count} -eq 0 ] && usage || exit 0
