#!/bin/sh

default_prefix=/usr/local
default_host=aarch64-linux-gnu
default_jobs=`grep -e '^processor\>' -c /proc/cpuinfo`
src_dir=`readlink -m ./src`
DESTDIR=`readlink -m ./artifacts`

help()
{
	cat << EOF
[NAME]
    `basename ${0}` - create toolchain running on the target itself

[SYNOPSIS]
    `basename ${0}` [--prefix PREFIX] [--host HOST] [--jobs JOBS]
        [-all] [--fetch-only] [--force] [--strip] [--cleanup] [--copy-libc]
        [--help] [packages...]

[OPTIONS]
    --prefix PREFIX [default: ${default_prefix}]
        specify prefix for the built toolchain on the target.
        this may be hardcoded to the built toolchain.
        the built toolchain is installed at
          "HOST/PREFIX".
        copy them to the target filesystem.

    --host HOST [default: ${default_host}]
        specify triplet of the platform on which the built toolchain runs.

    --jobs JOBS [default: ${default_jobs}]
        specify the number of jobs to run simultaneously.

    --all
        build/install all packages listed bellow.

    --fetch-only
        fetch source packages, but do not build/install them.
        the fetched packages are saved at
          "${src_dir}".

    --force
        do build/install even if it seems the specified package already
        has been installed.

    --strip
        remove symbol sections from built files while installation process.

    --cleanup
        remove the source and build directories of the just installed package,
        when installation has been completed.

    --copy-libc
        copy standard C library header files, crt*.o, and so on.

    --help
        show this help.

[EXAMPLES]
    * install minimum toolchain
        \$ `basename ${0}` --strip --cleanup --copy-libc gcc make

    * install debugging tools
        \$ `basename ${0}` --strip --cleanup gdb strace systemtap

    * install extra toolchain
        \$ `basename ${0}` --strip --cleanup \\
                    m4 autoconf automake libtool pkg-config git

    * install tools required by linux kernel development
        \$ `basename ${0}` --strip --cleanup ed bc rsync dtc

    * install terminal multiplexers
        \$ `basename ${0}` --strip --cleanup screen tmux

    * install text editing/coding tools
        \$ `basename ${0}` --strip --cleanup \\
                    vim ctags grep diffutils patch global

    * install clang/clang++ compilers
        \$ `basename ${0}` --strip --cleanup --copy-libc clang

    * install other programming languages
        \$ `basename ${0}` --strip --cleanup Python ruby go

    * install all packages with libc, but with no symbol information
        \$ `basename ${0}` --all --strip --cleanup --copy-libc

[PACKAGES]
`print_packages | tr '\n' ' ' | fold -s | sed -e 's/^/    /'`

EOF
}

: ${zlib_ver:=1.2.11}
: ${binutils_ver:=2.35}
: ${gmp_ver:=6.2.0}
: ${mpfr_ver:=4.1.0}
: ${mpc_ver:=1.2.0}
: ${isl_ver:=0.20}
: ${gcc_ver:=10.2.0}
: ${make_ver:=4.3}

: ${ncurses_ver:=6.2}
: ${readline_ver:=8.0}
: ${expat_ver:=2.2.9}
: ${libffi_ver:=3.3}
: ${openssl_ver:=1.1.1g}
: ${Python_ver:=3.8.5}
: ${boost_ver:=1_74_0}
: ${source_highlight_ver:=3.1.9}
: ${bzip2_ver:=1.0.8}
: ${xz_ver:=5.2.5}
: ${elfutils_ver:=0.178}
: ${pcre_ver:=8.43}
: ${pcre2_ver:=10.32}
: ${util_linux_ver:=2.35.1}
: ${popt_ver:=1.16}
: ${glib_ver:=2.59.0}
: ${babeltrace_ver:=1.5.6}
: ${gdb_ver:=9.2}
: ${strace_ver:=5.5}
: ${systemtap_ver:=4.2}
: ${libpcap_ver:=1.9.1}
: ${tcpdump_ver:=4.9.3}

: ${m4_ver:=1.4.18}
: ${perl_ver:=5.30.3}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.16.2}
: ${bison_ver:=3.7.1}
: ${flex_ver:=2.6.4}
: ${libtool_ver:=2.4.6}
: ${pkg_config_ver:=0.29.2}
: ${gettext_ver:=0.21}
: ${curl_ver:=7.69.1}
: ${git_ver:=2.28.0}
: ${ed_ver:=1.16}
: ${bc_ver:=1.07.1}
: ${rsync_ver:=3.1.3}
: ${dtc_ver:=1.6.0}

: ${screen_ver:=4.8.0}
: ${libevent_ver:=2.1.11-stable}
: ${tmux_ver:=3.1b}
: ${vim_ver:=8.2.1127}
: ${vimdoc_ja_ver:=master}
: ${ctags_ver:=git}
: ${grep_ver:=3.4}
: ${diffutils_ver:=3.7}
: ${patch_ver:=2.7.6}
: ${global_ver:=6.6.4}

: ${ruby_ver:=2.7.1}
: ${go_ver:=1.14.7}
: ${cmake_ver:=3.17.2}
: ${llvm_ver:=10.0.0}
: ${compiler_rt_ver:=${llvm_ver}}
: ${libunwind_ver:=${llvm_ver}}
: ${libcxxabi_ver:=${llvm_ver}}
: ${libcxx_ver:=${llvm_ver}}
: ${clang_ver:=${llvm_ver}}
: ${clang_tools_extra_ver:=${llvm_ver}}
: ${lld_ver:=${llvm_ver}}
: ${lldb_ver:=${llvm_ver}}

: ${prefix:=${default_prefix}}
: ${host:=${default_host}}
: ${jobs:=${default_jobs}}
: ${strip:=}
: ${cleanup:=}

: ${cmake_build_type:=Release}

build=`gcc -dumpmachine`

init()
{
	_1=`echo ${1} | tr - _`
	eval ${_1}_src_base=${src_dir}/${1}

	case ${1} in
	llvm|compiler-rt|libunwind|libcxxabi|libcxx|clang|clang-tools-extra|lld|lldb)
		eval ${_1}_ver=${llvm_ver}
		eval ${_1}_name=${1}-\${${_1}_ver}.src
		eval ${_1}_src_dir=\${${_1}_src_base}/\${${_1}_name}
		eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-${host}
		return 0
		;;
	esac

	case ${1} in
	boost)
		eval ${_1}_name=${1}_\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac
	eval ${_1}_src_dir=${src_dir}/${1}/\${${_1}_name}
	eval ${_1}_bld_dir=${src_dir}/${1}/\${${_1}_name}-${host}
}

check_archive()
{
	[ -f ${1}.tar.gz  -a -s ${1}.tar.gz  ] && return
	[ -f ${1}.tar.bz2 -a -s ${1}.tar.bz2 ] && return
	[ -f ${1}.tar.xz  -a -s ${1}.tar.xz  ] && return
	[ -f ${1}.tar.lz  -a -s ${1}.tar.lz  ] && return
	return 1
}

