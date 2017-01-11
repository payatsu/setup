#!/bin/sh -e
# [TODO] ホームディレクトリにusr/ができてしますバグ。
# [TODO] --enable-linker-build-id
# [TODO] ccache
# [TODO] valgrind
# [TODO] util-linux
# [TODO] newlib
# [TODO] perf
# [TODO] haskell(stack<-(ghc, cabal))
# [TODO] X11, gtk周りのインストールが未完成＆不安定
# [TODO] libav<-
# [TODO] webkitgtk<-libsoup
# [TODO] libmount, dtrace (GLib)
# [TODO] rsvg, imagemagick
# [TODO] LLDB, Polly, MySQL, expat, grub, util-linux
# [TODO] update-alternatives
# [TODO] linux-2.6.18, glibc-2.16.0の組み合わせを試す。
# [TODO] install_native_clang_tools_extra()のテスト実行が未完了。

: ${tar_ver:=1.29}
: ${cpio_ver:=2.12}
: ${xz_ver:=5.2.2}
: ${bzip2_ver:=1.0.6}
: ${gzip_ver:=1.8}
: ${wget_ver:=1.18}
: ${pkg_config_ver:=0.29.1}
: ${texinfo_ver:=6.3}
: ${coreutils_ver:=8.26}
: ${bison_ver:=3.0.4}
: ${flex_ver:=2.6.0}
: ${m4_ver:=1.4.17}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.15}
: ${autogen_ver:=5.18.12}
: ${libtool_ver:=2.4.6}
: ${sed_ver:=4.3}
: ${gawk_ver:=4.1.4}
: ${make_ver:=4.2}
: ${binutils_ver:=2.27}
: ${linux_ver:=3.18.13}
: ${gperf_ver:=3.0.4}
: ${glibc_ver:=2.24}
: ${gmp_ver:=6.1.2}
: ${mpfr_ver:=3.1.5}
: ${mpc_ver:=1.0.3}
: ${gcc_ver:=6.3.0}
: ${readline_ver:=7.0}
: ${ncurses_ver:=6.0}
: ${gdb_ver:=7.12}
: ${zlib_ver:=1.2.8}
: ${libpng_ver:=1.6.25}
: ${tiff_ver:=4.0.6}
: ${jpeg_ver:=v9b}
: ${giflib_ver:=5.1.4}
: ${libXpm_ver:=3.5.11}
: ${libwebp_ver:=0.5.1}
: ${libffi_ver:=3.2.1}
: ${emacs_ver:=25.1}
: ${vim_ver:=8.0.0027}
: ${vimdoc_ja_ver:=dummy}
: ${ctags_ver:=5.8}
: ${grep_ver:=2.27}
: ${global_ver:=6.5.6}
: ${pcre2_ver:=10.22}
: ${the_silver_searcher_ver:=1.0.2}
: ${the_platinum_searcher_ver:=2.1.4}
: ${highway_ver:=1.1.0}
: ${graphviz_ver:=2.38.0}
: ${doxygen_ver:=1.8.12}
: ${diffutils_ver:=3.5}
: ${patch_ver:=2.7.5}
: ${findutils_ver:=4.6.0}
: ${screen_ver:=4.4.0}
: ${libevent_ver:=2.0.22}
: ${tmux_ver:=2.3}
: ${expect_ver:=5.45}
: ${dejagnu_ver:=1.6}
: ${zsh_ver:=5.3}
: ${bash_ver:=4.4}
: ${inetutils_ver:=1.9.4}
: ${openssl_ver:=1.0.2i}
: ${openssh_ver:=7.3p1}
: ${curl_ver:=7.51.0}
: ${asciidoc_ver:=8.6.9}
: ${libxml2_ver:=2.9.4}
: ${libxslt_ver:=1.1.29}
: ${xmlto_ver:=0.0.28}
: ${gettext_ver:=0.19.8}
: ${git_ver:=2.11.0}
: ${mercurial_ver:=4.0.1}
: ${sqlite_autoconf_ver:=3150200}
: ${apr_ver:=1.5.2}
: ${apr_util_ver:=1.5.4}
: ${subversion_ver:=1.9.5}
: ${cmake_ver:=3.7.1}
: ${libedit_ver:=20160903-3.1}
: ${swig_ver:=3.0.10}
: ${llvm_ver:=3.9.1}
: ${libcxx_ver:=${llvm_ver}}
: ${libcxxabi_ver:=${llvm_ver}}
: ${compiler_rt_ver:=${llvm_ver}}
: ${cfe_ver:=${llvm_ver}}
: ${clang_tools_extra_ver:=${llvm_ver}}
: ${lld_ver:=${llvm_ver}}
: ${lldb_ver:=${llvm_ver}}
: ${boost_ver:=1_63_0}
: ${mingw_w64_ver:=4.0.6}
: ${Python_ver:=3.6.0}
: ${ruby_ver:=2.4.0}
: ${go_ver:=1.7.4}
: ${perl_ver:=5.24.0}
: ${tcl_ver:=8.6.6}
: ${tk_ver:=8.6.6}
: ${libunistring_ver:=0.9.7}
: ${libatomic_ops_ver:=7.4.4}
: ${gc_ver:=7.6.0}
: ${guile_ver:=2.0.13}
: ${yasm_ver:=1.3.0}
: ${x264_ver:=last-stable}
: ${x265_ver:=2.0}
: ${libav_ver:=11.7}
: ${opencv_ver:=3.1.0}
: ${opencv_contrib_ver:=3.1.0}

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
: ${glib_ver:=2.50.0}
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
: ${enable_check:=no}
: ${target:=`uname -m`-linux-gnu}

: ${enable_ccache:=no}
: ${build:=`uname -m`-linux-gnu}
: ${languages:=c,c++,go}
: ${strip:=strip}
: ${cmake_build_type:=Release}

