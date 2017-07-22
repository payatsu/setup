#!/bin/sh -e
# [TODO] ホームディレクトリにusr/ができてしますバグ。
# [TODO] canadiancross対応する。host, target柔軟性上げる。
# [TODO] qemu-kvm
# [TODO] lldbのビルドをllvmに統合する方法を考える。
# [TODO] lib/に配置されるlibstdc++.so.*gdb.pyをなんとかする。
# [TODO] peco
# [TODO] Rtags
# [TODO] ccache, distcc
# [TODO] valgrind
# [TODO] insight
# [TODO] util-linux
# [TODO] perf
# [TODO] haskell(stack<-(ghc, cabal))
# [TODO] X11, gtk周りのインストールが未完成＆不安定
# [TODO] libav<-
# [TODO] webkitgtk<-libsoup
# [TODO] libmount, dtrace (GLib)
# [TODO] rsvg, imagemagick
# [TODO] Polly, MySQL, grub, util-linux
# [TODO] update-alternatives

: ${tar_ver:=1.29}
: ${cpio_ver:=2.12}
: ${xz_ver:=5.2.3}
: ${bzip2_ver:=1.0.6}
: ${gzip_ver:=1.8}
: ${wget_ver:=1.19}
: ${pkg_config_ver:=0.29.1}
: ${texinfo_ver:=6.3}
: ${coreutils_ver:=8.27}
: ${busybox_ver:=1.26.2}
: ${bison_ver:=3.0.4}
: ${flex_ver:=2.6.0}
: ${m4_ver:=1.4.18}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.15}
: ${autogen_ver:=5.18.12}
: ${libtool_ver:=2.4.6}
: ${sed_ver:=4.4}
: ${gawk_ver:=4.1.4}
: ${make_ver:=4.2}
: ${binutils_ver:=2.28}
: ${elfutils_ver:=0.169}
: ${linux_ver:=3.18.13}
: ${qemu_ver:=2.8.1}
: ${gperf_ver:=3.1}
: ${glibc_ver:=2.25}
: ${newlib_ver:=2.5.0}
: ${mingw_w64_ver:=5.0.2}
: ${gmp_ver:=6.1.2}
: ${mpfr_ver:=3.1.5}
: ${mpc_ver:=1.0.3}
: ${isl_ver:=0.18}
: ${gcc_ver:=7.1.0}
: ${readline_ver:=7.0}
: ${ncurses_ver:=6.0}
: ${gdb_ver:=8.0}
: ${lcov_ver:=1.13}
: ${zlib_ver:=1.2.11}
: ${libpng_ver:=1.6.29}
: ${tiff_ver:=4.0.6}
: ${jpeg_ver:=v9b}
: ${giflib_ver:=5.1.4}
: ${libXpm_ver:=3.5.11}
: ${libwebp_ver:=0.6.0}
: ${libffi_ver:=3.2.1}
: ${emacs_ver:=25.2}
: ${libiconv_ver:=1.15}
: ${vim_ver:=8.0.0606}
: ${vimdoc_ja_ver:=dummy}
: ${ctags_ver:=git}
: ${grep_ver:=3.0}
: ${global_ver:=6.5.7}
: ${pcre_ver:=8.40}
: ${pcre2_ver:=10.23}
: ${the_silver_searcher_ver:=1.0.3}
: ${the_platinum_searcher_ver:=2.1.5}
: ${highway_ver:=1.1.0}
: ${graphviz_ver:=2.38.0}
: ${doxygen_ver:=1.8.13}
: ${diffutils_ver:=3.6}
: ${patch_ver:=2.7.5}
: ${findutils_ver:=4.6.0}
: ${screen_ver:=4.5.1}
: ${libevent_ver:=2.1.8}
: ${tmux_ver:=2.5}
: ${expect_ver:=5.45}
: ${dejagnu_ver:=1.6}
: ${zsh_ver:=5.3.1}
: ${bash_ver:=4.4}
: ${inetutils_ver:=1.9.4}
: ${openssl_ver:=1.0.2l}
: ${openssh_ver:=7.3p1}
: ${curl_ver:=7.54.0}
: ${expat_ver:=2.2.0}
: ${asciidoc_ver:=8.6.9}
: ${libxml2_ver:=2.9.4}
: ${libxslt_ver:=1.1.29}
: ${xmlto_ver:=0.0.28}
: ${gettext_ver:=0.19.8}
: ${git_ver:=2.13.1}
: ${git_manpages_ver:=${git_ver}}
: ${mercurial_ver:=4.2}
: ${sqlite_autoconf_ver:=3170000}
: ${apr_ver:=1.5.2}
: ${apr_util_ver:=1.5.4}
: ${subversion_ver:=1.9.5}
: ${cmake_ver:=3.8.1}
: ${libedit_ver:=20160903-3.1}
: ${swig_ver:=3.0.10}
: ${llvm_ver:=4.0.0}
: ${libcxx_ver:=${llvm_ver}}
: ${libcxxabi_ver:=${llvm_ver}}
: ${compiler_rt_ver:=${llvm_ver}}
: ${cfe_ver:=${llvm_ver}}
: ${clang_tools_extra_ver:=${llvm_ver}}
: ${lld_ver:=${llvm_ver}}
: ${lldb_ver:=${llvm_ver}}
: ${cling_ver:=git}
: ${boost_ver:=1_64_0}
: ${Python_ver:=3.6.1}
: ${ruby_ver:=2.4.1}
: ${go_ver:=1.8.3}
: ${perl_ver:=5.24.0}
: ${tcl_ver:=8.6.6}
: ${tk_ver:=8.6.6}
: ${libunistring_ver:=0.9.7}
: ${libatomic_ops_ver:=7.4.4}
: ${gc_ver:=7.6.0}
: ${guile_ver:=2.0.14}
: ${lua_ver:=5.3.4}
: ${nasm_ver:=2.13.01}
: ${yasm_ver:=1.3.0}
: ${x264_ver:=last-stable}
: ${x265_ver:=2.0}
: ${libav_ver:=11.9}
: ${opencv_ver:=3.2.0}
: ${opencv_contrib_ver:=3.2.0}
: ${googletest_ver:=1.8.0}

# TODO X11周りのインストールは未着手。
: ${xtrans_ver:=1.3.5}
: ${libX11_ver:=1.6.3}
: ${libxcb_ver:=1.12}
: ${libXext_ver:=1.3.3}
: ${libXfixes_ver:=5.0.2}
: ${libXdamage_ver:=1.1.4}
: ${libXt_ver:=1.1.5}
: ${inputproto_ver:=2.3}
: ${xcb_proto_ver:=1.12}
: ${xextproto_ver:=7.3.0}
: ${fixesproto_ver:=5.0}
: ${damageproto_ver:=1.2.1}
: ${xproto_ver:=7.0.31}
: ${kbproto_ver:=1.0.7}
: ${glproto_ver:=1.4.17}
: ${dri2proto_ver:=2.8}
: ${dri3proto_ver:=1.0}
: ${presentproto_ver:=1.0}
: ${libpciaccess_ver:=0.13.4}
: ${libdrm_ver:=2.4.70}
: ${libxshmfence_ver:=1.2}
: ${mesa_ver:=12.0.3}
: ${libepoxy_ver:=1.3.1}
: ${glib_ver:=2.52.3}
: ${cairo_ver:=1.14.6}
: ${pixman_ver:=0.34.0}
: ${pango_ver:=1.40.3}
: ${gdk_pixbuf_ver:=2.36.0}
: ${atk_ver:=2.22.0}
: ${gobject_introspection_ver:=1.50.0}
: ${gtk_ver:=3.22.0}
: ${webkitgtk_ver:=2.14.0}

: ${prefix:=/toolchains}
: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
: ${enable_ccache:=no}
: ${enable_check:=no}
: ${languages:=c,c++,go}
: ${host:=`uname -m`-linux-gnu}
: ${target:=`uname -m`-linux-gnu}

: ${build:=`uname -m`-linux-gnu}
: ${strip:=strip}
: ${cmake_build_type:=Release}

usage()
# Show usage.
{
	cat <<EOF
[Usage]
	${0} [-p prefix] [-j jobs] [-f yes|no] [-c yes|no] [-h host] [-t target] [variable=value]... commands...

[Options]
	-p prefix
		Installation directory, currently '${prefix}'.
		'/usr/local' is NOT strongly recommended.
	-j jobs
		The number of processes invoked simultaneously by 'make', currently '${jobs}'.
		Recommended not to be more than the number of CPU cores.
	-f yes|no
		Enable ccache, currently '${enable_ccache}'.
	-c yes|no
		Enable 'make check' before 'make install', currently '${enable_check}'.
	-l languages
		Enable languages in GCC build configulation, currently '${languages}'.
	-h host
		Host-triplet, currently '${host}'.
	-t target
		Target-triplet of new cross toolchain, currently '${target}'.
		ex.
			armv7l-linux-gnueabihf
			x86_64-linux-gnu
			i686-unknown-linux
			microblaze-none-linux
			nios2-none-linux (linux_ver=4.8.1)

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
	cpio_ver
		Specify the version of GNU cpio you want, currently '${cpio_ver}'.
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
	busybox_ver
		Specify the version of BusyBox you want, currently '${busybox_ver}'.
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
	autogen_ver
		Specify the version of GNU Autogen you want, currently '${autogen_ver}'.
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
	elfutils_ver
		Specify the version of Elfutils you want, currently '${elfutils_ver}'.
	linux_ver
		Specify the version of Linux kernel you want, currently '${linux_ver}'.
	qemu_ver
		Specify the version of QEMU you want, currently '${qemu_ver}'.
	gperf_ver
		Specify the version of gperf you want, currently '${gperf_ver}'.
	glibc_ver
		Specify the version of GNU C Library you want, currently '${glibc_ver}'.
	newlib_ver
		Specify the version of Newlib C Library you want, currently '${newlib_ver}'.
	mingw_w64_ver
		Specify the version of mingw-w64 you want, currently '${mingw_w64_ver}'.
	gmp_ver
		Specify the version of GNU MP Bignum Library you want, currently '${gmp_ver}'.
	mpfr_ver
		Specify the version of GNU MPFR Library you want, currently '${mpfr_ver}'.
	mpc_ver
		Specify the version of GNU MPC Library you want, currently '${mpc_ver}'.
	isl_ver
		Specify the version of ISL you want, currently '${isl_ver}'.
	gcc_ver
		Specify the version of GNU Compiler Collection you want, currently '${gcc_ver}'.
	readline_ver
		Specify the version of GNU Readline Library you want, currently '${readline_ver}'.
	ncurses_ver
		Specify the version of ncurses you want, currently '${ncurses_ver}'.
	gdb_ver
		Specify the version of GNU Debugger you want, currently '${gdb_ver}'.
	lcov_ver
		Specify the version of lcov you want, currently '${lcov_ver}'.
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
	emacs_ver
		Specify the version of GNU Emacs you want, currently '${emacs_ver}'.
	libiconv_ver
		Specify the version of libiconv you want, currently '${libiconv_ver}'.
	vim_ver
		Specify the version of Vim you want, currently '${vim_ver}'.
	ctags_ver
		Specify the version of ctags you want, currently '${ctags_ver}'.
	grep_ver
		Specify the version of GNU Grep you want, currently '${grep_ver}'.
	global_ver
		Specify the version of GNU Global you want, currently '${global_ver}'.
	pcre_ver
		Specify the version of PCRE you want, currently '${pcre_ver}'.
	pcre2_ver
		Specify the version of PCRE2 you want, currently '${pcre2_ver}'.
	the_silver_searcher_ver
		Specify the version of the silver searcher you want, currently '${the_silver_searcher_ver}'.
	the_platinum_searcher_ver
		Specify the version of the platinum searcher you want, currently '${the_platinum_searcher_ver}'.
	highway_ver
		Specify the version of highway you want, currently '${highway_ver}'.
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
	expect_ver
		Specify the version of expect you want, currently '${expect_ver}'.
	dejagnu_ver
		Specify the version of DejaGnu you want, currently '${dejagnu_ver}'.
	zsh_ver
		Specify the version of Zsh you want, currently '${zsh_ver}'.
	bash_ver
		Specify the version of Bash you want, currently '${bash_ver}'.
	inetutils
		Specify the version of inetutils you want, currently '${inetutils_ver}'.
	openssl_ver
		Specify the version of openssl you want, currently '${openssl_ver}'.
	openssh_ver
		Specify the version of openssh you want, currently '${openssh_ver}'.
	curl_ver
		Specify the version of Curl you want, currently '${libcur_ver}'.
	expat_ver
		Specify the version of expat you want, currently '${expat_ver}'.
	asciidoc_ver
		Specify the version of asciidoc you want, currently '${asciidoc_ver}'.
	libxml2_ver
		Specify the version of libxml2 you want, currently '${libxml2_ver}'.
	libxslt_ver
		Specify the version of libxslt you want, currently '${libxslt_ver}'.
	xmlto_ver
		Specify the version of xmlto you want, currently '${xmlto_ver}'.
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
	Python_ver
		Specify the version of python you want, currently '${Python_ver}'.
	ruby_ver
		Specify the version of ruby you want, currently '${ruby_ver}'.
	go_ver
		Specify the version of go you want, currently '${go_ver}'.
	perl_ver
		Specify the version of perl you want, currently '${perl_ver}'.
	tcl_ver
		Specify the version of tcl you want, currently '${tcl_ver}'.
	tk_ver
		Specify the version of tk you want, currently '${tk_ver}'.
	libunistring_ver
		Specify the version of libunistring you want, currently '${libunistring_ver}'.
	libatomic_ops_ver
		Specify the version of libatomic_ops you want, currently '${libatomic_ops_ver}'.
	gc_ver
		Specify the version of boehm GC you want, currently '${gc_ver}'.
	guile_ver
		Specify the version of GNU Guile you want, currently '${guile_ver}'.
	lua_ver
		Specify the version of Lua you want, currently '${lua_ver}'.
	nasm_ver
		Specify the version of NASM you want, currently '${nasm_ver}'.
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
	googletest_ver
		Specify the version of google test you want, currently '${googletest_ver}'.
	glib_ver
		Specify the version of GLib you want, currently '${glib_ver}'.

[Examples]
	For everything which this tool can install
	# ${0} -p /toolchains -t armv7l-linux-gnueabihf -j 8 auto

	For Raspberry pi2 cross compiler
	# ${0} -p /toolchains -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 linux_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

	For microblaze cross compiler
	# ${0} -p /toolchains -t microblaze-linux-gnu -j 8 binutils_ver=2.25 linux_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

	For MinGW64 cross compiler
	# ${0} -p /toolchains -t x86_64-w64-mingw32 -l c,c++ install_cross_gcc

EOF
}

auto()
# Perform auto installation for all available toolchains and other tools.
{
	fetch || return
	full || return
	clean || return
	archive || return
}