fetch()
{
	_1=`echo ${1} | tr - _`
	eval mkdir -pv \${${_1}_src_base} || return
	eval check_archive \${${_1}_src_dir} || \
		eval [ -d \${${_1}_src_dir} -o -h \${${_1}_src_dir} ] && return

	case ${1} in
	zlib)
		wget -O ${zlib_src_dir}.tar.xz \
			http://zlib.net/${zlib_name}.tar.xz || return;;
	binutils|gmp|mpfr|mpc|make|ncurses|readline|gdb|ed|bc|screen|m4|autoconf|automake|\
	bison|libtool|gettext|grep|diffutils|patch|global)
		for compress_format in xz bz2 gz lz; do
			eval wget -O \${${_1}_src_dir}.tar.${compress_format} \
				https://ftp.gnu.org/gnu/${1}/\${${_1}_name}.tar.${compress_format} \
					&& break \
					|| eval rm -v \${${_1}_src_dir}.tar.${compress_format}
		done || return;;
	isl)
		wget -O ${isl_src_dir}.tar.xz \
			http://isl.gforge.inria.fr/${isl_name}.tar.xz || return;;
	gcc)
		for compress_format in xz bz2 gz; do
			wget -O ${gcc_src_dir}.tar.${compress_format} \
				https://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.${compress_format} \
					&& break \
					|| rm -v ${gcc_src_dir}.tar.${compress_format}
		done || return;;
	expat)
		wget -O ${expat_src_dir}.tar.bz2 \
			https://sourceforge.net/projects/expat/files/expat/${expat_ver}/${expat_name}.tar.bz2/download || return;;
	libffi)
		wget -O ${libffi_src_dir}.tar.gz \
			http://mirrors.kernel.org/sourceware/libffi/${libffi_name}.tar.gz || return;;
	openssl)
		wget -O ${openssl_src_dir}.tar.gz \
			https://www.openssl.org/source/${openssl_name}.tar.gz ||
				wget -O ${openssl_src_dir}.tar.gz \
					http://www.openssl.org/source/old/`echo ${openssl_ver} | sed -e 's/[a-z]//g'`/${openssl_name}.tar.gz || return;;
	Python)
		wget -O ${Python_src_base}/Python-${Python_ver}.tar.xz \
			https://www.python.org/ftp/python/${Python_ver}/${Python_name}.tar.xz || return;;
	boost)
		wget --trust-server-names -O ${boost_src_dir}.tar.bz2 \
			https://dl.bintray.com/boostorg/release/`echo ${boost_ver} | tr _ .`/source/${boost_name}.tar.bz2 || return;;
	source-highlight)
		wget -O ${source_highlight_src_dir}.tar.gz \
			https://ftp.gnu.org/gnu/src-highlite/${source_highlight_name}.tar.gz || return;;
	bzip2)
		wget -O ${bzip2_src_dir}.tar.gz \
			https://www.sourceware.org/pub/bzip2/${bzip2_name}.tar.gz || return;;
	xz)
		wget -O ${xz_src_dir}.tar.bz2 \
			http://tukaani.org/xz/${xz_name}.tar.bz2 || return;;
	elfutils)
		wget -O ${elfutils_src_dir}.tar.bz2 \
			https://sourceware.org/elfutils/ftp/${elfutils_ver}/${elfutils_name}.tar.bz2 || return;;
	pcre|pcre2)
		eval wget -O \${${_1}_src_dir}.tar.bz2 \
			https://ftp.pcre.org/pub/pcre/\${${_1}_name}.tar.bz2 || return;;
	util-linux)
		wget -O ${util_linux_src_dir}.tar.xz \
			https://kernel.org/pub/linux/utils/util-linux/v`print_version util-linux`/${util_linux_name}.tar.xz || return;;
	popt)
		wget -O ${popt_src_dir}.tar.gz \
			http://anduin.linuxfromscratch.org/BLFS/popt/${popt_name}.tar.gz || return;;
	glib)
		wget -O ${glib_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/glib/`print_version glib`/${glib_name}.tar.xz || return;;
	babeltrace)
		wget -O ${babeltrace_src_dir}.tar.gz \
			https://github.com/efficios/babeltrace/archive/v${babeltrace_ver}.tar.gz || return;;
	strace)
		wget -O ${strace_src_dir}.tar.xz \
			https://strace.io/files/${strace_ver}/${strace_name}.tar.xz || return;;
	systemtap)
		wget -O ${systemtap_src_dir}.tar.gz \
			https://sourceware.org/systemtap/ftp/releases/${systemtap_name}.tar.gz || return;;
	libpcap|tcpdump)
		eval wget -O \${${_1}_src_dir}.tar.gz \
			http://www.tcpdump.org/release/\${${_1}_name}.tar.gz || return;;
	perl)
		wget -O ${perl_src_dir}.tar.gz \
			http://www.cpan.org/src/5.0/${perl_name}.tar.gz || return;;
	flex)
		wget -O ${flex_src_dir}.tar.gz \
			https://github.com/westes/flex/releases/download/v${flex_ver}/${flex_name}.tar.gz || return;;
	pkg-config)
		wget -O ${pkg_config_src_dir}.tar.gz \
			https://pkg-config.freedesktop.org/releases/${pkg_config_name}.tar.gz || return;;
	curl)
		wget -O ${curl_src_dir}.tar.bz2 \
			https://curl.haxx.se/download/${curl_name}.tar.bz2 || return;;
	git)
		wget -O ${git_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return;;
	rsync)
		wget -O ${rsync_src_dir}.tar.gz \
			https://download.samba.org/pub/rsync/src/${rsync_name}.tar.gz || return;;
	dtc)
		wget -O ${dtc_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/utils/dtc/${dtc_name}.tar.xz || return;;
	libevent)
		wget -O ${libevent_src_dir}.tar.gz \
			https://github.com/libevent/libevent/releases/download/release-${libevent_ver}/${libevent_name}.tar.gz || return;;
	tmux)
		wget -O ${tmux_src_dir}.tar.gz \
			https://github.com/tmux/tmux/releases/download/${tmux_ver}/${tmux_name}.tar.gz || return;;
	vim)
		wget -O ${vim_src_dir}.tar.gz \
			http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return;;
	vimdoc-ja)
		wget -O ${vimdoc_ja_src_dir}.tar.gz \
			https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz || return;;
	ctags)
		git clone --depth 1 \
			http://github.com/universal-ctags/ctags.git ${ctags_src_dir} || return;;
	ruby)
		wget -O ${ruby_src_dir}.tar.xz \
			http://cache.ruby-lang.org/pub/ruby/`print_version ruby`/${ruby_name}.tar.xz || return;;
	go)
		wget -O ${go_src_dir}.tar.gz \
			https://storage.googleapis.com/golang/go${go_ver}.src.tar.gz || return;;
	cmake)
		wget -O ${cmake_src_dir}.tar.gz \
			https://cmake.org/files/v`print_version cmake`/${cmake_name}.tar.gz || return;;
	llvm|compiler-rt|libunwind|libcxxabi|libcxx|clang|clang-tools-extra|lld|lldb)
		eval wget -O \${${_1}_src_dir}.tar.xz \
			https://github.com/llvm/llvm-project/releases/download/llvmorg-\${${_1}_ver}/\${${_1}_name}.tar.xz || return;;
	*) echo ERROR: not implemented. can not fetch \'${1}\'. >&2; return 1;;
	esac
}

unpack()
{
	_1=`echo ${1} | tr - _`
	eval mkdir -pv \${${_1}_bld_dir} || return
	eval d=\${${_1}_src_dir}
	[ -z "${2}" -a -d ${d} -o -d ${2}/`basename ${d}` ] && return
	${2:+eval mkdir -pv ${2} || return}
	[ -f ${d}.tar.gz  -a -s ${d}.tar.gz  ] && tar xzvf ${d}.tar.gz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.bz2 -a -s ${d}.tar.bz2 ] && tar xjvf ${d}.tar.bz2 --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.xz  -a -s ${d}.tar.xz  ] && tar xJvf ${d}.tar.xz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.lz  -a -s ${d}.tar.lz  ] && tar xvf  ${d}.tar.lz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	return 1
}

print_library_path()
{
	for d in ${DESTDIR}${prefix}/lib64 ${DESTDIR}${prefix}/lib `LANG=C ${CC:-${host:+${host}-}gcc} -print-search-dirs |
		sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs realpath -eq`; do
		[ -d ${d}${2:+/${2}} ] || continue
		candidates=`find ${d}${2:+/${2}} \( -type f -o -type l \) -name ${1} | sort`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return
	done
	return 1
}

print_library_dir()
{
	path=`print_library_path $@`
	[ $? = 0 ] && dirname ${path} || return
}

print_header_path()
{
	for d in ${DESTDIR}${prefix}/include \
		`LANG=C ${CC:-${host:+${host}-}gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
			sed -e '/^#include /,/^End of search list.$/p;d' | xargs realpath -eq`; do
		[ -d ${d}${2:+/${2}} ] || continue
		candidates=`find ${d}${2:+/${2}} \( -type f -o -type l \) -name ${1} | sort`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return
	done
	return 1
}

print_header_dir()
{
	path=`print_header_path $@`
	[ $? = 0 ] && echo ${path} | sed -e "s%${2:+/${2}}/${1}\$%%" || return
}

print_prefix()
{
	path=`print_header_path $@`
	[ $? = 0 ] && echo ${path} | sed -e 's/\/include\/.\+//' || return
}

print_binary_path()
{
	for d in ${DESTDIR}${prefix}/bin ${DESTDIR}${prefix}/sbin; do
		[ -d ${d}${2:+/${2}} ] || continue
		candidates=`find ${d}${2:+/${2}} \( -type f -o -type l \) -name ${1} | sort`
		[ -n "${candidates}" ] && echo "${candidates}" | head -n 1 && return
	done
	return 1
}

print_version()
{
	_1=`echo ${1} | tr - _`
	eval echo \${${_1}_ver} | cut -d. -f-${2:-2}
}

print_packages()
{
	grep -oPe '(?<=^: \${)\w+(?=_ver)' ${0} | sed -e '
		s/source_highlight/source-highlight/
		s/util_linux/util-linux/
		s/pkg_config/pkg-config/
		s/vimdoc_ja/vimdoc-ja/
		s/compiler_rt/compiler-rt/
		s/clang_tools_extra/clang-tools-extra/
	' || return
}

print_build_python_version()
{
	python3 -c 'import sys; print("{}.{}".format(*sys.version_info[:2]))' || return
}

print_target_python_version()
{
	grep -e '\<PY_VERSION\>' `print_header_dir Python.h`/patchlevel.h | \
		grep -oPe '(?<=")\d\.\d(?=\.\d+")' || return
}

print_target_python_abi()
{
	print_header_dir Python.h |
		grep -oe '[[:alpha:]]*$' || return
}

make()
{
	echo make "$@"
	command make "$@"
}