usage()
# Show usage.
{
	cat <<EOF
[Usage]
	${0} [-p prefix] [-j jobs] [-f yes|no] [-c yes|no] [-t target] [-h] [variable=value]... commands...

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
	-t target
		Target-triplet of new cross toolchain, currently '${target}'.
		ex.
			armv7l-linux-gnueabihf
			x86_64-linux-gnu
			i686-unknown-linux
			microblaze-none-linux
			nios2-none-linux (linux_ver=4.8.1)
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
	# ${0} -p /toolchains -t armv7l-linux-gnueabihf -j 8 auto

	For Raspberry pi2 cross compiler
	# ${0} -p /toolchains -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 linux_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

	For microblaze cross compiler
	# ${0} -p /toolchains -t microblaze-linux-gnu -j 8 binutils_ver=2.25 linux_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

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
	make|binutils|gperf|glibc|gmp|mpfr|mpc|readline|ncurses|gdb|emacs|grep|global|\
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
	flex)
		check_archive ${flex_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${flex_org_src_dir}.tar.xz \
				https://sourceforge.net/projects/flex/files/${flex_name}.tar.xz/download || return;;
	linux)
		check_archive ${linux_org_src_dir} ||
			wget --no-check-certificate -O ${linux_org_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/kernel/${linux_major_ver}/${linux_name}.tar.xz || return;;
	gcc)
		check_archive ${gcc_org_src_dir} ||
			wget -O ${gcc_org_src_dir}.tar.bz2 \
				http://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.bz2 || return;;
	zlib)
		check_archive ${zlib_org_src_dir} ||
			wget -O ${zlib_org_src_dir}.tar.xz \
				http://zlib.net/${zlib_name}.tar.xz || return;;
	libpng)
		check_archive ${libpng_org_src_dir} ||
			wget --trust-server-names -O ${libpng_org_src_dir}.tar.xz \
				http://download.sourceforge.net/libpng/${libpng_name}.tar.xz || return;;
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
		check_archive ${ctags_org_src_dir} ||
			wget --trust-server-names -O ${ctags_org_src_dir}.tar.gz \
				http://prdownloads.sourceforge.net/ctags/${ctags_name}.tar.gz || return;;
	pcre2)
		check_archive ${pcre2_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${pcre2_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/pcre/files/pcre2/${pcre2_ver}/${pcre2_name}.tar.bz2/download || return;;
	the_silver_searcher)
		check_archive ${the_silver_searcher_org_src_dir} ||
			wget -O ${the_silver_searcher_org_src_dir}.tar.gz \
				http://geoff.greer.fm/ag/releases/${the_silver_searcher_name}.tar.gz || return;;
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
	mercurial)
		check_archive ${mercurial_org_src_dir} ||
			wget --no-check-certificate -O ${mercurial_org_src_dir}.tar.gz \
				https://www.mercurial-scm.org/release/${mercurial_name}.tar.gz || return;;
	sqlite-autoconf)
		check_archive ${sqlite_autoconf_org_src_dir} ||
			wget --no-check-certificate -O ${sqlite_autoconf_org_src_dir}.tar.gz \
				https://www.sqlite.org/2016/${sqlite_autoconf_name}.tar.gz || return;;
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
	boost)
		check_archive ${boost_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${boost_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/boost/files/boost/`echo ${boost_ver} | tr _ .`/${boost_name}.tar.bz2/download || return;;
	mingw-w64)
		check_archive ${mingw_w64_org_src_dir} ||
			wget --trust-server-names --no-check-certificate -O ${mingw_w64_org_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v${mingw_w64_ver}.tar.bz2/download || return;;
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
		[ -d ${1} ] && return
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
		install_crossed_native_binutils || return
		install_crossed_native_gcc || return;;
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

	for f in install_mingw_w64_binutils install_mingw_w64_gcc; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	for f in `sed -e '/^install_crossed_native_[_[:alnum:]]\+()$/{s/()$//;p};d' ${0}`; do
		$f \
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
		! -name '*.tar.gz' ! -name '*.tar.bz2' ! -name '*.tar.xz' ! -name '*.zip' -exec rm -fr {} +
}

strip()
# Strip binary files.
{
	for strip_command in strip ${target}-strip x86_64-w64-mingw32-strip; do
		find ${prefix} -type f \( -perm /111 -o -name '*.o' -o -name '*.a' -o -name '*.so' -o -name '*.gox' \) \
			| xargs file | grep -e 'not stripped' | cut -d: -f1 | xargs -I "{}" sh -c "chmod u+w {}; ${strip_command} {}" || true
	done
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
	update_search_path || return
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
	find ${prefix} -mindepth 1 -maxdepth 1 ! -name src ! -name .git -exec rm -fr '{}' +
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
	os=`head -1 /etc/issue | cut -d' ' -f1`
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

	case `echo ${linux_ver} | cut -d. -f1,2` in
	2.6) linux_major_ver=v2.6;;
	3.*) linux_major_ver=v3.x;;
	4.*) linux_major_ver=v4.x;;
	*)   echo unsupported linux version >&2; return 1;;
	esac

	for pkg in `sed -e '/^: \${\(.\+\)_ver:=.\+}$/{s//\1/
		s/pkg_config/pkg-config/
		s/vimdoc_ja/vimdoc-ja/
		s/sqlite_autoconf/sqlite-autoconf/
		s/apr_util/apr-util/
		s/compiler_rt/compiler-rt/
		s/clang_tools_extra/clang-tools-extra/
		s/mingw_w64/mingw-w64/
		s/xcb_proto/xcb-proto/
		s/gdk_pixbuf/gdk-pixbuf/
		s/gobject_introspection/gobject-introspection/
		p};d' ${0}`; do
		set_src_directory ${pkg}
	done

	echo ${PATH} | tr : '\n' | grep -qe ^${prefix}/bin\$ \
		&& PATH=${prefix}/bin:`echo ${PATH} | sed -e "s+\(^\|:\)${prefix}/bin\(\$\|:\)+\1\2+g;s/::/:/g;s/^://;s/:\$//"` \
		|| PATH=${prefix}/bin:${PATH}
	echo ${PATH} | tr : '\n' | grep -qe ^/sbin\$ || PATH=/sbin:${PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${prefix}/lib64\$ || LD_LIBRARY_PATH=${prefix}/lib64:${LD_LIBRARY_PATH}
	echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${prefix}/lib\$   || LD_LIBRARY_PATH=${prefix}/lib:${LD_LIBRARY_PATH}
	export LD_LIBRARY_PATH
	[ "${enable_ccache}" = yes ] && export USE_CCACHE=1 CCACHE_DIR=${prefix}/src/.ccache CCACHE_BASEDIR=${prefix}/src && mkdir -p ${prefix}/src
	[ "${enable_ccache}" = yes ] && ! echo ${CC} | grep -qe ccache && export CC="ccache ${CC:-gcc}" CXX="ccache ${CXX:-g++}"
	[ "${enable_ccache}" = yes ] || ! echo ${CC} | grep -qe ccache || export CC=`echo ${CC} | sed -e 's/ccache //'` CXX=`echo ${CXX} | sed -e 's/ccache //'`
	export GOPATH=${GOPATH:-${HOME}/.go}
	update_pkg_config_path || return
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

update_search_path()
{
	[ `whoami` != root ] && return
	[ -f /etc/ld.so.conf.d/`basename ${prefix}`.conf ] ||
		echo \
"${prefix}/lib
${prefix}/lib64
${prefix}/lib32" > /etc/ld.so.conf.d/`basename ${prefix}`.conf || return
	ldconfig || return
}

update_pkg_config_path()
{
	PKG_CONFIG_PATH=`([ -d ${prefix}/lib ] && find ${prefix}/lib -type d -name pkgconfig
						[ -d ${prefix}/share ] && find ${prefix}/share -type d -name pkgconfig
						LANG=C ${CC:-gcc} -print-search-dirs | sed -e '/^libraries: =/{s/^libraries: =//;p};d' |
							tr : '\n' | xargs readlink -e | xargs -I dir find dir -maxdepth 1 -type d -name pkgconfig) |
							tr '\n' : | sed -e 's/:$//'`
	export PKG_CONFIG_PATH
}

search_library()
{
	for dir in ${prefix}/lib64 ${prefix}/lib `LANG=C ${CC:-gcc} -print-search-dirs |
		sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs readlink -e`; do
		[ -f ${dir}/${1} ] && echo ${dir}/${1} && return
	done
	return 1
}

search_library_dir()
{
	path=`search_library $@`
	[ $? = 0 ] && dirname ${path} || return
}

search_header()
{
	for dir in ${prefix}/include ${prefix}/lib/libffi-*/include \
		`LANG=C ${CC:-gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
			sed -e '/^#include /,/^End of search list.$/p;d' | xargs readlink -e`; do
		[ -d ${dir}${2:+/${2}} ] || continue
		candidates=`find ${dir}${2:+/${2}} -type f -name ${1}`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return
	done
	return 1
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
		apt-get install -y lua5.2 liblua5.2-dev || return # for vim
		apt-get install -y luajit libluajit-5.1 || return # for vim
		apt-get install -y libgnomeui-dev libxt-dev || return # for vim
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ || return
		yum install -y unifdef || return
		yum install -y gtk3-devel || return
		yum install -y lua lua-devel || return
		yum install -y luajit luajit-devel || return
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
	unpack ${tar_org_src_dir} ${tar_src_base} || return
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
	unpack ${cpio_org_src_dir} ${cpio_src_base} || return
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
	unpack ${xz_org_src_dir} ${xz_src_base} || return
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
	unpack ${bzip2_org_src_dir} ${bzip2_src_base} || return
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
	ln -fsv ./libbz2.so.${bzip2_ver} ${prefix}/lib/libbz2.so.`echo ${bzip2_ver} | cut -d. -f-2` || return
	cp -fv ${bzip2_org_src_dir}/bzlib.h ${prefix}/include || return
	cp -fv ${bzip2_org_src_dir}/bzlib_private.h ${prefix}/include || return
	update_search_path || return
}

install_native_gzip()
{
	[ -x ${prefix}/bin/gzip -a "${force_install}" != yes ] && return
	fetch gzip || return
	unpack ${gzip_org_src_dir} ${gzip_src_base} || return
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
	unpack ${wget_org_src_dir} ${wget_src_base} || return
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
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
	fetch pkg-config || return
	unpack ${pkg_config_org_src_dir} ${pkg_config_src_base} || return
	[ -f ${pkg_config_org_src_dir}/Makefile ] ||
		(cd ${pkg_config_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${pkg_config_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pkg_config_org_src_dir} -j ${jobs} -k check || return
	make -C ${pkg_config_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_texinfo()
{
	[ -x ${prefix}/bin/makeinfo -a "${force_install}" != yes ] && return
	fetch texinfo || return
	unpack ${texinfo_org_src_dir} ${texinfo_src_base} || return
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
	unpack ${coreutils_org_src_dir} ${coreutils_src_base} || return
	[ -f ${coreutils_org_src_dir}/Makefile ] ||
		(cd ${coreutils_org_src_dir}
		FORCE_UNSAFE_CONFIGURE=1 ./configure --prefix=${prefix} \
			--build=${build} --disable-silent-rules) || return
	make -C ${coreutils_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${coreutils_org_src_dir} -j ${jobs} -k check || return
	make -C ${coreutils_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_bison()
{
	[ -x ${prefix}/bin/bison -a "${force_install}" != yes ] && return
	fetch bison || return
	unpack ${bison_org_src_dir} ${bison_src_base} || return
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
	unpack ${flex_org_src_dir} ${flex_src_base} || return
	[ -f ${flex_org_src_dir}/Makefile ] ||
		(cd ${flex_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${flex_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${flex_org_src_dir} -j ${jobs} -k check || return
	make -C ${flex_org_src_dir} -j ${jobs} install${strip:+-${strip}} install-man || return
	update_search_path || return
}

install_native_m4()
{
	[ -x ${prefix}/bin/m4 -a "${force_install}" != yes ] && return
	fetch m4 || return
	unpack ${m4_org_src_dir} ${m4_src_base} || return
	[ -f ${m4_org_src_dir}/Makefile ] ||
		(cd ${m4_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${m4_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${m4_org_src_dir} -j ${jobs} -k check || return
	make -C ${m4_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_autoconf()
{
	[ -x ${prefix}/bin/autoconf -a "${force_install}" != yes ] && return
	fetch autoconf || return
	unpack ${autoconf_org_src_dir} ${autoconf_src_base} || return
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
	unpack ${automake_org_src_dir} ${automake_src_base} || return
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
#	which autoconf > /dev/null || install_native_autoconf || return
	fetch autogen || return
	unpack ${autogen_org_src_dir} ${autogen_src_base} || return
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
	unpack ${libtool_org_src_dir} ${libtool_src_base} || return
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
	unpack ${sed_org_src_dir} ${sed_src_base} || return
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
	unpack ${gawk_org_src_dir} ${gawk_src_base} || return
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
	unpack ${make_org_src_dir} ${make_src_base} || return
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
		(unpack ${binutils_org_src_dir} ${binutils_src_base} &&
			mv -v ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-sysroot=/ \
			--enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
#			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
#			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function"
		) || return
	make -C ${binutils_src_dir_ntv} -j 1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${binutils_src_dir_ntv} -j 1 -k check || return
	make -C ${binutils_src_dir_ntv} -j 1 install${strip:+-${strip}} || return
}

install_native_linux_header()
{
	fetch linux || return
	[ -d ${linux_src_dir_ntv} ] ||
		(unpack ${linux_org_src_dir} ${linux_src_base} &&
			mv -v ${linux_org_src_dir} ${linux_src_dir_ntv}) || return
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 mrproper || return
	make -C ${linux_src_dir_ntv} -j ${jobs} V=1 \
		ARCH=${native_linux_arch} INSTALL_HDR_PATH=${prefix} headers_install || return
}

install_native_gperf()
{
	[ -x ${prefix}/bin/gperf -a "${force_install}" != yes ] && return
	fetch gperf || return
	unpack ${gperf_org_src_dir} ${gperf_src_base} || return
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
		(unpack ${glibc_org_src_dir} ${glibc_src_base} &&
			mv -v ${glibc_org_src_dir} ${glibc_src_dir_ntv}) || return
	mkdir -pv ${glibc_bld_dir_ntv}
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
	update_search_path || return
}

install_native_gmp()
{
	[ -f ${prefix}/include/gmp.h -a "${force_install}" != yes ] && return
	fetch gmp || return
	[ -d ${gmp_src_dir_ntv} ] ||
		(unpack ${gmp_org_src_dir} ${gmp_src_base} &&
			mv -v ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --enable-cxx) || return
	make -C ${gmp_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gmp_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${gmp_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_mpfr()
{
	[ -f ${prefix}/include/mpfr.h -a "${force_install}" != yes ] && return
	search_header gmp.h > /dev/null || install_native_gmp || return
	fetch mpfr || return
	[ -d ${mpfr_src_dir_ntv} ] ||
		(unpack ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv -v ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --with-gmp=`get_prefix gmp.h`) || return
	make -C ${mpfr_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpfr_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${mpfr_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_mpc()
{
	[ -f ${prefix}/include/mpc.h -a "${force_install}" != yes ] && return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	fetch mpc || return
	[ -d ${mpc_src_dir_ntv} ] ||
		(unpack ${mpc_org_src_dir} ${mpc_src_base} &&
			mv -v ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h`) || return
	make -C ${mpc_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpc_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${mpc_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_gcc()
{
	[ -x ${prefix}/bin/gcc -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_ntv}
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=${languages} --disable-multilib --without-isl --with-system-zlib \
			--enable-libstdcxx-debug \
		) || return
	make -C ${gcc_bld_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_ntv} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	ln -fs ./gcc ${prefix}/bin/cc || return
}

install_native_readline()
{
	[ -f ${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return
	fetch readline || return
	unpack ${readline_org_src_dir} ${readline_src_base} || return
	[ -f ${readline_org_src_dir}/Makefile ] ||
		(cd ${readline_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${readline_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${readline_org_src_dir} -j ${jobs} -k check || return
	make -C ${readline_org_src_dir} -j ${jobs} install || return
	update_search_path || return
}

install_native_ncurses()
{
	[ -f ${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return
	fetch ncurses || return
	unpack ${ncurses_org_src_dir} ${ncurses_src_base} || return

	# [XXX] workaround for GCC 5.x
	patch -N -p0 -d ${ncurses_org_src_dir} <<EOF || [ $? = 1 ] || return
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
			--with-libtool --with-shared --with-cxx-shared) || return
	make -C ${ncurses_org_src_dir} -j ${jobs} || return
	make -C ${ncurses_org_src_dir} -j ${jobs} install || return
	update_search_path || return
}

install_native_gdb()
{
	[ -x ${prefix}/bin/gdb -a "${force_install}" != yes ] && return
	search_header readline.h readline > /dev/null || install_native_readline || return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_header Python.h > /dev/null || install_native_python || return
	which makeinfo > /dev/null || install_native_texinfo || return
	fetch gdb || return
	unpack ${gdb_org_src_dir} ${gdb_src_base} || return
	mkdir -pv ${gdb_bld_dir_ntv}
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

install_native_zlib()
{
	[ -f ${prefix}/include/zlib.h -a "${force_install}" != yes ] && return
	fetch zlib || return
	[ -d ${zlib_src_dir_ntv} ] ||
		(unpack ${zlib_org_src_dir} ${zlib_src_base} &&
			mv -v ${zlib_org_src_dir} ${zlib_src_dir_ntv}) || return
	(cd ${zlib_src_dir_ntv}
	./configure --prefix=${prefix}) || return
	make -C ${zlib_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${zlib_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${zlib_src_dir_ntv} -j ${jobs} install || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_libpng()
{
	[ -f ${prefix}/include/png.h -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	fetch libpng || return
	[ -d ${libpng_src_dir_ntv} ] ||
		(unpack ${libpng_org_src_dir} ${libpng_src_base} &&
			mv -v ${libpng_org_src_dir} ${libpng_src_dir_ntv}) || return
	[ -f ${libpng_src_dir_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${libpng_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpng_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${libpng_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_libtiff()
{
	[ -f ${prefix}/include/tiffio.h -a "${force_install}" != yes ] && return
	fetch tiff || return
	[ -d ${tiff_src_dir_ntv} ] ||
		(unpack ${tiff_org_src_dir} ${tiff_src_base} &&
			mv -v ${tiff_org_src_dir} ${tiff_src_dir_ntv}) || return
	[ -f ${tiff_src_dir_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${tiff_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tiff_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${tiff_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_libjpeg()
{
	[ -f ${prefix}/include/jpeglib.h -a "${force_install}" != yes ] && return
	fetch jpeg || return
	[ -d ${jpeg_src_dir_ntv} ] ||
		(unpack ${jpeg_org_src_dir} ${jpeg_src_base} &&
			mv -v ${jpeg_org_src_dir} ${jpeg_src_dir_ntv}) || return
	[ -f ${jpeg_src_dir_ntv}/Makefile ] ||
		(cd ${jpeg_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${jpeg_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${jpeg_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${jpeg_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_giflib()
{
	[ -f ${prefix}/include/gif_lib.h -a "${force_install}" != yes ] && return
	which xmlto > /dev/null || install_native_xmlto || return
	fetch giflib || return
	[ -d ${giflib_src_dir_ntv} ] ||
		(unpack ${giflib_org_src_dir} ${giflib_src_base} &&
			mv -v ${giflib_org_src_dir} ${giflib_src_dir_ntv}) || return
	[ -f ${giflib_src_dir_ntv}/Makefile ] ||
		(cd ${giflib_src_dir_ntv}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${giflib_src_dir_ntv} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${giflib_src_dir_ntv} -j ${jobs} -k check || return
	make -C ${giflib_src_dir_ntv} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_libXpm()
{
	[ -f ${prefix}/include/X11/xpm.h -a "${force_install}" != yes ] && return
	search_header Xproto.h X11 > /dev/null || install_native_xproto || return
	search_header XKBproto.h X11 > /dev/null || install_native_kbproto || return
	search_header Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXpm || return
	unpack ${libXpm_org_src_dir} ${libXpm_src_base} || return
	[ -f ${libXpm_org_src_dir}/Makefile ] ||
		(cd ${libXpm_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libXpm_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libXpm_org_src_dir} -j ${jobs} -k check || return
	make -C ${libXpm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
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
	unpack ${libwebp_org_src_dir} ${libwebp_src_base} || return
	[ -f ${libwebp_org_src_dir}/Makefile ] ||
		(cd ${libwebp_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libwebp_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libwebp_org_src_dir} -j ${jobs} -k check || return
	make -C ${libwebp_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_libffi()
{
	[ -f ${prefix}/lib/libffi-*/include/ffi.h -a "${force_install}" != yes ] && return
	fetch libffi || return
	unpack ${libffi_org_src_dir} ${libffi_src_base} || return
	[ -f ${libffi_org_src_dir}/Makefile ] ||
		(cd ${libffi_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${libffi_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libffi_org_src_dir} -j ${jobs} -k check || return
	make -C ${libffi_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	update_pkg_config_path || return
}

#install_native_glib()
#{
#	[ -f ${prefix}/include/glib-2.0/glib.h -a "${force_install}" != yes ] && return
#	search_header ffi.h > /dev/null || install_native_libffi || return
#	search_header pcre2.h > /dev/null || install_native_pcre2 || return
#	fetch glib || return
#	unpack ${glib_org_src_dir} ${glib_src_base} || return
#	[ -f ${glib_org_src_dir}/Makefile ] ||
#		(cd ${glib_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules --disable-libmount --disable-dtrace --enable-systemtap) || return
#	make -C ${glib_org_src_dir} -j ${jobs} || return
#	make -C ${glib_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_cairo()
#{
#	[ -f ${prefix}/include/cairo/cairo.h -a "${force_install}" != yes ] && return
#	fetch cairo || return
#	unpack ${cairo_org_src_dir} ${cairo_src_base} || return
#	[ -f ${cairo_org_src_dir}/Makefile ] ||
#		(cd ${cairo_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${cairo_org_src_dir} -j ${jobs} || return
#	make -C ${cairo_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_pixman()
#{
#	[ -f ${prefix}/include/pixman-1.0/pixman.h -a "${force_install}" != yes ] && return
#	fetch pixman || return
#	unpack ${pixman_org_src_dir} ${pixman_src_base} || return
#	[ -f ${pixman_org_src_dir}/Makefile ] ||
#		(cd ${pixman_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${pixman_org_src_dir} -j ${jobs} || return
#	make -C ${pixman_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_pango()
#{
#	[ -f ${prefix}/include/pango-1.0/pango/pango.h -a "${force_install}" != yes ] && return
#	search_header cairo.h cairo > /dev/null || install_native_cairo || return
#	search_header pixman.h pixman-1.0 > /dev/null || install_native_pixman || return
#	fetch pango || return
#	unpack ${pango_org_src_dir} ${pango_src_base} || return
#	[ -f ${pango_org_src_dir}/Makefile ] ||
#		(cd ${pango_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${pango_org_src_dir} -j ${jobs} || return
#	make -C ${pango_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_gdk_pixbuf()
#{
#	[ -f ${prefix}/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf.h -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch gdk-pixbuf || return
#	unpack ${gdk_pixbuf_org_src_dir} ${gdk_pixbuf_src_base} || return
#	[ -f ${gdk_pixbuf_org_src_dir}/Makefile ] ||
#		(cd ${gdk_pixbuf_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} || return
#	make -C ${gdk_pixbuf_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_atk()
#{
#	[ -f ${prefix}/include/atk-1.0/atk/atk.h -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch atk || return
#	unpack ${atk_org_src_dir} ${atk_src_base} || return
#	[ -f ${atk_org_src_dir}/Makefile ] ||
#		(cd ${atk_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${atk_org_src_dir} -j ${jobs} || return
#	make -C ${atk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_gobject_introspection()
#{
#	[ -d ${prefix}/include/gobject-introspection-1.0 -a "${force_install}" != yes ] && return
#	search_header glib.h glib-2.0 > /dev/null || install_native_glib || return
#	fetch gobject-introspection || return
#	unpack ${gobject_introspection_org_src_dir} ${gobject_introspection_src_base} || return
#	[ -f ${gobject_introspection_org_src_dir}/Makefile ] ||
#		(cd ${gobject_introspection_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} \
#			--disable-silent-rules) || return
#	make -C ${gobject_introspection_org_src_dir} -j ${jobs} || return
#	make -C ${gobject_introspection_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_inputproto()
#{
#	[ -d ${prefix}/include/X11/extensions/XI.h -a "${force_install}" != yes ] && return
#	fetch inputproto || return
#	unpack ${inputproto_org_src_dir} ${inputproto_src_base} || return
#	[ -f ${inputproto_org_src_dir}/Makefile ] ||
#		(cd ${inputproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${inputproto_org_src_dir} -j ${jobs} || return
#	make -C ${inputproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_xtrans()
#{
#	[ -f ${prefix}/include/X11/Xtrans/Xtrans.h -a "${force_install}" != yes ] && return
#	fetch xtrans || return
#	unpack ${xtrans_org_src_dir} ${xtrans_src_base} || return
#	[ -f ${xtrans_org_src_dir}/Makefile ] ||
#		(cd ${xtrans_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xtrans_org_src_dir} -j ${jobs} || return
#	make -C ${xtrans_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
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
#	unpack ${libX11_org_src_dir} ${libX11_src_base} || return
#	[ -f ${libX11_org_src_dir}/Makefile ] ||
#		(cd ${libX11_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libX11_org_src_dir} -j ${jobs} || return
#	make -C ${libX11_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libxcb()
#{
#	[ -f ${prefix}/include/xcb/xcb.h -a "${force_install}" != yes ] && return
#	[ -d ${prefix}/share/xcb ] || install_native_xcb_proto || return
#	fetch libxcb || return
#	unpack ${libxcb_org_src_dir} ${libxcb_src_base} || return
#	[ -f ${libxcb_org_src_dir}/Makefile ] ||
#		(cd ${libxcb_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libxcb_org_src_dir} -j ${jobs} || return
#	make -C ${libxcb_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_xcb_proto()
#{
#	[ -d ${prefix}/share/xcb -a "${force_install}" != yes ] && return
#	fetch xcb-proto || return
#	unpack ${xcb_proto_org_src_dir} ${xcb_proto_src_base} || return
#	[ -f ${xcb_proto_org_src_dir}/Makefile ] ||
#		(cd ${xcb_proto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xcb_proto_org_src_dir} -j ${jobs} || return
#	make -C ${xcb_proto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_xextproto()
#{
#	[ -f ${prefix}/include/X11/extensions/lbx.h -a "${force_install}" != yes ] && return
#	fetch xextproto || return
#	unpack ${xextproto_org_src_dir} ${xextproto_src_base} || return
#	[ -f ${xextproto_org_src_dir}/Makefile ] ||
#		(cd ${xextproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${xextproto_org_src_dir} -j ${jobs} || return
#	make -C ${xextproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libXext()
#{
#	[ -f ${prefix}/include/X11/extensions/Xext.h -a "${force_install}" != yes ] && return
#	search_header lbx.h X11/extensions > /dev/null || install_native_xextproto || return
#	fetch libXext || return
#	unpack ${libXext_org_src_dir} ${libXext_src_base} || return
#	[ -f ${libXext_org_src_dir}/Makefile ] ||
#		(cd ${libXext_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXext_org_src_dir} -j ${jobs} || return
#	make -C ${libXext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_fixesproto()
#{
#	[ -f ${prefix}/include/X11/extensions/xfixesproto.h -a "${force_install}" != yes ] && return
#	fetch fixesproto || return
#	unpack ${fixesproto_org_src_dir} ${fixesproto_src_base} || return
#	[ -f ${fixesproto_org_src_dir}/Makefile ] ||
#		(cd ${fixesproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${fixesproto_org_src_dir} -j ${jobs} || return
#	make -C ${fixesproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libXfixes()
#{
#	[ -f ${prefix}/include/X11/extensions/Xfixes.h -a "${force_install}" != yes ] && return
#	search_header xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return
#	fetch libXfixes || return
#	unpack ${libXfixes_org_src_dir} ${libXfixes_src_base} || return
#	[ -f ${libXfixes_org_src_dir}/Makefile ] ||
#		(cd ${libXfixes_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXfixes_org_src_dir} -j ${jobs} || return
#	make -C ${libXfixes_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_damageproto()
#{
#	[ -f ${prefix}/include/X11/extensions/damageproto.h -a "${force_install}" != yes ] && return
#	fetch damageproto || return
#	unpack ${damageproto_org_src_dir} ${damageproto_src_base} || return
#	[ -f ${damageproto_org_src_dir}/Makefile ] ||
#		(cd ${damageproto_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${damageproto_org_src_dir} -j ${jobs} || return
#	make -C ${damageproto_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libXdamage()
#{
#	[ -f ${prefix}/include/X11/extensions/Xdamage.h -a "${force_install}" != yes ] && return
#	search_header damageproto.h X11/extensions > /dev/null || install_native_damageproto || return
#	search_header Xfixes.h X11/extensions > /dev/null || install_native_libXfixes || return
#	fetch libXdamage || return
#	unpack ${libXdamage_org_src_dir} ${libXdamage_src_base} || return
#	[ -f ${libXdamage_org_src_dir}/Makefile ] ||
#		(cd ${libXdamage_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXdamage_org_src_dir} -j ${jobs} || return
#	make -C ${libXdamage_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libXt()
#{
#	[ -f ${prefix}/include/X11/Core.h -a "${force_install}" != yes ] && return
#	fetch libXt || return
#	unpack ${libXt_org_src_dir} ${libXt_src_base} || return
#	[ -f ${libXt_org_src_dir}/Makefile ] ||
#		(cd ${libXt_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libXt_org_src_dir} -j ${jobs} || return
#	make -C ${libXt_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_xproto()
#{
#	[ -f ${prefix}/include/X11/Xproto.h -a "${force_install}" != yes ] && return
#	fetch xproto || return
#	unpack ${xproto_org_src_dir} ${xproto_src_base} || return
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
#	unpack ${kbproto_org_src_dir} ${kbproto_src_base} || return
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
#	unpack ${glproto_org_src_dir} ${glproto_src_base} || return
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
#	unpack ${libpciaccess_org_src_dir} ${libpciaccess_src_base} || return
#	[ -f ${libpciaccess_org_src_dir}/Makefile ] ||
#		(cd ${libpciaccess_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libpciaccess_org_src_dir} -j ${jobs} || return
#	make -C ${libpciaccess_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libdrm()
#{
#	[ -f ${prefix}/include/xf86drm.h -a "${force_install}" != yes ] && return
#	search_header pciaccess.h > /dev/null || install_native_libpciaccess || return
#	fetch libdrm || return
#	unpack ${libdrm_org_src_dir} ${libdrm_src_base} || return
#	[ -f ${libdrm_org_src_dir}/Makefile ] ||
#		(cd ${libdrm_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
#			--enable-static) || return
#	make -C ${libdrm_org_src_dir} -j ${jobs} || return
#	make -C ${libdrm_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_dri2proto()
#{
#	[ -f ${prefix}/include/X11/extensions/dri2proto.h -a "${force_install}" != yes ] && return
#	fetch dri2proto || return
#	unpack ${dri2proto_org_src_dir} ${dri2proto_src_base} || return
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
#	unpack ${dri3proto_org_src_dir} ${dri3proto_src_base} || return
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
#	unpack ${presentproto_org_src_dir} ${presentproto_src_base} || return
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
#	unpack ${libxshmfence_org_src_dir} ${libxshmfence_src_base} || return
#	[ -f ${libxshmfence_org_src_dir}/Makefile ] ||
#		(cd ${libxshmfence_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libxshmfence_org_src_dir} -j ${jobs} || return
#	make -C ${libxshmfence_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
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
#	unpack ${mesa_org_src_dir} ${mesa_src_base} || return
#	[ -f ${mesa_org_src_dir}/Makefile ] ||
#		(cd ${mesa_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${mesa_org_src_dir} -j ${jobs} || return
#	make -C ${mesa_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
#}
#
#install_native_libepoxy()
#{
#	[ -f ${prefix}/include/epoxy/egl.h -a "${force_install}" != yes ] && return
#	search_header Core.h X11 > /dev/null || install_native_libXt || return
#	fetch libepoxy || return
#	unpack ${libepoxy_org_src_dir} ${libepoxy_src_base} || return
#	[ -f ${libepoxy_org_src_dir}/Makefile ] ||
#		(cd ${libepoxy_org_src_dir}
#		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
#	make -C ${libepoxy_org_src_dir} -j ${jobs} || return
#	make -C ${libepoxy_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
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
#	unpack ${gtk_org_src_dir} ${gtk_src_base} || return
#	[ -f ${gtk_org_src_dir}/Makefile ] ||
#		(cd ${gtk_org_src_dir}
#		update_pkg_config_path
#		./configure --prefix=${prefix} --build=${build} --enable-static \
#			--disable-silent-rules) || return
#	make -C ${gtk_org_src_dir} -j ${jobs} || return
#	make -C ${gtk_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
#	update_search_path || return
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
#	unpack ${webkitgtk_org_src_dir} ${webkitgtk_src_base} || return
#	mkdir -pv ${webkitgtk_bld_dir_ntv}
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
	unpack ${emacs_org_src_dir} ${emacs_src_base} || return
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

install_native_vim()
{
	[ -x ${prefix}/bin/vim -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	which gettext > /dev/null || install_native_gettext || return
	which perl > /dev/null || install_native_perl || return
	search_header Python.h > /dev/null || install_native_python || return
	search_header ruby.h > /dev/null || install_native_ruby || return
	fetch vim || return
	unpack ${vim_org_src_dir} ${vim_src_base} || return
	(cd ${vim_org_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--with-features=huge --enable-fail-if-missing \
		--enable-perlinterp=dynamic \
		--enable-python3interp=dynamic \
		--enable-rubyinterp=dynamic \
		--enable-luainterp=dynamic --with-luajit \
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
		(unpack ${vimdoc_ja_org_src_dir} ${vimdoc_ja_src_base}
		mv -fv ${vimdoc_ja_src_base}/vimdoc-ja-master ${vimdoc_ja_org_src_dir}) || return
	mkdir -pv ${prefix}/share/vim/vimfiles || return
	cp -rvt ${prefix}/share/vim/vimfiles ${vimdoc_ja_org_src_dir}/* || return
	vim -i NONE -u NONE -N -c "helptags ${prefix}/share/vim/vimfiles/doc" -c qall || return
}

install_native_ctags()
{
	[ -x ${prefix}/bin/ctags -a "${force_install}" != yes ] && return
	fetch ctags || return
	unpack ${ctags_org_src_dir} ${ctags_src_base} || return
	[ -f ${ctags_org_src_dir}/Makefile ] ||
		(cd ${ctags_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${ctags_org_src_dir} -j ${jobs} || return
	make -C ${ctags_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_dein()
{
	[ -f ${prefix}/src/vim/installer.sh ] ||
		(mkdir -pv ${prefix}/src/vim
		wget --no-check-certificate -O ${prefix}/src/vim/installer.sh \
			https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh) || return
	[ `whoami` != root ] || ! echo Error. run as root is not recommended. >&2 || return
	sh ${prefix}/src/vim/installer.sh ${HOME}/.vim || return
}

install_native_grep()
{
	[ -x ${prefix}/bin/grep -a "${force_install}" != yes ] && return
	fetch grep || return
	unpack ${grep_org_src_dir} ${grep_src_base} || return
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
	unpack ${global_org_src_dir} ${global_src_base} || return
	[ -f ${global_org_src_dir}/Makefile ] ||
		(cd ${global_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--with-ncurses=`get_prefix curses.h ncurses` CPPFLAGS="${CPPFLAGS} -I${prefix}/include/ncurses") || return
	make -C ${global_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${global_org_src_dir} -j ${jobs} -k check || return
	make -C ${global_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_pcre2()
{
	[ -f ${prefix}/include/pcre2.h -a "${force_install}" != yes ] && return
	fetch pcre2 || return
	unpack ${pcre2_org_src_dir} ${pcre2_src_base} || return
	[ -f ${pcre2_org_src_dir}/Makefile ] ||
		(cd ${pcre2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${pcre2_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pcre2_org_src_dir} -j ${jobs} -k check || return
	make -C ${pcre2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
}

install_native_the_silver_searcher()
{
	[ -x ${prefix}/bin/ag -a "${force_install}" != yes ] && return
	search_header pcre2.h > /dev/null || install_native_pcre2 || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header lzma.h > /dev/null || install_native_xz || return
	fetch the_silver_searcher || return
	unpack ${the_silver_searcher_org_src_dir} ${the_silver_searcher_src_base} || return
	[ -f ${the_silver_searcher_org_src_dir}/Makefile ] ||
		(cd ${the_silver_searcher_org_src_dir}
		update_pkg_config_path
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules) || return
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
	unpack ${the_platinum_searcher_org_src_dir} ${the_platinum_searcher_src_base} || return
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
	unpack ${highway_org_src_dir} ${highway_src_base} || return
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
	unpack ${graphviz_org_src_dir} ${graphviz_src_base} || return
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
	unpack ${doxygen_org_src_dir} ${doxygen_src_base} || return
	mkdir -pv ${doxygen_bld_dir_ntv}
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
	unpack ${diffutils_org_src_dir} ${diffutils_src_base} || return
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
	unpack ${patch_org_src_dir} ${patch_src_base} || return
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
	unpack ${findutils_org_src_dir} ${findutils_src_base} || return
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
	unpack ${screen_org_src_dir} ${screen_src_base} || return
	[ -f ${screen_org_src_dir}/Makefile ] ||
		(cd ${screen_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--enable-colors256 --enable-rxvt_osc) || return
	make -C ${screen_org_src_dir} -j ${jobs} || return
	mkdir -pv ${prefix}/share/screen/utf8encodings || return
	make -C ${screen_org_src_dir} -j ${jobs} install || return
}

install_native_libevent()
{
	[ -f ${prefix}/include/event2/event.h -a "${force_install}" != yes ] && return
	fetch libevent || return
	unpack ${libevent_org_src_dir}-stable ${libevent_src_base} || return
	[ -f ${libevent_org_src_dir}-stable/Makefile ] ||
		(cd ${libevent_org_src_dir}-stable
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${libevent_org_src_dir}-stable -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libevent_org_src_dir}-stable -j ${jobs} -k check || return
	make -C ${libevent_org_src_dir}-stable -j ${jobs} install || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_tmux()
{
	[ -x ${prefix}/bin/tmux -a "${force_install}" != yes ] && return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_header event.h event2 > /dev/null || install_native_libevent || return
	fetch tmux || return
	unpack ${tmux_org_src_dir} ${tmux_src_base} || return
	[ -f ${tmux_org_src_dir}/Makefile ] ||
		(cd ${tmux_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			CPPFLAGS="${CPPFLAGS} -I${prefix}/include/ncurses") || return
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
	unpack ${expect_org_src_dir} ${expect_src_base} || return
	[ -f ${expect_org_src_dir}/Makefile ] ||
		(cd ${expect_org_src_dir}
		./configure --prefix=${prefix} --build=${build} --enable-threads \
			--enable-64bit --with-tcl=`search_library_dir tclConfig.sh`) || return
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
	unpack ${dejagnu_org_src_dir} ${dejagnu_src_base} || return
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
	unpack ${zsh_org_src_dir} ${zsh_src_base} || return
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
	unpack ${bash_org_src_dir} ${bash_src_base} || return
	[ -f ${bash_org_src_dir}/Makefile ] ||
		(cd ${bash_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${bash_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${bash_org_src_dir} -j ${jobs} -k check || return
	make -C ${bash_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_pkg_config_path || return
	ln -fs ./bash ${prefix}/bin/sh || return
}

install_native_inetutils()
{
	[ -x ${prefix}/bin/telnet -a "${force_install}" != yes ] && return
	fetch inetutils || return
	unpack ${inetutils_org_src_dir} ${inetutils_src_base} || return
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
	unpack ${openssl_org_src_dir} ${openssl_src_base} || return
	(cd ${openssl_org_src_dir}
	./config --prefix=${prefix} shared) || return
	make -C ${openssl_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${openssl_org_src_dir} -j ${jobs} -k test || return
	make -C ${openssl_org_src_dir} -j ${jobs} install || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_openssh()
{
	[ -x ${prefix}/bin/ssh -a "${force_install}" != yes ] && return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	fetch openssh || return
	unpack ${openssh_org_src_dir} ${openssh_src_base} || return
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
	unpack ${curl_org_src_dir} ${curl_src_base} || return
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
	update_search_path || return
	update_pkg_config_path || return
}

install_native_asciidoc()
{
	[ -x ${prefix}/bin/asciidoc -a "${force_install}" != yes ] && return
	fetch asciidoc || return
	unpack ${asciidoc_org_src_dir} ${asciidoc_src_base} || return
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
	unpack ${libxml2_org_src_dir} ${libxml2_src_base} || return
	[ -f ${libxml2_org_src_dir}/Makefile ] ||
		(cd ${libxml2_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--without-python --disable-silent-rules) || return
	make -C ${libxml2_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libxml2_org_src_dir} -j ${jobs} -k check || return
	make -C ${libxml2_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
	update_pkg_config_path || return
}

install_native_libxslt()
{
	[ -d ${prefix}/include/libxslt -a "${force_install}" != yes ] && return
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	fetch libxslt || return
	unpack ${libxslt_org_src_dir} ${libxslt_src_base} || return
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
	unpack ${xmlto_org_src_dir} ${xmlto_src_base} || return
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
	unpack ${gettext_org_src_dir} ${gettext_src_base} || return
	[ -f ${gettext_org_src_dir}/Makefile ] ||
		(cd ${gettext_org_src_dir}
		./configure --prefix=${prefix} --build=${build}) || return
	make -C ${gettext_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gettext_org_src_dir} -j ${jobs} -k check || return
	make -C ${gettext_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_search_path || return
}

install_native_git()
{
	[ -x ${prefix}/bin/git -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	search_header ssl.h openssl > /dev/null || install_native_openssl || return
	search_header curl.h curl > /dev/null || install_native_curl || return
	which asciidoc > /dev/null || install_native_asciidoc || return
	which xmlto > /dev/null || install_native_xmlto || return
	search_header xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	search_header xslt.h libxslt > /dev/null || install_native_libxslt || return
	which msgfmt > /dev/null || install_native_gettext || return
	which perl > /dev/null || install_native_perl || return
	which wish > /dev/null || install_native_tk || return
	fetch git || return
	unpack ${git_org_src_dir} ${git_src_base} || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 configure || return
	(cd ${git_org_src_dir}
	./configure --prefix=${prefix} --build=${build}) || return
	sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_org_src_dir}/Makefile || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 LDFLAGS="${LDFLAGS} -ldl" all || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 doc || return
	[ "${enable_check}" != yes ] ||
		make -C ${git_org_src_dir} -j ${jobs} V=1 -k test || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 ${strip} install || return
	make -C ${git_org_src_dir} -j ${jobs} V=1 ${strip} install-doc install-html || return
}

install_native_mercurial()
{
	[ -x ${prefix}/bin/hg -a "${force_install}" != yes ] && return
	which python > /dev/null || install_native_python || return
	fetch mercurial || return
	unpack ${mercurial_org_src_dir} ${mercurial_src_base} || return
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
	unpack ${sqlite_autoconf_org_src_dir} ${sqlite_autoconf_src_base} || return
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
	unpack ${apr_org_src_dir} ${apr_src_base} || return
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
	unpack ${apr_util_org_src_dir} ${apr_util_src_base} || return
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
	unpack ${subversion_org_src_dir} ${subversion_src_base} || return
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
	unpack ${cmake_org_src_dir} ${cmake_src_base} || return
	[ -f ${cmake_org_src_dir}/Makefile ] ||
		(cd ${cmake_org_src_dir}
		./bootstrap --prefix=${prefix} --parallel=${jobs} \
			--system-curl --system-zlib --system-bzip2 --system-liblzma) || return
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
	unpack ${libedit_org_src_dir} ${libedit_src_base} || return
	[ -f ${libedit_org_src_dir}/Makefile ] ||
		(cd ${libedit_org_src_dir}
		./configure --prefix=${prefix} --build=${build} \
			--disable-silent-rules CFLAGS="${CFLAGS} -I${prefix}/include/ncurses") || return
	make -C ${libedit_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libedit_org_src_dir} -j ${jobs} -k check || return
	make -C ${libedit_org_src_dir} -j ${jobs} install || return
	update_pkg_config_path || return
}

install_native_swig()
{
	[ -x ${prefix}/bin/swig -a "${force_install}" != yes ] && return
	fetch swig || return
	unpack ${swig_org_src_dir} ${swig_src_base} || return
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
	unpack ${llvm_org_src_dir} ${llvm_src_base} || return
	mkdir -pv ${llvm_bld_dir}
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
	unpack ${libcxx_org_src_dir} ${libcxx_src_base} || return
	mkdir -pv ${libcxx_bld_dir}
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
	unpack ${libcxxabi_org_src_dir} ${libcxxabi_src_base} || return
	sed -ie '/set(LLVM_CMAKE_PATH /s%share/llvm/cmake%lib/cmake/llvm%' ${libcxxabi_org_src_dir}/CMakeLists.txt || return # [XXX] workaround for LLVM 3.9.0
	mkdir -pv ${libcxxabi_bld_dir}
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
	unpack ${compiler_rt_org_src_dir} ${compiler_rt_src_base} || return
	mkdir -pv ${compiler_rt_bld_dir}
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
	unpack ${cfe_org_src_dir} ${cfe_src_base} || return
	mkdir -pv ${cfe_bld_dir}
	[ -f ${cfe_bld_dir}/Makefile ] ||
		(cd ${cfe_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${cfe_org_src_dir}) || return
	make -C ${cfe_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cfe_bld_dir} -j ${jobs} -k check-all || return
	make -C ${cfe_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_clang_tools_extra()
{
	which cmake > /dev/null || install_native_cmake || return
	fetch clang-tools-extra || return
	unpack ${clang_tools_extra_org_src_dir} ${clang_tools_extra_src_base} || return
	mkdir -pv ${clang_tools_extra_bld_dir}
	[ -f ${clang_tools_extra_bld_dir}/Makefile ] ||
		(cd ${clang_tools_extra_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-gcc} -DCMAKE_CXX_COMPILER=${CXX:-g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${clang_tools_extra_org_src_dir}) || return
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} || return
	make -C ${clang_tools_extra_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_lld()
{
	[ -x ${prefix}/bin/lld -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} ${llvm_src_base} || return
	fetch lld || return
	[ -d ${llvm_org_src_dir}/tools/lld ] ||
		(unpack ${lld_org_src_dir} ${lld_src_base} &&
		mv -v ${lld_org_src_dir} ${llvm_org_src_dir}/tools/lld) || return
	mkdir -pv ${lld_bld_dir}
	[ -f ${lld_bld_dir}/Makefile ] ||
		(cd ${lld_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${llvm_org_src_dir}) || return
	make -C ${lld_bld_dir} -j ${jobs} || return
	make -C ${lld_bld_dir} -j ${jobs} check-lld || return
	make -C ${lld_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_lldb()
{
	[ -x ${prefix}/bin/lldb -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	search_header histedit.h > /dev/null || install_native_libedit || return
	which swig > /dev/null || install_native_swig || return
	fetch llvm || return
	unpack ${llvm_org_src_dir} ${llvm_src_base} || return
	fetch lldb || return
	[ -d ${llvm_org_src_dir}/tools/lldb ] ||
		(unpack ${lldb_org_src_dir} ${lldb_src_base} &&
		mv -v ${lldb_org_src_dir} ${llvm_org_src_dir}/tools/lldb) || return
	mkdir -pv ${lldb_bld_dir}
	[ -f ${lldb_bld_dir}/Makefile ] ||
		(cd ${lldb_bld_dir}
		cmake -DCMAKE_C_COMPILER=${CC:-clang} -DCMAKE_CXX_COMPILER=${CXX:-clang++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} ${llvm_org_src_dir}) || return
	make -C ${lldb_bld_dir} -j ${jobs} || return
	make -C ${lldb_bld_dir} -j ${jobs} check-lldb || return
	make -C ${lldb_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_boost()
{
	[ -d ${prefix}/include/boost -a "${force_install}" != yes ] && return
	search_header bzlib.h > /dev/null || install_native_bzip2 || return
	fetch boost || return
	unpack ${boost_org_src_dir} ${boost_src_base} || return
	(cd ${boost_org_src_dir}
	./bootstrap.sh --prefix=${prefix} --with-toolset=gcc &&
	./b2 --prefix=${prefix} --build-dir=${boost_bld_dir_ntv} \
		--layout=system --build-type=minimal -j ${jobs} -q \
		include=${prefix}/include library-path=${prefix}/lib install) || return
}

install_cross_binutils()
{
	[ -x ${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "target(${target}) must be different from build(${build})" >&2 || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	which yacc > /dev/null || install_native_bison || return
	fetch binutils || return
	[ -d ${binutils_src_dir_crs} ] ||
		(unpack ${binutils_org_src_dir} ${binutils_src_base} &&
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
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_crs_1st}
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_1st} -j ${jobs} -k check-gcc || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return
}

install_cross_linux_header()
{
	fetch linux || return
	[ -d ${linux_src_dir_crs} ] ||
		(unpack ${linux_org_src_dir} ${linux_src_base} &&
			mv -v ${linux_org_src_dir} ${linux_src_dir_crs}) || return
	make -C ${linux_src_dir_crs} -j ${jobs} mrproper || return
	make -C ${linux_src_dir_crs} -j ${jobs} \
		ARCH=${cross_linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return
}

install_cross_glibc_headers()
{
	which awk > /dev/null || install_native_gawk || return
	which gperf > /dev/null || install_native_gperf || return
	fetch glibc || return
	[ -d ${glibc_src_dir_crs_hdr} ] ||
		(unpack ${glibc_org_src_dir} ${glibc_src_base} &&
			mv -v ${glibc_org_src_dir} ${glibc_src_dir_crs_hdr}) || return
	mkdir -pv ${glibc_bld_dir_crs_hdr}
	[ -f ${glibc_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${glibc_bld_dir_crs_hdr}
		LD_LIBRARY_PATH='' ${glibc_src_dir_crs_hdr}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return
	make -C ${glibc_bld_dir_crs_hdr} -j ${jobs} DESTDIR=${sysroot} install-headers || return
}

install_cross_gcc_with_glibc_headers()
{
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` --with-sysroot=${sysroot} --with-newlib \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-gcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k check-gcc || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-gcc || return
	touch ${sysroot}/usr/include/gnu/stubs.h
	touch ${sysroot}/usr/include/gnu/stubs-soft.h
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-target-libgcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k check-target-libgcc || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-target-libgcc || return
}

install_cross_1st_glibc()
{
	[ -d ${glibc_src_dir_crs_1st} ] ||
		(unpack ${glibc_org_src_dir} ${glibc_src_base} &&
			mv -v ${glibc_org_src_dir} ${glibc_src_dir_crs_1st}) || return

	[ ${cross_linux_arch} = microblaze ] &&
		(cd ${glibc_src_dir_crs_1st}; patch -N -p0 -d ${glibc_src_dir_crs_1st} <<EOF || [ $? = 1 ] || return
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

	mkdir -pv ${glibc_bld_dir_crs_1st}
	[ -f ${glibc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${glibc_bld_dir_crs_1st}
		LD_LIBRARY_PATH='' ${glibc_src_dir_crs_1st}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include CFLAGS="${CFLAGS} -Wno-error=parentheses -O2" \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} AR=${target}-ar || return
	[ "${enable_check}" != yes ] ||
		make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} -k check || return
	make -C ${glibc_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_cross_functional_gcc()
{
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_crs_3rd}
	[ -f ${gcc_bld_dir_crs_3rd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_3rd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=${languages} --disable-multilib --without-isl --with-system-zlib \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` \
			--enable-libstdcxx-debug --with-sysroot=${sysroot} ${strip:+STRIP=${target}-strip}) || return
	LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		LIBS=-lgcc_s make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir_crs_3rd} -j ${jobs} -k install${strip:+-${strip}} || true # [XXX] install-stripを強行する(現状gotoolsだけ失敗する)ため、-kと|| trueで暫定対応(WA)
}

install_cross_gcc()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "target(${target}) must be different from build(${build})" >&2 || return
	which ${target}-as > /dev/null || install_cross_binutils || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	install_cross_gcc_without_headers || return
	install_cross_linux_header || return
	install_cross_glibc_headers || return
	install_cross_gcc_with_glibc_headers || return
	install_cross_1st_glibc || return
	install_cross_functional_gcc || return
}

install_cross_gdb()
{
	[ -x ${prefix}/bin/${target}-gdb -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "target(${target}) must be different from build(${build})" >&2 || return
	search_header readline.h readline > /dev/null || install_native_readline || return
	search_header curses.h ncurses > /dev/null || install_native_ncurses || return
	search_header Python.h > /dev/null || install_native_python || return
	fetch gdb || return
	unpack ${gdb_org_src_dir} ${gdb_src_base} || return
	mkdir -pv ${gdb_bld_dir_crs}
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

install_mingw_w64_binutils()
{
	[ -x ${prefix}/bin/x86_64-w64-mingw32-as -a "${force_install}" != yes ] && return
	prev_target=${target}; target=x86_64-w64-mingw32
	set_variables || return
	install_cross_binutils || return
	target=${prev_target}
	set_variables || return
}

install_mingw_w64_header()
{
	fetch mingw-w64 || return
	[ -d ${mingw_w64_src_dir_crs_hdr} ] ||
		(unpack ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv -v ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_hdr}) || return
	mkdir -pv ${mingw_w64_bld_dir_crs_hdr}
	[ -f ${mingw_w64_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_hdr}
		${mingw_w64_src_dir_crs_hdr}/configure --prefix=/mingw --build=${build} --host=${target} \
			--disable-multilib --without-crt --with-sysroot=${sysroot}) || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_mingw_w64_gcc_with_mingw_w64_header()
{
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_crs_2nd}
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`get_prefix gmp.h` --with-mpfr=`get_prefix mpfr.h` --with-mpc=`get_prefix mpc.h` \
			--enable-languages=c --disable-multilib --without-isl --with-system-zlib --with-sysroot=${sysroot} \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
		) || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} all-gcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k check-gcc || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} install-gcc || return
}

install_mingw_w64_crt()
{
	[ -d ${mingw_w64_src_dir_crs_1st} ] ||
		(unpack ${mingw_w64_org_src_dir} ${mingw_w64_src_base} &&
			mv -v ${mingw_w64_org_src_dir} ${mingw_w64_src_dir_crs_1st}) || return
	mkdir -pv ${mingw_w64_bld_dir_crs_1st}
	[ -f ${mingw_w64_bld_dir_crs_1st}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_1st}
		${mingw_w64_src_dir_crs_1st}/configure --prefix=/mingw --build=${build} --host=${target} \
			--disable-multilib --without-header --with-sysroot=${sysroot} \
		) || return
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs_1st} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_mingw_w64_gcc()
{
	[ -x ${prefix}/bin/x86_64-w64-mingw32-gcc -a "${force_install}" != yes ] && return
	prev_target=${target}; target=x86_64-w64-mingw32
	prev_languages=${languages}; languages=c,c++
	set_variables || return
	install_cross_binutils || return
	[ ${build} != ${target} ] || ! echo "target(${target}) must be different from build(${build})" >&2 || return
	search_header gmp.h > /dev/null || install_native_gmp || return
	search_header mpfr.h > /dev/null || install_native_mpfr || return
	search_header mpc.h > /dev/null || install_native_mpc || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	install_cross_gcc_without_headers || return
	install_mingw_w64_header || return
	install_mingw_w64_gcc_with_mingw_w64_header || return
	install_mingw_w64_crt || return
	install_cross_functional_gcc || return
	target=${prev_target}
	languages=${prev_languages}
	set_variables || return
}

install_native_python()
{
	[ -x ${prefix}/bin/python3 -a "${force_install}" != yes ] && return
	fetch Python || return
	unpack ${Python_org_src_dir} ${Python_src_base} || return
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
	unpack ${ruby_org_src_dir} ${ruby_src_base} || return
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
	[ -d ${go_org_src_dir} ] || unpack ${go_src_base}/go${go_ver}.src ${go_src_base} || return
	[ -d ${go_src_base}/go ] && mv -v ${go_src_base}/go ${go_org_src_dir}
	(cd ${go_org_src_dir}/src
	CGO_CPPFLAGS=-I${prefix}/include GOROOT_BOOTSTRAP=${prefix} \
		GOROOT=${go_org_src_dir} GOROOT_FINAL=${prefix}/go ${go_org_src_dir}/src/make.bash) || return
	[ ! -d ${prefix}/go ] || rm -fr ${prefix}/go || return
	mv -v ${go_org_src_dir} ${prefix}/go || return
	${prefix}/go/bin/go get golang.org/x/tools/cmd/... || return
}

install_native_perl()
{
	[ -x ${prefix}/bin/perl -a "${force_install}" != yes ] && return
	fetch perl || return
	unpack ${perl_org_src_dir} ${perl_src_base} || return
	(cd ${perl_org_src_dir}
	./Configure -de -Dprefix=${prefix} -Dcc=${CC:-gcc} \
		-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits \
		-Duseshrplib) || return
	make -C ${perl_org_src_dir} -j ${jobs} || return
	make -C ${perl_org_src_dir} -j ${jobs} test || return
	make -C ${perl_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_tcl()
{
	[ -x ${prefix}/bin/tclsh -a "${force_install}" != yes ] && return
	fetch tcl || return
	unpack ${tcl_org_src_dir} ${tcl_src_base} || return
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
	ln -fsv ./tclsh`echo ${tcl_ver} | cut -d. -f-2` ${prefix}/bin/tclsh || return
}

install_native_tk()
{
	[ -x ${prefix}/bin/wish -a "${force_install}" != yes ] && return
	search_library tclConfig.sh > /dev/null || install_native_tcl || return
	fetch tk || return
	unpack ${tk_org_src_dir} ${tk_src_base} || return
	[ -f ${tk_org_src_dir}/unix/Makefile ] ||
		(cd ${tk_org_src_dir}/unix
		./configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --enable-64bit --enable-man-symlinks) || return
	make -C ${tk_org_src_dir}/unix -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tk_org_src_dir}/unix -j ${jobs} -k test || return
	make -C ${tk_org_src_dir}/unix -j ${jobs} install${strip:+-${strip}} || return
	ln -fsv ./wish`echo ${tk_ver} | cut -d. -f-2` ${prefix}/bin/wish || return
}

install_native_libunistring()
{
	[ -r ${prefix}/include/unistr.h -a "${force_install}" != yes ] && return
	fetch libunistring || return
	unpack ${libunistring_org_src_dir} ${libunistring_src_base} || return
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
	[ -r ${prefix}/include/atomic_ops.h -a "${force_install}" != yes ] && return
	fetch libatomic_ops || return
	unpack ${libatomic_ops_org_src_dir} ${libatomic_ops_src_base} || return
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
	[ -r ${prefix}/include/gc.h -a "${force_install}" != yes ] && return
	search_header atomic_ops.h > /dev/null || install_native_libatomic_ops || return
	fetch gc || return
	unpack ${gc_org_src_dir} ${gc_src_base} || return
	[ -f ${gc_org_src_dir}/Makefile ] ||
		(cd ${gc_org_src_dir}
		./configure --prefix=${prefix} -build=${build} --disable-silent-rules) || return
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
	unpack ${guile_org_src_dir} ${guile_src_base} || return
	[ -f ${guile_org_src_dir}/Makefile ] ||
		(cd ${guile_org_src_dir}
		./configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --with-libunistring-prefix=`get_prefix unistr.h`) || return
	make -C ${guile_org_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${guile_org_src_dir} -j ${jobs} -k check || return
	make -C ${guile_org_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_yasm()
{
	[ -x ${prefix}/bin/yasm -a "${force_install}" != yes ] && return
	fetch yasm || return
	unpack ${yasm_org_src_dir} ${yasm_src_base} || return
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
		(unpack ${x264_org_src_dir} ${x264_src_base} &&
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
		(unpack ${x265_org_src_dir} ${x265_src_base} &&
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
		unpack ${libav_org_src_dir} ${libav_src_base} || return
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
	unpack ${opencv_org_src_dir} ${opencv_src_base} || return
	fetch opencv_contrib || return
	unpack ${opencv_contrib_org_src_dir} ${opencv_contrib_src_base} || return
	mkdir -pv ${opencv_bld_dir_ntv}
	(cd ${opencv_bld_dir_ntv}
	libdirs="-L`search_library_dir libpng.so` -L`search_library_dir libtiff.so` -L`search_library_dir libjpeg.so` -L${prefix}/lib"
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

install_crossed_native_binutils()
{
	[ -x ${sysroot}/usr/bin/as -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	search_header zlib.h > /dev/null || install_native_zlib || return
	which yacc > /dev/null || install_native_bison || return
	fetch binutils || return
	[ -d ${binutils_src_dir_crs_ntv} ] ||
		(unpack ${binutils_org_src_dir} ${binutils_src_base} &&
			mv -v ${binutils_org_src_dir} ${binutils_src_dir_crs_ntv}) || return
	[ -f ${binutils_src_dir_crs_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-sysroot=/ \
			--enable-64-bit-bfd --enable-gold --enable-targets=all --with-system-zlib \
			CFLAGS="${CFLAGS} -Wno-error=unused-const-variable -Wno-error=misleading-indentation -Wno-error=shift-negative-value" \
			CXXFLAGS="${CXXFLAGS} -Wno-error=unused-function") || return
	make -C ${binutils_src_dir_crs_ntv} -j 1 || return
	make -C ${binutils_src_dir_crs_ntv} -j 1 DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_gmp()
{
	[ -f ${sysroot}/usr/include/gmp.h -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	fetch gmp || return
	[ -d ${gmp_src_dir_crs_ntv} ] ||
		(unpack ${gmp_org_src_dir} ${gmp_src_base} &&
			mv -v ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --enable-cxx) || return
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${gmp_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_mpfr()
{
	[ -f ${sysroot}/usr/include/mpfr.h -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	fetch mpfr || return
	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(unpack ${mpfr_org_src_dir} ${mpfr_src_base} &&
			mv -v ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-gmp=${sysroot}/usr) || return
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${mpfr_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
	sed -i -e /^dependency_libs=/s/\'.\*\'\$/\'\'/ ${sysroot}/usr/lib/libmpfr.la || return
	# [XXX] mpcビルド時に、mpfrが依存しているgmpを参照しようとしてlibmpfr.laの不整合に
	#       引っかからないようにするために、強行的にlibmpfr.la書き換えてる。
}

install_crossed_native_mpc()
{
	[ -f ${sysroot}/usr/include/mpc.h -a "${force_install}" != yes ] && return
	[ ${build} = ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	fetch mpc || return
	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(unpack ${mpc_org_src_dir} ${mpc_src_base} &&
			mv -v ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr) || return
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${mpc_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_gcc()
{
	[ -x ${sysroot}/usr/bin/gcc -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	install_crossed_native_zlib || return
	[ -f ${sysroot}/usr/include/gmp.h ] || install_crossed_native_gmp || return
	[ -f ${sysroot}/usr/include/mpfr.h ] || install_crossed_native_mpfr || return
	[ -f ${sysroot}/usr/include/mpc.h ] || install_crossed_native_mpc || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack ${gcc_org_src_dir} ${gcc_src_base} || return
	mkdir -pv ${gcc_bld_dir_crs_ntv}
	[ -f ${gcc_bld_dir_crs_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_ntv}
		${gcc_org_src_dir}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr --with-mpc=${sysroot}/usr \
			--enable-languages=${languages} --with-sysroot=/ --without-isl --with-system-zlib \
			--enable-libstdcxx-debug \
			CC_FOR_TARGET=${target}-gcc CXX_FOR_TARGET=${target}-g++ GOC_FOR_TARGET=${target}-gccgo) || return
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} || return
	make -C ${gcc_bld_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_zlib()
{
	[ -f ${sysroot}/usr/include/zlib.h -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	fetch zlib || return
	[ -d ${zlib_src_dir_crs_ntv} ] ||
		(unpack ${zlib_org_src_dir} ${zlib_src_base} &&
			mv -v ${zlib_org_src_dir} ${zlib_src_dir_crs_ntv}) || return
	(cd ${zlib_src_dir_crs_ntv}
	CC=${target}-gcc AR=${target}-ar RANLIB=${target}-ranlib ./configure --prefix=/usr) || return
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${zlib_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install || return
}

install_crossed_native_libpng()
{
	[ -f ${sysroot}/usr/include/png.h -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	install_crossed_native_zlib || return
	fetch libpng || return
	[ -d ${libpng_src_dir_crs_ntv} ] ||
		(unpack ${libpng_org_src_dir} ${libpng_src_base} &&
			mv -v ${libpng_org_src_dir} ${libpng_src_dir_crs_ntv}) || return
	[ -f ${libpng_src_dir_crs_ntv}/Makefile ] ||
		(cd ${libpng_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=${target} \
			CPPFLAGS="-I ${sysroot}/include ${CPPFLAGS}") || return
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${libpng_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

install_crossed_native_libtiff()
{
	[ -f ${sysroot}/usr/include/tiffio.h -a "${force_install}" != yes ] && return
	[ ${build} != ${target} ] || ! echo "host(${target}) must be different from build(${build})" >&2 || return
	fetch tiff || return
	[ -d ${tiff_src_dir_crs_ntv} ] ||
		(unpack ${tiff_org_src_dir} ${tiff_src_base} &&
			mv -v ${tiff_org_src_dir} ${tiff_src_dir_crs_ntv}) || return
	[ -f ${tiff_src_dir_crs_ntv}/Makefile ] ||
		(cd ${tiff_src_dir_crs_ntv}
		./configure --prefix=/usr --build=${build} --host=`echo ${target} | sed -e 's/arm[^-]\+/arm/'` \
			CC=${target}-gcc CXX=${target}-g++ AS=${target}-as STRIP=${target}-strip RANLIB=${target}-ranlib) || return
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} || return
	make -C ${tiff_src_dir_crs_ntv} -j ${jobs} DESTDIR=${sysroot} install${strip:+-${strip}} || return
}

while getopts p:j:f:c:l:t:h arg; do
	case ${arg} in
	p)  prefix=${OPTARG};;
	j)  jobs=${OPTARG};;
	f)  enable_ccache=${OPTARG};;
	c)  enable_check=${OPTARG};;
	l)  languages=${OPTARG};;
	t)  target=${OPTARG};;
	h)  set_variables || true; help; exit 0;;
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
				|| exec bash --noprofile --norc --posix -e ${0} -p ${prefix} -t ${target} -j ${jobs} shell
		   count=`expr ${count} + 1`;;
	*=*)   eval export ${1}; set_variables;;
	*)     eval ${1} || exit 1; count=`expr ${count} + 1`;;
	esac
	shift
done
[ ${count} -eq 0 ] && usage || exit 0