fetch()
# Fetch source files.
{
	_1=`echo ${1} | tr - _`
	[ -z "${_1}" ] || eval mkdir -pv \${${_1}_src_base} || return
	case ${1} in
	'')
		for pkg in `sed -e '/^fetch()$/,/^}$/p;d' ${0} | sed -e '/\([-_[:alnum:]]\+|\?\)\+\(\\\\\|)\)$/{y/|)\\\/   /;p};d'`; do
			fetch ${pkg} || return
		done;;
	tar|cpio|gzip|wget|texinfo|coreutils|bison|m4|autoconf|automake|libtool|sed|gawk|\
	make|binutils|gperf|glibc|gmp|mpfr|mpc|readline|ncurses|gdb|emacs|libiconv|grep|global|\
	diffutils|patch|findutils|screen|dejagnu|bash|inetutils|gettext|libunistring|guile)
		eval check_archive \${${_1}_org_src_dir} ||
			for compress_format in xz bz2 gz; do
				eval wget -O \${${_1}_org_src_dir}.tar.${compress_format} \
					http://ftp.gnu.org/gnu/${_1}/\${${_1}_name}.tar.${compress_format} \
					&& break \
					|| eval rm -v \${${_1}_org_src_dir}.tar.${compress_format}
			done || return;;
	autogen)
		check_archive ${autogen_org_src_dir} ||
			wget -O ${autogen_org_src_dir}.tar.xz \
				http://ftp.gnu.org/gnu/autogen/rel${autogen_ver}/${autogen_name}.tar.xz || return;;
	xz)
		check_archive ${xz_org_src_dir} ||
			wget --no-check-certificate -O ${xz_org_src_dir}.tar.bz2 \
				http://tukaani.org/xz/${xz_name}.tar.bz2 || return;;
	bzip2)
		check_archive ${bzip2_org_src_dir} ||
			wget -O ${bzip2_org_src_dir}.tar.gz \
				http://www.bzip.org/${bzip2_ver}/${bzip2_name}.tar.gz || return;;
	busybox)
		check_archive ${busybox_org_src_dir} ||
			wget --no-check-certificate -O ${busybox_org_src_dir}.tar.bz2 \
				https://www.busybox.net/downloads/${busybox_name}.tar.bz2 || return;;
	flex)
		check_archive ${flex_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${flex_org_src_dir}.tar.xz \
				https://sourceforge.net/projects/flex/files/${flex_name}.tar.xz/download || return;;
	elfutils)
		check_archive ${elfutils_org_src_dir} ||
			wget --no-check-certificate -O ${elfutils_org_src_dir}.tar.bz2 \
				https://sourceware.org/elfutils/ftp/${elfutils_ver}/${elfutils_name}.tar.bz2 || return;;
	linux)
		case `echo ${linux_ver} | cut -d. -f1,2` in
		2.6) linux_major_ver=v2.6;;
		3.*) linux_major_ver=v3.x;;
		4.*) linux_major_ver=v4.x;;
		*)   echo unsupported linux version >&2; return 1;;
		esac
		check_archive ${linux_org_src_dir} ||
			wget --no-check-certificate -O ${linux_org_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/kernel/${linux_major_ver}/${linux_name}.tar.xz || return;;
	qemu)
		check_archive ${qemu_org_src_dir} ||
			wget -O ${qemu_org_src_dir}.tar.xz \
				http://download.qemu-project.org/${qemu_name}.tar.xz || return;;
	newlib)
		check_archive ${newlib_org_src_dir} ||
			wget -O ${newlib_org_src_dir}.tar.gz \
				ftp://sourceware.org/pub/newlib/${newlib_name}.tar.gz || return;;
	mingw-w64)
		check_archive ${mingw_w64_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${mingw_w64_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v${mingw_w64_ver}.tar.bz2/download || return;;
	isl)
		check_archive ${isl_org_src_dir} ||
			wget -O ${isl_org_src_dir}.tar.xz \
				http://isl.gforge.inria.fr/${isl_name}.tar.xz || return;;
	gcc)
		check_archive ${gcc_org_src_dir} ||
			for compress_format in xz bz2 gz; do
				wget -O ${gcc_org_src_dir}.tar.${compress_format} \
					http://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.${compress_format} \
					&& break \
					|| rm -v ${gcc_org_src_dir}.tar.${compress_format}
			done || return;;
	lcov)
		check_archive ${lcov_org_src_dir} ||
			wget --no-check-certificate -O ${lcov_org_src_dir}.tar.gz \
				https://github.com/linux-test-project/lcov/archive/v${lcov_ver}.tar.gz || return;;
	zlib)
		check_archive ${zlib_org_src_dir} ||
			wget -O ${zlib_org_src_dir}.tar.xz \
				http://zlib.net/${zlib_name}.tar.xz || return;;
	libpng)
		check_archive ${libpng_org_src_dir} ||
			wget --no-check-certificate --trust-server-names -O ${libpng_org_src_dir}.tar.xz \
				https://download.sourceforge.net/libpng/${libpng_name}.tar.xz || return;;
	tiff)
		check_archive ${tiff_org_src_dir} ||
			wget -O ${tiff_org_src_dir}.tar.gz \
				http://download.osgeo.org/libtiff/${tiff_name}.tar.gz || return;;
	jpeg)
		check_archive ${jpeg_org_src_dir} ||
			wget -O ${jpeg_org_src_dir}.tar.gz \
				http://www.ijg.org/files/${jpeg_name}.tar.gz || return;;
	giflib)
		check_archive ${giflib_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${giflib_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/giflib/files/${giflib_name}.tar.bz2/download || return;;
	libwebp)
		check_archive ${libwebp_org_src_dir} ||
			wget --no-check-certificate -O ${libwebp_org_src_dir}.tar.gz \
				https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${libwebp_name}.tar.gz || return;;
	libffi)
		check_archive ${libffi_org_src_dir} ||
			wget -O ${libffi_org_src_dir}.tar.gz \
				http://mirrors.kernel.org/sourceware/libffi/${libffi_name}.tar.gz || return;;
	vim)
		check_archive ${vim_org_src_dir} ||
			wget --no-check-certificate -O ${vim_org_src_dir}.tar.gz \
				http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return;;
	vimdoc-ja)
		check_archive ${vimdoc_ja_org_src_dir} ||
			wget --no-check-certificate -O ${vimdoc_ja_org_src_dir}.tar.gz \
				https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz || return;;
	ctags)
		[ -d ${ctags_org_src_dir} ] ||
			git clone --depth 1 http://github.com/universal-ctags/ctags.git ${ctags_org_src_dir} || return;;
	pcre|pcre2)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.bz2 \
				https://ftp.pcre.org/pub/pcre/\${${_1}_name}.tar.bz2 || return;;
	the_silver_searcher)
		check_archive ${the_silver_searcher_org_src_dir} ||
			wget --no-check-certificate -O ${the_silver_searcher_org_src_dir}.tar.gz \
				https://geoff.greer.fm/ag/releases/${the_silver_searcher_name}.tar.gz || return;;
	the_platinum_searcher)
		check_archive ${the_platinum_searcher_org_src_dir} ||
			wget --no-check-certificate -O ${the_platinum_searcher_org_src_dir}.tar.gz \
				https://github.com/monochromegane/the_platinum_searcher/archive/v${the_platinum_searcher_ver}.tar.gz || return;;
	highway)
		check_archive ${highway_org_src_dir} ||
			wget --no-check-certificate -O ${highway_org_src_dir}.tar.gz \
				https://github.com/tkengo/highway/archive/v${highway_ver}.tar.gz || return;;
	graphviz)
		check_archive ${graphviz_org_src_dir} ||
			wget -O ${graphviz_org_src_dir}.tar.gz \
				http://www.graphviz.org/pub/graphviz/stable/SOURCES/${graphviz_name}.tar.gz || return;;
	doxygen)
		check_archive ${doxygen_org_src_dir} ||
			wget -O ${doxygen_org_src_dir}.tar.gz \
				http://ftp.stack.nl/pub/users/dimitri/${doxygen_name}.src.tar.gz || return;;
	libevent)
		check_archive ${libevent_org_src_dir}-stable ||
			wget --no-check-certificate -O ${libevent_org_src_dir}-stable.tar.gz \
				https://github.com/libevent/libevent/releases/download/release-${libevent_ver}-stable/${libevent_name}-stable.tar.gz || return;;
	tmux)
		check_archive ${tmux_org_src_dir} ||
			wget --no-check-certificate -O ${tmux_org_src_dir}.tar.gz \
				https://github.com/tmux/tmux/releases/download/${tmux_ver}/${tmux_name}.tar.gz || return;;
	expect)
		check_archive ${expect_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${expect_org_src_dir}.tar.gz \
				https://sourceforge.net/projects/expect/files/Expect/${expect_ver}/${expect_name}.tar.gz/download || return;;
	zsh)
		check_archive ${zsh_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${zsh_org_src_dir}.tar.xz \
				https://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.xz/download || return;;
	openssl)
		check_archive ${openssl_org_src_dir} ||
			wget --no-check-certificate -O ${openssl_org_src_dir}.tar.gz \
				http://www.openssl.org/source/old/`echo ${openssl_ver} | sed -e 's/[a-z]//g'`/${openssl_name}.tar.gz || return;;
	openssh)
		check_archive ${openssh_org_src_dir} ||
			wget -O ${openssh_org_src_dir}.tar.gz \
				http://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/${openssh_name}.tar.gz || return;;
	curl)
		check_archive ${curl_org_src_dir} ||
			wget --no-check-certificate -O ${curl_org_src_dir}.tar.bz2 \
				https://curl.haxx.se/download/${curl_name}.tar.bz2 || return;;
	expat)
		check_archive ${expat_org_src_dir} ||
			wget --no-check-certificate -O ${expat_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/expat/files/expat/${expat_ver}/${expat_name}.tar.bz2/download || return;;
	asciidoc)
		check_archive ${asciidoc_org_src_dir} ||
			wget --no-check-certificate -O ${asciidoc_org_src_dir}.tar.gz \
				https://sourceforge.net/projects/asciidoc/files/asciidoc/${asciidoc_ver}/${asciidoc_name}.tar.gz/download || return;;
	libxml2|libxslt)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.gz \
				ftp://xmlsoft.org/${_1}/\${${_1}_name}.tar.gz || return;;
	xmlto)
		check_archive ${xmlto_org_src_dir} ||
			wget --no-check-certificate -O ${xmlto_org_src_dir}.tar.bz2 \
				https://fedorahosted.org/releases/x/m/xmlto/${xmlto_name}.tar.bz2 || return;;
	git)
		check_archive ${git_org_src_dir} ||
			wget --no-check-certificate -O ${git_org_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return;;
	git-manpages)
		check_archive ${git_manpages_org_src_dir} ||
			wget --no-check-certificate -O ${git_manpages_org_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/scm/git/${git_manpages_name}.tar.xz || return;;
	mercurial)
		check_archive ${mercurial_org_src_dir} ||
			wget --no-check-certificate -O ${mercurial_org_src_dir}.tar.gz \
				https://www.mercurial-scm.org/release/${mercurial_name}.tar.gz || return;;
	sqlite-autoconf)
		check_archive ${sqlite_autoconf_org_src_dir} ||
			wget --no-check-certificate -O ${sqlite_autoconf_org_src_dir}.tar.gz \
				https://www.sqlite.org/2017/${sqlite_autoconf_name}.tar.gz || return;;
	apr|apr-util)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.bz2 \
				http://ftp.tsukuba.wide.ad.jp/software/apache/apr/\${${_1}_name}.tar.bz2 || return;;
	subversion)
		check_archive ${subversion_org_src_dir} ||
			wget -O ${subversion_org_src_dir}.tar.bz2 \
				http://ftp.tsukuba.wide.ad.jp/software/apache/subversion/${subversion_name}.tar.bz2 || return;;
	cmake)
		check_archive ${cmake_org_src_dir} ||
			wget --no-check-certificate -O ${cmake_org_src_dir}.tar.gz \
				https://cmake.org/files/v`echo ${cmake_ver} | cut -d. -f1,2`/${cmake_name}.tar.gz || return;;
	libedit)
		check_archive ${libedit_org_src_dir} ||
			wget -O ${libedit_org_src_dir}.tar.gz \
				http://thrysoee.dk/editline/${libedit_name}.tar.gz || return;;
	swig)
		check_archive ${swig_org_src_dir} ||
			wget --no-check-certificate --trust-server-names -O ${swig_org_src_dir}.tar.gz \
				https://sourceforge.net/projects/swig/files/swig/${swig_name}/${swig_name}.tar.gz/download || return;;
	llvm|libcxx|libcxxabi|compiler-rt|cfe|clang-tools-extra|lld|lldb)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.xz \
				http://llvm.org/releases/${llvm_ver}/\${${_1}_name}.tar.xz || return;;
	cling)
		[ -d ${cling_org_src_dir} ] ||
			(git clone --depth 1 http://root.cern.ch/git/llvm.git ${cling_org_src_dir} -b cling-patches &&
			git clone --depth 1 http://root.cern.ch/git/clang.git ${cling_org_src_dir}/tools/clang -b cling-patches &&
			git clone --depth 1 http://root.cern.ch/git/cling.git ${cling_org_src_dir}/tools/cling) || return;;
	boost)
		check_archive ${boost_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${boost_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/boost/files/boost/`echo ${boost_ver} | tr _ .`/${boost_name}.tar.bz2/download || return;;
	Python)
		check_archive ${Python_org_src_dir} ||
			wget --no-check-certificate -O ${Python_org_src_dir}.tar.xz \
				https://www.python.org/ftp/python/${Python_ver}/${Python_name}.tar.xz || return;;
	ruby)
		check_archive ${ruby_org_src_dir} ||
			wget -O ${ruby_org_src_dir}.tar.xz \
				http://cache.ruby-lang.org/pub/ruby/${ruby_name}.tar.xz || return;;
	go)
		check_archive ${go_src_base}/go${go_ver}.src ||
			wget --no-check-certificate -O ${go_src_base}/go${go_ver}.src.tar.gz \
				https://storage.googleapis.com/golang/go${go_ver}.src.tar.gz || return;;
	perl)
		check_archive ${perl_org_src_dir} ||
			wget -O ${perl_org_src_dir}.tar.gz \
				http://www.cpan.org/src/5.0/${perl_name}.tar.gz || return;;
	tcl|tk)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.gz \
				http://prdownloads.sourceforge.net/tcl/\${${_1}_name}-src.tar.gz || return;;
	libatomic_ops|gc)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.gz \
				https://www.hboehm.info/gc/gc_source/\${${_1}_name}.tar.gz || return;;
	lua)
		check_archive ${lua_org_src_dir} ||
			wget -O ${lua_org_src_dir}.tar.gz \
				http://www.lua.org/ftp/${lua_name}.tar.gz || return;;
	nasm)
		check_archive ${nasm_org_src_dir} ||
			wget -O ${nasm_org_src_dir}.tar.xz \
				http://www.nasm.us/pub/nasm/releasebuilds/${nasm_ver}/${nasm_name}.tar.xz || return;;
	yasm)
		check_archive ${yasm_org_src_dir} ||
			wget -O ${yasm_org_src_dir}.tar.gz \
				http://www.tortall.net/projects/yasm/releases/${yasm_name}.tar.gz || return;;
	x264)
		check_archive ${x264_org_src_dir} ||
			wget -O ${x264_org_src_dir}.tar.bz2 \
				http://ftp.videolan.org/pub/x264/snapshots/`echo ${x264_ver} | tr - _`_x264.tar.bz2 || return;;
	x265)
		check_archive ${x265_org_src_dir} ||
			wget -O ${x265_org_src_dir}.tar.gz \
				http://ftp.videolan.org/pub/videolan/x265/x265_${x265_ver}.tar.gz || return;;
	libav)
		check_archive ${libav_org_src_dir} ||
			wget --no-check-certificate -O ${libav_org_src_dir}.tar.xz \
				https://libav.org/releases/${libav_name}.tar.xz || return;;
	opencv|opencv_contrib)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.gz \
				https://github.com/opencv/${_1}/archive/\${${_1}_ver}.tar.gz || return;;
	googletest)
		check_archive ${googletest_org_src_dir} ||
			wget --no-check-certificate -O ${googletest_org_src_dir}.tar.gz \
				https://github.com/google/googletest/archive/release-${googletest_ver}.tar.gz || return;;
	pkg-config)
		check_archive ${pkg_config_org_src_dir} ||
			wget --no-check-certificate -O ${pkg_config_org_src_dir}.tar.gz \
				https://pkg-config.freedesktop.org/releases/${pkg_config_name}.tar.gz || return;;
	xextproto|fixesproto|damageproto|presentproto|inputproto|kbproto|xproto|glproto|dri2proto|dri3proto)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.bz2 \
				ftp://ftp.freedesktop.org/pub/individual/proto/\${${_1}_name}.tar.bz2 || return;;
	libXext|libXfixes|libXdamage|xtrans|libX11|libxshmfence|libpciaccess|libXpm|libXt)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.bz2 \
				https://www.x.org/releases/individual/lib/\${${_1}_name}.tar.bz2 || return;;
	libdrm)
		check_archive ${libdrm_org_src_dir} ||
			wget --no-check-certificate -O ${libdrm_org_src_dir}.tar.bz2 \
				https://dri.freedesktop.org/libdrm/${libdrm_name}.tar.bz2 || return;;
	xcb-proto|libxcb)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.bz2 \
				https://www.x.org/releases/individual/xcb/\${${_1}_name}.tar.bz2 || return;;
	libepoxy)
		check_archive ${libepoxy_org_src_dir} ||
			wget --no-check-certificate -O ${libepoxy_org_src_dir}.tar.bz2 \
				https://github.com/anholt/libepoxy/releases/download/v${libepoxy_ver}/${libepoxy_name}.tar.bz2 || return;;
	mesa)
		check_archive ${mesa_org_src_dir} ||
			wget -O ${mesa_org_src_dir}.tar.xz \
				ftp://ftp.freedesktop.org/pub/mesa/${mesa_ver}/${mesa_name}.tar.xz || return;;
	cairo)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.xz \
				https://www.cairographics.org/releases/\${${_1}_name}.tar.xz || return;;
	pixman)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget --no-check-certificate -O \${${_1}_org_src_dir}.tar.gz \
				https://www.cairographics.org/releases/\${${_1}_name}.tar.gz || return;;
	glib|pango|gdk-pixbuf|atk|gobject-introspection)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.xz \
				http://ftp.gnome.org/pub/gnome/sources/${1}/\`echo \${${_1}_ver} \| cut -d. -f-2\`/\${${_1}_name}.tar.xz || return;;
	gtk)
		eval check_archive \${${_1}_org_src_dir} ||
			eval wget -O \${${_1}_org_src_dir}.tar.xz \
				http://ftp.gnome.org/pub/gnome/sources/gtk+/\`echo \${${_1}_ver} \| cut -d. -f-2\`/\${${_1}_name}.tar.xz || return;;
	webkitgtk)
		check_archive ${webkitgtk_org_src_dir} ||
			wget --no-check-certificate -O ${webkitgtk_org_src_dir}.tar.xz \
				https://webkitgtk.org/releases/${webkitgtk_name}.tar.xz || return;;
	*)
		echo fetch: no match: ${1} >&2; return 1;;
	esac
}

unpack()
# Unpack source files.
{
	case ${1} in
	'')
		clean || return
		for f in `find ${prefix}/src -name '*.tar.gz' -o -name '*.tar.bz2' -o -name '*.tar.xz' -o -name '*.zip'`; do
			unpack `echo $f | sed -e 's/\.tar\.gz$//;s/\.tar\.bz2$//;s/\.tar\.xz$//;s/\.zip$//'` `dirname $f`
		done;;
	*)
		[ -z "${2}" -a -d ${1} -o -d ${2}/`basename ${1}` ] && return
		${2:+eval mkdir -pv ${2} || return}
		[ -f ${1}.tar.gz  -a -s ${1}.tar.gz  ] && tar xzvf ${1}.tar.gz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${1}`} && return
		[ -f ${1}.tar.bz2 -a -s ${1}.tar.bz2 ] && tar xjvf ${1}.tar.bz2 --no-same-owner --no-same-permissions -C ${2:-`dirname ${1}`} && return
		[ -f ${1}.tar.xz  -a -s ${1}.tar.xz  ] && tar xJvf ${1}.tar.xz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${1}`} && return
		[ -f ${1}.zip     -a -s ${1}.zip     ] && unzip -d ${2:-`dirname ${1}`} ${1}.zip && return
		return 1;;
	esac
}

install()
# Build source files, then install built files.
{
	_1=`echo ${1} | tr - _`
	case ${1} in
	native)
		install_native_binutils || return
		install_native_gcc || return
		install_native_gdb || return;;
	cross)
		install_cross_binutils || return
		install_cross_gcc || return
		install_cross_gdb || return;;
	crossed)
		install_crossed_binutils || return
		install_crossed_gcc || return;;
	*)
		echo install: no match: ${1} >&2; return 1;;
	esac
}

full()
# Install native/cross GNU toolchain and other tools. as many as possible.
{
	for f in `sed -e \
		'/^install_native_[_[:alnum:]]\+()$/{
			s/()$//
			s/install_native_pkg_config//
			s/install_native_linux_header//
			s/install_native_glibc//
			s/install_native_libXpm//
			s/install_native_glib//
			s/install_native_cairo//
			s/install_native_pixman//
			s/install_native_pango//
			s/install_native_gdk_pixbuf//
			s/install_native_atk//
			s/install_native_gobject_introspection//
			s/install_native_inputproto//
			s/install_native_xtrans//
			s/install_native_libX11//
			s/install_native_libxcb//
			s/install_native_xcb_proto//
			s/install_native_xextproto//
			s/install_native_libXext//
			s/install_native_fixesproto//
			s/install_native_libXfixes//
			s/install_native_damageproto//
			s/install_native_libXdamage//
			s/install_native_libXt//
			s/install_native_xproto//
			s/install_native_kbproto//
			s/install_native_glproto//
			s/install_native_libpciaccess//
			s/install_native_libdrm//
			s/install_native_dri2proto//
			s/install_native_dri3proto//
			s/install_native_presentproto//
			s/install_native_libxshmfence//
			s/install_native_mesa//
			s/install_native_libepoxy//
			s/install_native_gtk//
			s/install_native_webkitgtk//
			p
		}
		d' ${0}`; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	for f in install_cross_binutils install_cross_gcc install_cross_gdb; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	(target=x86_64-w64-mingw32; host=${build}; languages=c,c++; set_variables; install_cross_gcc) \
		&& echo "'install_cross_gcc(mingw)'" succeeded. | logger -p user.notice -t `basename ${0}` \
		|| echo "'install_cross_gcc(mingw)'" failed.    | logger -p user.notice -t `basename ${0}`

	for f in `sed -e '/^install_crossed_native_[_[:alnum:]]\+()$/{s/()$//;p};d' ${0}`; do
		(host=${target}; set_variables; $f) \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	return 0
}