build()
{
	case ${1} in
	zlib)
		[ -f ${DESTDIR}${prefix}/include/zlib.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${zlib_bld_dir}
		CHOST=${host} ${zlib_src_dir}/configure --prefix=${prefix}) || return
		make -C ${zlib_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${zlib_bld_dir} -j ${jobs} -k check || return
		make -C ${zlib_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	binutils)
		[ -x ${DESTDIR}${prefix}/bin/as -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${binutils_bld_dir}/Makefile ] ||
			(cd ${binutils_bld_dir}
			${binutils_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--enable-shared --enable-gold --enable-threads --enable-plugins \
				--enable-compressed-debug-sections=all --enable-targets=all --enable-64-bit-bfd \
				--with-system-zlib \
				CFLAGS="${CFLAGS} -I`print_header_dir zlib.h`" \
				CXXFLAGS="${CXXFLAGS} -I`print_header_dir zlib.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`") || return
		make -C ${binutils_bld_dir} -j 1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${binutils_bld_dir} -j 1 -k check || return
		make -C ${binutils_bld_dir} -j 1 DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for b in addr2line ar as c++filt coffdump dlltool dllwrap dwp \
			elfedit gprof ld ld.bfd ld.gold nm objcopy objdump ranlib \
			readelf size srconv strings strip sysdump windmc windres; do
			[ -f ${DESTDIR}${prefix}/bin/${target}-${b} ] && continue
			ln -fsv ${b} ${DESTDIR}${prefix}/bin/${target}-${b} || return
		done
		;;
	gmp)
		[ -f ${DESTDIR}${prefix}/include/gmp.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${gmp_bld_dir}/Makefile ] ||
			(cd ${gmp_bld_dir}
			${gmp_src_dir}/configure --prefix=${prefix} --host=${host} --enable-cxx) || return
		make -C ${gmp_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${gmp_bld_dir} -j ${jobs} -k check || return
		make -C ${gmp_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	mpfr)
		[ -f ${DESTDIR}${prefix}/include/mpfr.h -a "${force_install}" != yes ] && return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${mpfr_bld_dir}/Makefile ] ||
			(cd ${mpfr_bld_dir}
			${mpfr_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-gmp=`print_prefix gmp.h`) || return
		make -C ${mpfr_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${mpfr_bld_dir} -j ${jobs} -k check || return
		make -C ${mpfr_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	mpc)
		[ -f ${DESTDIR}${prefix}/include/mpc.h -a "${force_install}" != yes ] && return
		print_header_path mpfr.h > /dev/null || ${0} ${cmdopt} mpfr || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${mpc_bld_dir}/Makefile ] ||
			(cd ${mpc_bld_dir}
			${mpc_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h`) || return
		make -C ${mpc_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${mpc_bld_dir} -j ${jobs} -k check || return
		make -C ${mpc_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	isl)
		[ -f ${DESTDIR}${prefix}/include/isl/version.h -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${isl_bld_dir}/Makefile ] ||
			(cd ${isl_bld_dir}
			${isl_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--with-gmp-prefix=`print_prefix gmp.h` \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so` -L`print_library_dir libgmp.so`" LIBS=-lgmp) || return
		make -C ${isl_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${isl_bld_dir} -j ${jobs} -k check || return
		make -C ${isl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	gcc)
		[ -x ${DESTDIR}${prefix}/bin/gcc -a "${force_install}" != yes ] && return
		print_binary_path ${target}-as > /dev/null || ${0} ${cmdopt} binutils || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		print_header_path mpfr.h > /dev/null || ${0} ${cmdopt} mpfr || return
		print_header_path mpc.h > /dev/null || ${0} ${cmdopt} mpc || return
		print_header_path version.h isl > /dev/null || ${0} ${cmdopt} isl || return
		fetch ${1} || return
		unpack ${1} || return
		gcc_base_ver=`cat ${gcc_src_dir}/gcc/BASE-VER` || return
		[ -f ${gcc_bld_dir}/Makefile ] ||
			(cd ${gcc_bld_dir}
			${gcc_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h` --with-mpc=`print_prefix mpc.h` \
				--with-isl=`print_prefix version.h isl` --with-system-zlib \
				--enable-languages=${languages} --disable-multilib --enable-linker-build-id --enable-libstdcxx-debug \
				--program-suffix=-${gcc_base_ver} --enable-version-specific-runtime-libs \
			) || return
		make -C ${gcc_bld_dir} -j ${jobs} \
			CPPFLAGS="${CPPFLAGS} -DLIBICONV_PLUG" \
			CPPFLAGS_FOR_TARGET="${CPPFLAGS} -DLIBICONV_PLUG" \
			CFLAGS_FOR_TARGET="${CFLAGS} -Wno-error" \
			LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`" || return
		[ "${enable_check}" != yes ] ||
			make -C ${gcc_bld_dir} -j ${jobs} -k check || return
		make -C ${gcc_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		[ -f ${gcc_bld_dir}/gcc/xg++ -a "${force_install}" = yes ] &&
			which doxygen > /dev/null && make -C ${gcc_bld_dir}/${target}/libstdc++-v3 -j ${jobs} DESTDIR=${DESTDIR} install-man
		ln -fsv gcc ${DESTDIR}${prefix}/bin/cc || return
		[ ! -f ${DESTDIR}${prefix}/bin/${target}-gcc-tmp ] || rm -v ${DESTDIR}${prefix}/bin/${target}-gcc-tmp || return
		for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool go gofmt; do
			[ -f ${DESTDIR}${prefix}/bin/${b}-${gcc_base_ver} ] || continue
			ln -fsv ${b}-${gcc_base_ver} ${DESTDIR}${prefix}/bin/${b} || return
			ln -fsv ${b} ${DESTDIR}${prefix}/bin/${target}-${b} || return
			ln -fsv ${b}-${gcc_base_ver}.1 ${DESTDIR}${prefix}/share/man/man1/${b}.1 || return
		done
		for l in libgcc_s.so libgcc_s.so.1; do
			[ -f ${DESTDIR}${prefix}/lib/gcc/${target}/${gcc_base_ver}/${l} ] ||
				ln -fsv ../lib64/${l} ${DESTDIR}${prefix}/lib/gcc/${target}/${gcc_base_ver} || return # XXX work around for --enable-version-specific-runtime-libs
		done
		;;
	make)
		[ -x ${DESTDIR}${prefix}/bin/make -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${make_bld_dir}/Makefile ] ||
			(cd ${make_bld_dir}
			${make_src_dir}/configure --prefix=${prefix} --host=${host} --without-guile) || return
		make -C ${make_bld_dir} -j ${jobs} MAKE_MAINTAINER_MODE= || return
		[ "${enable_check}" != yes ] ||
			make -C ${make_bld_dir} -j ${jobs} -k check || return
		make -C ${make_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	ncurses)
		[ -f ${DESTDIR}${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ncurses_bld_dir}/Makefile ] ||
			(cd ${ncurses_bld_dir}
			sed -i -e "
				/^INSTALL_PROG\>/{
					s!\( --strip-program=[[:graph:]]\+\)\?\$! --strip-program=`which ${host:+${host}-}strip`!
				}" ${ncurses_src_dir}/progs/Makefile.in || return
			${ncurses_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-shared --with-cxx-shared --with-termlib \
				--enable-termcap --enable-colors) || return
		make -C ${ncurses_bld_dir} -j 1 DESTDIR=${DESTDIR} || return # XXX work around for parallel make
		make -C ${ncurses_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		for h in `find ${DESTDIR}${prefix}/include/ncurses \( -type f -o -type l \) -name '*.h'`; do
			ln -fsv `echo ${h} | sed -e "s%${DESTDIR}${prefix}/include/%%"` ${DESTDIR}${prefix}/include || return
		done
		rm -fv ${DESTDIR}${prefix}/lib/libncurses.so || return
		echo 'INPUT(libncurses.so.'`print_version ncurses 1`' -ltinfo)' > ${DESTDIR}${prefix}/lib/libncurses.so || return
		echo 'INPUT(libncurses.so.'`print_version ncurses 1`' -ltinfo)' > ${DESTDIR}${prefix}/lib/libcurses.so || return
		for ext in a la; do
			ln -fsv libncurses.${ext} ${DESTDIR}${prefix}/lib/libcurses.${ext} || return
		done
		[ -z "${strip}" ] && return
		for b in clear infocmp tabs tic toe tput tset; do
			[ -f ${DESTDIR}${prefix}/bin/${b} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		for l in libform libmenu libncurses++ libpanel libtinfo; do
			[ -f ${DESTDIR}${prefix}/lib/${l}.so ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
		done
		;;
	readline)
		[ -f ${DESTDIR}${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${readline_bld_dir}/Makefile ] ||
			(cd ${readline_bld_dir}
			${readline_src_dir}/configure --prefix=${prefix} --host=${host} \
				--enable-multibyte --with-curses) || return
		make -C ${readline_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${readline_bld_dir} -j ${jobs} -k check || return
		make -C ${readline_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for l in libhistory libreadline; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
		done
		;;
	expat)
		[ -f ${DESTDIR}${prefix}/include/expat.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${expat_bld_dir}/Makefile ] ||
			(cd ${expat_bld_dir}
			${expat_src_dir}/configure --prefix=${prefix} --host=${host}) || return
		make -C ${expat_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${expat_bld_dir} -j ${jobs} -k check || return
		make -C ${expat_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/xmlwf || return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libexpat.so || return
		;;
	libffi)
		[ -f ${DESTDIR}${prefix}/include/ffi.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libffi_bld_dir}/Makefile ] ||
			(cd ${libffi_bld_dir}
			${libffi_src_dir}/configure --prefix=${prefix} --host=${host}) || return
		make -C ${libffi_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libffi_bld_dir} -j ${jobs} -k check || return
		make -C ${libffi_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		[ -d ${DESTDIR}${prefix}/include ] || mkdir -pv ${DESTDIR}${prefix}/include || return
		for f in `find ${DESTDIR}${prefix}/lib/${libffi_name}/include -type f -name '*.h'`; do
			ln -fsv ../lib/${libffi_name}/include/`basename ${f}` ${DESTDIR}${prefix}/include/`basename ${f}` || return
		done
		for f in `find ${DESTDIR}${prefix}/lib64 -name 'libffi.a' -o -name 'libffi.la' -o -name 'libffi.so' -o -name 'libffi.so.?'`; do
			ln -fsv ../lib64/`basename ${f}` ${DESTDIR}${prefix}/lib || return
		done
		;;
	openssl)
		[ -d ${DESTDIR}${prefix}/include/openssl -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${openssl_bld_dir}
		MACHINE=`echo ${host} | cut -d- -f1` SYSTEM=Linux \
			${openssl_src_dir}/config --prefix=${prefix} shared) || return
		make -C ${openssl_bld_dir} -j 1 CROSS_COMPILE=${host}- || return # XXX work around for parallel make
		[ "${enable_check}" != yes ] ||
			make -C ${openssl_bld_dir} -j 1 -k test || return # XXX work around for parallel make
		mkdir -pv ${DESTDIR}${prefix}/ssl || return
		rm -fv ${DESTDIR}${prefix}/ssl/certs || return
		[ ! -d /etc/ssl/certs ] || ln -fsv /etc/ssl/certs ${DESTDIR}${prefix}/ssl/certs || return
		[   -d /etc/ssl/certs ] || mkdir -pv ${DESTDIR}${prefix}/ssl/certs || return
		make -C ${openssl_bld_dir} -j 1 DESTDIR=${DESTDIR} install || return # XXX work around for parallel make
		mkdir -pv ${DESTDIR}${prefix}/lib/pkgconfig || return
		for f in libcrypto.pc libssl.pc openssl.pc; do
			[ ! -f ${DESTDIR}${prefix}/lib64/pkgconfig/${f} ] || ln -fsv ../../lib64/pkgconfig/${f} ${DESTDIR}${prefix}/lib/pkgconfig || return
		done
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/openssl || return
		;;
	Python)
		[ -x ${DESTDIR}${prefix}/bin/python3 -a "${force_install}" != yes ] && return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path ffi.h > /dev/null || ${0} ${cmdopt} libffi || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${Python_bld_dir}/Makefile ] ||
			(cd ${Python_bld_dir}
			python3 -S -m sysconfig --generate-posix-vars || {
				echo ERROR: Python3 \'sysconfig\' module does not work well. >&2
				echo ERROR: you probably need \'python3-dev\' package for your build system. >&2
				echo ERROR: please install it and try again. >&2
				return 1;} || return
			[ -f config.site ] || cat << EOF > config.site || return
ac_cv_file__dev_ptmx=yes
ac_cv_file__dev_ptc=no
PYTHON_FOR_BUILD='_PYTHON_PROJECT_BASE=\$(abs_builddir) \
_PYTHON_HOST_PLATFORM=\$(_PYTHON_HOST_PLATFORM) \
PYTHONPATH=\$(shell test -f pybuilddir.txt && echo \$(abs_builddir)/\`cat pybuilddir.txt\`:)\$(srcdir)/Lib \
_PYTHON_SYSCONFIGDATA_NAME=`find build -type f | xargs -I @ basename @ .py` python3'
EOF
			rm -fvr build pybuilddir.txt || return
			sed -i -e "
				/^    set_compiler_flags('LDFLAGS', 'PY_LDFLAGS_NODIST')/d
				/^        sysconf_built = sysconfig\.get_config_var('MODBUILT_NAMES')\.split()/s//        sysconf_built = []/
				/^        sysconf_dis = sysconfig\.get_config_var('MODDISABLED_NAMES')\.split()/s//        sysconf_dis = []/
				" ${Python_src_dir}/setup.py || return
			${Python_src_dir}/configure --prefix=${prefix} --build=`uname -m` --host=${host} --enable-universalsdk \
				--enable-shared --enable-optimizations --enable-ipv6 \
				--with-universal-archs=all --with-lto --with-system-expat --with-system-ffi \
				--with-openssl=`print_prefix ssl.h openssl` \
				--with-doc-strings --with-pymalloc --with-ensurepip \
				CONFIG_SITE=config.site || return
			) || return
		make -C ${Python_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${Python_bld_dir} -j ${jobs} -k test || return
		make -C ${Python_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for v in `print_version Python` `print_version Python`m; do
			[ ! -f ${DESTDIR}${prefix}/bin/python${v} ] || ${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/python${v} || return
		done
		for soname_v in `print_version Python 1`.so `print_version Python`.so.1.0 `print_version Python`m.so.1.0; do
			[ ! -f ${DESTDIR}${prefix}/lib/libpython${soname_v} ] ||
				(chmod -v u+w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
				${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
				chmod -v u-w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return) || return
		done
		;;
	boost)
		[ -d ${DESTDIR}${prefix}/include/boost -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${boost_src_dir}
		./bootstrap.sh --prefix=${DESTDIR}${prefix} --with-toolset=gcc &&
		sed -i -e "/^    using gcc /s//&: : ${host}-gcc /" project-config.jam &&
		./b2 --prefix=${DESTDIR}${prefix} --build-dir=${boost_bld_dir} \
			--layout=system --build-type=minimal -j ${jobs} -q \
			--without-python \
			include=${DESTDIR}${prefix}/include library-path=${DESTDIR}${prefix}/lib install) || return
		;;
	source-highlight)
		[ -x ${DESTDIR}${prefix}/bin/source-highlight -a "${force_install}" != yes ] && return
		print_header_path version.hpp boost > /dev/null || ${0} ${cmdopt} boost || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${source_highlight_bld_dir}/Makefile ] ||
			(cd ${source_highlight_bld_dir}
			${source_highlight_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-boost=`print_prefix regex.hpp boost` \
				--with-boost-libdir=`print_library_dir libboost_regex.so` \
				--without-doxygen) || return
		make -C ${source_highlight_bld_dir} -j ${jobs} -k || true
		[ "${enable_check}" != yes ] ||
			make -C ${source_highlight_bld_dir} -j ${jobs} -k check || return
		make -C ${source_highlight_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} -k || true
		;;
	bzip2)
		[ -x ${DESTDIR}${prefix}/bin/bzip2 -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${bzip2_bld_dir}/Makefile ] || cp -Tvr ${bzip2_src_dir} ${bzip2_bld_dir} || return
		sed -i -e '
			/^CFLAGS=/{
				s/ -fPIC//g
				s/$/ -fPIC/
			}
			s/ln -s -f \$(PREFIX)\/bin\//ln -s -f /' ${bzip2_bld_dir}/Makefile || return
		make -C ${bzip2_bld_dir} -j ${jobs} \
			CC=${CC:-${host:+${host}-}gcc} AR=${host}-gcc-ar RANLIB=${host}-gcc-ranlib bzip2 bzip2recover || return
		[ "${enable_check}" != yes ] ||
			make -C ${bzip2_bld_dir} -j ${jobs} -k check || return
		make -C ${bzip2_bld_dir} -j ${jobs} PREFIX=${DESTDIR}${prefix} install || return
		make -C ${bzip2_bld_dir} -j ${jobs} clean || return
		make -C ${bzip2_bld_dir} -j ${jobs} -f Makefile-libbz2_so CC=${CC:-${host:+${host}-}gcc} || return
		[ "${enable_check}" != yes ] ||
			make -C ${bzip2_bld_dir} -j ${jobs} -k check || return
		cp -fv ${bzip2_bld_dir}/libbz2.so.${bzip2_ver} ${DESTDIR}${prefix}/lib || return
		chmod -v a+r ${DESTDIR}${prefix}/lib/libbz2.so.${bzip2_ver} || return
		ln -fsv libbz2.so.${bzip2_ver} ${DESTDIR}${prefix}/lib/libbz2.so.`print_version bzip2` || return
		ln -fsv libbz2.so.`print_version bzip2` ${DESTDIR}${prefix}/lib/libbz2.so || return
		cp -fv ${bzip2_bld_dir}/bzlib.h ${DESTDIR}${prefix}/include || return
		cp -fv ${bzip2_bld_dir}/bzlib_private.h ${DESTDIR}${prefix}/include || return
		[ -z "${strip}" ] && return
		for b in bunzip2 bzcat bzip2 bzip2recover; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libbz2.so || return
		;;
	xz)
		[ -x ${DESTDIR}${prefix}/bin/xz -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${xz_bld_dir}/Makefile ] ||
			(cd ${xz_bld_dir}
			${xz_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
		make -C ${xz_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${xz_bld_dir} -j ${jobs} -k check || return
		make -C ${xz_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	elfutils)
		[ -x ${DESTDIR}${prefix}/bin/eu-addr2line -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${elfutils_bld_dir}/Makefile ] ||
			(cd ${elfutils_bld_dir}
			${elfutils_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--disable-debuginfod \
				CFLAGS="${CFLAGS} -I`print_header_dir zlib.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`" \
				LIBS="${LIBS} -lz -lbz2 -llzma") || return
		make -C ${elfutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${elfutils_bld_dir} -j ${jobs} -k check || return
		make -C ${elfutils_bld_dir} -j 1 STRIPPROG=${host:+${host}-}strip DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	pcre)
		[ -f ${DESTDIR}${prefix}/include/pcre.h -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${pcre_bld_dir}/Makefile ] ||
			(cd ${pcre_bld_dir}
			${pcre_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--enable-pcre16 --enable-pcre32 --enable-jit --enable-utf --enable-unicode-properties \
				--enable-newline-is-any --enable-pcregrep-libz --enable-pcregrep-libbz2 \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir zlib.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`") || return
		make -C ${pcre_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${pcre_bld_dir} -j ${jobs} -k check || return
		make -C ${pcre_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	pcre2)
		[ -f ${DESTDIR}${prefix}/include/pcre2.h -a "${force_install}" != yes ] && return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${pcre2_bld_dir}/Makefile ] ||
			(cd ${pcre2_bld_dir}
			${pcre2_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--enable-pcre2-16 --enable-pcre2-32 --enable-jit --enable-newline-is-any \
				--enable-pcre2grep-libz --enable-pcre2grep-libbz2 \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir bzlib.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libbz2.so`") || return
		make -C ${pcre2_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${pcre2_bld_dir} -j ${jobs} -k check || return
		make -C ${pcre2_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	util-linux)
		[ -x ${DESTDIR}${prefix}/bin/hexdump -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${util_linux_bld_dir}/Makefile ] ||
			(cd ${util_linux_bld_dir}
			${util_linux_src_dir}/configure --prefix=${prefix} --host=${host} --build=${build} --disable-silent-rules \
				--enable-write --disable-use-tty-group --with-bashcompletiondir=${prefix}/share/bash-completion \
				PKG_CONFIG_LIBDIR=) || return
		make -C ${util_linux_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${util_linux_bld_dir} -j ${jobs} -k check || return
		make -C ${util_linux_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} -k || true
		;;
	popt)
		[ -f ${DESTDIR}${prefix}/include/popt.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${popt_bld_dir}/Makefile ] ||
			(cd ${popt_bld_dir}
			sed -i -e '/^AM_C_PROTOTYPES$/d' ${popt_src_dir}/configure.ac || return
			sed -i -e '/^TESTS = /d' ${popt_src_dir}/Makefile.am || return
			autoreconf -fiv ${popt_src_dir} || return
			${popt_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-rpath) || return
		make -C ${popt_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${popt_bld_dir} -j ${jobs} -k check || return
		make -C ${popt_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	glib)
		[ -f ${DESTDIR}${prefix}/include/glib-2.0/glib.h -a "${force_install}" != yes ] && return
		print_header_path ffi.h > /dev/null || ${0} ${cmdopt} libffi || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path pcre.h > /dev/null || ${0} ${cmdopt} pcre || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${glib_src_dir}/configure ] ||
			(cd ${glib_src_dir}; NOCONFIGURE=yes ./autogen.sh) || return
		[ -f ${glib_bld_dir}/Makefile ] ||
			(cd ${glib_bld_dir}
			${glib_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-static \
				--disable-silent-rules --disable-libmount --disable-dtrace --enable-systemtap \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir zlib.h`" \
				LIBFFI_CFLAGS=-I`print_header_dir ffi.h` LIBFFI_LIBS="-L`print_library_dir libffi.so` -lffi" \
				PCRE_CFLAGS=-I`print_header_dir pcre.h` PCRE_LIBS="-L`print_library_dir libpcre.so` -lpcre" \
				LIBS="-L`print_library_dir libffi.so` -lffi -L`print_library_dir libpcre.so` -lpcre -lz" \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				glib_cv_stack_grows=no glib_cv_uscore=no) || return
		make -C ${glib_bld_dir} -j ${jobs} || return
		make -C ${glib_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		[ -z "${strip}" ] && return
		for b in gapplication gdbus gio gio-launch-desktop gio-querymodules glib-compile-resources glib-compile-schemas gobject-query gresource gsettings gtester; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	babeltrace)
		[ -x ${DESTDIR}${prefix}/bin/babeltrace -a "${force_install}" != yes ] && return
		print_header_path pcre.h > /dev/null || ${0} ${cmdopt} pcre || return
		print_header_path glib.h glib-2.0 > /dev/null || ${0} ${cmdopt} glib || return
		print_header_path uuid.h uuid > /dev/null || ${0} ${cmdopt} util-linux || return
		print_header_path popt.h > /dev/null || ${0} ${cmdopt} popt || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${babeltrace_src_dir}/configure ] || (cd ${babeltrace_src_dir}; ./bootstrap) || return
		[ -f ${babeltrace_bld_dir}/Makefile ] ||
			(cd ${babeltrace_bld_dir}
			${babeltrace_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`" \
				LIBS="${LIBS} -lpcre -lz -lbz2 -llzma" \
				PKG_CONFIG_LIBDIR=`print_library_dir glib-2.0.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				ac_cv_func_malloc_0_nonnull=yes \
				ac_cv_func_realloc_0_nonnull=yes \
				bt_cv_lib_elfutils=yes) || return
		make -C ${babeltrace_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${babeltrace_bld_dir} -j ${jobs} -k check || return
		make -C ${babeltrace_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	gdb)
		[ -x ${DESTDIR}${prefix}/bin/gdb -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path mpfr.h > /dev/null || ${0} ${cmdopt} mpfr || return
		print_header_path Python.h > /dev/null || ${0} ${cmdopt} Python || return
		print_header_path sourcehighlight.h srchilite > /dev/null || ${0} ${cmdopt} source-highlight || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		print_header_path babeltrace.h babeltrace > /dev/null || ${0} ${cmdopt} babeltrace || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${gdb_bld_dir}/Makefile ] ||
			(cd ${gdb_bld_dir}
			[ -f host_configargs ] || cat << EOF | tr '\n' ' ' > host_configargs || return
--disable-rpath
CFLAGS='${CFLAGS} -I`print_header_dir zlib.h` -I`print_header_dir curses.h` -I`print_header_dir Python.h`'
CPPFLAGS='${CPPFLAGS} -I`print_header_dir zlib.h` -I`print_header_dir Python.h`'
LDFLAGS=-L`print_prefix Python.h`/lib
LIBS='${LIBS} -lpopt -luuid -lgmodule-2.0 -lglib-2.0 -lpcre -ldw -lelf -lz -lbz2 -llzma'
PKG_CONFIG_SYSROOT_DIR=${DESTDIR}
PKG_CONFIG_LIBDIR=`print_library_dir source-highlight.pc`
EOF
			${gdb_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--enable-targets=all --enable-64-bit-bfd --enable-tui --enable-source-highlight \
				--with-auto-load-dir='$debugdir:$datadir/auto-load:'${prefix}/lib/gcc/${target} \
				--with-system-zlib --with-system-readline \
				--with-expat=yes --with-libexpat-prefix=`print_prefix expat.h` \
				--with-mpfr=yes --with-libmpfr-prefix=`print_prefix mpfr.h` \
				--with-python=python3 --without-guile \
				--with-lzma=yes --with-liblzma-prefix=`print_prefix lzma.h` \
				--with-babeltrace=yes --with-libbabeltrace-prefix=`print_prefix babeltrace.h babeltrace` \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so` -L`print_library_dir libncurses.so`" \
				host_configargs="`cat host_configargs`") || return
		make -C ${gdb_bld_dir} -j ${jobs} V=1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${gdb_bld_dir} -j ${jobs} -k check || return
		make -C ${gdb_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		make -C ${gdb_bld_dir}/gdb -j ${jobs} DESTDIR=${DESTDIR} STRIPPROG=${host:+${host}-}strip install${strip:+-${strip}} || return
		make -C ${gdb_bld_dir}/sim -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	strace)
		[ -x ${DESTDIR}${prefix}/bin/strace -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${strace_bld_dir}/Makefile ] ||
			(cd ${strace_bld_dir}
			${strace_src_dir}/configure --prefix=${prefix} --host=${host} --enable-mpers=check) || return
		make -C ${strace_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${strace_bld_dir} -j ${jobs} -k check || return
		make -C ${strace_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	systemtap)
		[ -x ${DESTDIR}${prefix}/bin/stap -a "${force_install}" != yes ] && return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${systemtap_bld_dir}/Makefile ] ||
			(cd ${systemtap_bld_dir}
			${systemtap_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir libdw.h elfutils`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libdw.so`" \
				LIBS="${LIBS} -lz -lbz2 -llzma" \
				) || return
		make -C ${systemtap_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${systemtap_bld_dir} -j ${jobs} -k check || return
		make -C ${systemtap_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	libpcap)
		[ -f ${DESTDIR}${prefix}/include/pcap/pcap.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libpcap_bld_dir}/Makefile ] ||
			(cd ${libpcap_bld_dir}
			${libpcap_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${libpcap_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libpcap_bld_dir} -j ${jobs} -k test || return
		make -C ${libpcap_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	tcpdump)
		[ -x ${DESTDIR}${prefix}/sbin/tcpdump -a "${force_install}" != yes ] && return
		print_header_path pcap.h pcap > /dev/null || ${0} ${cmdopt} libpcap || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${tcpdump_bld_dir}/Makefile ] ||
			(cd ${tcpdump_bld_dir}
			${tcpdump_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--with-system-libpcap \
				ac_cv_path_PCAP_CONFIG=: \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir pcap.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libpcap.so`" \
				LIBS="${LIBS} -lpcap" \
				) || return
		make -C ${tcpdump_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tcpdump_bld_dir} -j ${jobs} -k check || return
		make -C ${tcpdump_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	m4)
		[ -x ${DESTDIR}${prefix}/bin/m4 -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${m4_bld_dir}/Makefile ] ||
			(cd ${m4_bld_dir}
			${m4_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--enable-c++ --enable-changeword) || return
		make -C ${m4_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${m4_bld_dir} -j ${jobs} -k check || return
		make -C ${m4_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	perl)
		echo WARNING: not implemented. can not build \'${1}\'. skipped. >&2
		return 0

		[ -x ${DESTDIR}${prefix}/bin/perl -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${perl_bld_dir}/Makefile ] ||
			(cd ${perl_bld_dir}
			${perl_src_dir}/Configure -de -Dusecrosscompile -Dprefix=${prefix} -Dcc=${CC:-${host:+${host}-}gcc} \
				-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits -Duseshrplib -Dmksymlinks) || return
		make -C ${perl_bld_dir} -j 1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${perl_bld_dir} -j ${jobs} -k test || return
		make -C ${perl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		ln -fsv `find ${DESTDIR}${prefix}/lib -type f -name libperl.so | sed -e s%^${DESTDIR}${prefix}/lib/%%` ${DESTDIR}${prefix}/lib || return
		;;
	autoconf)
		[ -x ${DESTDIR}${prefix}/bin/autoconf -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${autoconf_bld_dir}/Makefile ] ||
			(cd ${autoconf_bld_dir}
			${autoconf_src_dir}/configure --prefix=${prefix} --host=${host}) || return
		make -C ${autoconf_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${autoconf_bld_dir} -j ${jobs} -k check || return
		make -C ${autoconf_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	automake)
		[ -x ${DESTDIR}${prefix}/bin/automake -a "${force_install}" != yes ] && return
		print_binary_path autoconf > /dev/null || ${0} ${cmdopt} autoconf || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${automake_bld_dir}/Makefile ] ||
			(cd ${automake_bld_dir}
			${automake_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${automake_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${automake_bld_dir} -j ${jobs} -k check || return
		make -C ${automake_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	bison)
		[ -x ${DESTDIR}${prefix}/bin/bison -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${bison_bld_dir}/Makefile ] ||
			(cd ${bison_bld_dir}
			${bison_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${bison_bld_dir} -j ${jobs} || return
		make -C ${bison_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	flex)
		[ -x ${DESTDIR}${prefix}/bin/flex -a "${force_install}" != yes ] && return
		print_binary_path bison > /dev/null || ${0} ${cmdopt} bison || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${flex_bld_dir}/Makefile ] ||
			(cd ${flex_bld_dir}
			${flex_src_dir}/configure --prefix=${prefix} --host=${host} \
				ac_cv_func_reallocarray=no) || return
		make -C ${flex_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${flex_bld_dir} -j ${jobs} -k check || return
		make -C ${flex_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} install-man || return
		;;
	libtool)
		[ -x ${DESTDIR}${prefix}/bin/libtool -a "${force_install}" != yes ] && return
		print_binary_path flex > /dev/null || ${0} ${cmdopt} flex || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libtool_bld_dir}/Makefile ] ||
			(cd ${libtool_bld_dir}
			${libtool_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${libtool_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libtool_bld_dir} -j ${jobs} -k check || return
		make -C ${libtool_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libltdl.so || return
		;;
	pkg-config)
		[ -x ${DESTDIR}${prefix}/bin/pkg-config -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${pkg_config_bld_dir}/Makefile -a -f ${pkg_config_bld_dir}/glib/Makefile ] ||
			(cd ${pkg_config_bld_dir}
			${pkg_config_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--with-internal-glib \
				glib_cv_stack_grows=no \
				glib_cv_uscore=no \
				ac_cv_func_posix_getpwuid_r=yes \
				ac_cv_func_posix_getgrgid_r=yes) || return
		make -C ${pkg_config_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${pkg_config_bld_dir} -j ${jobs} -k check || return
		make -C ${pkg_config_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	gettext)
		[ -x ${DESTDIR}${prefix}/bin/gettext -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${gettext_bld_dir}/Makefile ] ||
			(cd ${gettext_bld_dir}
			${gettext_src_dir}/configure --prefix=${prefix} --host=${host} \
				--enable-threads --disable-rpath) || return
		make -C ${gettext_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${gettext_bld_dir} -j ${jobs} -k check || return
		make -C ${gettext_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	curl)
		[ -x ${DESTDIR}${prefix}/bin/curl -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${curl_bld_dir}
		${curl_src_dir}/configure --prefix=${prefix} --host=${host} \
			--enable-optimize --disable-silent-rules \
			--enable-http --enable-ftp --enable-file \
			--enable-ldap --enable-ldaps --enable-rtsp --enable-proxy \
			--enable-dict --enable-telnet --enable-tftp --enable-pop3 \
			--enable-imap --enable-smb --enable-smtp --enable-gopher \
			--enable-manual --enable-ipv6 --enable-openssl-auto-load-config \
			--enable-sspi --enable-crypto-auth --enable-tls-srp \
			--enable-unix-sockets --enable-cookies --enable-http-auth \
			--enable-doh --enable-mime --enable-dateparse --enable-netrc \
			--enable-progress-meter --enable-dnsshuffle --enable-alt-svc \
			--with-zlib=`print_prefix zlib.h` \
			--with-ssl=`print_prefix ssl.h openssl`) || return
		make -C ${curl_bld_dir} -j ${jobs} || return
		make -C ${curl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/curl || return
		;;
	git)
		[ -x ${DESTDIR}${prefix}/bin/git -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		print_header_path curl.h curl > /dev/null || ${0} ${cmdopt} curl || return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path pcre2.h > /dev/null || ${0} ${cmdopt} pcre2 || return
		which msgfmt > /dev/null || ${0} ${cmdopt} --host ${build} gettext || return
		fetch ${1} || return
		unpack ${1} || return
		make -C ${git_src_dir} -j ${jobs} V=1 configure || return
		(cd ${git_src_dir}
		./configure --prefix=${prefix} --host=${host} \
			--with-openssl=`print_prefix ssl.h openssl` --with-libpcre=`print_prefix pcre2.h` \
			--with-curl=`print_prefix curl.h curl` --with-expat=`print_prefix expat.h` \
			--with-perl=perl --with-python=python3 --with-zlib=`print_prefix zlib.h` \
			--without-tcltk \
			ac_cv_iconv_omits_bom=no \
			ac_cv_fread_reads_directories=yes \
			ac_cv_snprintf_returns_bogus=no \
			) || return
		sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_src_dir}/Makefile || return
		sed -i -e 's/^\(CC_LD_DYNPATH=\).\+/\1-L/' ${git_src_dir}/config.mak.autogen || return
		make -C ${git_src_dir} -j 1       V=1 LDFLAGS="${LDFLAGS} -ldl" all || return
		[ "${enable_check}" != yes ] ||
			make -C ${git_src_dir} -j ${jobs} -k V=1 test || return
		make -C ${git_src_dir} -j ${jobs} V=1 STRIP=${host:+${host}-}strip DESTDIR=${DESTDIR} ${strip} install || return
		[ -z "${strip}" ] && return
		for b in git git-receive-pack git-upload-archive git-upload-pack; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	ed)
		[ -x ${DESTDIR}${prefix}/bin/ed -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ed_bld_dir}/Makefile ] ||
			(cd ${ed_bld_dir}
			${ed_src_dir}/configure --prefix=${prefix} CC=${CC:-${host:+${host}-}gcc}) || return
		make -C ${ed_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${ed_bld_dir} -j ${jobs} -k check || return
		make -C ${ed_bld_dir} -j 1 DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	bc)
		[ -x ${DESTDIR}${prefix}/bin/bc -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${bc_bld_dir}/Makefile ] ||
			(cd ${bc_bld_dir}
			sed -i -e 's!^	\./fbc\>!	bc!' ${bc_src_dir}/bc/Makefile.am || return
			autoreconf -v ${bc_src_dir} || return
			${bc_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --with-readline) || return
		make -C ${bc_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${bc_bld_dir} -j ${jobs} -k check || return
		make -C ${bc_bld_dir} -j 1 DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	rsync)
		[ -x ${DESTDIR}${prefix}/bin/rsync -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path popt.h > /dev/null || ${0} ${cmdopt} popt || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${rsync_bld_dir}/Makefile ] ||
			(cd ${rsync_bld_dir}
			${rsync_src_dir}/configure --prefix=${prefix} --host=${host} --without-included-zlib\
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir zlib.h` -I`print_header_dir popt.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so` -L`print_library_dir libpopt.so`" \
				) || return
		make -C ${rsync_bld_dir} -j ${jobs} || return
		make -C ${rsync_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	dtc)
		[ -x ${DESTDIR}${prefix}/bin/dtc -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${dtc_bld_dir}/Makefile ] || cp -Tvr ${dtc_src_dir} ${dtc_bld_dir} || return
		(unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1 NO_PYTHON=1 CC=${CC:-${host:+${host}-}gcc}) || return # XXX work around for parallel make
		(unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1 NO_PYTHON=1 PREFIX=${DESTDIR}${prefix} install) || return # XXX work around for parallel make
		[ -z "${strip}" ] && return
		for b in convert-dtsv0 dtc fdtdump fdtget fdtoverlay fdtput; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libfdt-`print_version dtc`.0.so || return
		;;
	screen)
		[ -x ${DESTDIR}${prefix}/bin/screen -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${screen_bld_dir}/Makefile ] ||
			(cd ${screen_bld_dir}
			${screen_src_dir}/configure --prefix=${prefix} --host=${host} \
				--enable-telnet --enable-colors256 --enable-rxvt_osc \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libtinfo.so`") || return
		make -C ${screen_bld_dir} -j ${jobs} || return
		mkdir -pv ${DESTDIR}${prefix}/share/screen/utf8encodings || return
		make -C ${screen_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${screen_name} || return
		;;
	libevent)
		[ -f ${DESTDIR}${prefix}/include/event2/event.h -a "${force_install}" != yes ] && return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libevent_bld_dir}/Makefile ] ||
			(cd ${libevent_bld_dir}
			${libevent_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				PKG_CONFIG_LIBDIR=`print_library_dir openssl.pc` \
				) || return
		make -C ${libevent_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libevent_bld_dir} -j ${jobs} -k check || return
		make -C ${libevent_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for l in '' _core _extra _openssl _pthreads; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libevent${l}.so || return
		done
		;;
	tmux)
		[ -x ${DESTDIR}${prefix}/bin/tmux -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path event.h event2 > /dev/null || ${0} ${cmdopt} libevent || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${tmux_bld_dir}/Makefile ] ||
			(cd ${tmux_bld_dir}
			${tmux_src_dir}/configure --prefix=${prefix} --host=${host} \
				CPPFLAGS="${CPPFLAGS} -I`print_header_dir curses.h`" \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libtinfo.so`" \
				LIBTINFO_LIBS=-ltinfo) || return
		make -C ${tmux_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tmux_bld_dir} -j ${jobs} -k check || return
		make -C ${tmux_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/tmux || return
		;;
	vim)
		[ -x ${DESTDIR}${prefix}/bin/vim -a "${force_install}" != yes ] && return
		which msgfmt > /dev/null || ${0} ${cmdopt} --host ${build} gettext || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path Python.h > /dev/null || ${0} ${cmdopt} Python || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${vim_bld_dir}/configure ] || cp -Tvr ${vim_src_dir} ${vim_bld_dir} || return
		[ -f ${vim_bld_dir}/src/auto/config.h ] ||
			(cd ${vim_bld_dir}
			[ -f src/auto/config.cache ] || cat << EOF > src/auto/config.cache || return
vim_cv_getcwd_broken=${vim_cv_getcwd_broken=no}
vim_cv_memmove_handles_overlap=${vim_cv_memmove_handles_overlap=yes}
vim_cv_stat_ignores_slash=${vim_cv_stat_ignores_slash=no}
vim_cv_terminfo=${vim_cv_terminfo=yes}
vim_cv_tgetent=${vim_cv_tgetent=non-zero}
vim_cv_toupper_broken=${vim_cv_toupper_broken=no}
vi_cv_var_python3_version=`print_target_python_version`
vi_cv_var_python3_abiflags=`print_target_python_abi`
vi_cv_path_python3_pfx=`print_prefix Python.h`
vi_cv_path_python3_epfx=`print_prefix Python.h`
vi_cv_path_python3_conf=`print_library_dir python.o`
vi_cv_dll_name_python3=libpython`print_target_python_version`.so.1.0
EOF
			./configure --prefix=${prefix} --host=${host}  \
				--with-features=huge --enable-fail-if-missing \
				--enable-python3interp=dynamic --with-python3-command=python3 \
				--enable-cscope --enable-terminal --enable-autoservername --enable-multibyte \
				--with-tlib=tinfo \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libtinfo.so`" \
				STRIP=${host:+${host}-}strip \
			) || return
		patch -N -p0 -d ${vim_bld_dir} <<'EOF' || [ $? = 1 ] || return
--- src/Makefile
+++ src/Makefile
@@ -1446,6 +1446,7 @@
 .SUFFIXES: .c .o .pro
 
 PRE_DEFS = -Iproto $(DEFS) $(GUI_DEFS) $(GUI_IPATH) $(CPPFLAGS) $(EXTRA_IPATHS)
+PRE_DEFS := $(sort $(PRE_DEFS))
 POST_DEFS = $(X_CFLAGS) $(MZSCHEME_CFLAGS) $(EXTRA_DEFS)
 
 ALL_CFLAGS = $(PRE_DEFS) $(CFLAGS) $(PROFILE_CFLAGS) $(SANITIZER_CFLAGS) $(LEAK_CFLAGS) $(ABORT_CLFAGS) $(POST_DEFS)
@@ -1482,6 +1483,7 @@
 	   $(PROFILE_LIBS) \
 	   $(SANITIZER_LIBS) \
 	   $(LEAK_LIBS)
+ALL_LIBS := $(sort $(filter-out $(LDFLAGS) $(ALL_LIB_DIRS),$(ALL_LIBS)))
 
 # abbreviations
 DEST_BIN = $(DESTDIR)$(BINDIR)
EOF
		sed -i -e '
			/^LDFLAGS\>/s/-Wl,-rpath,[[:graph:]]\+//
			/^PERL_LIBS\>/s/[[:graph:]]\+CORE//g
			' ${vim_bld_dir}/src/auto/config.mk || return
		make -C ${vim_bld_dir} -j ${jobs} || return
		for l in ex rview rvim view vimdiff; do
			[ ! -h ${DESTDIR}${prefix}/bin/${l} ] || rm -fv ${DESTDIR}${prefix}/bin/${l} || return
		done
		make -C ${vim_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -f ${DESTDIR}${prefix}/bin/vi ] || ln -fsv vim ${DESTDIR}${prefix}/bin/vi || return
		${0} ${cmdopt} vimdoc-ja || return
		;;
	vimdoc-ja)
		[ -d ${DESTDIR}${prefix}/share/vim/vimfiles -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		mkdir -pv ${DESTDIR}${prefix}/share/vim/vimfiles || return
		cp -Tvr ${vimdoc_ja_src_dir} ${DESTDIR}${prefix}/share/vim/vimfiles || return
		! which vim > /dev/null && return
		vim -i NONE -u NONE -N -c "helptags ${DESTDIR}${prefix}/share/vim/vimfiles/doc" -c qall || return
		;;
	ctags)
		[ -x ${DESTDIR}${prefix}/bin/ctags -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		grep -qe '^packcc_LINK\>' ${ctags_src_dir}/Makefile.am || sed -i -e '
			/^packcc_CPPFLAGS =/{
				ipackcc_LINK = cc $(packcc_CFLAGS) $(CFLAGS) $(AM_LDFLAGS) $(LDFLAGS) -o $@
				imisc/packcc/packcc-packcc.o: misc/packcc/packcc.c
				i\\t$(AM_V_CC)cc $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(packcc_CPPFLAGS) $(CPPFLAGS) $(packcc_CFLAGS) $(CFLAGS) -c -o misc/packcc/packcc-packcc.o misc/packcc/packcc.c
			}
			' ${ctags_src_dir}/Makefile.am || return
		[ -f ${ctags_src_dir}/configure ] ||
			(cd ${ctags_src_dir}; ./autogen.sh) || return
		[ -f ${ctags_bld_dir}/configure ] || cp -Tvr ${ctags_src_dir} ${ctags_bld_dir} || return
		[ -f ${ctags_bld_dir}/Makefile ] ||
			(cd ${ctags_bld_dir}
			./configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--disable-dependency-tracking \
				PKG_CONFIG_LIBDIR=) || return
		make -C ${ctags_bld_dir} -j ${jobs} || return
		make -C ${ctags_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	grep)
		[ -x ${DESTDIR}${prefix}/bin/grep -a "${force_install}" != yes ] && return
		print_header_path pcre.h > /dev/null || ${0} ${cmdopt} pcre || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${grep_bld_dir}/Makefile ] ||
			(cd ${grep_bld_dir}
			${grep_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${grep_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${grep_bld_dir} -j ${jobs} -k check || return
		make -C ${grep_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	diffutils)
		[ -x ${DESTDIR}${prefix}/bin/diff -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${diffutils_bld_dir}/Makefile ] ||
			(cd ${diffutils_bld_dir}
			${diffutils_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${diffutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${diffutils_bld_dir} -j ${jobs} -k check || return
		make -C ${diffutils_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	patch)
		[ -x ${DESTDIR}${prefix}/bin/patch -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${patch_bld_dir}/Makefile ] ||
			(cd ${patch_bld_dir}
			${patch_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
		make -C ${patch_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${patch_bld_dir} -j ${jobs} -k check || return
		make -C ${patch_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	global)
		[ -x ${DESTDIR}${prefix}/bin/global -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${global_bld_dir}/Makefile ] ||
			(cd ${global_bld_dir}
			${global_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-ncurses=`print_prefix curses.h` CPPFLAGS="${CPPFLAGS} -I`print_header_dir curses.h`" \
				CFLAGS="${CFLAGS} -fcommon" \
				ac_cv_posix1_2008_realpath=yes) || return
		make -C ${global_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${global_bld_dir} -j ${jobs} -k check || return
		make -C ${global_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	ruby)
		[ -x ${DESTDIR}${prefix}/bin/ruby -a "${force_install}" != yes ] && return
		ruby --version || return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ruby_bld_dir}/Makefile ] ||
			(cd ${ruby_bld_dir}
			${ruby_src_dir}/configure --prefix=${prefix} --host=${host} \
				--disable-silent-rules --enable-multiarch --enable-shared \
				--with-compress-debug-sections \
				--with-zlib-dir=`print_prefix zlib.h` \
				--with-readline-dir=`print_prefix readline.h readline` \
				--with-openssl-dir=`print_prefix ssl.h openssl` \
				) || return
		make -C ${ruby_bld_dir} -j ${jobs} V=1 SHELL=bash || return
		[ "${enable_check}" != yes ] ||
			make -C ${ruby_bld_dir} -j ${jobs} -k V=1 check || return
		make -C ${ruby_bld_dir} -j ${jobs} V=1 DESTDIR=${DESTDIR} install || return
		mkdir -pv ${DESTDIR}${prefix}/lib/pkgconfig || return
		ruby_platform=`grep -e '^arch =' -m 1 ${ruby_bld_dir}/Makefile | grep -oe '[[:graph:]]\+$'`
		ln -fsv ${ruby_platform}/pkgconfig/ruby-`print_version ruby`.pc ${DESTDIR}${prefix}/lib/pkgconfig || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/ruby || return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${ruby_platform}/libruby.so || return
		find ${DESTDIR}${prefix}/lib/${ruby_platform}/ruby/`print_version ruby`.0 -type f -name '*.so' -exec ${host:+${host}-}strip -v {} + || return
		;;
	go)
		[ -x ${DESTDIR}${prefix}/go/bin/go -a "${force_install}" != yes ] && return
		which go > /dev/null || { echo WARNING: host \'go\' is not found. skipped. >&2; return;}
		fetch ${1} || return
		[ -d ${go_src_dir} ] || unpack ${1} || return
		[ -d ${go_src_base}/go ] && mv -v ${go_src_base}/go ${go_src_dir}
		mkdir -pv ${DESTDIR}${prefix}/go/bin || return
		[ -f ${DESTDIR}${prefix}/go/bin/go ] || ln -sv `which go` ${DESTDIR}${prefix}/go/bin/go || return
		(cd ${go_src_dir}/src
		GOROOT_BOOTSTRAP=`go version | grep -qe gccgo && echo ${DESTDIR}${prefix}/go` \
			GOROOT_FINAL=${prefix}/go GOARCH=`goarch ${host}` GOOS=linux bash -x ${go_src_dir}/src/make.bash -v) || return
		rm -v ${DESTDIR}${prefix}/go/bin/go || return
		cp -Tfvr ${go_src_dir} ${DESTDIR}${prefix}/go || return
		;;
	cmake)
		[ -x ${DESTDIR}${prefix}/bin/cmake -a "${force_install}" != yes ] && return
		print_header_path curl.h curl > /dev/null || ${0} ${cmdopt} curl || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${cmake_bld_dir}/Makefile ] ||
			(cd ${cmake_bld_dir}
			${cmake_src_dir}/bootstrap --prefix=${DESTDIR}${prefix} --parallel=${jobs} \
				--system-curl --system-zlib --system-bzip2 --system-liblzma -- \
				-DCURL_INCLUDE_DIR=`print_header_dir curl.h curl` -DCURL_LIBRARY=`print_library_path libcurl.so` \
				-DBZIP2_INCLUDE_DIR=`print_header_dir bzlib.h` -DBZIP2_LIBRARIES=`print_library_path libbz2.so` \
				-DLIBLZMA_INCLUDE_DIR=`print_header_dir lzma.h` -DLIBLZMA_LIBRARY=`print_library_path liblzma.so`) || return
		make -C ${cmake_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${cmake_bld_dir} -j ${jobs} -k test || return
		make -C ${cmake_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
		;;
	llvm)
		[ -d ${DESTDIR}${prefix}/include/llvm -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} cmake || return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${llvm_src_dir} -B ${llvm_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_CROSSCOMPILING=True \
			-DLLVM_DEFAULT_TARGET_TRIPLE=${host} -DLLVM_TARGET_ARCH=`echo ${host} | cut -d- -f1` \
			`[ ${build} != ${host} ] && { echo -n -DLLVM_TABLEGEN=; which llvm-tblgen;}` \
			-DLLVM_ENABLE_LIBXML2=OFF \
			-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON || return
		cmake --build ${llvm_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${llvm_bld_dir} -v -j ${jobs} --target check || return
		cmake --install ${llvm_bld_dir} -v ${strip:+--${strip}} || return
		;;
	compiler-rt)
		[ -d ${DESTDIR}${prefix}/include/sanitizer -a "${force_install}" != yes ] && return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		fetch ${1} || return
		unpack ${1} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${compiler_rt_src_dir} -B ${compiler_rt_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON -DSANITIZER_CXX_ABI=libc++ || return
		cmake --build ${compiler_rt_bld_dir} -v -j ${jobs} || return
		cmake --install ${compiler_rt_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libunwind)
		[ -e ${DESTDIR}${prefix}/lib/libunwind.so -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libunwind_src_dir} -B ${libunwind_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DLIBUNWIND_USE_COMPILER_RT=ON || return
		cmake --build ${libunwind_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${libunwind_bld_dir} -v -j ${jobs} --target check-unwind || return
		cmake --install ${libunwind_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libcxxabi)
		[ -e ${DESTDIR}${prefix}/lib/libc++abi.so -a "${force_install}" != yes ] && return
		print_library_path libunwind.so > /dev/null || ${0} ${cmdopt} libunwind || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		init libcxx || return
		fetch libcxx || return
		unpack libcxx || return
		fetch ${1} || return
		unpack ${1} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libcxxabi_src_dir} -B ${libcxxabi_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_CXX_FLAGS=-L`print_library_dir libunwind.so` \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DLIBCXXABI_LIBCXX_PATH=${libcxx_src_dir} \
			-DLIBCXXABI_USE_LLVM_UNWINDER=ON || return
		cmake --build ${libcxxabi_bld_dir} -v -j ${jobs} || return
		cmake --install ${libcxxabi_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libcxx)
		[ -e ${DESTDIR}${prefix}/lib/libc++.so -a "${force_install}" != yes ] && return
		print_library_path libc++abi.so > /dev/null || ${0} ${cmdopt} libcxxabi || return
		init libcxxabi || return
		fetch libcxxabi || return
		unpack libcxxabi || return
		fetch ${1} || return
		unpack ${1} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libcxx_src_dir} -B ${libcxx_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_CXX_FLAGS=-L`print_library_dir libunwind.so` \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_CXX_ABI_INCLUDE_PATHS=${libcxxabi_src_dir}/include \
			-DLIBCXXABI_USE_LLVM_UNWINDER=ON || return
		cmake --build ${libcxx_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${libcxx_bld_dir} -v -j ${jobs} --target check-libcxx || return
		cmake --install ${libcxx_bld_dir} -v ${strip:+--${strip}} || return
		;;
	clang)
		[ -x ${DESTDIR}${prefix}/bin/clang -a "${force_install}" != yes ] && return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} ${1} || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		print_header_path allocator_interface.h sanitizer > /dev/null || ${0} ${cmdopt} compiler-rt || return
		print_library_path libunwind.so > /dev/null || ${0} ${cmdopt} libunwind || return
		print_library_path libc++abi.so > /dev/null || ${0} ${cmdopt} libcxxabi || return
		print_header_path iostream c++/v1 > /dev/null || ${0} ${cmdopt} libcxx || return
		print_binary_path lld > /dev/null || ${0} ${cmdopt} lld || return
		fetch ${1} || return
		unpack ${1} || return
		init clang-tools-extra || return
		fetch clang-tools-extra || return
		[ -d ${clang_src_dir}/tools/extra ] ||
			(unpack clang-tools-extra &&
			mv -v ${clang_tools_extra_src_dir} ${clang_src_dir}/tools/extra) || return
		patch -N -p0 -d ${clang_src_dir} <<EOF || [ $? = 1 ] || return
--- tools/extra/clangd/CodeComplete.h
+++ tools/extra/clangd/CodeComplete.h
@@ -71,7 +71,7 @@
   /// A visual indicator to prepend to the completion label to indicate whether
   /// completion result would trigger an #include insertion or not.
   struct IncludeInsertionIndicator {
-    std::string Insert = "•";
+    std::string Insert = "*";
     std::string NoInsert = " ";
   } IncludeIndicator;
 
EOF
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${clang_src_dir} -B ${clang_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_CXX_FLAGS="-I`print_header_dir llvm-config.h llvm/Config` -L`print_library_dir libLLVM.so`" \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_CROSSCOMPILING=True \
			-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
			-DLLVM_TOOLS_BINARY_DIR=`which llvm-tblgen | xargs dirname` \
			-DLLVM_DEFAULT_TARGET_TRIPLE=${host} -DLLVM_TARGET_ARCH=`echo ${host} | cut -d- -f1` \
			-DLLVM_ENABLE_LIBXML2=OFF \
			-DCLANG_TABLEGEN=`which clang-tblgen` \
			-DCMAKE_INSTALL_RPATH=';' -DENABLE_LINKER_BUILD_ID=ON \
			-DCLANG_DEFAULT_CXX_STDLIB=libc++ \
			-DCLANG_DEFAULT_RTLIB=compiler-rt \
			`print_binary_path lld > /dev/null && echo -DCLANG_DEFAULT_LINKER=lld` \
			-DGCC_INSTALL_PREFIX=`print_prefix iostream c++` || return
		cmake --build ${clang_bld_dir} -v -j ${jobs} || return
		cmake --install ${clang_bld_dir} -v ${strip:+--${strip}} || return
		install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${clang_bld_dir}/bin/clang-tblgen || return
		;;
	clang-tools-extra)
		[ -x ${DESTDIR}${prefix}/bin/clangd ] || echo WARNING: \'${1}\' can be install as a part of \'clang\'. skipped. >&2
		;;
	lld)
		[ -x ${DESTDIR}${prefix}/bin/lld -a "${force_install}" != yes ] && return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${lld_bld_dir}/llvm-config ] || cat << EOF > ${lld_bld_dir}/llvm-config || return
echo `print_library_dir libLLVM.so`
echo `print_header_dir llvm-config.h`
echo `print_library_dir LLVMConfig.cmake`
echo not-used
EOF
		chmod -v a+x ${lld_bld_dir}/llvm-config || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${lld_src_dir} -B ${lld_bld_dir} \
			-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DLLVM_CONFIG_PATH=${lld_bld_dir}/llvm-config \
			-DLLVM_TABLEGEN_EXE=`which llvm-tblgen` \
			-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON || return
		cmake --build ${lld_bld_dir} -v -j ${jobs} || return
		cmake --install ${lld_bld_dir} -v ${strip:+--${strip}} || return
		;;
	*) echo ERROR: not implemented. can not build \'${1}\'. >&2; return 1;;
	esac
	for d in lib lib64; do
		[ -d ${DESTDIR}${prefix}/${d} ] || continue
		find ${DESTDIR}${prefix}/${d} -type f -name '*.la' -exec \
			sed -i -e "
				/^dependency_libs='.\+'/{
					s/^/# /
					adependency_libs=''
				}
				s!^\(libdir='\)\(${prefix}\)!\1${DESTDIR}\2!
				" {} + || return
	done
	return 0
}

goarch()
{
	case ${1} in
	x86_64*)  echo amd64;;
	arm*)     echo arm;;
	aarch64*) echo arm64;;
	*) echo ERROR: unsupported GOARCH. >&2; return 1;;
	esac
}

generate_pathconfig()
{
	mkdir -pv `dirname ${1}` || return
	func_name=`basename ${1} | tr . _ | tr -cd '[:alpha:]_'`
	cat << 'EOF' | sed -e '1,/^{$/{s%prefix_place_holder%'${prefix}'%;s%host_place_holder%'${host}'%;s%func_place_holder%'${func_name}'%};$s%func_place_holder%'${func_name}'%' > ${1} || return
prefix=prefix_place_holder
host=host_place_holder
func_place_holder()
{
	for p in ${prefix}/bin ${prefix}/sbin; do
		[ -d ${p} ] || continue
		echo ${p} | grep -qe "/usr/local/s\?bin" && continue
		echo ${PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& PATH=${p}`echo ${PATH} | sed -e "
					s%\(^\|:\)${p}\(\$\|:\)%\1\2%g
					s/::/:/g
					s/^://
					s/:\$//
					s/^./:&/
				"` \
			|| PATH=${p}${PATH:+:${PATH}}
	done
	unset p

	for p in ${prefix}/lib ${prefix}/lib64 `[ -d ${prefix}/${host} ] && find ${prefix}/${host} -mindepth 2 -maxdepth 2 -type d -name lib` \
		`[ -d ${prefix}/lib/gcc/${host} ] && find ${prefix}/lib/gcc/${host} -mindepth 1 -maxdepth 1 -type d -name '*.?.?' | sort -rV | head -n 1`; do
		[ -d ${p} ] || continue
		echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& export LD_LIBRARY_PATH=${p}`echo ${LD_LIBRARY_PATH} | sed -e "
					s%\(^\|:\)${p}\(\$\|:\)%\1\2%g
					s/::/:/g
					s/^://
					s/:\$//
					s/^./:&/
				"` \
			|| export LD_LIBRARY_PATH=${p}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	done
	unset p

	echo ${MANPATH} | tr : '\n' | grep -qe ^${prefix}/share/man\$ \
		&& export MANPATH=${prefix}/share/man:`echo ${MANPATH} | sed -e '
				s%\(^\|:\)'${prefix}'/share/man\($\|:\)%\1\2%g
				s/::/:/g
				s/^://
			'` \
		|| export MANPATH=${prefix}/share/man:${MANPATH}

	[ "${TERM}" = linux ] && TERM=xterm-256color
	export TERMINFO=${prefix}/share/terminfo
}
func_place_holder
EOF
}

copy_libc()
{
	mkdir -pv ${DESTDIR}${prefix}/include || return
	(cd  `${host}-gcc -print-sysroot`/usr/include
	find . -mindepth 1 -maxdepth 1 | sed -e "
		s!^\./!!
		s!^.\+\$![ -e ${DESTDIR}${prefix}/include/& ] || cp -HTvr & ${DESTDIR}${prefix}/include/& || exit!
		" | sh || return
	) || return

	mkdir -pv ${DESTDIR}${prefix}/lib || return
	(cd  `${host}-gcc -print-file-name=crt1.o | xargs dirname`
	find . -mindepth 1 -maxdepth 1 -name '*.o' | sed -e "
		s!^\./!!
		s!^.\+\$![ -e ${DESTDIR}${prefix}/lib/& ] || cp -HTvr & ${DESTDIR}${prefix}/lib/& || exit!
		" | sh || return
	) || return
	(cd  `${host}-gcc -print-file-name=libgcc_s.so | xargs dirname`
	find . -mindepth 1 -maxdepth 1 -name 'libgcc_s.*' | sed -e "
		s!^\./!!
		s!^.\+\$![ -e ${DESTDIR}${prefix}/lib/& ] || cp -HTvr & ${DESTDIR}${prefix}/lib/& || exit!
		" | sh || return
	) || return
}

cleanup()
{
	[ -z "${cleanup}" ] && return
	eval rm -fvr \${${_1}_src_dir} || return
	eval rm -fvr \${${_1}_bld_dir} || return
}

atexit()
{
	realpath -e ${0} | grep -qe ^/tmp/ || return
	[ -z "${tmpdir}" ] || rm -fr `dirname ${0}` || return
}

delegate()
{
	realpath -e ${0} | grep -qe ^/tmp/ && return
	tmpdir=`mktemp -dp /tmp` || return
	cp ${0} ${tmpdir} || return
	exec sh -$- ${tmpdir}/`basename ${0}` --tmpdir "$@"
}

parse_cmdopts()
{
	unset cmdopt
	while [ $# -gt 0 ]; do
		case ${1} in
		--prefix|--host|--jobs)
			cmdopt="${cmdopt:+${cmdopt} }${1}"
			opt=`echo ${1} | cut -d- -f3`
			shift
			eval ${opt}=\${1:-\${${opt}}}
			;;
		--all|--fetch-only|--force|--strip|--cleanup|--copy-libc|--help|--tmpdir)
			opt=`echo ${1} | cut -d- -f3- | tr - _`
			eval ${opt}=${opt}
			;;
		-*|--*) echo ERROR: unknown option \'${1}\'. try \'--help\' for more information. >&2; return 1;;
		*) break;;
		esac
		case ${1} in
		--copy-libc|--tmpdir) ;; # don't pass these options to child process.
		*) cmdopt="${cmdopt:+${cmdopt} }${1}";;
		esac
		shift
	done
	pkgs="$@"
}

main()
{
	trap atexit EXIT HUP INT QUIT TERM
	delegate "$@" || return

	parse_cmdopts "$@" || return
	set -- ${pkgs} || return

	[ -n "${help}" ] && { help; return;}
	[ -z "${all}" ] || set -- `print_packages` || return
	[ $# -eq 0 ] && echo WARNING: no packages specified. try \'--help\' for more information. >&2
	[ -n "${force}" ] && force_install=yes

	${host}-gcc --version > /dev/null || return
	target=${host}
	DESTDIR=`readlink -m ${host}`

	PATH=`readlink -m ${build}${prefix}/bin`:${PATH}
	export LD_LIBRARY_PATH=`readlink -m ${build}${prefix}/lib/gcc/${build}/${gcc_ver}`:`readlink -m ${build}${prefix}/lib64`:`readlink -m ${build}${prefix}/lib`${LD_LIBRARY_PATH:+:}${LD_LIBRARY_PATH}

	languages=c,c++
	which ${host}-gccgo > /dev/null && languages=${languages},go

	for p in $@; do
		init ${p} || return
		if [ -n "${fetch_only}" ]; then
			fetch ${p} || return
			continue
		fi
		build ${p} || return
		cleanup ${p} || return
	done
	generate_pathconfig ${DESTDIR}${prefix}/pathconfig.sh || return
	[ -z "${copy_libc}" ] || copy_libc || return
}

main "$@"