clean()
# Delete no longer required source trees.
{
	[ "${enable_ccache}" != yes ] || ccache -C > /dev/null || return
	find ${prefix}/src -mindepth 2 -maxdepth 2 \
		! -name '*.tar.gz' ! -name '*.tar.bz2' ! -name '*.tar.xz' ! -name '*.zip' ! -name '*-git' -exec rm -fvr {} +
	find ${prefix}/src -mindepth 2 -maxdepth 2 \
		-name '*-git' -exec sh -c "cd {}; make -j ${jobs} clean" \;
}

strip()
# Strip binary files.
{
	find ${prefix} -type f \( -perm /111 -o -name '*.o' -o -name '*.a' -o -name '*.so' -o -name '*.gox' \) \
		| xargs file | grep -e 'not stripped' | cut -d: -f1 | xargs -I "{}" sh -c "chmod u+w {}; strip {}" || true
}

archive()
# Archive related files.
{
	[ ${prefix}/src = `dirname ${0}` ] || cp -fv ${0} ${prefix}/src || return
	convert_archives || return
	tar cJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		-C `dirname ${prefix}` `basename ${prefix}` || return
}

deploy()
# Deploy related files.
{
	tar xJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		--no-same-owner --no-same-permissions -C `dirname ${prefix}` || return
	update_library_search_path || return
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
	clean || return
	find ${prefix} -mindepth 1 -maxdepth 1 ! -name src ! -name .git -exec rm -fvr '{}' +
	[ `whoami` = root ] && rm -fv /etc/ld.so.conf.d/`basename ${prefix}`.conf
	[ `whoami` = root ] && ldconfig || true
}

debug()
# Enter debug mode.
{
	prev_set=$-; set -e
	while true; do read ${BASH:+-e} -p "${1}> " cmd; eval ${cmd} || true; done
	set +e; set -${prev_set}
}

set_src_directory()
{
	_1=`echo ${1} | tr - _`

	case ${1} in
	llvm|libcxx|libcxxabi|compiler-rt|cfe|clang-tools-extra|lld|lldb)
		eval ${_1}_name=${1}-\${${_1}_ver}.src
		eval ${_1}_src_base=${prefix}/src/${1}
		eval ${_1}_org_src_dir=\${${_1}_src_base}/\${${_1}_name}
		eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-bld
		return 0
		;;
	esac

	case ${1} in
	jpeg)
		eval ${_1}_name=${1}src.\${${_1}_ver};;
	vimdoc-ja)
		eval ${_1}_name=${1};;
	gtk)
		eval ${_1}_name=${1}+-\${${_1}_ver};;
	boost)
		eval ${_1}_name=${1}_\${${_1}_ver};;
	mingw-w64)
		eval ${_1}_name=${1}-v\${${_1}_ver};;
	expect|tcl|tk)
		eval ${_1}_name=${1}\${${_1}_ver};;
	googletest)
		eval ${_1}_name=${1}-release-\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac

	eval ${_1}_src_base=${prefix}/src/${1}
	eval ${_1}_org_src_dir=\${${_1}_src_base}/\${${_1}_name}

	case ${1} in
	glibc|newlib|mingw-w64)
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
	prefix=`realpath -m ${prefix}`
	[ ${build} = ${host} ] && sysroot=${prefix}/${target}/sysroot || sysroot=${prefix}/${host}/sysroot
	sysroot_mingw='C:/MinGW64'
	[ ${host} = x86_64-w64-mingw32 ] && exe=.exe || exe=''
	[ -f /etc/issue ] && os=`head -1 /etc/issue | cut -d' ' -f1`
	[ "${strip}" = strip ] || cmake_build_type=Debug

	case ${target} in
	arm*)        cross_linux_arch=arm;;
	i?86*)       cross_linux_arch=x86;;
	microblaze*) cross_linux_arch=microblaze;;
	nios2*)      cross_linux_arch=nios2;;
	x86_64*)     cross_linux_arch=x86;;
	*) echo Unknown target architecture: ${target} >&2; return 1;;
	esac

	for pkg in `sed -e \
		'/^: \${\(.\+\)_ver:=.\+}$/{
			s//\1/
			s/pkg_config/pkg-config/
			s/vimdoc_ja/vimdoc-ja/
			s/git_manpages/git-manpages/
			s/sqlite_autoconf/sqlite-autoconf/
			s/apr_util/apr-util/
			s/compiler_rt/compiler-rt/
			s/clang_tools_extra/clang-tools-extra/
			s/mingw_w64/mingw-w64/
			s/xcb_proto/xcb-proto/
			s/gdk_pixbuf/gdk-pixbuf/
			s/gobject_introspection/gobject-introspection/
			p
		}
		d' ${0}`; do
		set_src_directory ${pkg}
	done

	echo ${PATH} | tr : '\n' | grep -qe ^${prefix}/bin\$ \
		&& PATH=${prefix}/bin:`echo ${PATH} | sed -e "s+\(^\|:\)${prefix}/bin\(\$\|:\)+\1\2+g;s/::/:/g;s/^://;s/:\$//"` \
		|| PATH=${prefix}/bin${PATH:+:${PATH}}
	echo ${PATH} | tr : '\n' | grep -qe ^/sbin\$ || PATH=/sbin:${PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${prefix}/lib64\$ || LD_LIBRARY_PATH=${prefix}/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${prefix}/lib\$   || LD_LIBRARY_PATH=${prefix}/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	export LD_LIBRARY_PATH
	[ "${enable_ccache}" = yes ] && export USE_CCACHE=1 CCACHE_DIR=${prefix}/src/.ccache CCACHE_BASEDIR=${prefix}/src && ! mkdir -pv ${prefix}/src && return 1
	[ "${enable_ccache}" = yes ] && ! echo ${CC} | grep -qe ccache && export CC="ccache ${CC:-gcc}" CXX="ccache ${CXX:-g++}"
	[ "${enable_ccache}" = yes ] || ! echo ${CC} | grep -qe ccache || export CC=`echo ${CC} | sed -e 's/ccache //'` CXX=`echo ${CXX} | sed -e 's/ccache //'`
	echo ${GOPATH} | tr : '\n' | grep -qe ^${prefix}/.go\$ \
		&& export GOPATH=${prefix}/.go:`echo ${GOPATH} | sed -e "s+\(^\|:\)${prefix}/.go\(\$\|:\)+\1\2+g;s/::/:/g;s/^://;s/:\$//"` \
		|| export GOPATH=${prefix}/.go${GOPATH:+:${GOPATH}}
	update_pkg_config_path || return
}

check_platform()
{
	echo build: ${1}, host: ${2}, target: ${3}. >&2
	case ${1} in
	${2}) case ${2} in
		${3}) echo native;;
		*)    echo cross;;
		esac;;
	*)    case ${2} in
		${3}) echo crossed;;
		*)    echo canadian;;
		esac;;
	esac
}

convert_archives()
{
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.gz'  -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.gz\$/.xz/"`;  [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; gzip  -cd {} | xz -cv > ${xzfile}' \; -delete || return
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.tar.bz2' -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.bz2\$/.xz/"`; [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; bzip2 -cd {} | xz -cv > ${xzfile}' \; -delete || return
	find ${prefix}/src -mindepth 2 -maxdepth 2 -name '*.zip'  -execdir sh -c '[ -f `basename {} .zip`.tar.xz ] && exit 0; unzip {} && tar cJvf `basename {} .zip`.tar.xz `basename {} .zip`' \; -delete || return
}

archive_sources()
{
	fetch || return
	clean || return
	convert_archives || return
	tar cJvf ${prefix}/src.tar.xz -C ${prefix} src
}

list_major_commands()
{
	echo '[Available commands]'
	eval "`grep -A 1 -e '^[[:alnum:]]\+()$' ${0} |
		sed -e '/^--$/d; /^{$/d; s/()$//; s/^# /\t/; s/^/\t/; 1s/^/echo "/; $s/$/"/'`"
}

list_all_commands()
{
	cat <<EOF
[All commands]
#: major commands, -: internal commands(for debugging use)
EOF
	commands=`grep -e '^[_[:alnum:]]*[[:alnum:]]\+()$' ${0} | sed -e 's/^/- /;s/()$//;s/- \([[:alnum:]]\+\)$/# \1/'`

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
	eval echo `grep -e '^[[:space:]]\+\(https\?\|ftp\)://.\+/' ${0} | sed -e 's/ || return$//;s/^[[:space:]]\+//'` | tr ' ' '\n'
}

update_library_search_path()
{
	[ `whoami` != root ] && return
	[ -f /etc/ld.so.conf.d/`basename ${prefix}`.conf ] ||
		cat <<EOF > /etc/ld.so.conf.d/`basename ${prefix}`.conf || return
${prefix}/lib
${prefix}/lib64
${prefix}/lib32
${prefix}/lib/gcc/${host}/${gcc_ver}
EOF
	ldconfig || return
}

update_pkg_config_path()
{
	PKG_CONFIG_PATH=`([ -d ${prefix}/lib ] && find ${prefix}/lib -type d -name pkgconfig
						[ -d ${prefix}/share ] && find ${prefix}/share -type d -name pkgconfig
						LANG=C ${CC:-gcc} -print-search-dirs | sed -e '/^libraries: =/{s/^libraries: =//;p};d' |
							tr : '\n' | xargs realpath -eq | xargs -I dir find dir -maxdepth 1 -type d -name pkgconfig) |
							tr '\n' : | sed -e 's/:$//'`
	export PKG_CONFIG_PATH
}

search_library()
{
	for dir in ${prefix}/lib64 ${prefix}/lib `LANG=C ${CC:-gcc} -print-search-dirs |
		sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs realpath -eq`; do
		[ -f ${dir}/${1} ] && echo ${dir}/${1} && return
	done
	return 1
}

get_library_path()
{
	path=`search_library $@`
	[ $? = 0 ] && dirname ${path} || return
}

search_header()
{
	for dir in ${prefix}/include ${prefix}/lib/libffi-*/include \
		`LANG=C ${CC:-gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
			sed -e '/^#include /,/^End of search list.$/p;d' | xargs realpath -eq`; do
		[ -d ${dir}${2:+/${2}} ] || continue
		candidates=`find ${dir}${2:+/${2}} -type f -name ${1}`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return
	done
	return 1
}

get_include_path()
{
	path=`search_header $@`
	[ $? = 0 ] && echo ${path} | sed -e "s%${2:+/${2}}/${1}\$%%" || return
}

get_prefix()
{
	path=`search_header $@`
	[ $? = 0 ] && echo ${path} | sed -e 's/\/include\/.\+//' || return
}

install_prerequisites()
{
	[ -n "${prerequisites_have_been_already_installed}" ] && return
	case ${os} in
	Debian|Ubuntu|Raspbian)
		apt-get install -y make gcc g++ || return
		apt-get install -y unifdef || return # for linux kernel(microblaze)
		apt-get install -y libgtk-3-dev libgnome2-dev libgnomeui-dev libx11-dev || return # for emacs
		apt-get install -y libudev-dev || return # for webkitgtk
		apt-get install -y libwebkitgtk-3.0-dev python-dev # libicu-dev # for emacs(xwidgets)
		apt-get install -y libgnomeui-dev libxt-dev || return # for vim
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ || return
		yum install -y unifdef || return
		yum install -y gtk3-devel || return
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1 ;;
	esac
	prerequisites_have_been_already_installed=yes
}

check_archive()
{
	[ -f ${1}.tar.gz  -a -s ${1}.tar.gz  ] && return
	[ -f ${1}.tar.bz2 -a -s ${1}.tar.bz2 ] && return
	[ -f ${1}.tar.xz  -a -s ${1}.tar.xz  ] && return
	[ -f ${1}.zip     -a -s ${1}.zip     ] && return
	return 1
}

install_native_tar()
{
	[ -x ${prefix}/bin/tar -a "${force_install}" != yes ] && return
	which xz > /dev/null || install_native_xz || return
	fetch tar || return
	unpack ${tar_org_src_dir} || return
	[ -f ${tar_org_src_dir}/Makefile ] ||
		(cd ${tar_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} \
			--build=${build} --disable-silent-rules) || return
	make -C ${tar_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tar_org_src_dir} -j ${jobs} -k check || return
	make -C ${tar_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_cpio()
{
	[ -x ${prefix}/bin/cpio -a "${force_install}" != yes ] && return
	fetch cpio || return
	unpack ${cpio_org_src_dir} || return
	[ -f ${cpio_org_src_dir}/Makefile ] ||
		(cd ${cpio_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${cpio_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cpio_org_src_dir} -j ${jobs} -k check || return
	make -C ${cpio_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_xz()
{
	[ -x ${prefix}/bin/xz -a "${force_install}" != yes ] && return
	fetch xz || return
	unpack ${xz_org_src_dir} || return
	[ -f ${xz_org_src_dir}/Makefile ] ||
		(cd ${xz_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${xz_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${xz_org_src_dir} -j ${jobs} -k check || return
	make -C ${xz_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_bzip2()
{
	[ -x ${prefix}/bin/bzip2 -a "${force_install}" != yes ] && return
	fetch bzip2 || return
	unpack ${bzip2_org_src_dir} || return
	sed -i -e \
			'/^CFLAGS=/{
				s/ -fPIC//g
				s/$/ -fPIC/
			}
			s/ln -s -f \$(PREFIX)\/bin\//ln -s -f /' ${bzip2_org_src_dir}/Makefile || return
	make -C ${bzip2_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${bzip2_org_src_dir} -j ${jobs} -k check || return
	make -C ${bzip2_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return
	make -C ${bzip2_org_src_dir} -j ${jobs} clean || return
	make -C ${bzip2_org_src_dir} -j ${jobs} -f Makefile-libbz2_so || return
	[ "${enable_check}" != yes ] ||
		make -C ${bzip2_org_src_dir} -j ${jobs} -k check || return
	cp -fv ${bzip2_org_src_dir}/libbz2.so.${bzip2_ver} ${prefix}/lib || return
	chmod a+r ${prefix}/lib/libbz2.so.${bzip2_ver} || return
	ln -fsv libbz2.so.${bzip2_ver} ${prefix}/lib/libbz2.so.`echo ${bzip2_ver} | cut -d. -f-2` || return
	ln -fsv libbz2.so.`echo ${bzip2_ver} | cut -d. -f-2` ${prefix}/lib/libbz2.so || return
	cp -fv ${bzip2_org_src_dir}/bzlib.h ${prefix}/include || return
	cp -fv ${bzip2_org_src_dir}/bzlib_private.h ${prefix}/include || return
	update_library_search_path || return
}

install_native_gzip()
{
	[ -x ${prefix}/bin/gzip -a "${force_install}" != yes ] && return
	fetch gzip || return
	unpack ${gzip_org_src_dir} || return
	[ -f ${gzip_org_src_dir}/Makefile ] ||
		(cd ${gzip_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${gzip_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gzip_org_src_dir} -j ${jobs} -k check || return
	make -C ${gzip_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_wget()
{
	[ -x ${prefix}/bin/wget -a "${force_install}" != yes ] && return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	fetch wget || return
	unpack ${wget_org_src_dir} || return
	[ -f ${wget_org_src_dir}/Makefile ] ||
		(cd ${wget_org_src_dir}
		OPENSSL_CFLAGS="-I${prefix}/include -L${prefix}/lib" OPENSSL_LIBS='-lssl -lcrypto' \
			./configure --prefix=${prefix} --build=${build} --disable-silent-rules --with-ssl=openssl) || return
	make -C ${wget_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${wget_org_src_dir} -j ${jobs} -k check || return
	make -C ${wget_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_pkg_config()
{
	[ -x ${prefix}/bin/pkg-config -a "${force_install}" != yes ] && return
	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
	fetch pkg-config || return
	unpack ${pkg_config_org_src_dir} || return
	[ -f ${pkg_config_org_src_dir}/Makefile ] ||
		(cd ${pkg_config_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			GLIB_CFLAGS="-I`get_include_path glib.h` -I`get_library_path libglib-2.0.so`/glib-2.0/include" \
			GLIB_LIBS="-L`get_library_path libglib-2.0.so` -lglib-2.0") || return
	make -C ${pkg_config_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pkg_config_org_src_dir} -j ${jobs} -k check || return
	make -C ${pkg_config_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_texinfo()
{
	[ -x ${prefix}/bin/makeinfo -a "${force_install}" != yes ] && return
	fetch texinfo || return
	unpack ${texinfo_org_src_dir} || return
	[ -f ${texinfo_org_src_dir}/Makefile ] ||
		(cd ${texinfo_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${texinfo_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${texinfo_org_src_dir} -j ${jobs} -k check || return
	make -C ${texinfo_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_coreutils()
{
	[ -x ${prefix}/bin/cat -a "${force_install}" != yes ] && return
	fetch coreutils || return
	unpack ${coreutils_org_src_dir} || return
	[ -f ${coreutils_org_src_dir}/Makefile ] ||
		(cd ${coreutils_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} \
			--build=${build} --disable-silent-rules) || return
	make -C ${coreutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${coreutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${coreutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_busybox()
{
	[ -x ${prefix}/bin/busybox/busybox -a "${force_install}" != yes ] && return
	fetch busybox || return
	unpack ${busybox_org_src_dir} || return
	make -C ${busybox_org_src_dir} -j ${jobs} V=1 defconfig || return
	make -C ${busybox_org_src_dir} -j ${jobs} V=1 || return
	make -C ${busybox_org_src_dir} -j ${jobs} CONFIG_PREFIX=${prefix}/busybox install || return
}

install_native_bison()
{
	[ -x ${prefix}/bin/bison -a "${force_install}" != yes ] && return
	fetch bison || return
	unpack ${bison_org_src_dir} || return
	[ -f ${bison_org_src_dir}/Makefile ] ||
		(cd ${bison_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${bison_org_src_dir} -j ${jobs} || return
	make -C ${bison_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_flex()
{
	[ -x ${prefix}/bin/flex -a "${force_install}" != yes ] && return
	which yacc > /dev/null || install_native_bison || return
	fetch flex || return
	unpack ${flex_org_src_dir} || return
	[ -f ${flex_org_src_dir}/Makefile ] ||
		(cd ${flex_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${flex_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${flex_org_src_dir} -j ${jobs} -k check || return
	make -C ${flex_org_src_dir} -j ${jobs} install${strip:+-${strip}} install-man || return
	update_library_search_path || return
}

install_native_m4()
{
	[ -x ${prefix}/bin/m4 -a "${force_install}" != yes ] && return
	fetch m4 || return
	unpack ${m4_org_src_dir} || return
	[ -f ${m4_org_src_dir}/Makefile ] ||
		(cd ${m4_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${m4_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${m4_org_src_dir} -j ${jobs} -k check || return
	make -C ${m4_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_autoconf()
{
	[ -x ${prefix}/bin/autoconf -a "${force_install}" != yes ] && return
	fetch autoconf || return
	unpack ${autoconf_org_src_dir} || return
	[ -f ${autoconf_org_src_dir}/Makefile ] ||
		(cd ${autoconf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${autoconf_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${autoconf_org_src_dir} -j ${jobs} -k check || return
	make -C ${autoconf_org_src_dir} -j ${jobs} install || return
}

install_native_automake()
{
	[ -x ${prefix}/bin/automake -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	fetch automake || return
	unpack ${automake_org_src_dir} || return
	[ -f ${automake_org_src_dir}/Makefile ] ||
		(cd ${automake_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${automake_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${automake_org_src_dir} -j ${jobs} -k check || return
	make -C ${automake_org_src_dir} -j ${jobs} install || return
}

install_native_autogen()
{
	[ -x ${prefix}/bin/autogen -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	search_header libguile.h > /dev/null || install_native_guile || return
	fetch autogen || return
	unpack ${autogen_org_src_dir} || return
	[ -f ${autogen_org_src_dir}/Makefile ] ||
		(cd ${autogen_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${autogen_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${autogen_org_src_dir} -j ${jobs} -k check || return
	make -C ${autogen_org_src_dir} -j ${jobs} install || return
}

install_native_libtool()
{
	[ -x ${prefix}/bin/libtool -a "${force_install}" != yes ] && return
	which flex > /dev/null || install_native_flex || return
	fetch libtool || return
	unpack ${libtool_org_src_dir} || return
	[ -f ${libtool_org_src_dir}/Makefile ] ||
		(cd ${libtool_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libtool_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libtool_org_src_dir} -j ${jobs} -k check || return
	make -C ${libtool_org_src_dir} -j ${jobs} install || return
}

install_native_sed()
{
	[ -x ${prefix}/bin/sed -a "${force_install}" != yes ] && return
	fetch sed || return
	unpack ${sed_org_src_dir} || return
	[ -f ${sed_org_src_dir}/Makefile ] ||
		(cd ${sed_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${sed_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${sed_org_src_dir} -j ${jobs} -k check || return
	make -C ${sed_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_gawk()
{
	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return
	fetch gawk || return
	unpack ${gawk_org_src_dir} || return
	[ -f ${gawk_org_src_dir}/Makefile ] ||
		(cd ${gawk_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${gawk_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gawk_org_src_dir} -j ${jobs} -k check || return
	make -C ${gawk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_make()
{
	[ -x ${prefix}/bin/make -a "${force_install}" != yes ] && return
	search_header libguile.h > /dev/null || install_native_guile || return
	fetch make || return
	unpack ${make_org_src_dir} || return
	[ -f ${make_org_src_dir}/Makefile ] ||
		(cd ${make_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --host=${build} \
			--with-guile) || return
	make -C ${make_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${make_org_src_dir} -j ${jobs} -k check || return
	make -C ${make_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_binutils()
{
	[ -x ${prefix}/bin/as -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	which yacc > /dev/null || install_native_bison || return
	fetch binutils || return
	[ -d ${binutils_src_dir_ntv} ] ||
		(unpack ${binutils_org_src_dir} &&
			mv -v ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-sysroot=/ \
			--enable-shared --enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
#			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
#			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function"
		) || return
	make -C ${binutils_src_dir_ntv} -j 1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${binutils_src_dir_ntv} -j 1 -k check || return
	make -C ${binutils_src_dir_ntv} -j 1 install${strip:+-${strip}} || return
}

install_native_elfutils()
{
	[ -x ${prefix}/bin/eu-addr2line -a "${force_install}" != yes ] && return
	fetch elfutils || return
	unpack ${elfutils_org_src_dir} || return
	[ -f ${elfutils_org_src_dir}/Makefile ] ||
		(cd ${elfutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${elfutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${elfutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${elfutils_org_src_dir} -j 1 install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_linux_header()
{
	fetch linux || return
	[ -d ${linux_src_dir_ntv} ] ||
		(unpack ${linux_org_src_dir} &&
			mv -v ${linux_org_src_dir} ${linux_src_dir_ntv}) || return
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 mrproper || return
	case ${build} in
	arm*)        native_linux_arch=arm;;
	i?86*)       native_linux_arch=x86;;
	microblaze*) native_linux_arch=microblaze;;
	x86_64*)     native_linux_arch=x86;;
	*) echo Unknown build architecture: ${build} >&2; return 1;;
	esac
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 \
		ARCH=${native_linux_arch} INSTALL_HDR_PATH=${prefix} headers_install || return
}

install_native_qemu()
{
	[ -x ${prefix}/bin/qemu-img -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	fetch qemu || return
	unpack ${qemu_org_src_dir} || return
	(cd ${qemu_org_src_dir}
	./configure --prefix=${prefix} --cc=${CC:-gcc} --host-cc=${CC:-gcc} --cxx=${CXX:-g++}) || return
	make -C ${qemu_org_src_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${qemu_org_src_dir} -j ${jobs} -k test || return
	make -C ${qemu_org_src_dir} -j ${jobs} install || return
}

install_native_gperf()
{
	[ -x ${prefix}/bin/gperf -a "${force_install}" != yes ] && return
	fetch gperf || return
	unpack ${gperf_org_src_dir} || return
	[ -f ${gperf_org_src_dir}/Makefile ] ||
		(cd ${gperf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${gperf_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gperf_org_src_dir} -j ${jobs} -k check || return
	make -C ${gperf_org_src_dir} -j ${jobs} install || return
}

install_native_glibc()
{
	[ -e ${prefix}/lib/libc.so -a "${force_install}" != yes ] && return
	install_native_linux_header || return
	which awk > /dev/null || install_native_gawk || return
	which gperf > /dev/null || install_native_gperf || return
	fetch glibc || return
	[ -d ${glibc_src_dir_ntv} ] ||
		(unpack ${glibc_org_src_dir} &&
			mv -v ${glibc_org_src_dir} ${glibc_src_dir_ntv}) || return
	mkdir -pv ${glibc_bld_dir_ntv} || return
	[ -f ${glibc_bld_dir_ntv}/Makefile ] ||
		(cd ${glibc_bld_dir_ntv}
		LD_LIBRARY_PATH='' ${glibc_src_dir_ntv}/configure \
			--prefix=${prefix} --build=${build} \
			--with-headers=${prefix}/include --without-selinux --enable-add-ons \
			CPPFLAGS="${CPPFLAGS} -I${prefix}/include -D_LIBC") || return
	make -C ${glibc_bld_dir_ntv} -j ${jobs} install-headers || return
	make -C ${glibc_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${glibc_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${glibc_bld_dir_ntv} -j ${jobs} install || return
	make -C ${glibc_bld_dir_ntv} -j ${jobs} localedata/install-locales || return
	update_library_search_path || return
}

install_native_gmp()
{
	[ -f ${prefix}/include/gmp.h -a "${force_install}" != yes ] && return
	fetch gmp || return
	[ -d ${gmp_src_dir_ntv} ] ||
		(unpack ${gmp_org_src_dir} &&
			mv -v ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --enable-cxx) || return
	make -C ${gmp_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gmp_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${gmp_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_mpfr()
{
	[ -f ${prefix}/include/mpfr.h -a "${force_install}" != yes ] && return
	search_header gmp.h > /dev/null || install_native_gmp || return
	fetch mpfr || return
	[ -d ${mpfr_src_dir_ntv} ] ||
		(unpack ${mpfr_org_src_dir} &&
			mv -v ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-gmp=`get_prefix gmp.h`) || return
	make -C ${mpfr_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpfr_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${mpfr_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_mpc()
{
	[ -f ${prefix}/include/mpc.h -a "${force_install}" != yes ] && return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	fetch mpc || return
	[ -d ${mpc_src_dir_ntv} ] ||
		(unpack ${mpc_org_src_dir} &&
			mv -v ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h`) || return
	make -C ${mpc_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpc_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${mpc_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_isl()
{
	[ -f ${prefix}/include/isl/version.h -a "${force_install}" != yes ] && return
	search_header gmp.h > /dev/null || install_native_gmp || return
	fetch isl || return
	unpack ${isl_org_src_dir} || return
	[ -f ${isl_org_src_dir}/Makefile ] ||
		(cd ${isl_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${isl_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${isl_org_src_dir} -j ${jobs} -k check || return
	make -C ${isl_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_gcc()
{
	[ -x ${prefix}/bin/gcc -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	search_header version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} || return
	mkdir -pv ${gcc_bld_dir_ntv} || return
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		with_libiconv_prefix(){ [ -n "`search_library libiconv.so`" ] && echo --with-libiconv-prefix=`get_prefix iconv.h`;}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--with-isl=`get_prefix version.h isl` --with-system-zlib `with_libiconv_prefix` \
			--enable-languages=${languages} --disable-multilib --enable-linker-build-id --enable-libstdcxx-debug \
			--program-suffix=-${gcc_ver} --enable-version-specific-runtime-libs \
		) || return
	make -C ${gcc_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	[ ! -f ${prefix}/bin/${build}-gcc-tmp ] || rm -v ${prefix}/bin/${build}-gcc-tmp || return
	for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool go gofmt; do
		[ ! -f ${prefix}/bin/${b}-${gcc_ver} ] || ln -fsv ${b}-${gcc_ver} ${prefix}/bin/${b} || return
	done
	ln -fsv gcc ${prefix}/bin/cc || return
}

install_native_readline()
{
	[ -f ${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return
	fetch readline || return
	unpack ${readline_org_src_dir} || return
	[ -f ${readline_org_src_dir}/Makefile ] ||
		(cd ${readline_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${readline_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${readline_org_src_dir} -j ${jobs} -k check || return
	make -C ${readline_org_src_dir} -j ${jobs} install || return
	update_library_search_path || return
}

install_native_ncurses()
{
	[ -f ${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return
	fetch ncurses || return
	unpack ${ncurses_org_src_dir} || return

	# [XXX] workaround for GCC 5.x
	which patch > /dev/null || install_native_patch || return
	patch -N -p0 -d ${ncurses_org_src_dir} <<\EOF || [ $? = 1 ] || return
--- ncurses/base/MKlib_gen.sh
+++ ncurses/base/MKlib_gen.sh
@@ -491,11 +491,18 @@
 	-e 's/gen_$//' \
 	-e 's/  / /g' >>$TMP

+cat >$ED1 <<EOF
+s/  / /g
+s/^ //
+s/ $//
+s/P_NCURSES_BOOL/NCURSES_BOOL/g
+EOF
+
+sed -e 's/bool/P_NCURSES_BOOL/g' $TMP > $ED2
+cat $ED2 >$TMP
+
 $preprocessor $TMP 2>/dev/null \
-| sed \
-	-e 's/  / /g' \
-	-e 's/^ //' \
-	-e 's/_Bool/NCURSES_BOOL/g' \
+| sed -f $ED1 \
 | $AWK -f $AW2 \
 | sed -f $ED3 \
 | sed \
EOF

	[ -f ${ncurses_org_src_dir}/Makefile ] ||
		(cd ${ncurses_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--with-libtool --with-shared --with-cxx-shared) || return
	make -C ${ncurses_org_src_dir} -j ${jobs} || return
	make -C ${ncurses_org_src_dir} -j ${jobs} install || return
	update_library_search_path || return
}

install_native_gdb()
{
	[ -x ${prefix}/bin/gdb -a "${force_install}" != yes ] && return
	search_header readline.h readline > /dev/null || install_native_readline || return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_library libpython`python3 --version | grep -oe '[[:digit:]]\.[[:digit:]]'`m.so > /dev/null || install_native_python || return
	which makeinfo > /dev/null || install_native_texinfo || return
	fetch gdb || return
	unpack ${gdb_org_src_dir} || return
	mkdir -pv ${gdb_bld_dir_ntv} || return
	[ -f ${gdb_bld_dir_ntv}/Makefile ] ||
		(cd ${gdb_bld_dir_ntv}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--enable-targets=all --enable-tui --with-python=python3 \
			--with-system-zlib --with-system-readline) || return
	make -C ${gdb_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gdb_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${gdb_bld_dir_ntv} -j ${jobs} install || return
	make -C ${gdb_bld_dir_ntv}/gdb -j ${jobs} install${strip:+-${strip}} || return
}

install_native_lcov()
{
	[ -x ${prefix}/bin/lcov -a "${force_install}" != yes ] && return
	fetch lcov || return
	unpack ${lcov_org_src_dir} || return
	make -C ${lcov_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return
}

install_native_zlib()
{
	[ -f ${prefix}/include/zlib.h -a "${force_install}" != yes ] && return
	fetch zlib || return
	[ -d ${zlib_src_dir_ntv} ] ||
		(unpack ${zlib_org_src_dir} &&
			mv -v ${zlib_org_src_dir} ${zlib_src_dir_ntv}) || return
	(cd ${zlib_src_dir_ntv}
	./configure --prefix=${prefix}) || return
	make -C ${zlib_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${zlib_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${zlib_src_dir_ntv} -j ${jobs} install || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libpng()
{
	[ -f ${prefix}/include/png.h -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	fetch libpng || return
	[ -d ${libpng_src_dir_ntv} ] ||
		(unpack ${libpng_org_src_dir} &&
			mv -v ${libpng_org_src_dir} ${libpng_src_dir_ntv}) || return
	[ -f ${libpng_src_dir_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} LDFLAGS="${LDFLAGS} -L`get_library_path libz.so`") || return
	make -C ${libpng_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpng_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${libpng_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libtiff()
{
	[ -f ${prefix}/include/tiffio.h -a "${force_install}" != yes ] && return
	fetch tiff || return
	[ -d ${tiff_src_dir_ntv} ] ||
		(unpack ${tiff_org_src_dir} &&
			mv -v ${tiff_org_src_dir} ${tiff_src_dir_ntv}) || return
	[ -f ${tiff_src_dir_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${tiff_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tiff_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${tiff_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libjpeg()
{
	[ -f ${prefix}/include/jpeglib.h -a "${force_install}" != yes ] && return
	fetch jpeg || return
	[ -d ${jpeg_src_dir_ntv} ] ||
		(unpack ${jpeg_org_src_dir} &&
			mv -v ${jpeg_org_src_dir} ${jpeg_src_dir_ntv}) || return
	[ -f ${jpeg_src_dir_ntv}/Makefile ] ||
		(cd ${jpeg_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${jpeg_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${jpeg_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${jpeg_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_giflib()
{
	[ -f ${prefix}/include/gif_lib.h -a "${force_install}" != yes ] && return
	which xmlto > /dev/null || install_native_xmlto || return
	fetch giflib || return
	[ -d ${giflib_src_dir_ntv} ] ||
		(unpack ${giflib_org_src_dir} &&
			mv -v ${giflib_org_src_dir} ${giflib_src_dir_ntv}) || return
	[ -f ${giflib_src_dir_ntv}/Makefile ] ||
		(cd ${giflib_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${giflib_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${giflib_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${giflib_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_libXpm()
{
	[ -f ${prefix}/include/X11/xpm.h -a "${force_install}" != yes ] && return
	search_header Xproto.h X11 > /dev/null || install_native_xproto || return
	search_header XKBproto.h X11 > /dev/null || install_native_kbproto || return
	search_header Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXpm || return
	unpack ${libXpm_org_src_dir} || return
	[ -f ${libXpm_org_src_dir}/Makefile ] ||
		(cd ${libXpm_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libXpm_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libXpm_org_src_dir} -j ${jobs} -k check || return
	make -C ${libXpm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libwebp()
{
	[ -f ${prefix}/include/webp/decode.h -a "${force_install}" != yes ] && return
	search_header png.h > /dev/null || install_native_libpng || return
	search_header tiff.h > /dev/null || install_native_libtiff || return
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return
	search_header gif_lib.h > /dev/null || install_native_giflib || return
	fetch libwebp || return
	unpack ${libwebp_org_src_dir} || return
	[ -f ${libwebp_org_src_dir}/Makefile ] ||
		(cd ${libwebp_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libwebp_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libwebp_org_src_dir} -j ${jobs} -k check || return
	make -C ${libwebp_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libffi()
{
	[ -f ${prefix}/lib/libffi-*/include/ffi.h -a "${force_install}" != yes ] && return
	fetch libffi || return
	unpack ${libffi_org_src_dir} || return
	[ -f ${libffi_org_src_dir}/Makefile ] ||
		(cd ${libffi_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${libffi_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libffi_org_src_dir} -j ${jobs} -k check || return
	make -C ${libffi_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_glib()
{
	[ -f ${prefix}/include/glib-2.0/glib.h -a "${force_install}" != yes ] && return
	search_header iconv.h > /dev/null || install_native_libiconv || return
	search_header ffi.h > /dev/null || install_native_libffi || return
	search_header pcre.h > /dev/null || install_native_pcre || return
	fetch glib || return
	unpack ${glib_org_src_dir} || return
	[ -f ${glib_org_src_dir}/Makefile ] ||
		(cd ${glib_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-static \
			--disable-silent-rules --disable-libmount --disable-dtrace --enable-systemtap --with-libiconv \
			LIBFFI_CFLAGS=-I`get_include_path ffi.h` LIBFFI_LIBS="-L`get_library_path libffi.so` -lffi" \
			PCRE_CFLAGS=-I`get_include_path pcre.h` PCRE_LIBS="-L`get_library_path libpcre.so` -lpcre") || return
	make -C ${glib_org_src_dir} -j ${jobs} || return
	make -C ${glib_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

#install_native_cairo()
#{
#	[ -f ${prefix}/include/cairo/cairo.h -a "${force_install}" != yes ] && return
#	fetch cairo || return
#	unpack ${cairo_org_src_dir} || return
#	[ -f ${cairo_org_src_dir}/Makefile ] ||
#		(cd ${cairo_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${cairo_org_src_dir} -j ${jobs} || return
#	make -C ${cairo_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_pixman()
#{
#	[ -f ${prefix}/include/pixman-1.0/pixman.h -a "${force_install}" != yes ] && return
#	fetch pixman || return
#	unpack ${pixman_org_src_dir} || return
#	[ -f ${pixman_org_src_dir}/Makefile ] ||
#		(cd ${pixman_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${pixman_org_src_dir} -j ${jobs} || return
#	make -C ${pixman_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_pango()
#{
#	[ -f ${prefix}/include/pango-1.0/pango/pango.h -a "${force_install}" != yes ] && return
#	search_header cairo.h cairo > /dev/null || install_native_cairo || return
#	search_header pixman.h pixman-1.0 > /dev/null || install_native_pixman || return
#	fetch pango || return
#	unpack ${pango_org_src_dir} || return
#	[ -f ${pango_org_src_dir}/Makefile ] ||
#		(cd ${pango_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${pango_org_src_dir} -j ${jobs} || return
#	make -C ${pango_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_gdk_pixbuf()
#{
#	[ -f ${prefix}/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf.h -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch gdk-pixbuf || return
#	unpack ${gdk_pixbuf_org_src_dir} || return
#	[ -f ${gdk_pixbuf_org_src_dir}/Makefile ] ||
#		(cd ${gdk_pixbuf_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} || return
#	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_atk()
#{
#	[ -f ${prefix}/include/atk-1.0/atk/atk.h -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch atk || return
#	unpack ${atk_org_src_dir} || return
#	[ -f ${atk_org_src_dir}/Makefile ] ||
#		(cd ${atk_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${atk_org_src_dir} -j ${jobs} || return
#	make -C ${atk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_gobject_introspection()
#{
#	[ -d ${prefix}/include/gobject-introspection-1.0 -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch gobject-introspection || return
#	unpack ${gobject_introspection_org_src_dir} || return
#	[ -f ${gobject_introspection_org_src_dir}/Makefile ] ||
#		(cd ${gobject_introspection_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} \
#			--disable-silent-rules) || return
#	make -C ${gobject_introspection_org_src_dir} -j ${jobs} || return
#	make -C ${gobject_introspection_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_inputproto()
#{
#	[ -d ${prefix}/include/X11/extensions/XI.h -a "${force_install}" != yes ] && return
#	fetch inputproto || return
#	unpack ${inputproto_org_src_dir} || return
#	[ -f ${inputproto_org_src_dir}/Makefile ] ||
#		(cd ${inputproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${inputproto_org_src_dir} -j ${jobs} || return
#	make -C ${inputproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_xtrans()
#{
#	[ -f ${prefix}/include/X11/Xtrans/Xtrans.h -a "${force_install}" != yes ] && return
#	fetch xtrans || return
#	unpack ${xtrans_org_src_dir} || return
#	[ -f ${xtrans_org_src_dir}/Makefile ] ||
#		(cd ${xtrans_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xtrans_org_src_dir} -j ${jobs} || return
#	make -C ${xtrans_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libX11()
#{
#	[ -f ${prefix}/include/X11/Xlib.h -a "${force_install}" != yes ] && return
#	search_header XI.h X11/extensions > /dev/null || install_native_inputproto || return
#	search_header Xtrans.h X11/Xtrans > /dev/null || install_native_xtrans || return
#	search_header lbx.h X11/extensions > /dev/null || install_native_xextproto || return
#	search_header xcb.h xcb > /dev/null || install_native_libxcb || return
#	fetch libX11 || return
#	unpack ${libX11_org_src_dir} || return
#	[ -f ${libX11_org_src_dir}/Makefile ] ||
#		(cd ${libX11_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libX11_org_src_dir} -j ${jobs} || return
#	make -C ${libX11_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libxcb()
#{
#	[ -f ${prefix}/include/xcb/xcb.h -a "${force_install}" != yes ] && return
#	[ -d ${prefix}/share/xcb ] || install_native_xcb_proto || return
#	fetch libxcb || return
#	unpack ${libxcb_org_src_dir} || return
#	[ -f ${libxcb_org_src_dir}/Makefile ] ||
#		(cd ${libxcb_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libxcb_org_src_dir} -j ${jobs} || return
#	make -C ${libxcb_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_xcb_proto()
#{
#	[ -d ${prefix}/share/xcb -a "${force_install}" != yes ] && return
#	fetch xcb-proto || return
#	unpack ${xcb_proto_org_src_dir} || return
#	[ -f ${xcb_proto_org_src_dir}/Makefile ] ||
#		(cd ${xcb_proto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xcb_proto_org_src_dir} -j ${jobs} || return
#	make -C ${xcb_proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_xextproto()
#{
#	[ -f ${prefix}/include/X11/extensions/lbx.h -a "${force_install}" != yes ] && return
#	fetch xextproto || return
#	unpack ${xextproto_org_src_dir} || return
#	[ -f ${xextproto_org_src_dir}/Makefile ] ||
#		(cd ${xextproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xextproto_org_src_dir} -j ${jobs} || return
#	make -C ${xextproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libXext()
#{
#	[ -f ${prefix}/include/X11/extensions/Xext.h -a "${force_install}" != yes ] && return
#	search_header lbx.h X11/extensions > /dev/null || install_native_xextproto || return
#	fetch libXext || return
#	unpack ${libXext_org_src_dir} || return
#	[ -f ${libXext_org_src_dir}/Makefile ] ||
#		(cd ${libXext_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXext_org_src_dir} -j ${jobs} || return
#	make -C ${libXext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_fixesproto()
#{
#	[ -f ${prefix}/include/X11/extensions/xfixesproto.h -a "${force_install}" != yes ] && return
#	fetch fixesproto || return
#	unpack ${fixesproto_org_src_dir} || return
#	[ -f ${fixesproto_org_src_dir}/Makefile ] ||
#		(cd ${fixesproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${fixesproto_org_src_dir} -j ${jobs} || return
#	make -C ${fixesproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libXfixes()
#{
#	[ -f ${prefix}/include/X11/extensions/Xfixes.h -a "${force_install}" != yes ] && return
#	search_header xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return
#	fetch libXfixes || return
#	unpack ${libXfixes_org_src_dir} || return
#	[ -f ${libXfixes_org_src_dir}/Makefile ] ||
#		(cd ${libXfixes_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXfixes_org_src_dir} -j ${jobs} || return
#	make -C ${libXfixes_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_damageproto()
#{
#	[ -f ${prefix}/include/X11/extensions/damageproto.h -a "${force_install}" != yes ] && return
#	fetch damageproto || return
#	unpack ${damageproto_org_src_dir} || return
#	[ -f ${damageproto_org_src_dir}/Makefile ] ||
#		(cd ${damageproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${damageproto_org_src_dir} -j ${jobs} || return
#	make -C ${damageproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libXdamage()
#{
#	[ -f ${prefix}/include/X11/extensions/Xdamage.h -a "${force_install}" != yes ] && return
#	search_header damageproto.h X11/extensions > /dev/null || install_native_damageproto || return
#	search_header Xfixes.h X11/extensions > /dev/null || install_native_libXfixes || return
#	fetch libXdamage || return
#	unpack ${libXdamage_org_src_dir} || return
#	[ -f ${libXdamage_org_src_dir}/Makefile ] ||
#		(cd ${libXdamage_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXdamage_org_src_dir} -j ${jobs} || return
#	make -C ${libXdamage_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libXt()
#{
#	[ -f ${prefix}/include/X11/Core.h -a "${force_install}" != yes ] && return
#	fetch libXt || return
#	unpack ${libXt_org_src_dir} || return
#	[ -f ${libXt_org_src_dir}/Makefile ] ||
#		(cd ${libXt_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXt_org_src_dir} -j ${jobs} || return
#	make -C ${libXt_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_xproto()
#{
#	[ -f ${prefix}/include/X11/Xproto.h -a "${force_install}" != yes ] && return
#	fetch xproto || return
#	unpack ${xproto_org_src_dir} || return
#	[ -f ${xproto_org_src_dir}/Makefile ] ||
#		(cd ${xproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xproto_org_src_dir} -j ${jobs} || return
#	make -C ${xproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_kbproto()
#{
#	[ -f ${prefix}/include/X11/XKBproto.h -a "${force_install}" != yes ] && return
#	fetch kbproto || return
#	unpack ${kbproto_org_src_dir} || return
#	[ -f ${kbproto_org_src_dir}/Makefile ] ||
#		(cd ${kbproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${kbproto_org_src_dir} -j ${jobs} || return
#	make -C ${kbproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_glproto()
#{
#	[ -f ${prefix}/include/GL/glxproto.h -a "${force_install}" != yes ] && return
#	fetch glproto || return
#	unpack ${glproto_org_src_dir} || return
#	[ -f ${glproto_org_src_dir}/Makefile ] ||
#		(cd ${glproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${glproto_org_src_dir} -j ${jobs} || return
#	make -C ${glproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_libpciaccess()
#{
#	[ -f ${prefix}/include/pciaccess.h -a "${force_install}" != yes ] && return
#	fetch libpciaccess || return
#	unpack ${libpciaccess_org_src_dir} || return
#	[ -f ${libpciaccess_org_src_dir}/Makefile ] ||
#		(cd ${libpciaccess_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libpciaccess_org_src_dir} -j ${jobs} || return
#	make -C ${libpciaccess_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libdrm()
#{
#	[ -f ${prefix}/include/xf86drm.h -a "${force_install}" != yes ] && return
#	search_header pciaccess.h > /dev/null || install_native_libpciaccess || return
#	fetch libdrm || return
#	unpack ${libdrm_org_src_dir} || return
#	[ -f ${libdrm_org_src_dir}/Makefile ] ||
#		(cd ${libdrm_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
#			--enable-static) || return
#	make -C ${libdrm_org_src_dir} -j ${jobs} || return
#	make -C ${libdrm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_dri2proto()
#{
#	[ -f ${prefix}/include/X11/extensions/dri2proto.h -a "${force_install}" != yes ] && return
#	fetch dri2proto || return
#	unpack ${dri2proto_org_src_dir} || return
#	[ -f ${dri2proto_org_src_dir}/Makefile ] ||
#		(cd ${dri2proto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${dri2proto_org_src_dir} -j ${jobs} || return
#	make -C ${dri2proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_dri3proto()
#{
#	[ -f ${prefix}/include/X11/extensions/dri3proto.h -a "${force_install}" != yes ] && return
#	fetch dri3proto || return
#	unpack ${dri3proto_org_src_dir} || return
#	[ -f ${dri3proto_org_src_dir}/Makefile ] ||
#		(cd ${dri3proto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${dri3proto_org_src_dir} -j ${jobs} || return
#	make -C ${dri3proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_presentproto()
#{
#	[ -f ${prefix}/include/X11/extensions/presentproto.h -a "${force_install}" != yes ] && return
#	fetch presentproto || return
#	unpack ${presentproto_org_src_dir} || return
#	[ -f ${presentproto_org_src_dir}/Makefile ] ||
#		(cd ${presentproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${presentproto_org_src_dir} -j ${jobs} || return
#	make -C ${presentproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#}
#
#install_native_libxshmfence()
#{
#	[ -f ${prefix}/include/X11/xshmfence.h -a "${force_install}" != yes ] && return
#	fetch libxshmfence || return
#	unpack ${libxshmfence_org_src_dir} || return
#	[ -f ${libxshmfence_org_src_dir}/Makefile ] ||
#		(cd ${libxshmfence_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libxshmfence_org_src_dir} -j ${jobs} || return
#	make -C ${libxshmfence_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_mesa()
#{
#	[ -f ${prefix}/include/GL/gl.h -a "${force_install}" != yes ] && return
#	search_header glxproto.h GL > /dev/null || install_native_glproto || return
#	search_header xf86drm.h > /dev/null || install_native_libdrm || return
#	search_header dri2proto.h X11/extensions > /dev/null || install_native_dri2proto || return
#	search_header dri3proto.h X11/extensions > /dev/null || install_native_dri3proto || return
#	search_header presentproto.h X11/extensions > /dev/null || install_native_presentproto || return
#	[ -d ${prefix}/share/xcb ] || install_native_xcb_proto || return
#	search_header xcb.h xcb > /dev/null || install_native_libxcb || return
#	search_header xshmfence.h X11 > /dev/null || install_native_libxshmfence || return
#	search_header Xext.h X11/extensions > /dev/null || install_native_libXext || return
#	search_header Xdamage.h X11/extensions > /dev/null || install_native_libXdamage || return
#	search_header Xlib.h X11 > /dev/null || install_native_libX11 || return
#	fetch mesa || return
#	unpack ${mesa_org_src_dir} || return
#	[ -f ${mesa_org_src_dir}/Makefile ] ||
#		(cd ${mesa_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${mesa_org_src_dir} -j ${jobs} || return
#	make -C ${mesa_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_libepoxy()
#{
#	[ -f ${prefix}/include/epoxy/egl.h -a "${force_install}" != yes ] && return
#	search_header Core.h X11 > /dev/null || install_native_libXt || return
#	fetch libepoxy || return
#	unpack ${libepoxy_org_src_dir} || return
#	[ -f ${libepoxy_org_src_dir}/Makefile ] ||
#		(cd ${libepoxy_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libepoxy_org_src_dir} -j ${jobs} || return
#	make -C ${libepoxy_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_gtk()
#{
#	[ -f ${prefix}/include/gtk-3.0/gtk/gtk.h -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	search_header pango.h pango-1.0/pango > /dev/null || install_native_pango || return
#	search_header gdk-pixbuf.h gdk-pixbuf-2.0/gdk-pixbuf > /dev/null || install_native_gdk_pixbuf || return
#	search_header atk.h atk-1.0/atk > /dev/null || install_native_atk || return
#	search_header giversionmacros.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return
#	search_header egl.h epoxy > /dev/null || install_native_libepoxy || return
#	fetch gtk || return
#	unpack ${gtk_org_src_dir} || return
#	[ -f ${gtk_org_src_dir}/Makefile ] ||
#		(cd ${gtk_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${gtk_org_src_dir} -j ${jobs} || return
#	make -C ${gtk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_library_search_path || return
#}
#
#install_native_webkitgtk()
#{
##	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return
#	search_header gtk.h gtk-3.0/gtk > /dev/null || install_native_gtk || return
#	search_header sqlite3.h > /dev/null || install_native_sqlite || return
#	search_header png.h > /dev/null || install_native_libpng || return
#	search_header tiff.h > /dev/null || install_native_libtiff || return
#	search_header jpeglib.h > /dev/null || install_native_libjpeg || return
#	search_header gif_lib.h > /dev/null || install_native_giflib || return
#	search_header decode.h webp > /dev/null || install_native_libwebp || return
#	fetch webkitgtk || return
#	unpack ${webkitgtk_org_src_dir} || return
#	mkdir -pv ${webkitgtk_bld_dir_ntv} || return
#	[ -f ${webkitgtk_bld_dir_ntv}/Makefile ] ||
#		(cd ${webkitgtk_bld_dir_ntv}
#		update_pkg_config_path
#		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
#			-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} -L${prefix}/lib" \
#			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
#			-DPORT=GTK -DENABLE_CREDENTIAL_STORAGE=OFF \
#			-DENABLE_SPELLCHECK=OFF -DENABLE_WEB_AUDIO=OFF -DENABLE_VIDEO=OFF \
#			-DUSE_LIBNOTIFY=OFF -DUSE_LIBHYPHEN=OFF \
#			${webkitgtk_org_src_dir}) || return
#	make -C ${webkitgtk_bld_dir_ntv} -j ${jobs} || return
#	make -C ${webkitgtk_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return
#}

install_native_emacs()
{
	[ -x ${prefix}/bin/emacs -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header png.h > /dev/null || install_native_libpng || return
	search_header tiff.h > /dev/null || install_native_libtiff || return
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return
	search_header gif_lib.h > /dev/null || install_native_giflib || return
	search_header xpm.h X11 > /dev/null || install_native_libXpm || return
	fetch emacs || return
	unpack ${emacs_org_src_dir} || return
	[ -f ${emacs_org_src_dir}/Makefile ] ||
		(cd ${emacs_org_src_dir}
		CPPFLAGS="${CPPFLAGS} -I${prefix}/include" LDFLAGS="${LDFLAGS} -L${prefix}/lib" \
			./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--with-modules --with-xwidgets) || return
	make -C ${emacs_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${emacs_org_src_dir} -j ${jobs} -k check || return
	make -C ${emacs_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_libiconv()
{
	[ -x ${prefix}/bin/iconv -a "${force_install}" != yes ] && return
	fetch libiconv || return
	unpack ${libiconv_org_src_dir} || return
	[ -f ${libiconv_org_src_dir}/Makefile ] ||
		(cd ${libiconv_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${libiconv_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libiconv_org_src_dir} -j ${jobs} -k check || return
	make -C ${libiconv_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_vim()
{
	[ -x ${prefix}/bin/vim -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	which gettext > /dev/null || install_native_gettext || return
	search_header lua.h > /dev/null || install_native_lua || return
	which perl > /dev/null || install_native_perl || return
	search_header Python.h > /dev/null || install_native_python || return
	search_library tclConfig.sh > /dev/null || install_native_tcl || return
	search_header ruby.h > /dev/null || install_native_ruby || return
	fetch vim || return
	unpack ${vim_org_src_dir} || return
	(cd ${vim_org_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--with-features=huge --enable-fail-if-missing \
		--enable-luainterp=dynamic --with-lua-prefix=`get_prefix lua.h` \
		--enable-perlinterp=dynamic \
		--enable-python3interp=dynamic \
		--enable-tclinterp=dynamic \
		--enable-rubyinterp=dynamic \
		--enable-cscope --enable-multibyte \
		--enable-gui=gnome2 --enable-xim --enable-fontset \
#		+footer \
#		+mouse_jsbterm \
#		+mouse_gpm \
#		+xterm_save \
	) || return
	make -C ${vim_org_src_dir} -j ${jobs} || return
	make -C ${vim_org_src_dir} -j ${jobs} install || return
	fetch vimdoc-ja || return
	[ -d ${vimdoc_ja_org_src_dir} ] ||
		(unpack ${vimdoc_ja_org_src_dir} &&
		mv -v ${vimdoc_ja_src_base}/vimdoc-ja-master ${vimdoc_ja_org_src_dir}) || return
	mkdir -pv ${prefix}/share/vim/vimfiles || return
	cp -rvt ${prefix}/share/vim/vimfiles ${vimdoc_ja_org_src_dir}/* || return
	vim -i NONE -u NONE -N -c "helptags ${prefix}/share/vim/vimfiles/doc" -c qall || return
}

install_native_ctags()
{
	[ -x ${prefix}/bin/ctags -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	fetch ctags || return
	unpack ${ctags_org_src_dir} || return
	[ -f ${ctags_org_src_dir}/configure ] ||
		(cd ${ctags_org_src_dir}
		PATH=/usr/bin:${PATH} ./autogen.sh) || return # modifying PATH is workaround for autoconf; force to use /usr/bin/autoconf
	[ -f ${ctags_org_src_dir}/Makefile ] ||
		(cd ${ctags_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${ctags_org_src_dir} -j ${jobs} || return
	make -C ${ctags_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_dein()
{
	[ -f ${prefix}/src/vim/installer.sh ] ||
		(mkdir -pv ${prefix}/src/vim || return
		wget --no-check-certificate -O ${prefix}/src/vim/installer.sh \
			https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh) || return
	[ `whoami` != root ] || ! echo Error. run as root is not recommended. >&2 || return
	sh ${prefix}/src/vim/installer.sh ${HOME}/.vim || return
}

install_native_grep()
{
	[ -x ${prefix}/bin/grep -a "${force_install}" != yes ] && return
	search_header pcre.h > /dev/null || install_native_pcre || return
	fetch grep || return
	unpack ${grep_org_src_dir} || return
	[ -f ${grep_org_src_dir}/Makefile ] ||
		(cd ${grep_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${grep_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${grep_org_src_dir} -j ${jobs} -k check || return
	make -C ${grep_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_global()
{
	[ -x ${prefix}/bin/global -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	fetch global || return
	unpack ${global_org_src_dir} || return
	[ -f ${global_org_src_dir}/Makefile ] ||
		(cd ${global_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--with-ncurses=`get_prefix curses.h` CPPFLAGS="${CPPFLAGS} -I`get_include_path curses.h`") || return
	make -C ${global_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${global_org_src_dir} -j ${jobs} -k check || return
	make -C ${global_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_pcre()
{
	[ -f ${prefix}/include/pcre.h -a "${force_install}" != yes ] && return
	fetch pcre || return
	unpack ${pcre_org_src_dir} || return
	[ -f ${pcre_org_src_dir}/Makefile ] ||
		(cd ${pcre_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-pcre16 --enable-pcre32 --enable-jit --enable-utf --enable-unicode-properties \
			--enable-newline-is-any --enable-pcregrep-libz --enable-pcregrep-libbz2 \
			--enable-pcretest-libreadline) || return
	make -C ${pcre_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pcre_org_src_dir} -j ${jobs} -k check || return
	make -C ${pcre_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_pcre2()
{
	[ -f ${prefix}/include/pcre2.h -a "${force_install}" != yes ] && return
	fetch pcre2 || return
	unpack ${pcre2_org_src_dir} || return
	[ -f ${pcre2_org_src_dir}/Makefile ] ||
		(cd ${pcre2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${pcre2_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pcre2_org_src_dir} -j ${jobs} -k check || return
	make -C ${pcre2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_the_silver_searcher()
{
	[ -x ${prefix}/bin/ag -a "${force_install}" != yes ] && return
	search_header pcre.h > /dev/null || install_native_pcre || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header lzma.h > /dev/null || install_native_xz || return
	fetch the_silver_searcher || return
	unpack ${the_silver_searcher_org_src_dir} || return
	[ -f ${the_silver_searcher_org_src_dir}/Makefile ] ||
		(cd ${the_silver_searcher_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			PCRE_CFLAGS=-I`get_include_path pcre.h` PCRE_LIBS="-L`get_library_path libpcre.so` -lpcre" \
			LZMA_CFLAGS=-I`get_include_path lzma.h` LZMA_LIBS="-L`get_library_path liblzma.so` -llzma") || return
	make -C ${the_silver_searcher_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${the_silver_searcher_org_src_dir} -j ${jobs} -k check || return
	make -C ${the_silver_searcher_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_the_platinum_searcher()
{
	[ -x ${prefix}/bin/pt -a "${force_install}" != yes ] && return
	which go > /dev/null || install_native_go || return
	fetch the_platinum_searcher || return
	unpack ${the_platinum_searcher_org_src_dir} || return
	(cd ${the_platinum_searcher_org_src_dir}
	go get ./...) || return
}

install_native_highway()
{
	[ -x ${prefix}/bin/hw -a "${force_install}" != yes ] && return
	which gperf > /dev/null || install_native_gperf || return
	which autoconf > /dev/null || install_native_autoconf || return
	which automake > /dev/null || install_native_automake || return
	fetch highway || return
	unpack ${highway_org_src_dir} || return
	sed -ie "s%^\./configure %&--prefix=${prefix}%;
				s/^make\$/& -j ${jobs} \&\& make -j ${jobs} install${strip:+-${strip}}/" \
				${highway_org_src_dir}/tools/build.sh || return
	(cd ${highway_org_src_dir}
	./tools/build.sh) || return
}

install_native_graphviz()
{
	[ -x ${prefix}/bin/dot -a "${force_install}" != yes ] && return
	which swig > /dev/null || install_native_swig || return
	fetch graphviz || return
	unpack ${graphviz_org_src_dir} || return
	[ -f ${graphviz_org_src_dir}/Makefile ] ||
		(cd ${graphviz_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-swig --enable-go --enable-perl --enable-python \
			--enable-ruby ) || return
	make -C ${graphviz_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${graphviz_org_src_dir} -j ${jobs} -k check || return
	make -C ${graphviz_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_doxygen()
{
	[ -x ${prefix}/bin/doxygen -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which clang > /dev/null || install_native_cfe || return
	fetch doxygen || return
	unpack ${doxygen_org_src_dir} || return
	mkdir -pv ${doxygen_bld_dir_ntv} || return
	[ -f ${doxygen_bld_dir_ntv}/Makefile ] ||
		(cd ${doxygen_bld_dir_ntv}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-Dbuild_doc=ON -Duse_libclang=ON ${doxygen_org_src_dir}) || return # [TODO] Xapian入れられたら、build_search=ONにする・・・かも。
	make -C ${doxygen_bld_dir_ntv} -j ${jobs} || return
#	make -C ${doxygen_bld_dir_ntv} -j ${jobs} docs || return
	[ "${enable_check}" != yes ] ||
		make -C ${doxygen_bld_dir_ntv} -j ${jobs} -k tests || return
	make -C ${doxygen_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_diffutils()
{
	[ -x ${prefix}/bin/diff -a "${force_install}" != yes ] && return
	fetch diffutils || return
	unpack ${diffutils_org_src_dir} || return
	[ -f ${diffutils_org_src_dir}/Makefile ] ||
		(cd ${diffutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${diffutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${diffutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${diffutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_patch()
{
	[ -x ${prefix}/bin/patch -a "${force_install}" != yes ] && return
	fetch patch || return
	unpack ${patch_org_src_dir} || return
	[ -f ${patch_org_src_dir}/Makefile ] ||
		(cd ${patch_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${patch_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${patch_org_src_dir} -j ${jobs} -k check || return
	make -C ${patch_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_findutils()
{
	[ -x ${prefix}/bin/find -a "${force_install}" != yes ] && return
	fetch findutils || return
	unpack ${findutils_org_src_dir} || return
	[ -f ${findutils_org_src_dir}/Makefile ] ||
		(cd ${findutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${findutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${findutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${findutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_screen()
{
	[ -x ${prefix}/bin/screen -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	fetch screen || return
	unpack ${screen_org_src_dir} || return
	[ -f ${screen_org_src_dir}/Makefile ] ||
		(cd ${screen_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-telnet --enable-colors256 --enable-rxvt_osc) || return
	make -C ${screen_org_src_dir} -j ${jobs} || return
	mkdir -pv ${prefix}/share/screen/utf8encodings || return
	make -C ${screen_org_src_dir} -j ${jobs} install || return
}

install_native_libevent()
{
	[ -f ${prefix}/include/event2/event.h -a "${force_install}" != yes ] && return
	fetch libevent || return
	unpack ${libevent_org_src_dir}-stable || return
	[ -f ${libevent_org_src_dir}-stable/Makefile ] ||
		(cd ${libevent_org_src_dir}-stable
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libevent_org_src_dir}-stable -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libevent_org_src_dir}-stable -j ${jobs} -k check || return
	make -C ${libevent_org_src_dir}-stable -j ${jobs} install || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_tmux()
{
	[ -x ${prefix}/bin/tmux -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_header event.h event2 > /dev/null || install_native_libevent || return
	fetch tmux || return
	unpack ${tmux_org_src_dir} || return
	[ -f ${tmux_org_src_dir}/Makefile ] ||
		(cd ${tmux_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			CPPFLAGS="${CPPFLAGS} -I`get_include_path curses.h`") || return
	make -C ${tmux_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tmux_org_src_dir} -j ${jobs} -k check || return
	make -C ${tmux_org_src_dir} -j ${jobs} install || return
}

install_native_expect()
{
	[ -x ${prefix}/bin/expect -a "${force_install}" != yes ] && return
	search_library tclConfig.sh > /dev/null || install_native_tcl || return
	fetch expect || return
	unpack ${expect_org_src_dir} || return
	[ -f ${expect_org_src_dir}/Makefile ] ||
		(cd ${expect_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-threads \
			--enable-64bit --with-tcl=`get_library_path tclConfig.sh`) || return
	make -C ${expect_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${expect_org_src_dir} -j ${jobs} -k check || return
	make -C ${expect_org_src_dir} -j ${jobs} install || return
	ln -fsv ./${expect_name}/lib${expect_name}.so ${prefix}/lib || return
}

install_native_dejagnu()
{
	[ -x ${prefix}/bin/runtest -a "${force_install}" != yes ] && return
	which expect > /dev/null || install_native_expect || return
	fetch dejagnu || return
	unpack ${dejagnu_org_src_dir} || return
	[ -f ${dejagnu_org_src_dir}/Makefile ] ||
		(cd ${dejagnu_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${dejagnu_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${dejagnu_org_src_dir} -j ${jobs} -k check || return
	make -C ${dejagnu_org_src_dir} -j ${jobs} install || return
}

install_native_zsh()
{
	[ -x ${prefix}/bin/zsh -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	fetch zsh || return
	unpack ${zsh_org_src_dir} || return
	[ -f ${zsh_org_src_dir}/Makefile ] ||
		(cd ${zsh_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${zsh_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${zsh_org_src_dir} -j ${jobs} -k check || return
	make -C ${zsh_org_src_dir} -j ${jobs} install || return
}

install_native_bash()
{
	[ -x ${prefix}/bin/bash -a "${force_install}" != yes ] && return
	fetch bash || return
	unpack ${bash_org_src_dir} || return
	[ -f ${bash_org_src_dir}/Makefile ] ||
		(cd ${bash_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${bash_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${bash_org_src_dir} -j ${jobs} -k check || return
	make -C ${bash_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
	ln -fsv bash ${prefix}/bin/sh || return
}

install_native_inetutils()
{
	[ -x ${prefix}/bin/telnet -a "${force_install}" != yes ] && return
	fetch inetutils || return
	unpack ${inetutils_org_src_dir} || return
	[ -f ${inetutils_org_src_dir}/Makefile ] ||
		(cd ${inetutils_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${inetutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${inetutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${inetutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_openssl()
{
	[ -d ${prefix}/include/openssl -a "${force_install}" != yes ] && return
	fetch openssl || return
	unpack ${openssl_org_src_dir} || return
	(cd ${openssl_org_src_dir}
	./config --prefix=${prefix} shared) || return
	make -C ${openssl_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${openssl_org_src_dir} -j ${jobs} -k test || return
	make -C ${openssl_org_src_dir} -j ${jobs} install || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_openssh()
{
	[ -x ${prefix}/bin/ssh -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	fetch openssh || return
	unpack ${openssh_org_src_dir} || return
	[ -f ${openssh_org_src_dir}/Makefile ] ||
		(cd ${openssh_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${openssh_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${openssh_org_src_dir} -j ${jobs} -k tests || return
	make -C ${openssh_org_src_dir} -j ${jobs} install || return
}

install_native_curl()
{
	[ -x ${prefix}/bin/curl -a "${force_install}" != yes ] && return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	fetch curl || return
	unpack ${curl_org_src_dir} || return
	(cd ${curl_org_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--enable-optimize --disable-silent-rules \
		--enable-http --enable-ftp --enable-file \
		--enable-ldap --enable-ldaps --enable-rtsp --enable-proxy \
		--enable-dict --enable-telnet --enable-tftp --enable-pop3 \
		--enable-imap --enable-smb --enable-smtp --enable-gopher \
		--enable-manual --enable-ipv6 --with-ssl) || return
	make -C ${curl_org_src_dir} -j ${jobs} || return
	make -C ${curl_org_src_dir} -j ${jobs} install || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_expat()
{
	[ -f ${prefix}/include/expat.h -a "${force_install}" != yes ] && return
	fetch expat || return
	unpack ${expat_org_src_dir} || return
	[ -f ${expat_org_src_dir}/Makefile ] ||
		(cd ${expat_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${expat_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${expat_org_src_dir} -j ${jobs} -k check || return
	make -C ${expat_org_src_dir} -j ${jobs} install || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_asciidoc()
{
	[ -x ${prefix}/bin/asciidoc -a "${force_install}" != yes ] && return
	fetch asciidoc || return
	unpack ${asciidoc_org_src_dir} || return
	[ -f ${asciidoc_org_src_dir}/Makefile ] ||
		(cd ${asciidoc_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${asciidoc_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${asciidoc_org_src_dir} -j ${jobs} -k test || return
	make -C ${asciidoc_org_src_dir} -j ${jobs} install || return
}

install_native_libxml2()
{
	[ -d ${prefix}/include/libxml2 -a "${force_install}" != yes ] && return
	search_header Python.h > /dev/null || install_native_python || return
	fetch libxml2 || return
	unpack ${libxml2_org_src_dir} || return
	[ -f ${libxml2_org_src_dir}/Makefile ] ||
		(cd ${libxml2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--without-python --disable-silent-rules) || return
	make -C ${libxml2_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libxml2_org_src_dir} -j ${jobs} -k check || return
	make -C ${libxml2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
	update_pkg_config_path || return
}

install_native_libxslt()
{
	[ -d ${prefix}/include/libxslt -a "${force_install}" != yes ] && return
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	fetch libxslt || return
	unpack ${libxslt_org_src_dir} || return
	[ -f ${libxslt_org_src_dir}/Makefile ] ||
		(cd ${libxslt_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libxslt_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libxslt_org_src_dir} -j ${jobs} -k check || return
	make -C ${libxslt_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_xmlto()
{
	[ -x ${prefix}/bin/xmlto -a "${force_install}" != yes ] && return
	search_header xslt.h libxslt > /dev/null || install_native_libxslt || return
	fetch xmlto || return
	unpack ${xmlto_org_src_dir} || return
	[ -f ${xmlto_org_src_dir}/Makefile ] ||
		(cd ${xmlto_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${xmlto_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${xmlto_org_src_dir} -j ${jobs} -k check || return
	make -C ${xmlto_org_src_dir} -j ${jobs} install || return
}

install_native_gettext()
{
	[ -x ${prefix}/bin/gettext -a "${force_install}" != yes ] && return
	fetch gettext || return
	unpack ${gettext_org_src_dir} || return
	[ -f ${gettext_org_src_dir}/Makefile ] ||
		(cd ${gettext_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${gettext_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gettext_org_src_dir} -j ${jobs} -k check || return
	make -C ${gettext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_library_search_path || return
}

install_native_git()
{
	[ -x ${prefix}/bin/git -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	search_header curl.h curl > /dev/null || install_native_curl || return
	search_header expat.h > /dev/null || install_native_expat || return
	which asciidoc > /dev/null || install_native_asciidoc || return
	which xmlto > /dev/null || install_native_xmlto || install_native_git_manpages || return
	which msgfmt > /dev/null || install_native_gettext || return
	which perl > /dev/null || install_native_perl || return
	which wish > /dev/null || install_native_tk || return
	fetch git || return
	unpack ${git_org_src_dir} || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 configure || return
	(cd ${git_org_src_dir}
	./configure --prefix=${prefix} --build=${build}) || return
	sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_org_src_dir}/Makefile || return
	make -C ${git_org_src_dir} -j 1       V=1 LDFLAGS="${LDFLAGS} -ldl" all || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 doc || install_native_git_manpages || return
	[ "${enable_check}" != yes ] ||
		make -C ${git_org_src_dir} -j ${jobs} V=1 -k test || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 ${strip} install || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 ${strip} install-doc install-html || true # git-manpagesでfallbackするのでmake install-docの失敗はシェル関数の失敗ではない。
}

install_native_git_manpages()
{
	[ -f ${prefix}/share/man/man1/git.1 -a "${force_install}" != yes ] && return
	fetch git-manpages || return
	unpack ${git_manpages_org_src_dir} ${prefix}/share/man || return
}

install_native_mercurial()
{
	[ -x ${prefix}/bin/hg -a "${force_install}" != yes ] && return
	which python > /dev/null || install_native_python || return
	fetch mercurial || return
	unpack ${mercurial_org_src_dir} || return
	pip install docutils || return
	make -C ${mercurial_org_src_dir} -j ${jobs} PYTHON=python all || return
	[ "${enable_check}" != yes ] ||
		make -C ${mercurial_org_src_dir} -j ${jobs} PYTHON=python -k check || return
	make -C ${mercurial_org_src_dir} -j ${jobs} PREFIX=${prefix} install || return
}

install_native_sqlite()
{
	[ -f ${prefix}/include/sqlite3.h -a "${force_install}" != yes ] && return
	fetch sqlite-autoconf || return
	unpack ${sqlite_autoconf_org_src_dir} || return
	[ -f ${sqlite_autoconf_org_src_dir}/Makefile ] ||
		(cd ${sqlite_autoconf_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${sqlite_autoconf_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${sqlite_autoconf_org_src_dir} -j ${jobs} -k check || return
	make -C ${sqlite_autoconf_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_apr()
{
	[ -d ${prefix}/include/apr-1 -a "${force_install}" != yes ] && return
	fetch apr || return
	unpack ${apr_org_src_dir} || return
	[ -f ${apr_org_src_dir}/Makefile ] ||
		(cd ${apr_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-threads --enable-posix-shm --enable-other-child) || return
	make -C ${apr_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${apr_org_src_dir} -j ${jobs} -k check || return
	make -C ${apr_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_apr_util()
{
	[ -f ${prefix}/include/apr-1/apu.h -a "${force_install}" != yes ] && return
	search_header apr.h apr-1 > /dev/null || install_native_apr || return
	search_header sqlite3.h > /dev/null || install_native_sqlite || return
	fetch apr-util || return
	unpack ${apr_util_org_src_dir} || return
	[ -f ${apr_util_org_src_dir}/Makefile ] ||
		(cd ${apr_util_org_src_dir}
		./configure --prefix=${prefix} --with-apr=`get_prefix apr.h apr-1` \
			--with-crypto --with-openssl --with-sqlite3=`get_prefix sqlite3.h`) || return
	make -C ${apr_util_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${apr_util_org_src_dir} -j ${jobs} -k check || return
	make -C ${apr_util_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_subversion()
{
	[ -x ${prefix}/bin/svn -a "${force_install}" != yes ] && return
	search_header apr.h apr-1 > /dev/null || install_native_apr || return
	search_header apu.h apr-1 > /dev/null || install_native_apr_util || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	which python3 > /dev/null || install_native_python || return
	which perl > /dev/null || install_native_perl || return
	which ruby > /dev/null || install_native_ruby || return
	fetch subversion || return
	unpack ${subversion_org_src_dir} || return
	[ -f ${subversion_org_src_dir}/Makefile ] ||
		(cd ${subversion_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --with-zlib=`get_prefix zlib.h` \
			--with-sqlite=`get_prefix sqlite3.h` \
			${strip:+--enable-optimize}) || return
	make -C ${subversion_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${subversion_org_src_dir} -j ${jobs} -k check || return
	make -C ${subversion_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_cmake()
{
	[ -x ${prefix}/bin/cmake -a "${force_install}" != yes ] && return
	search_header curl.h curl > /dev/null || install_native_curl || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header bzlib.h > /dev/null || install_native_bzip2 || return
	search_header lzma.h > /dev/null || install_native_xz || return
	fetch cmake || return
	unpack ${cmake_org_src_dir} || return
	[ -f ${cmake_org_src_dir}/Makefile ] ||
		(cd ${cmake_org_src_dir}
		./bootstrap --prefix=${prefix} --parallel=${jobs} \
			--system-curl --system-zlib --system-bzip2 --system-liblzma -- \
			-DCURL_INCLUDE_DIR=`get_include_path curl.h curl` -DCURL_LIBRARY=`search_library libcurl.so` \
			-DBZIP2_INCLUDE_DIR=`get_include_path bzlib.h` -DBZIP2_LIBRARIES=`search_library libbz2.so` \
			-DLIBLZMA_INCLUDE_DIR=`get_include_path lzma.h` -DLIBLZMA_LIBRARY=`search_library liblzma.so`) || return
	make -C ${cmake_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cmake_org_src_dir} -j ${jobs} -k test || return
	make -C ${cmake_org_src_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_libedit()
{
	[ -f ${prefix}/include/histedit.h -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	fetch libedit || return
	unpack ${libedit_org_src_dir} || return
	[ -f ${libedit_org_src_dir}/Makefile ] ||
		(cd ${libedit_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules CFLAGS="${CFLAGS} -I`get_include_path curses.h` -I`get_include_path ncurses_dll.h ncurses`") || return
	make -C ${libedit_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libedit_org_src_dir} -j ${jobs} -k check || return
	make -C ${libedit_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_swig()
{
	[ -x ${prefix}/bin/swig -a "${force_install}" != yes ] && return
	search_header pcre.h > /dev/null || install_native_pcre || return
	fetch swig || return
	unpack ${swig_org_src_dir} || return
	[ -f ${swig_org_src_dir}/Makefile ] ||
		(cd ${swig_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-cpp11-testing) || return
	make -C ${swig_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${swig_org_src_dir} -j ${jobs} -k check || return
	make -C ${swig_org_src_dir} -j ${jobs} install || return
}

install_native_llvm()
{
	[ -d ${prefix}/include/llvm -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} || return
	[ -x ${prefix}/bin/lld ] || place_llvm_tools lld || return
	mkdir -pv ${llvm_bld_dir} || return
	[ -f ${llvm_bld_dir}/Makefile ] ||
		(cd ${llvm_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DLLVM_LINK_LLVM_DYLIB=ON ${llvm_org_src_dir}) || return
	make -C ${llvm_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${llvm_bld_dir} -j ${jobs} -k check || return
	make -C ${llvm_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_libcxx()
{
	[ -e ${prefix}/lib/libc++.so -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch libcxx || return
	unpack ${libcxx_org_src_dir} || return
	mkdir -pv ${libcxx_bld_dir} || return
	[ -f ${libcxx_bld_dir}/Makefile ] ||
		(cd ${libcxx_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DLLVM_LINK_LLVM_DYLIB=ON ${libcxx_org_src_dir}) || return
	make -C ${libcxx_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libcxx_bld_dir} -j ${jobs} -k check-libcxx || return
	make -C ${libcxx_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_libcxxabi()
{
	[ -e ${prefix}/lib/libc++abi.so -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	search_header iostream c++/v1 > /dev/null || install_native_libcxx || return
	fetch libcxxabi || return
	unpack ${libcxxabi_org_src_dir} || return
	sed -ie '/set(LLVM_CMAKE_PATH /s%share/llvm/cmake%lib/cmake/llvm%' ${libcxxabi_org_src_dir}/CMakeLists.txt || return # [XXX] workaround for LLVM 3.9.0
	mkdir -pv ${libcxxabi_bld_dir} || return
	[ -f ${libcxxabi_bld_dir}/Makefile ] ||
		(cd ${libcxxabi_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${libcxxabi_org_src_dir}) || return
	make -C ${libcxxabi_bld_dir} -j ${jobs} || return
	make -C ${libcxxabi_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_compiler_rt()
{
	[ -d ${prefix}/include/sanitizer -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	fetch compiler-rt || return
	unpack ${compiler_rt_org_src_dir} || return
	mkdir -pv ${compiler_rt_bld_dir} || return
	[ -f ${compiler_rt_bld_dir}/Makefile ] ||
		(cd ${compiler_rt_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${compiler_rt_org_src_dir}) || return
	make -C ${compiler_rt_bld_dir} -j ${jobs} || return
	make -C ${compiler_rt_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_cfe()
{
	[ -x ${prefix}/bin/clang -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	search_header iostream c++/v1 > /dev/null || install_native_libcxx || return
	search_header ABI.h clang/Basic > /dev/null || install_native_libcxxabi || return
	search_header allocator_interface.h sanitizer > /dev/null || install_native_compiler_rt || return
	fetch cfe || return
	unpack ${cfe_org_src_dir} || return
	mkdir -pv ${cfe_bld_dir} || return
	[ -f ${cfe_bld_dir}/Makefile ] ||
		(cd ${cfe_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DENABLE_LINKER_BUILD_ID=ON \
			-DGCC_INSTALL_PREFIX=`get_prefix iostream c++/\`gcc -dumpversion\`` \
			${cfe_org_src_dir}) || return
	make -C ${cfe_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cfe_bld_dir} -j ${jobs} -k check-all || return
	make -C ${cfe_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_clang_tools_extra()
{
	[ -x ${prefix}/bin/clang-tidy -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} || return
	fetch cfe || return
	[ -d ${llvm_org_src_dir}/tools/clang ] ||
		(unpack ${cfe_org_src_dir} &&
		mv -v ${cfe_org_src_dir} ${llvm_org_src_dir}/tools/clang) || return
	fetch clang-tools-extra || return
	[ -d ${llvm_org_src_dir}/tools/clang/tools/extra ] ||
		(unpack ${clang_tools_extra_org_src_dir} &&
		mv -v ${clang_tools_extra_org_src_dir} ${llvm_org_src_dir}/tools/clang/tools/extra) || return
	mkdir -pv ${clang_tools_extra_bld_dir} || return
	[ -f ${clang_tools_extra_bld_dir}/Makefile ] ||
		(cd ${clang_tools_extra_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${llvm_org_src_dir}) || return
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} || return
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

place_llvm_tools()
{
	fetch ${1} || return
	[ -d ${llvm_org_src_dir}/tools/${1} ] ||
		(eval unpack \${${1}_org_src_dir} &&
		eval mv -v \${${1}_org_src_dir} ${llvm_org_src_dir}/tools/${1}) || return
}

install_native_lld()
{
	[ -x ${prefix}/bin/lld -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} || return
	place_llvm_tools lld || return
	mkdir -pv ${lld_bld_dir} || return
	[ -f ${lld_bld_dir}/Makefile ] ||
		(cd ${lld_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DLLVM_LINK_LLVM_DYLIB=ON ${llvm_org_src_dir}) || return
	make -C ${lld_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lld_bld_dir} -j ${jobs} -k check || return
	make -C ${lld_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_lldb()
{
	[ -x ${prefix}/bin/lldb -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header curses.h > /dev/null || install_native_ncurses || return
	search_header histedit.h > /dev/null || install_native_libedit || return
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	which swig > /dev/null || install_native_swig || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} || return
	place_llvm_tools lldb || return
	mkdir -pv ${lldb_bld_dir} || return
	[ -f ${lldb_bld_dir}/Makefile ] ||
		(cd ${lldb_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DLLVM_LINK_LLVM_DYLIB=ON \
			-DCMAKE_C_FLAGS="${CFLAGS} -I`get_include_path Version.h clang/Basic`" \
			-DCMAKE_CXX_FLAGS="${CXXFLAGS} -I`get_include_path curses.h` -I`get_include_path ncurses_dll.h ncurses` -I`get_include_path histedit.h`" \
			${llvm_org_src_dir}) || return
	make -C ${lldb_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lldb_bld_dir} -j ${jobs} -k check || return
	make -C ${lldb_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_cling()
{
	[ -x ${prefix}/bin/cling -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	fetch cling || return
	mkdir -pv ${cling_bld_dir_ntv} || return
	[ -f ${cling_bld_dir_ntv}/Makefile ] ||
		(cd ${cling_bld_dir_ntv}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix}/cling \
			-DENABLE_LINKER_BUILD_ID=ON ${cling_org_src_dir}) || return
	make -C ${cling_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cling_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${cling_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_boost()
{
	[ -d ${prefix}/include/boost -a "${force_install}" != yes ] && return
	search_header bzlib.h > /dev/null || install_native_bzip2 || return
	fetch boost || return
	unpack ${boost_org_src_dir} || return
	(cd ${boost_org_src_dir}
	./bootstrap.sh --prefix=${prefix} --with-toolset=gcc &&
	./b2 --prefix=${prefix} --build-dir=${boost_bld_dir_ntv} \
		--layout=system --build-type=minimal -j ${jobs} -q \
		include=${prefix}/include library-path=${prefix}/lib install) || return
}

install_cross_binutils()
{
	[ -x ${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	which yacc > /dev/null || install_native_bison || return
	fetch binutils || return
	[ -d ${binutils_src_dir_crs} ] ||
		(unpack ${binutils_org_src_dir} &&
			mv -v ${binutils_org_src_dir} ${binutils_src_dir_crs}) || return
	[ -f ${binutils_src_dir_crs}/Makefile ] ||
		(cd ${binutils_src_dir_crs}
		./configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-sysroot=${sysroot} --enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return
	make -C ${binutils_src_dir_crs} -j 1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${binutils_src_dir_crs} -j 1 -k check || return
	make -C ${binutils_src_dir_crs} -j 1 install${strip:+-${strip}} || return
}

install_cross_gcc_without_headers()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	which ${target}-as > /dev/null || install_cross_binutils || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	search_header version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} || return
	mkdir -pv ${gcc_bld_dir_crs_1st} || return
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--with-isl=`get_prefix version.h isl` --with-system-zlib --enable-languages=c --disable-multilib \
			--program-prefix=${target}- --program-suffix=-${gcc_ver} --enable-version-specific-runtime-libs \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv) || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_1st} -j ${jobs} -k check-gcc || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return
	[ ${target} = x86_64-w64-mingw32 ] && return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-target-libgcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_1st} -j ${jobs} -k check-target-libgcc || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-target-libgcc || return
	for b in cpp gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-dump gcov-tool; do
		[ ! -f ${prefix}/bin/${target}-${b}-${gcc_ver} ] || ln -fsv ${target}-${b}-${gcc_ver} ${prefix}/bin/${target}-${b} || return
	done
}

install_cross_linux_header()
{
	[ -d ${sysroot}/usr/include/linux -a "${force_install}" != yes ] && return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	fetch linux || return
	[ -d ${linux_src_dir_crs} ] ||
		(unpack ${linux_org_src_dir} &&
			mv -v ${linux_org_src_dir} ${linux_src_dir_crs}) || return
	make -C ${linux_src_dir_crs} -j ${jobs} V=1 mrproper || return
	make -C ${linux_src_dir_crs} -j ${jobs} V=1 \
		ARCH=${cross_linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return
}

install_cross_glibc()
{
	[ -f ${sysroot}/usr/include/stdio.h -a "${force_install}" != yes ] && return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	which awk > /dev/null || install_native_gawk || return
	which gperf > /dev/null || install_native_gperf || return
	fetch glibc || return
	[ -d ${glibc_src_dir_crs_1st} ] ||
		(unpack ${glibc_org_src_dir} &&
			mv -v ${glibc_org_src_dir} ${glibc_src_dir_crs_1st}) || return

	[ ${cross_linux_arch} != microblaze ] ||
		patch -N -p0 -d ${glibc_src_dir_crs_1st} <<EOF || [ $? = 1 ] || return
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

	mkdir -pv ${glibc_bld_dir_crs_1st} || return
	[ -f ${glibc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${glibc_bld_dir_crs_1st}
		${glibc_src_dir_crs_1st}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include CFLAGS="${CFLAGS} -Wno-error=parentheses -O2" \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install-headers || return
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} AR=${target}-ar || return
	[ "${enable_check}" != yes ] ||
		make -C ${glibc_bld_dir_crs_1st} -j ${jobs} -k check || return
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_cross_newlib()
{
	[ -f ${sysroot}/usr/include/stdio.h -a "${force_install}" != yes ] && return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	fetch newlib || return
	[ -d ${newlib_src_dir_crs_hdr} ] ||
		(unpack ${newlib_org_src_dir} &&
			mv -v ${newlib_org_src_dir} ${newlib_src_dir_crs_hdr}) || return
	mkdir -pv ${newlib_bld_dir_crs_hdr} || return
	[ -f ${newlib_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${newlib_bld_dir_crs_hdr}
		${newlib_src_dir_crs_hdr}/configure --prefix=/ --build=${build} --target=${target}) || return
	make -C ${newlib_bld_dir_crs_hdr} -j 1 || return
	make -C ${newlib_bld_dir_crs_hdr} -j 1 DESTDIR=${sysroot} install || return
	mv -v ${sysroot}/${target} ${sysroot}/usr || return
}

install_mingw_w64_header()
{
	fetch mingw-w64 || return
	[ -d ${mingw_w64_src_dir_crs_hdr} ] ||
		(unpack ${mingw_w64_org_src_dir} &&
			mv -v ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_hdr}) || return
	mkdir -pv ${mingw_w64_bld_dir_crs_hdr} || return
	[ -f ${mingw_w64_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_hdr}
		${mingw_w64_src_dir_crs_hdr}/configure --prefix=${sysroot}/mingw --build=${build} --host=${target} \
			--disable-multilib --without-crt --with-sysroot=${sysroot}) || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} install || return
}

install_mingw_w64_crt()
{
	fetch mingw-w64 || return
	[ -d ${mingw_w64_src_dir_crs_1st} ] ||
		(unpack ${mingw_w64_org_src_dir} &&
			mv -v ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_1st}) || return
	mkdir -pv ${mingw_w64_bld_dir_crs_1st} || return
	[ -f ${mingw_w64_bld_dir_crs_1st}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_1st}
		CFLAGS="${CFLAGS} -I${sysroot}/mingw/include" ${mingw_w64_src_dir_crs_1st}/configure --prefix=${sysroot}/mingw --build=${build} --host=${target} \
			--disable-multilib --without-headers --with-sysroot=${sysroot}) || return
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} install || return
}

install_cross_functional_gcc()
{
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	which ${target}-as > /dev/null || install_cross_binutils || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	search_header version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} || return
	mkdir -pv ${gcc_bld_dir_crs_2nd} || return
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--with-isl=`get_prefix version.h isl` --with-system-zlib --enable-languages=${languages} --disable-multilib \
			--program-prefix=${target}- --program-suffix=-${gcc_ver} --enable-version-specific-runtime-libs \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` \
			--enable-libstdcxx-debug --with-sysroot=${sysroot}) || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} LIBS=-lgcc_s || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k install${strip:+-${strip}} ${strip:+STRIP=${target}-strip} || true # [XXX] install-stripを強行する(現状gotoolsだけ失敗する)ため、-kと|| trueで暫定対応(WA)
	for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool; do
		[ ! -f ${prefix}/bin/${target}-${b}-${gcc_ver} ] || ln -fsv ${target}-${b}-${gcc_ver} ${prefix}/bin/${target}-${b} || return
	done
}

install_cross_gcc()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	install_cross_gcc_without_headers || return
	case ${target} in
	x86_64-w64-mingw32)
           install_mingw_w64_header || return
           install_mingw_w64_crt || return;;
	*-elf) install_cross_newlib || return;;
	*)     install_cross_linux_header || return
           install_cross_glibc || return;;
	esac
	install_cross_functional_gcc || return
}

install_cross_gdb()
{
	[ -x ${prefix}/bin/${target}-gdb -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	search_header readline.h readline > /dev/null || install_native_readline || return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_library libpython`python3 --version | grep -oe '[[:digit:]]\.[[:digit:]]'`m.so > /dev/null || install_native_python || return
	fetch gdb || return
	unpack ${gdb_org_src_dir} || return
	mkdir -pv ${gdb_bld_dir_crs} || return
	[ -f ${gdb_bld_dir_crs}/Makefile ] ||
		(cd ${gdb_bld_dir_crs}
		${gdb_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--enable-targets=all --enable-tui --with-python=python3 \
			--with-system-zlib --with-system-readline --with-sysroot=${sysroot}) || return
	make -C ${gdb_bld_dir_crs} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gdb_bld_dir_crs} -j ${jobs} -k check || return
	make -C ${gdb_bld_dir_crs} -j ${jobs} install || return
	make -C ${gdb_bld_dir_crs}/gdb -j ${jobs} install${strip:+-${strip}} || return
	make -C ${gdb_bld_dir_crs}/sim -j ${jobs} install${strip:+-${strip}} || return
}

install_native_python()
{
	[ -x ${prefix}/bin/python3 -a "${force_install}" != yes ] && return
	fetch Python || return
	unpack ${Python_org_src_dir} || return
	[ -f ${Python_org_src_dir}/Makefile ] ||
		(cd ${Python_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-shared --disable-ipv6 \
			--with-universal-archs=all --enable-universalsdk \
			--with-signal-module --with-threads --with-doc-strings \
			--with-tsc --with-pymalloc --with-ensurepip) || return # --enable-ipv6 --with-address-sanitizer --with-system-expat --with-system-ffi
	make -C ${Python_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${Python_org_src_dir} -j ${jobs} -k test || return
	make -C ${Python_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_ruby()
{
	[ -x ${prefix}/bin/ruby -a "${force_install}" != yes ] && return
	fetch ruby || return
	unpack ${ruby_org_src_dir} || return
	[ -f ${ruby_org_src_dir}/Makefile ] ||
		(cd ${ruby_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-multiarch --enable-shared --disable-silent-rules) || return
	make -C ${ruby_org_src_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${ruby_org_src_dir} -j ${jobs} -k V=1 check || return
	make -C ${ruby_org_src_dir} -j ${jobs} V=1 install || return
	update_pkg_config_path || return
}

install_native_go()
{
	[ -x ${prefix}/go/bin/go -a "${force_install}" != yes ] && return
	[ -n "${GOPATH}" ] || ! echo Error. GOPATH not set. >&2 || return
	which git > /dev/null || install_native_git || return
	fetch go || return
	[ -d ${go_org_src_dir} ] || unpack ${go_src_base}/go${go_ver}.src || return
	[ -d ${go_src_base}/go ] && mv -v ${go_src_base}/go ${go_org_src_dir}
	(cd ${go_org_src_dir}/src
	CGO_CPPFLAGS=-I${prefix}/include GOROOT_BOOTSTRAP=`which go | sed -e 's/\/bin\/go//'` \
		GOROOT=${go_org_src_dir} GOROOT_FINAL=${prefix}/go ${go_org_src_dir}/src/make.bash) || return
	[ ! -d ${prefix}/go ] || rm -fvr ${prefix}/go || return
	mv -v ${go_org_src_dir} ${prefix}/go || return
	${prefix}/go/bin/go get golang.org/x/tools/cmd/... || return
}

install_native_perl()
{
	[ -x ${prefix}/bin/perl -a "${force_install}" != yes ] && return
	fetch perl || return
	unpack ${perl_org_src_dir} || return
	[ -f ${perl_org_src_dir}/Makefile ] ||
		(cd ${perl_org_src_dir}
		./Configure -de -Dprefix=${prefix} -Dcc=${CC:-gcc} \
			-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits -Duseshrplib) || return
	make -C ${perl_org_src_dir} -j 1 || return
	make -C ${perl_org_src_dir} -j ${jobs} test || return
	make -C ${perl_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_tcl()
{
	[ -x ${prefix}/bin/tclsh -a "${force_install}" != yes ] && return
	fetch tcl || return
	unpack ${tcl_org_src_dir} || return
	[ -f ${tcl_org_src_dir}/unix/Makefile ] ||
		(cd ${tcl_org_src_dir}/unix
		./configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --enable-64bit --enable-man-symlinks) || return
	make -C ${tcl_org_src_dir}/unix -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tcl_org_src_dir}/unix -j ${jobs} -k test || return
	make -C ${tcl_org_src_dir}/unix -j ${jobs} install || return
	make -C ${tcl_org_src_dir}/unix -j ${jobs} install-private-headers || return
	update_pkg_config_path || return
	ln -fsv tclsh`echo ${tcl_ver} | cut -d. -f-2` ${prefix}/bin/tclsh || return
}

install_native_tk()
{
	[ -x ${prefix}/bin/wish -a "${force_install}" != yes ] && return
	search_library tclConfig.sh > /dev/null || install_native_tcl || return
	fetch tk || return
	unpack ${tk_org_src_dir} || return
	[ -f ${tk_org_src_dir}/unix/Makefile ] ||
		(cd ${tk_org_src_dir}/unix
		./configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --enable-64bit --enable-man-symlinks) || return
	make -C ${tk_org_src_dir}/unix -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tk_org_src_dir}/unix -j ${jobs} -k test || return
	make -C ${tk_org_src_dir}/unix -j ${jobs} install${strip:+-${strip}} || return
	ln -fsv wish`echo ${tk_ver} | cut -d. -f-2` ${prefix}/bin/wish || return
}

install_native_libunistring()
{
	[ -f ${prefix}/include/unistr.h -a "${force_install}" != yes ] && return
	fetch libunistring || return
	unpack ${libunistring_org_src_dir} || return
	[ -f ${libunistring_org_src_dir}/Makefile ] ||
		(cd ${libunistring_org_src_dir}
		./configure --prefix=${prefix} -build=${build} --disable-silent-rules) || return
	make -C ${libunistring_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libunistring_org_src_dir} -j ${jobs} -k check || return
	make -C ${libunistring_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_libatomic_ops()
{
	[ -f ${prefix}/include/atomic_ops.h -a "${force_install}" != yes ] && return
	fetch libatomic_ops || return
	unpack ${libatomic_ops_org_src_dir} || return
	[ -f ${libatomic_ops_org_src_dir}/Makefile ] ||
		(cd ${libatomic_ops_org_src_dir}
		./configure --prefix=${prefix} -build=${build} --disable-silent-rules \
			--enable-shared) || return
	make -C ${libatomic_ops_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libatomic_ops_org_src_dir} -j ${jobs} -k check || return
	make -C ${libatomic_ops_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_gc()
{
	[ -f ${prefix}/include/gc.h -a "${force_install}" != yes ] && return
	search_header atomic_ops.h > /dev/null || install_native_libatomic_ops || return
	fetch gc || return
	unpack ${gc_org_src_dir} || return
	[ -f ${gc_org_src_dir}/Makefile ] ||
		(cd ${gc_org_src_dir}
		./configure --prefix=${prefix} -build=${build} --disable-silent-rules \
			ATOMIC_OPS_CFLAGS=-I`get_include_path atomic_ops.h` \
			ATOMIC_OPS_LIBS=-L`get_library_path libatomic_ops.so`) || return
	make -C ${gc_org_src_dir} -j ${jobs} || return
	make -C ${gc_org_src_dir} -j ${jobs} check || return
	make -C ${gc_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_guile()
{
	[ -x ${prefix}/bin/guile -a "${force_install}" != yes ] && return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header unistr.h > /dev/null || install_native_libunistring || return
	search_header ffi.h > /dev/null || install_native_libffi || return
	search_header gc.h > /dev/null || install_native_gc || return
	fetch guile || return
	unpack ${guile_org_src_dir} || return
	[ -f ${guile_org_src_dir}/Makefile ] ||
		(cd ${guile_org_src_dir}
		./configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --with-libunistring-prefix=`get_prefix unistr.h` \
			LIBFFI_CFLAGS=-I`get_include_path ffi.h` LIBFFI_LIBS="-L`get_library_path libffi.so` -lffi" \
			BDW_GC_CFLAGS="-I`get_include_path gc.h` -DHAVE_GC_SET_FINALIZER_NOTIFIER -DHAVE_GC_GET_HEAP_USAGE_SAFE -DHAVE_GC_GET_FREE_SPACE_DIVISOR -DHAVE_GC_SET_FINALIZE_ON_DEMAND" \
			BDW_GC_LIBS="-L`get_library_path libgc.so` -lgc") || return
	make -C ${guile_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${guile_org_src_dir} -j ${jobs} -k check || return
	make -C ${guile_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_lua()
{
	[ -x ${prefix}/bin/lua -a "${force_install}" != yes ] && return
	fetch lua || return
	unpack ${lua_org_src_dir} || return
	patch -N -p0 -d ${lua_org_src_dir} <<'EOF' || [ $? = 1 ] || return
--- Makefile
+++ Makefile
@@ -41,7 +41,7 @@
 # What to install.
 TO_BIN= lua luac
 TO_INC= lua.h luaconf.h lualib.h lauxlib.h lua.hpp
-TO_LIB= liblua.a
+TO_LIB= liblua.a liblua.so
 TO_MAN= lua.1 luac.1

 # Lua version and release.
--- src/Makefile
+++ src/Makefile
@@ -6,7 +6,7 @@
 # Your platform. See PLATS for possible values.
 PLAT= none

-CC= gcc -std=gnu99
+CC= gcc -std=gnu99 -fPIC
 CFLAGS= -O2 -Wall -Wextra -DLUA_COMPAT_5_2 $(SYSCFLAGS) $(MYCFLAGS)
 LDFLAGS= $(SYSLDFLAGS) $(MYLDFLAGS)
 LIBS= -lm $(SYSLIBS) $(MYLIBS)
@@ -29,6 +29,7 @@
 PLATS= aix bsd c89 freebsd generic linux macosx mingw posix solaris

 LUA_A=	liblua.a
+LUA_SO=	liblua.so
 CORE_O=	lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o \
 	lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o \
 	ltm.o lundump.o lvm.o lzio.o
@@ -43,7 +44,7 @@
 LUAC_O=	luac.o

 ALL_O= $(BASE_O) $(LUA_O) $(LUAC_O)
-ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T)
+ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T) $(LUA_SO)
 ALL_A= $(LUA_A)

 # Targets start here.
@@ -59,6 +60,9 @@
 	$(AR) $@ $(BASE_O)
 	$(RANLIB) $@

+$(LUA_SO): $(BASE_O)
+	$(CC) --shared -o $@ $^
+
 $(LUA_T): $(LUA_O) $(LUA_A)
 	$(CC) -o $@ $(LDFLAGS) $(LUA_O) $(LUA_A) $(LIBS)
EOF
	make -C ${lua_org_src_dir} -j ${jobs} MYLIBS=-lncurses linux || return # XXX linuxにしか対応していない。
	[ "${enable_check}" != yes ] ||
		make -C ${lua_org_src_dir} -j ${jobs} -k test || return
	make -C ${lua_org_src_dir} -j ${jobs} INSTALL_TOP=${prefix} install || return
	mv -v ${prefix}/lib/liblua.so ${prefix}/lib/liblua.so.`echo ${lua_ver} | cut -d. -f-2` || return
	ln -fsv liblua.so.`echo ${lua_ver} | cut -d. -f-2` ${prefix}/lib/liblua.so || return
	update_library_search_path || return
}

install_native_nasm()
{
	[ -x ${prefix}/bin/nasm -a "${force_install}" != yes ] && return
	fetch nasm || return
	unpack ${nasm_org_src_dir} || return
	[ -f ${nasm_org_src_dir}/Makefile ] ||
		(cd ${nasm_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${nasm_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${nasm_org_src_dir} -j ${jobs} -k test || return
	[ -z "${strip}" ] || make -C ${nasm_org_src_dir} -j ${jobs} strip || return
	make -C ${nasm_org_src_dir} -j ${jobs} install || return
}

install_native_yasm()
{
	[ -x ${prefix}/bin/yasm -a "${force_install}" != yes ] && return
	fetch yasm || return
	unpack ${yasm_org_src_dir} || return
	[ -f ${yasm_org_src_dir}/Makefile ] ||
		(cd ${yasm_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${yasm_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${yasm_org_src_dir} -j ${jobs} -k check || return
	make -C ${yasm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_x264()
{
	[ -x ${prefix}/bin/x264 -a "${force_install}" != yes ] && return
	which yasm > /dev/null || install_native_yasm || return
	fetch x264 || return
	[ -d ${x264_org_src_dir} ] ||
		(unpack ${x264_org_src_dir} &&
		mv -v ${x264_src_base}/x264-snapshot-* ${x264_org_src_dir}) || return
	(cd ${x264_org_src_dir}
	./configure --prefix=${prefix} \
		--enable-shared --enable-static \
		${strip:+--enable-strip}) || return
	make -C ${x264_org_src_dir} -j ${jobs} || return
	make -C ${x264_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_x265()
{
	[ -x ${prefix}/bin/x265 -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which yasm > /dev/null || install_native_yasm || return
	fetch x265 || return
	[ -d ${x265_org_src_dir} ] ||
		(unpack ${x265_org_src_dir} &&
		mv -v ${x265_src_base}/x265_${x265_ver} ${x265_org_src_dir}) || return
	(cd ${x265_org_src_dir}/source
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DNATIVE_BUILD=ON) || return
	make -C ${x265_org_src_dir}/source -j ${jobs} || return
	make -C ${x265_org_src_dir}/source -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_libav()
{
	[ -x ${prefix}/bin/avconv -a "${force_install}" != yes ] && return
	which yasm > /dev/null || install_native_yasm || return
	search_header x264.h > /dev/null || install_native_x264 || return
	search_header x265.h > /dev/null || install_native_x265 || return
	fetch libav || return
	[ -d ${libav_org_src_dir} ] ||
		unpack ${libav_org_src_dir} || return
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
	) || return
	make -C ${libav_org_src_dir} -j ${jobs} || return
	make -C ${libav_org_src_dir} -j ${jobs} install || return
}

install_native_opencv()
{
	[ -f ${prefix}/include/opencv2/opencv.hpp -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header png.h > /dev/null || install_native_libpng || return # systemのlibpngだと古くて新規インストール必須かも。
	search_header tiff.h > /dev/null || install_native_libtiff || return
	search_header jpeglib.h > /dev/null || install_native_libjpeg || return # systemのlibjpegだと古くて新規インストール必須かも。
	fetch opencv || return
	unpack ${opencv_org_src_dir} || return
	fetch opencv_contrib || return
	unpack ${opencv_contrib_org_src_dir} || return
	mkdir -pv ${opencv_bld_dir_ntv} || return
	(cd ${opencv_bld_dir_ntv}
	libdirs="-L`get_library_path libpng.so` -L`get_library_path libtiff.so` -L`get_library_path libjpeg.so` -L${prefix}/lib"
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_MODULE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DENABLE_PRECOMPILED_HEADERS=OFF \
		-DOPENCV_EXTRA_MODULES_PATH=${opencv_contrib_org_src_dir}/modules ${opencv_org_src_dir}) || return
	make -C ${opencv_bld_dir_ntv} -j ${jobs} -k || return # make 一発じゃだめっぽいので2回。
	make -C ${opencv_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${opencv_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${opencv_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return
	update_pkg_config_path || return
}

install_native_googletest()
{
	[ -f ${prefix}/include/gtest/gtest.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch googletest || return
	unpack ${googletest_org_src_dir} || return
	mkdir -pv ${googletest_bld_dir_ntv} || return
	(cd ${googletest_bld_dir_ntv}
	cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DBUILD_SHARED_LIBS=ON ${googletest_org_src_dir}/googletest) || return
	make -C ${googletest_bld_dir_ntv} -j ${jobs} || return
	make -C ${googletest_bld_dir_ntv} -j ${jobs} install${strip:+/${strip}} || return
	update_pkg_config_path || return
}

install_crossed_binutils()
{
	[ \( `check_platform ${build} ${host} ${target}` = crossed  -a -x ${sysroot}/usr/bin/as${exe} -o \
		 `check_platform ${build} ${host} ${target}` = canadian -a -x ${sysroot}/usr/bin/${target}-as${exe} \) -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	[ -f ${sysroot}/usr/include/zlib.h ] || install_crossed_native_zlib || return
	which yacc > /dev/null || install_native_bison || return
	fetch binutils || return
	[ -d ${binutils_src_dir_crs_ntv} ] ||
		(unpack ${binutils_org_src_dir} &&
			mv -v ${binutils_org_src_dir} ${binutils_src_dir_crs_ntv}) || return
	[ -f ${binutils_src_dir_crs_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${host} --target=${target} --with-sysroot=/ \
			--enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
			CFLAGS="${CFLAGS} -I${sysroot}/usr/include -L${sysroot}/usr/lib -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return
	make -C ${binutils_src_dir_crs_ntv} -j 1 || return
	make -C ${binutils_src_dir_crs_ntv} -j 1 DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_gmp()
{
	[ -f ${sysroot}/usr/include/gmp.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	fetch gmp || return
	[ -d ${gmp_src_dir_crs_ntv} ] ||
		(unpack ${gmp_org_src_dir} &&
			mv -v ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${host} --enable-cxx) || return
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_mpfr()
{
	[ -f ${sysroot}/usr/include/mpfr.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	install_crossed_native_gmp || return
	fetch mpfr || return
	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(unpack ${mpfr_org_src_dir} &&
			mv -v ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${host} --with-gmp=${sysroot}/usr ${enable_static_disable_shared}) || return
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
	sed -i -e /^dependency_libs=/s/\'.\*\'\$/\'\'/ ${sysroot}/usr/lib/libmpfr.la || return
	# [XXX] mpcビルド時に、mpfrが依存しているgmpを参照しようとしてlibmpfr.laの不整合に
	#       引っかからないようにするために、強行的にlibmpfr.la書き換えてる。
}

install_crossed_native_mpc()
{
	[ -f ${sysroot}/usr/include/mpc.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	install_crossed_native_mpfr || return
	fetch mpc || return
	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(unpack ${mpc_org_src_dir} &&
			mv -v ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${host} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr ${enable_static_disable_shared}) || return
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_gcc()
{
	[ -x ${sysroot}/usr/bin/gcc${exe} -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	(target=${host}; host=${build}; set_variables; install_cross_binutils) || return # XXX libgccのconfigureが${target}-nm, ${target}-ranlib見つけてくれないので現状は${prefix}/bin/${target}-{nm,ranlib}が必須。
	(target=${host}; host=${build}; set_variables; install_cross_gcc) || return
	[ -f ${sysroot}/usr/bin/as${exe} ] || install_crossed_binutils || return
	[ ${host} = x86_64-w64-mingw32 ] && enable_static_disable_shared='--enable-static --disable-shared' || enable_static_disable_shared=''
	[ -f ${sysroot}/usr/include/gmp.h ] || install_crossed_native_gmp || return
	[ -f ${sysroot}/usr/include/mpfr.h ] || install_crossed_native_mpfr || return
	[ -f ${sysroot}/usr/include/mpc.h ] || install_crossed_native_mpc || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} || return
	mkdir -pv ${gcc_bld_dir_crs_ntv} || return
	[ -f ${gcc_bld_dir_crs_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_ntv}
		${gcc_org_src_dir}/configure --prefix=/usr --build=${build} --host=${host} --target=${target} \
			--with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr --with-mpc=${sysroot}/usr \
			--enable-languages=${languages} --with-sysroot=${sysroot_mingw:-/} --with-build-sysroot=${sysroot} --without-isl --with-system-zlib \
			--enable-libstdcxx-debug \
			CC_FOR_TARGET=${target}-gcc CXX_FOR_TARGET=${target}-g++ GOC_FOR_TARGET=${target}-gccgo) || return
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} || return
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_zlib()
{
	[ -f ${sysroot}/usr/include/zlib.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	fetch zlib || return
	[ -d ${zlib_src_dir_crs_ntv} ] ||
		(unpack ${zlib_org_src_dir} &&
			mv -v ${zlib_org_src_dir} ${zlib_src_dir_crs_ntv}) || return
	(cd ${zlib_src_dir_crs_ntv}
	[ ${host} = x86_64-w64-mingw32 ] && static=--static || static=''
	CC=${host}-gcc AR=${host}-ar RANLIB=${host}-ranlib ./configure --prefix=/usr ${static}) || return
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_crossed_native_libpng()
{
	[ -f ${sysroot}/usr/include/png.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	install_crossed_native_zlib || return
	fetch libpng || return
	[ -d ${libpng_src_dir_crs_ntv} ] ||
		(unpack ${libpng_org_src_dir} &&
			mv -v ${libpng_org_src_dir} ${libpng_src_dir_crs_ntv}) || return
	[ -f ${libpng_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} \
			CPPFLAGS="${CPPFLAGS} -I ${sysroot}/usr/include") || return
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_libtiff()
{
	[ -f ${sysroot}/usr/include/tiffio.h -a "${force_install}" != yes ] && return
	check_platform ${build} ${host} ${target} | grep -qe '^\(crossed\|canadian\)$' || return
	fetch tiff || return
	[ -d ${tiff_src_dir_crs_ntv} ] ||
		(unpack ${tiff_org_src_dir} &&
			mv -v ${tiff_org_src_dir} ${tiff_src_dir_crs_ntv}) || return
	[ -f ${tiff_src_dir_crs_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=`echo ${target} | sed -e 's/arm[^-]\+/arm/'` \
			CC=${target}-gcc CXX=${target}-g++ AS=${target}-as STRIP=${target}-strip RANLIB=${target}-ranlib) || return
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

realpath -e ${0} | grep -qe ^/tmp/ || { tmpdir=`mktemp -dp /tmp` && trap 'rm -fvr ${tmpdir}' EXIT HUP INT QUIT TERM && cp -v ${0} ${tmpdir} && sh -$- ${tmpdir}/`basename ${0}` "$@"; exit;}
trap 'set' USR1
while getopts p:j:f:c:l:t:h: arg; do
	case ${arg} in
	p)  prefix=${OPTARG};;
	j)  jobs=${OPTARG};;
	f)  enable_ccache=${OPTARG};;
	c)  enable_check=${OPTARG};;
	l)  languages=${OPTARG};;
	h)  host=${OPTARG};;
	t)  target=${OPTARG};;
	\?) set_variables || true; usage >&2; exit 1;;
	esac
done
shift `expr ${OPTIND} - 1`

set_variables

count=0
while [ $# -gt 0 ]; do
	case ${1} in
	debug) ${1} `[ -n "${BASH}" ] && echo shell || echo ${1}`;;
	shell) [ -n "${BASH}" ] \
				&& set placeholder debug \
				|| exec bash --noprofile --norc --posix -e ${0} -p ${prefix} -j ${jobs} -l ${languages} -h ${host} -t ${target} shell
		   count=`expr ${count} + 1`;;
	*=*)   eval export ${1}; set_variables;;
	*)     eval ${1} || exit 1; count=`expr ${count} + 1`;;
	esac
	shift
done
[ ${count} -eq 0 ] && usage || exit 0
