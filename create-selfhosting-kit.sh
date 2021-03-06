#!/bin/sh

default_prefix=/usr/local
default_host=aarch64-linux-gnu
default_jobs=`grep -e '^processor\>' -c /proc/cpuinfo`
src_dir=`readlink -m ./src`

help()
{
	cat << EOF
[NAME]
    `basename ${0}` - create toolchain running on the target itself

[SYNOPSIS]
    `basename ${0}` [--prefix PREFIX] [--host HOST] [--jobs JOBS] [--prepare]
        [-all] [--exclude XXX] [--fetch-only] [--force] [--strip] [--cleanup]
        [--with-libc] [--without-libc] [--help] [packages...]

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

    --prepare
        build/install native build tools.

    --all
        build/install all packages listed bellow.

    --exclude XXX
        exclude package XXX when '--all' is enabled.

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

    --with-libc
        copy standard C library header files, crt*.o, and so on.

    --without-libc
        remove standard C library header files, crt*.o, and so on.

    --XXX-ver x.y.z
        specify the version of package XXX as x.y.z.

    --help
        show this help.

[EXAMPLES]
    * install minimum toolchain
        \$ `basename ${0}` --strip --cleanup --with-libc gcc make

    * install debugging tools
        \$ `basename ${0}` --strip --cleanup gdb strace systemtap

    * install extra toolchain
        \$ `basename ${0}` --strip --cleanup \\
                    m4 autoconf automake libtool pkg-config git \\
                    cmake ninja meson

    * install tools required by linux kernel development
        \$ `basename ${0}` --strip --cleanup ed bc rsync dtc

    * install terminal multiplexers
        \$ `basename ${0}` --strip --cleanup screen tmux

    * install text editing/coding tools
        \$ `basename ${0}` --strip --cleanup \\
                    vim ctags grep diffutils patch global

    * install clang/clang++ compilers
        \$ `basename ${0}` --strip --cleanup --with-libc clang

    * install other programming languages
        \$ `basename ${0}` --strip --cleanup Python go

    * install all packages with libc, but with no symbol information
        \$ `basename ${0}` --all --strip --cleanup --with-libc

[PACKAGES]
`print_packages | tr '\n' ' ' | fold -s | sed -e 's/^/    /'`

EOF
}

: ${zlib_ver:=1.2.11}
: ${bzip2_ver:=1.0.8}
: ${xz_ver:=5.2.5}
: ${zstd_ver:=1.5.0}
: ${openssl_ver:=1.1.1k}
: ${curl_ver:=7.75.0}
: ${elfutils_ver:=0.183}
: ${binutils_ver:=2.37}
: ${gmp_ver:=6.2.1}
: ${mpfr_ver:=4.1.0}
: ${mpc_ver:=1.2.1}
: ${isl_ver:=0.20}
: ${gcc_ver:=11.1.0}
: ${make_ver:=4.3}
: ${ccache_ver:=4.3}

: ${ncurses_ver:=6.2}
: ${readline_ver:=8.1}
: ${expat_ver:=2.4.1}
: ${libffi_ver:=3.3}
: ${Python_ver:=3.9.5}
: ${boost_ver:=1_76_0}
: ${source_highlight_ver:=3.1.9}
: ${pcre_ver:=8.44}
: ${pcre2_ver:=10.37}
: ${util_linux_ver:=2.37}
: ${popt_ver:=1.18}
: ${glib_ver:=2.59.0}
: ${babeltrace_ver:=1.5.8}
: ${gdb_ver:=10.2}
: ${crash_ver:=7.3.0}
: ${strace_ver:=5.12}
: ${systemtap_ver:=4.5}
: ${linux_ver:=5.12.9}
: ${perf_ver:=${linux_ver}}
: ${libcap_ver:=2.49}
: ${numactl_ver:=2.0.14}
: ${OpenCSD_ver:=1.1.0}
: ${libunwindnongnu_ver:=1.5.0}
: ${libpfm_ver:=4.11.0}
: ${libbpf_ver:=0.4.0}
: ${bcc_ver:=0.20.0}
: ${bpftrace_ver:=0.13.0}
: ${libtraceevent_ver:=1.3.3}
: ${libtracefs_ver:=1.2.3}
: ${trace_cmd_ver:=v2.9.4}
: ${libpcap_ver:=1.9.1}
: ${tcpdump_ver:=4.9.3}
: ${procps_ver:=3.3.16}
: ${sysstat_ver:=12.5.4}
: ${inetutils_ver:=2.0}
: ${iproute2_ver:=5.9.0}
: ${nmap_ver:=7.90}
: ${i2c_tools_ver:=4.2}

: ${m4_ver:=1.4.19}
: ${perl_ver:=5.32.1}
: ${autoconf_ver:=2.71}
: ${automake_ver:=1.16.3}
: ${bison_ver:=3.7.6}
: ${flex_ver:=2.6.4}
: ${libtool_ver:=2.4.6}
: ${pkg_config_ver:=0.29.2}
: ${sed_ver:=4.8}
: ${gawk_ver:=5.1.0}
: ${gettext_ver:=0.21}
: ${git_ver:=2.32.0}
: ${openssh_ver:=8.5p1}
: ${lzip_ver:=1.22}
: ${ed_ver:=1.17}
: ${bc_ver:=1.07.1}
: ${rsync_ver:=3.2.3}
: ${dtc_ver:=1.6.0}
: ${kmod_ver:=28}
: ${u_boot_ver:=2020.10}
: ${tar_ver:=1.34}
: ${cpio_ver:=2.13}
: ${e2fsprogs_ver:=1.46.2}
: ${v4l_utils_ver:=1.20.0}

: ${screen_ver:=4.8.0}
: ${libevent_ver:=2.1.11-stable}
: ${tmux_ver:=3.2}
: ${zsh_ver:=5.8}
: ${bash_ver:=5.0}
: ${tcsh_ver:=TCSH6_22_04}
: ${vim_ver:=8.2.2886}
: ${vimdoc_ja_ver:=master}
: ${emacs_ver:=27.2}
: ${nano_ver:=5.8}
: ${ctags_ver:=git}
: ${grep_ver:=3.6}
: ${diffutils_ver:=3.7}
: ${patch_ver:=2.7.6}
: ${global_ver:=6.6.6}
: ${findutils_ver:=4.8.0}

: ${help2man_ver:=1.47.16}
: ${coreutils_ver:=8.32}
: ${file_ver:=5.39}

: ${go_ver:=1.16.6}
: ${cmake_ver:=3.19.4}
: ${ninja_ver:=1.10.2}
: ${meson_ver:=0.58.1}
: ${libxml2_ver:=2.9.10}
: ${libedit_ver:=20191231-3.1}
: ${swig_ver:=4.0.2}
: ${llvm_ver:=12.0.1}
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
	[ ${1} = perf ] && init linux && perf_ver=${linux_ver}

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
	libunwindnongnu)
		eval ${_1}_name=libunwind-\${${_1}_ver};;
	procps)
		eval ${_1}_name=${1}-v\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac
	eval ${_1}_src_dir=${src_dir}/${1}/\${${_1}_name}
	eval ${_1}_bld_dir=${src_dir}/${1}/\${${_1}_name}-${host}`[ ${host} != ${target} ] && echo -${target}`
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
	[ ${1} != perf ] || { fetch linux; return $?;}
	_1=`echo ${1} | tr - _`
	eval mkdir -pv \${${_1}_src_base} || return
	eval check_archive \${${_1}_src_dir} || \
		eval [ -d \${${_1}_src_dir} -o -h \${${_1}_src_dir} ] && return

	case ${1} in
	zlib)
		wget -O ${zlib_src_dir}.tar.xz \
			http://zlib.net/${zlib_name}.tar.xz || return;;
	binutils|gmp|mpfr|mpc|make|ncurses|readline|gdb|inetutils|m4|autoconf|automake|\
	bison|libtool|sed|gawk|gettext|ed|bc|tar|cpio|screen|bash|emacs|nano|grep|\
	diffutils|patch|global|findutils|help2man|coreutils)
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
	zstd)
		wget -O ${zstd_src_dir}.tar.gz \
			https://github.com/facebook/zstd/releases/download/v${zstd_ver}/${zstd_name}.tar.gz || return;;
	ccache)
		wget -O ${ccache_src_dir}.tar.xz \
			https://github.com/ccache/ccache/releases/download/v${ccache_ver}/${ccache_name}.tar.xz || return;;
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
			https://boostorg.jfrog.io/artifactory/main/release/`echo ${boost_ver} | tr _ .`/source/${boost_name}.tar.bz2 || return;;
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
			https://www.kernel.org/pub/linux/utils/util-linux/v`print_version util-linux`/${util_linux_name}.tar.xz || return;;
	popt)
		wget -O ${popt_src_dir}.tar.gz \
			http://ftp.rpm.org/popt/releases/popt-1.x/${popt_name}.tar.gz || return;;
	glib)
		wget -O ${glib_src_dir}.tar.xz \
			http://ftp.gnome.org/pub/gnome/sources/glib/`print_version glib`/${glib_name}.tar.xz || return;;
	babeltrace)
		wget -O ${babeltrace_src_dir}.tar.gz \
			https://github.com/efficios/babeltrace/archive/v${babeltrace_ver}.tar.gz || return;;
	crash)
		wget -O ${crash_src_dir}.tar.gz \
			https://github.com/crash-utility/crash/archive/${crash_ver}.tar.gz || return;;
	strace)
		wget -O ${strace_src_dir}.tar.xz \
			https://strace.io/files/${strace_ver}/${strace_name}.tar.xz || return;;
	systemtap)
		wget -O ${systemtap_src_dir}.tar.gz \
			https://sourceware.org/systemtap/ftp/releases/${systemtap_name}.tar.gz || return;;
	linux|perf)
		wget -O ${linux_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/kernel/v`print_version ${_1} 1`.x/${linux_name}.tar.xz || return;;
	libcap)
		wget -O ${libcap_src_dir}.tar.gz \
			https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${libcap_name}.tar.gz || return;;
	numactl)
		wget -O ${numactl_src_dir}.tar.gz \
			https://github.com/numactl/numactl/releases/download/v${numactl_ver}/${numactl_name}.tar.gz || return;;
	OpenCSD)
		wget -O ${OpenCSD_src_dir}.tar.gz \
			https://github.com/Linaro/OpenCSD/archive/refs/tags/v${OpenCSD_ver}.tar.gz || return;;
	libunwindnongnu)
		wget -O ${libunwindnongnu_src_dir}.tar.gz \
			http://download.savannah.nongnu.org/releases/libunwind/${libunwindnongnu_name}.tar.gz || return;;
	libpfm)
		wget -O ${libpfm_src_dir}.tar.gz \
			https://sourceforge.net/projects/perfmon2/files/libpfm4/${libpfm_name}.tar.gz/download || return;;
	libbpf)
		wget -O ${libbpf_src_dir}.tar.gz \
			https://github.com/libbpf/libbpf/archive/v${libbpf_ver}.tar.gz || return;;
	bcc)
		wget -O ${bcc_src_dir}.tar.gz \
			https://github.com/iovisor/bcc/archive/v${bcc_ver}.tar.gz || return;;
	bpftrace)
		wget -O ${bpftrace_src_dir}.tar.gz \
			https://github.com/iovisor/bpftrace/archive/v${bpftrace_ver}.tar.gz || return;;
	libtraceevent)
		wget -O ${libtraceevent_src_dir}.tar.gz \
			https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/snapshot/libtraceevent-${libtraceevent_ver}.tar.gz || return;;
	libtracefs)
		wget -O ${libtracefs_src_dir}.tar.gz \
			https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/snapshot/libtracefs-${libtracefs_ver}.tar.gz || return;;
	trace-cmd)
		wget -O ${trace_cmd_src_dir}.tar.gz \
			https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot/trace-cmd-${trace_cmd_ver}.tar.gz || return;;
	libpcap|tcpdump)
		eval wget -O \${${_1}_src_dir}.tar.gz \
			http://www.tcpdump.org/release/\${${_1}_name}.tar.gz || return;;
	procps)
		wget -O ${procps_src_dir}.tar.bz2 \
			https://gitlab.com/procps-ng/procps/-/archive/v${procps_ver}/procps-v${procps_ver}.tar.bz2 || return;;
	sysstat)
		wget -O ${sysstat_src_dir}.tar.gz \
			https://github.com/sysstat/sysstat/archive/v${sysstat_ver}.tar.gz || return;;
	iproute2)
		wget -O ${iproute2_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/utils/net/iproute2/${iproute2_name}.tar.xz || return;;
	nmap)
		wget -O ${nmap_src_dir}.tar.bz2 \
			https://nmap.org/dist/${nmap_name}.tar.bz2 || return;;
	i2c-tools)
		wget -O ${i2c_tools_src_dir}.tar.xz \
			https://mirrors.edge.kernel.org/pub/software/utils/i2c-tools/${i2c_tools_name}.tar.xz || return;;
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
	openssh)
		wget -O ${openssh_src_dir}.tar.gz \
			http://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/${openssh_name}.tar.gz || return;;
	lzip)
		wget -O ${lzip_src_dir}.tar.gz \
			http://download.savannah.gnu.org/releases/lzip/${lzip_name}.tar.gz || return;;
	rsync)
		wget -O ${rsync_src_dir}.tar.gz \
			https://download.samba.org/pub/rsync/src/${rsync_name}.tar.gz || return;;
	dtc)
		wget -O ${dtc_src_dir}.tar.xz \
			https://www.kernel.org/pub/software/utils/dtc/${dtc_name}.tar.xz || return;;
	kmod)
		wget -O ${kmod_src_dir}.tar.xz \
			https://www.kernel.org/pub/linux/utils/kernel/kmod/${kmod_name}.tar.xz || return;;
	u-boot)
		wget -O ${u_boot_src_dir}.tar.bz2 \
			ftp://ftp.denx.de/pub/u-boot/${u_boot_name}.tar.bz2 || return;;
	e2fsprogs)
		wget -O ${e2fsprogs_src_dir}.tar.gz \
			https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${e2fsprogs_ver}/${e2fsprogs_name}.tar.gz/download || return;;
	v4l-utils)
		wget -O ${v4l_utils_src_dir}.tar.bz2 \
			https://linuxtv.org/downloads/v4l-utils/${v4l_utils_name}.tar.bz2 || return;;
	libevent)
		wget -O ${libevent_src_dir}.tar.gz \
			https://github.com/libevent/libevent/releases/download/release-${libevent_ver}/${libevent_name}.tar.gz || return;;
	tmux)
		wget -O ${tmux_src_dir}.tar.gz \
			https://github.com/tmux/tmux/releases/download/${tmux_ver}/${tmux_name}.tar.gz || return;;
	zsh)
		wget --trust-server-names -O ${zsh_src_dir}.tar.xz \
			https://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.xz/download || return;;
	tcsh)
		wget -O ${tcsh_src_dir}.tar.gz \
			https://github.com/tcsh-org/tcsh/archive/refs/tags/${tcsh_ver}.tar.gz || return;;
	vim)
		wget -O ${vim_src_dir}.tar.gz \
			http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return;;
	vimdoc-ja)
		wget -O ${vimdoc_ja_src_dir}.tar.gz \
			https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz || return;;
	ctags)
		git clone --depth 1 \
			http://github.com/universal-ctags/ctags.git ${ctags_src_dir} || return;;
	file)
		wget -O ${file_src_dir}.tar.gz \
			http://ftp.astron.com/pub/file/${file_name}.tar.gz || return;;
	go)
		wget -O ${go_src_dir}.tar.gz \
			https://storage.googleapis.com/golang/go${go_ver}.src.tar.gz || return;;
	cmake)
		wget -O ${cmake_src_dir}.tar.gz \
			https://cmake.org/files/v`print_version cmake`/${cmake_name}.tar.gz || return;;
	ninja)
		wget -O ${ninja_src_dir}.tar.gz \
			https://github.com/ninja-build/ninja/archive/v${ninja_ver}.tar.gz || return;;
	meson)
		wget -O ${meson_src_dir}.tar.gz \
			https://github.com/mesonbuild/meson/archive/${meson_ver}.tar.gz || return;;
	libxml2|libxslt)
		eval wget -O \${${_1}_src_dir}.tar.gz \
			http://xmlsoft.org/sources/\${${_1}_name}.tar.gz || return;;
	libedit)
		wget -O ${libedit_src_dir}.tar.gz \
			http://thrysoee.dk/editline/${libedit_name}.tar.gz || return;;
	swig)
		wget --trust-server-names -O ${swig_src_dir}.tar.gz \
			https://sourceforge.net/projects/swig/files/swig/${swig_name}/${swig_name}.tar.gz/download || return;;
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
	[ -z "${2}" -a -d ${d} ] && return
	[ -n "${2}" -a -d ${2}/`basename ${d}` ] && return
	${2:+eval mkdir -pv ${2} || return}
	[ -f ${d}.tar.gz  -a -s ${d}.tar.gz  ] && tar xzvf ${d}.tar.gz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.bz2 -a -s ${d}.tar.bz2 ] && tar xjvf ${d}.tar.bz2 --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.xz  -a -s ${d}.tar.xz  ] && tar xJvf ${d}.tar.xz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	[ -f ${d}.tar.lz  -a -s ${d}.tar.lz  ] && tar xvf  ${d}.tar.lz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
	return 1
}

print_sysroot()
{
	${CC:-${host:+${host}-}gcc} -print-sysroot || return
}

filter_shortest_hierarchy()
{
	awk '{print split($0, a, /\//), $0}' | sort -n | cut -d ' ' -f 2 | head -n 1
}

squash_options()
{
	uniq | tr '\n' ' ' | sed -e 's/ $//' || return
}

print_library_path()
{
	for d in ${DESTDIR}${prefix}/lib64 ${DESTDIR}${prefix}/lib \
		`[ ${build} = ${host} ] && echo /usr/local/lib64 /usr/local/lib` \
		`LANG=C ${CC:-${host:+${host}-}gcc} -print-search-dirs |
			sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs realpath -eq`; do
		[ -d ${d}${2:+/${2}} ] || continue
		candidates=`find ${d}${2:+/${2}} \( -type f -o -type l \) -name ${1} | filter_shortest_hierarchy`
		[ -n "${candidates}" ] && echo "${candidates}" && return
	done
	return 1
}

print_library_dir()
{
	path=`print_library_path $@`
	[ $? = 0 ] && dirname ${path} || return
}

L()
{
	for l in "$@"; do
		echo ${l} | grep -qe '/' && d=`dirname ${l}` || d=
		f=lib`basename ${l}`.so
		print_library_dir ${f} ${d} || return
	done | sed -e 's/^/-L/' | squash_options || return
}

l()
{
	L "$@" || return
	echo "$@" | sed -e 's/^/ /;s/ / -l/g' || return
}

print_header_path()
{
	for d in ${DESTDIR}${prefix}/include \
		`LANG=C ${CC:-${host:+${host}-}gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
			sed -e '/^#include /,/^End of search list.$/p;d' | xargs realpath -eq`; do
		[ -d ${d}${2:+/${2}} ] || continue
		candidates=`find ${d}${2:+/${2}} \( -type f -o -type l \) -name ${1} | filter_shortest_hierarchy`
		[ -n "${candidates}" ] && echo "${candidates}" && return
	done
	return 1
}

print_header_dir()
{
	path=`print_header_path $@`
	[ $? = 0 ] && echo ${path} | sed -e "s%${2:+/${2}}/${1}\$%%" || return
}

I()
{
	for h in "$@"; do
		echo ${h} | grep -qe '/' && d=`dirname ${h}` || d=
		f=`basename ${h}`
		print_header_dir ${f} ${d} || return
	done | sed -e 's/^/-I/' | squash_options || return
}

idirafter()
{
	for h in "$@"; do
		echo ${h} | grep -qe '/' && d=`dirname ${h}` || d=
		f=`basename ${h}`
		print_header_dir ${f} ${d} || return
	done | sed -e 's/^/-idirafter/' | squash_options || return
}

print_aclocal_dir()
{
	for d in ${DESTDIR}${prefix}/share/aclocal \
		`print_sysroot`/usr/share/aclocal; do
		[ -d ${d} ] || continue
		echo ${d}
	done
}

print_pkg_config_sysroot()
{
	[ `print_library_dir ${1}` = ${DESTDIR}${prefix}/lib/pkgconfig ] && echo ${DESTDIR} && return
	print_sysroot || return
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
		s/trace_cmd/trace-cmd/
		s/i2c_tools/i2c-tools/
		s/pkg_config/pkg-config/
		s/vimdoc_ja/vimdoc-ja/
		s/u_boot/u-boot/
		s/v4l_utils/v4l-utils/
		s/compiler_rt/compiler-rt/
		s/clang_tools_extra/clang-tools-extra/
	' || return
}

print_filtered_packages()
{
	print_packages | grep -v -e dummy `echo $@ | tr ' ' '\n' | sed -e 's/^/-e ^/;s/$/$/'`
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

print_target_llvm_version()
{
	grep -e 'LLVM_VERSION_STRING' `print_header_path llvm-config.h` | cut -d\" -f2 || return
}

print_swig_lib_dir()
{
	for d in ${DESTDIR}`swig -swiglib` `swig -swiglib`; do
		[ -d ${d} ] && echo ${d} && return
	done
	return 1
}

make()
{
	echo make "$@"
	command make "$@"
}

cmake()
{
	echo cmake "$@"
	command cmake "$@"
}

build()
{
	case ${1} in
	zlib)
		[ -f ${DESTDIR}${prefix}/include/zlib.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${zlib_bld_dir}
		unset LDSHARED CFLAGS
		CHOST=${host} ${zlib_src_dir}/configure --prefix=${prefix}) || return
		make -C ${zlib_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${zlib_bld_dir} -j ${jobs} -k check || return
		make -C ${zlib_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
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
			CC="${CC:-${host:+${host}-}gcc}" AR=${host}-gcc-ar RANLIB=${host}-gcc-ranlib bzip2 bzip2recover || return
		[ "${enable_check}" != yes ] ||
			make -C ${bzip2_bld_dir} -j ${jobs} -k check || return
		make -C ${bzip2_bld_dir} -j ${jobs} PREFIX=${DESTDIR}${prefix} install || return
		make -C ${bzip2_bld_dir} -j ${jobs} clean || return
		make -C ${bzip2_bld_dir} -j ${jobs} -f Makefile-libbz2_so CC="${CC:-${host:+${host}-}gcc}" || return
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
			remove_rpath_option ${1} || return
			${xz_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
		make -C ${xz_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${xz_bld_dir} -j ${jobs} -k check || return
		make -C ${xz_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	zstd)
		[ -x ${DESTDIR}${prefix}/bin/zstd -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${zstd_bld_dir}/Makefile ] || cp -Tvr ${zstd_src_dir} ${zstd_bld_dir} || return
		make -C ${zstd_bld_dir} -j ${jobs} V=1 CC="${CC:-${host:+${host}-}gcc}" || return
		make -C ${zstd_bld_dir} -j ${jobs} V=1 prefix=${DESTDIR}${prefix} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/zstd || return
		;;
	openssl)
		[ -d ${DESTDIR}${prefix}/include/openssl -a "${force_install}" != yes ] && return
		${0} ${cmdopt} --host ${build} --target ${build} perl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${openssl_bld_dir}/Makefile ] ||
			(cd ${openssl_bld_dir}
			MACHINE=`echo ${host} | cut -d- -f1` SYSTEM=Linux \
				${openssl_src_dir}/config --prefix=${prefix} shared) || return
		make -C ${openssl_bld_dir} -j 1 `[ -z "${CC}" ] && echo CROSS_COMPILE=${host}-` || return # XXX work around for parallel make
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
	curl)
		[ -x ${DESTDIR}${prefix}/bin/curl -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path zstd.h > /dev/null || ${0} ${cmdopt} zstd || return
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
			--enable-mqtt --enable-manual --enable-ipv6 --enable-openssl-auto-load-config \
			--enable-sspi --enable-crypto-auth --enable-tls-srp \
			--enable-unix-sockets --enable-cookies --enable-http-auth \
			--enable-doh --enable-mime --enable-dateparse --enable-netrc \
			--enable-progress-meter --enable-dnsshuffle --enable-alt-svc \
			--disable-versioned-symbols \
			--with-zlib=`print_prefix zlib.h` \
			--with-zstd=`print_prefix zstd.h` \
			--with-ssl=`print_prefix ssl.h openssl` \
			LDFLAGS="${LDFLAGS} `L zstd`" \
			LIBS='-lzstd') || return
		make -C ${curl_bld_dir} -j ${jobs} || return
		make -C ${curl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/curl || return
		;;
	elfutils)
		[ -x ${DESTDIR}${prefix}/bin/eu-addr2line -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		print_header_path zstd.h > /dev/null || ${0} ${cmdopt} zstd || return
		print_header_path curl.h curl > /dev/null || ${0} ${cmdopt} curl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${elfutils_bld_dir}/Makefile ] ||
			(cd ${elfutils_bld_dir}
			${elfutils_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--enable-libdebuginfod --disable-debuginfod \
				CFLAGS="${CFLAGS} `I zlib.h zstd.h`" \
				LDFLAGS="${LDFLAGS} `L z bz2 lzma zstd`" \
				LIBS="${LIBS} `l z bz2 lzma curl zstd ssl crypto`" \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir libcurl.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				) || return
		make -C ${elfutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${elfutils_bld_dir} -j ${jobs} -k check || return
		make -C ${elfutils_bld_dir} -j 1 STRIPPROG=${host:+${host}-}strip DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	binutils)
		[ -x ${DESTDIR}${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${binutils_bld_dir}/Makefile ] ||
			(cd ${binutils_bld_dir}
			sed -i -e 's/\(\$\(wl\|{wl}\)\)\?-\?-rpath[, ]\(\$\(wl\|{wl}\)\)\?\$\(libdir\|(libdir)\)//' \
				`grep -le '\<rpath\>' -r ${binutils_src_dir} --exclude=ltmain.sh --exclude=Makefile.in` || return
			sed -i -e 's/\(\<runpath_var\>=\).\+/\1dummy_runpath/' `find ${binutils_src_dir} -type f -name libtool.m4` || return
			[ -f host_configargs ] || cat << EOF | tr '\n' ' ' > host_configargs || return
--disable-rpath
--enable-install-libiberty
LIBS='`l z curl zstd ssl crypto`'
EOF
			${binutils_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--enable-shared --enable-gold --enable-threads --enable-plugins \
				--enable-compressed-debug-sections=all --enable-targets=all --enable-64-bit-bfd \
				--with-system-zlib --with-debuginfod \
				CFLAGS="${CFLAGS} `I zlib.h elfutils/debuginfod.h`" \
				CXXFLAGS="${CXXFLAGS} `I zlib.h`" \
				LDFLAGS="${LDFLAGS} `L z debuginfod`" \
				LIBS="`l z curl zstd ssl crypto`" \
				host_configargs="`cat host_configargs`") || return
		make -C ${binutils_bld_dir} -j 1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${binutils_bld_dir} -j 1 -k check || return
		make -C ${binutils_bld_dir} -j 1 DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for b in addr2line ar as c++filt coffdump dlltool dllwrap dwp \
			elfedit gprof ld ld.bfd ld.gold nm objcopy objdump ranlib \
			readelf size srconv strings strip sysdump windmc windres; do
			[ -f ${DESTDIR}${prefix}/bin/${target}-${b} ] && continue
			ln -fsv ${b} ${DESTDIR}${prefix}/bin/${target}-${b} || return
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR} ${prefix}/lib: || return
		done
		for l in libbfd.so libctf-nobfd.so libctf.so libopcodes.so; do
			truncate_path_in_elf ${DESTDIR}${prefix}/lib/${l} ${DESTDIR} ${prefix}/lib: || return
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
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libmpfr.so ${DESTDIR} ${prefix}/lib || return
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
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libmpc.so ${DESTDIR} ${prefix}/lib || return
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
				LDFLAGS="${LDFLAGS} `L z gmp`" LIBS=-lgmp) || return
		make -C ${isl_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${isl_bld_dir} -j ${jobs} -k check || return
		make -C ${isl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libisl.so ${DESTDIR} ${prefix}/lib || return
		;;
	gcc)
		[ -x ${DESTDIR}${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
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
				--enable-languages=c`{
					echo ${target} | grep -qe linux && echo ,c++
					[ ${build} = ${host} ] || which ${host}-gccgo > /dev/null && echo ,go
				} | tr -d '\n'` \
				--disable-multilib --enable-linker-build-id --enable-libstdcxx-debug \
				--program-suffix=-${gcc_base_ver} --enable-version-specific-runtime-libs \
				`[ ${build} != ${host} ] && {
					d=$(${target}-gcc -print-sysroot)
					[ -d "${d}" ] && echo --with-build-sysroot=${d} && exit
					echo ${SDKTARGETSYSROOT:+--with-build-sysroot=${SDKTARGETSYSROOT}}
				}` \
			) || return
		make -C ${gcc_bld_dir} -j ${jobs} \
			CPPFLAGS="${CPPFLAGS} -DLIBICONV_PLUG" \
			CPPFLAGS_FOR_TARGET="${CPPFLAGS} -DLIBICONV_PLUG" \
			CFLAGS_FOR_TARGET="${CFLAGS} -Wno-error" \
			LDFLAGS="${LDFLAGS} `L z`" || return
		[ "${enable_check}" != yes ] ||
			make -C ${gcc_bld_dir} -j ${jobs} -k check || return
		make -C ${gcc_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		[ -f ${gcc_bld_dir}/gcc/xg++ -a "${force_install}" = yes ] &&
			which doxygen > /dev/null && make -C ${gcc_bld_dir}/${target}/libstdc++-v3 -j ${jobs} DESTDIR=${DESTDIR} install-man
		[ ${host} != ${target} ] || ln -fsv gcc ${DESTDIR}${prefix}/bin/cc || return
		[ ! -f ${DESTDIR}${prefix}/bin/${target}-gcc-tmp ] || rm -v ${DESTDIR}${prefix}/bin/${target}-gcc-tmp || return
		for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool go gofmt; do
			[ -f ${DESTDIR}${prefix}/bin/${target}-${b}-${gcc_base_ver} ] || continue
			[ ${host} != ${target} ] || ln -fsv ${b}-${gcc_base_ver} ${DESTDIR}${prefix}/bin/${b} || return
			ln -fsv `[ ${host} = ${target} ] && echo ${b} || echo ${target}-${b}-${gcc_base_ver}` \
				${DESTDIR}${prefix}/bin/${target}-${b} || return
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
	ccache)
		[ -x ${DESTDIR}${prefix}/bin/ccache -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_header_path zstd.h > /dev/null || ${0} ${cmdopt} zstd || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gcc_wrapper ${ccache_bld_dir} || return
		generate_gxx_wrapper ${ccache_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${ccache_src_dir} -B ${ccache_bld_dir} \
			-DCMAKE_C_COMPILER=${ccache_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${ccache_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DZSTD_LIBRARY=`print_library_path libzstd.so` \
			-DZSTD_INCLUDE_DIR=`print_header_dir zstd.h` \
			|| return
		cmake --build ${ccache_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${ccache_bld_dir} -v -j ${jobs} --target check || return
		cmake --install ${ccache_bld_dir} -v ${strip:+--${strip}} || return
		update_ccache_wrapper -f || return
		;;
	ncurses)
		[ -f ${DESTDIR}${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ncurses_bld_dir}/Makefile ] ||
			(cd ${ncurses_bld_dir}
			sed -i -e "
				/^INSTALL_PROG\>/{
					s!\( --strip-program=[[:graph:]]\+\)\?\$! --strip-program=${host:+${host}-}strip!
				}" ${ncurses_src_dir}/progs/Makefile.in || return
			${ncurses_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-shared --with-cxx-shared --with-termlib \
				--with-versioned-syms --enable-termcap --enable-colors) || return
		make -C ${ncurses_bld_dir} -j 1 DESTDIR=${DESTDIR} || return # XXX work around for parallel make
		make -C ${ncurses_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		make -C ${ncurses_bld_dir} -j ${jobs} distclean || return
		[ -f ${ncurses_bld_dir}/Makefile ] ||
			(cd ${ncurses_bld_dir}
			${ncurses_src_dir}/configure --prefix=${prefix} --host=${host} \
				--with-shared --with-cxx-shared --with-termlib \
				--with-versioned-syms --enable-termcap --enable-widec --enable-colors) || return
		make -C ${ncurses_bld_dir} -j 1 DESTDIR=${DESTDIR} || return # XXX work around for parallel make
		make -C ${ncurses_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		for h in `find ${DESTDIR}${prefix}/include/ncurses \( -type f -o -type l \) -name '*.h'`; do
			ln -fsv `echo ${h} | sed -e "s%${DESTDIR}${prefix}/include/%%"` ${DESTDIR}${prefix}/include || return
		done
		rm -fv ${DESTDIR}${prefix}/lib/libncurses.so || return
		echo 'INPUT(libncurses.so.'`print_version ncurses 1`' -ltinfo)' > ${DESTDIR}${prefix}/lib/libncurses.so || return
		echo 'INPUT(libncurses.so.'`print_version ncurses 1`' -ltinfo)' > ${DESTDIR}${prefix}/lib/libcurses.so || return
		ln -fsv libncurses.a ${DESTDIR}${prefix}/lib/libcurses.a || return
		[ -z "${strip}" ] && return
		for b in clear infocmp tabs tic toe tput tset; do
			[ -f ${DESTDIR}${prefix}/bin/${b} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		for l in libform libmenu libncurses++ libpanel libtinfo libformw libmenuw libncurses++w libncursesw libpanelw libtinfow; do
			[ -f ${DESTDIR}${prefix}/lib/${l}.so ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
		done
		;;
	readline)
		[ -f ${DESTDIR}${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${readline_bld_dir}/Makefile ] ||
			(cd ${readline_bld_dir}
			sed -i -e 's/\(-Wl,\)\?-rpath[, ]\$(libdir) \?//' ${readline_src_dir}/support/shobj-conf || return
			${readline_src_dir}/configure --prefix=${prefix} --host=${host} \
				--enable-multibyte --with-curses) || return
		make -C ${readline_bld_dir} -j ${jobs} SHLIB_LIBS="`l tinfo`" || return
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
	Python)
		[ -x ${DESTDIR}${prefix}/bin/python3 -a "${force_install}" != yes ] && return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path ffi.h > /dev/null || ${0} ${cmdopt} libffi || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${Python_bld_dir}/Makefile ] ||
			(cd ${Python_bld_dir}
			[ ${build} = ${host} -o -f config.site ] || cat << EOF > config.site || return
ac_cv_file__dev_ptmx=yes
ac_cv_file__dev_ptc=no
EOF
			${Python_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-universalsdk \
				--enable-shared --enable-optimizations --enable-ipv6 \
				--with-universal-archs=all --with-lto --with-system-expat --with-system-ffi \
				--with-openssl=`print_prefix ssl.h openssl` \
				--with-doc-strings --with-pymalloc \
				LDSHARED= \
				CFLAGS="${CFLAGS} -I`{ print_header_dir curses.h ncursesw | sed -e 's/include$/&\/ncursesw/'; print_header_dir curses.h;} | head -n 1` `I expat.h`" \
				LDFLAGS="${LDFLAGS} `L expat`" \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir libffi.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				CONFIG_SITE=config.site || return
			) || return
		make -C ${Python_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${Python_bld_dir} -j ${jobs} -k test || return
		generate_command_wrapper ${Python_bld_dir} lsb_release \
			'PYTHONPATH=/usr/share/pyshared:${PYTHONPATH} python3 '`which lsb_release`' "$@"' || return
		PATH=${Python_bld_dir}:${PATH} make -C ${Python_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for v in `print_version Python` `print_version Python`m; do
			[ ! -f ${DESTDIR}${prefix}/bin/python${v} ] || ${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/python${v} || return
		done
		for soname_v in `print_version Python 1`.so `print_version Python`.so.1.0 `print_version Python`m.so.1.0; do
			[ -f ${DESTDIR}${prefix}/lib/libpython${soname_v} ] || continue
			chmod -v u+w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
			chmod -v u-w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
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
		CXX= ./bootstrap.sh --prefix=${DESTDIR}${prefix} --with-toolset=gcc &&
		sed -i -e "/^    using gcc /s!!&: : ${CC:-${host:+${host}-}gcc} !" project-config.jam &&
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
				--without-doxygen \
				CXXFLAGS="${CXXFLAGS} -std=c++14") || return # XXX: workaround for Dynamic Exception Specification.
		make -C ${source_highlight_bld_dir} -j ${jobs} -k || true
		[ "${enable_check}" != yes ] ||
			make -C ${source_highlight_bld_dir} -j ${jobs} -k check || return
		make -C ${source_highlight_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} -k || true
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
				CPPFLAGS="${CPPFLAGS} `I zlib.h`" \
				LDFLAGS="${LDFLAGS} `L z`") || return
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
				CPPFLAGS="${CPPFLAGS} `I bzlib.h`" \
				LDFLAGS="${LDFLAGS} `L bz2`") || return
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
				CFLAGS="${CFLAGS} `I zlib.h Python.h`" \
				LDFLAGS="`L tinfo`" \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=) || return
		make -C ${util_linux_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${util_linux_bld_dir} -j ${jobs} -k check || return
		make -C ${util_linux_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} -k || true
		;;
	popt)
		[ -f ${DESTDIR}${prefix}/include/popt.h -a "${force_install}" != yes ] && return
		which autopoint > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} gettext || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${popt_bld_dir}/Makefile ] ||
			(cd ${popt_bld_dir}
			sed -i -e '/^AM_C_PROTOTYPES$/d' ${popt_src_dir}/configure.ac || return
			sed -i -e '/^TESTS = /d' ${popt_src_dir}/Makefile.am || return
			gettext_datadir=$(dirname $(which gettext))/../share/gettext autoreconf -fiv ${popt_src_dir} || return
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
		which gettext > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} gettext || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${glib_src_dir}/configure ] ||
			(cd ${glib_src_dir}; NOCONFIGURE=yes ./autogen.sh) || return
		[ -f ${glib_bld_dir}/Makefile ] ||
			(cd ${glib_bld_dir}
			${glib_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-static \
				--disable-silent-rules --disable-libmount --disable-dtrace --enable-systemtap \
				CPPFLAGS="${CPPFLAGS} `I zlib.h`" \
				LIBFFI_CFLAGS=`I ffi.h` LIBFFI_LIBS="`l ffi`" \
				PCRE_CFLAGS=`I pcre.h` PCRE_LIBS="`l pcre`" \
				LIBS="`l ffi pcre z`" \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir libffi.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				glib_cv_stack_grows=no glib_cv_uscore=no) || return
		make -C ${glib_bld_dir} -j ${jobs} || return
		make -C ${glib_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for b in gapplication gdbus gio gio-launch-desktop gio-querymodules glib-compile-resources glib-compile-schemas gobject-query gresource gsettings gtester; do
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR}${prefix}/lib/../lib64:${DESTDIR} ${prefix}/lib || return
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR} ${prefix}/lib || return
			[ -z "${strip}" ] && continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		for l in libgio-2.0.so libglib-2.0.so libgmodule-2.0.so libgobject-2.0.so libgthread-2.0.so; do
			truncate_path_in_elf ${DESTDIR}${prefix}/lib/${l} ${DESTDIR}${prefix}/lib/../lib64:${DESTDIR} ${prefix}/lib || return
			truncate_path_in_elf ${DESTDIR}${prefix}/lib/${l} ${DESTDIR} ${prefix}/lib || return
		done
		;;
	babeltrace)
		[ -x ${DESTDIR}${prefix}/bin/babeltrace -a "${force_install}" != yes ] && return
		print_header_path pcre.h > /dev/null || ${0} ${cmdopt} pcre || return
		print_header_path glib.h glib-2.0 > /dev/null || ${0} ${cmdopt} glib || return
		print_header_path uuid.h uuid > /dev/null || ${0} ${cmdopt} util-linux || return
		print_header_path popt.h > /dev/null || ${0} ${cmdopt} popt || return
		print_header_path zstd.h > /dev/null || ${0} ${cmdopt} zstd || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${babeltrace_src_dir}/configure ] ||
			(cd ${babeltrace_src_dir}
			ACLOCAL_PATH=`print_aclocal_dir | tr '\n' :` ./bootstrap) || return
		[ -f ${babeltrace_bld_dir}/Makefile ] ||
			(cd ${babeltrace_bld_dir}
			${babeltrace_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				CPPFLAGS="${CPPFLAGS} `I popt.h`" \
				LDFLAGS="${LDFLAGS} `L popt`" \
				LIBS="${LIBS} `l pcre z bz2 lzma zstd`" \
				PKG_CONFIG_PATH=`print_library_dir glib-2.0.pc`:`print_library_dir libpcre.pc`  \
				PKG_CONFIG_LIBDIR= \
				PKG_CONFIG_SYSROOT_DIR=`print_pkg_config_sysroot glib-2.0.pc` \
				ac_cv_func_malloc_0_nonnull=yes \
				ac_cv_func_realloc_0_nonnull=yes \
				bt_cv_lib_elfutils=yes) || return
		make -C ${babeltrace_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${babeltrace_bld_dir} -j ${jobs} -k check || return
		make -C ${babeltrace_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for b in babeltrace babeltrace-log; do
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR} ${prefix}/lib || return
		done
		for l in libbabeltrace-ctf-metadata.so  libbabeltrace-ctf-text.so  libbabeltrace-ctf.so  libbabeltrace-dummy.so  libbabeltrace-lttng-live.so  libbabeltrace.so; do
			truncate_path_in_elf ${DESTDIR}${prefix}/lib/${l} ${DESTDIR} ${prefix}/lib || return
		done
		;;
	gdb)
		[ -x ${DESTDIR}${prefix}/bin/gdb -a "${force_install}" != yes ] && return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
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
CFLAGS='${CFLAGS} `I zlib.h curses.h Python.h`'
CPPFLAGS='${CPPFLAGS} `I zlib.h Python.h`'
LDFLAGS='-L`print_prefix Python.h`/lib `L popt`'
LIBS='${LIBS} `l popt uuid gmodule-2.0 glib-2.0 pcre dw elf z bz2 lzma curl zstd`'
PKG_CONFIG_PATH=
PKG_CONFIG_LIBDIR=`print_library_dir source-highlight.pc`
PKG_CONFIG_SYSROOT_DIR=${DESTDIR}
EOF
			${gdb_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--enable-targets=all --enable-64-bit-bfd --enable-tui --enable-source-highlight \
				--with-auto-load-dir='$debugdir:$datadir/auto-load:'${prefix}/lib/gcc/${target} \
				--with-debuginfod --with-system-zlib --with-system-readline \
				--with-expat=yes --with-libexpat-prefix=`print_prefix expat.h` \
				--with-mpfr=yes --with-libmpfr-prefix=`print_prefix mpfr.h` \
				--with-python=python3 --without-guile \
				--with-lzma=yes --with-liblzma-prefix=`print_prefix lzma.h` \
				--with-babeltrace=yes --with-libbabeltrace-prefix=`print_prefix babeltrace.h babeltrace` \
				LDFLAGS="${LDFLAGS} `L z ncurses popt`" \
				host_configargs="`cat host_configargs`") || return
		make -C ${gdb_bld_dir} -j ${jobs} V=1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${gdb_bld_dir} -j ${jobs} -k check || return
		make -C ${gdb_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		make -C ${gdb_bld_dir}/gdb -j ${jobs} DESTDIR=${DESTDIR} STRIPPROG=${host:+${host}-}strip install${strip:+-${strip}} || return
		make -C ${gdb_bld_dir}/sim -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	crash)
		[ -x ${DESTDIR}${prefix}/bin/crash -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${crash_bld_dir}/Makefile ] || cp -Tvr ${crash_src_dir} ${crash_bld_dir} || return
		sed -i -e "s!^\(INSTALLDIR=\${DESTDIR}\)/usr/bin\$!\1${prefix}/bin!" ${crash_bld_dir}/Makefile || return
		sed -i -e 's/^	@${CC}\( ${CONF_FLAGS}\)/	${BUILDCC}\1/' ${crash_bld_dir}/Makefile || return
		sed -i -e "/^CRASH_CFLAGS=/s!\${CFLAGS}\$!& `I zlib.h`!" ${crash_bld_dir}/Makefile || return
		grep -qe --host ${crash_bld_dir}/configure.c ||
			sed -i -e '/^#define /s!GDB_CONF_FLAGS=!&--host='${host}' CFLAGS=\\"'"`I curses.h`"' '"`l curses`"'\\" !' \
				${crash_bld_dir}/configure.c || return
		make -C ${crash_bld_dir} -j ${jobs} BUILDCC=cc target=`echo ${target} | cut -d- -f1` || return
		make -C ${crash_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/crash || return
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
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/strace || return
		;;
	systemtap)
		[ -x ${DESTDIR}${prefix}/bin/stap -a "${force_install}" != yes ] && return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path Python.h > /dev/null || ${0} ${cmdopt} Python || return
		fetch ${1} || return
		unpack ${1} || return
		generate_python_config_dummy ${systemtap_bld_dir} || return
		[ -f ${systemtap_bld_dir}/Makefile ] ||
			(cd ${systemtap_bld_dir}
			${systemtap_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--without-python2-probes \
				CPPFLAGS="${CPPFLAGS} `I elfutils/libdw.h Python.h`" \
				LDFLAGS="${LDFLAGS} `L dw` `l python$(print_target_python_version)$(print_target_python_abi)`" \
				LIBS="${LIBS} `l z bz2 lzma zstd`" \
				PYTHON_CONFIG=${systemtap_bld_dir}/python-config \
				) || return
		sed -i -e '/^\<LDFLAGS\>/{
			s/\( -lc\)\?$/ -lc/
			aexport LDFLAGS
		}' ${systemtap_bld_dir}/python/Makefile || return
		make -C ${systemtap_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${systemtap_bld_dir} -j ${jobs} -k check || return
		make -C ${systemtap_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	linux)
		[ -f ${DESTDIR}${prefix}/include/linux/version.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		generate_toolchain_wrapper ${linux_bld_dir} || return
		make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} mrproper || return
		make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} \
			ARCH=`print_linux_arch ${host}` CROSS_COMPILE=${linux_bld_dir}/${host:+${host}-} INSTALL_HDR_PATH=${DESTDIR}${prefix} headers_install || return
		;;
	perf)
		[ -x ${DESTDIR}${prefix}/bin/perf -a "${force_install}" != yes ] && return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		print_header_path babeltrace.h babeltrace > /dev/null || ${0} ${cmdopt} babeltrace || return
		print_header_path bpf.h bpf > /dev/null || ${0} ${cmdopt} libbpf || return
		print_header_path capability.h sys > /dev/null || ${0} ${cmdopt} libcap || return
		print_header_path numaif.h > /dev/null || ${0} ${cmdopt} numactl || return
		print_header_path ocsd_if_version.h opencsd > /dev/null || ${0} ${cmdopt} OpenCSD || return
		print_header_path libunwind.h > /dev/null || ${0} ${cmdopt} libunwindnongnu || return
		print_header_path pfmlib.h perfmon > /dev/null || ${0} ${cmdopt} libpfm || return
		fetch linux || return
		unpack linux || return
		mkdir -pv ${perf_bld_dir} || return
		generate_toolchain_wrapper ${perf_bld_dir} || return
		PKG_CONFIG_PATH= \
		PKG_CONFIG_LIBDIR= \
		PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
		make -C ${linux_src_dir}/tools/perf -j ${jobs} V=1 VF=1 W=1 O=${perf_bld_dir} \
			ARCH=`print_linux_arch ${host}` CROSS_COMPILE=${perf_bld_dir}/${host:+${host}-} \
			EXTRA_CFLAGS="${CFLAGS} `idirafter libelf.h zstd.h perfmon/pfmlib.h` `L elf bpf babeltrace popt curl zstd`" \
			EXTRA_CXXFLAGS="${CXXFLAGS} `idirafter libelf.h zstd.h perfmon/pfmlib.h` `L elf bpf babeltrace popt curl zstd`" \
			LDFLAGS="${LDFLAGS} `l babeltrace popt elf bz2 lzma z curl zstd`" \
			NO_LIBPERL=1 WERROR=0 NO_SLANG=1 CORESIGHT=1 LIBPFM4=1 \
			prefix=${prefix} all || return
		make -C ${linux_src_dir}/tools/perf -j ${jobs} V=1 VF=1 W=1 O=${perf_bld_dir} \
			ARCH=`print_linux_arch ${host}` CROSS_COMPILE=${perf_bld_dir}/${host:+${host}-} \
			EXTRA_CFLAGS="${CFLAGS} `idirafter libelf.h zstd.h perfmon/pfmlib.h` `L elf bpf babeltrace popt curl zstd`" \
			EXTRA_CXXFLAGS="${CXXFLAGS} `idirafter libelf.h zstd.h perfmon/pfmlib.h` `L elf bpf babeltrace popt curl zstd`" \
			LDFLAGS="${LDFLAGS} `l babeltrace popt elf bz2 lzma z curl zstd`" \
			NO_LIBPERL=1 WERROR=0 NO_SLANG=1 CORESIGHT=1 LIBPFM4=1 \
			prefix=${prefix} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for b in perf trace; do
			[ -f ${DESTDIR}${prefix}/bin/${b} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	libcap)
		[ -x ${DESTDIR}${prefix}/sbin/getcap -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libcap_bld_dir}/Makefile ] || cp -Tvr ${libcap_src_dir} ${libcap_bld_dir} || return
		generate_toolchain_wrapper ${libcap_bld_dir} || return
		make -C ${libcap_bld_dir} -j ${jobs} prefix=${prefix} lib=lib CROSS_COMPILE=${libcap_bld_dir}/${host:+${host}-} BUILD_CC=cc GOLANG=no || return
		[ "${enable_check}" != yes ] ||
			make -C ${libcap_bld_dir} -j ${jobs} -k CROSS_COMPILE=${libcap_bld_dir}/${host:+${host}-} test || return
		make -C ${libcap_bld_dir} -j ${jobs} prefix=${prefix} lib=lib CROSS_COMPILE=${libcap_bld_dir}/${host:+${host}-} BUILD_CC=cc GOLANG=no DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for b in capsh getcap getpcaps setcap; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/sbin/${b} || return
		done
		for l in libcap.so libpsx.so; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l} || return
		done
		;;
	numactl)
		[ -x ${DESTDIR}${prefix}/bin/numactl -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${numactl_bld_dir}/Makefile ] ||
			(cd ${numactl_bld_dir}
			remove_rpath_option ${1} || return
			${numactl_src_dir}/configure --prefix=${prefix} --host=${host}) || return
		make -C ${numactl_bld_dir} -j ${jobs} V=1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${numactl_bld_dir} -j ${jobs} -k check V=1 || return
		make -C ${numactl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	OpenCSD)
		[ -f ${DESTDIR}${prefix}/include/opencsd/ocsd_if_version.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${OpenCSD_bld_dir}/README.md ] || cp -Tvr ${OpenCSD_src_dir} ${OpenCSD_bld_dir} || return
		generate_toolchain_wrapper ${OpenCSD_bld_dir} || return
		make -C ${OpenCSD_bld_dir}/decoder/build/linux -j ${jobs} CROSS_COMPILE=${OpenCSD_bld_dir}/${host:+${host}-} || return
		make -C ${OpenCSD_bld_dir}/decoder/build/linux -j ${jobs} PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/trc_pkt_lister || return
		for l in libopencsd.so libopencsd_c_api.so; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l} || return
		done
		;;
	libunwindnongnu)
		[ -f ${DESTDIR}${prefix}/include/libunwind.h -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libunwindnongnu_bld_dir}/Makefile ] ||
			(cd ${libunwindnongnu_bld_dir}
			remove_rpath_option ${1} || return
			${libunwindnongnu_src_dir}/configure --prefix=${prefix} --host=${host} \
				--enable-coredump --enable-ptrace --enable-setjmp \
				--enable-cxx-exceptions --enable-debug-frame \
				--enable-minidebuginfo --enable-zlibdebuginfo \
				CFLAGS="${CFLAGS} `I zlib.h lzma.h`" \
				LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${libunwindnongnu_bld_dir}/src/.libs" \
				LIBS="${LIBS} `l z lzma`" \
				|| return
			remove_rpath_option ${1} || return
			) || return
		make -C ${libunwindnongnu_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libunwindnongnu_bld_dir} -j ${jobs} -k check || return
		make -C ${libunwindnongnu_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	libpfm)
		[ -f ${DESTDIR}${prefix}/include/perfmon/pfmlib.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libpfm_bld_dir}/Makefile ] || cp -Tvr ${libpfm_src_dir} ${libpfm_bld_dir} || return
		sed -i -e '/^DIRS=/s/\<tests\>//' ${libpfm_bld_dir}/Makefile || return
		sed -i -e '/^ARCH :=/s/\$(shell uname -m)/'`print_linux_arch ${host}`'/' ${libpfm_bld_dir}/config.mk || return
		make -C ${libpfm_bld_dir} -j ${jobs} PREFIX=${prefix} CC="${CC:-${host:+${host}-}gcc}" || return
		make -C ${libpfm_bld_dir} -j ${jobs} PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libpfm.so || return
		;;
	libbpf)
		[ -f ${DESTDIR}${prefix}/include/bpf/bpf.h -a "${force_install}" != yes ] && return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		fetch ${1} || return
		unpack ${1} || return
		PKG_CONFIG_PATH= \
		PKG_CONFIG_LIBDIR=`print_library_dir libelf.pc` \
		PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
		make -C ${libbpf_src_dir}/src -j ${jobs} V=1 OBJDIR=${libbpf_bld_dir} CC="${CC:-${host:+${host}-}gcc}" PREFIX=${prefix} || return
		make -C ${libbpf_src_dir}/src -j ${jobs} V=1 OBJDIR=${libbpf_bld_dir} CC="${CC:-${host:+${host}-}gcc}" PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for l in lib/libbpf.a lib/libbpf.so lib64/libbpf.a lib64/libbpf.so; do
			[ -f ${DESTDIR}${prefix}/${l} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/${l} || return
		done
		;;
	bcc)
		[ -f ${DESTDIR}${prefix}/include/bcc/bcc_version.h -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		${0} ${cmdopt} --host ${build} --target ${build} bison || return
		${0} ${cmdopt} --host ${build} --target ${build} flex || return
		print_header_path FlexLexer.h > /dev/null || ${0} ${cmdopt} flex || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		print_header_path Version.h clang/Basic > /dev/null || ${0} ${cmdopt} clang || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path bfd.h > /dev/null || ${0} ${cmdopt} binutils || return
		print_binary_path python3 > /dev/null || ${0} ${cmdopt} Python || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		sed -i -e '/--install-layout/s/^ /#&/' ${bcc_src_dir}/src/python/CMakeLists.txt || return
		init libbpf || return
		fetch libbpf || return
		unpack libbpf || return
		[ -f ${bcc_src_dir}/src/cc/libbpf/README.md ] || cp -Tvr ${libbpf_src_dir} ${bcc_src_dir}/src/cc/libbpf || return
		generate_gcc_wrapper ${bcc_bld_dir} || return
		generate_gxx_wrapper ${bcc_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${bcc_src_dir} -B ${bcc_bld_dir} \
			-DCMAKE_C_COMPILER=${bcc_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${bcc_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_C_FLAGS="${CFLAGS} `L elf z`" \
			-DCMAKE_CXX_FLAGS="${CXXFLAGS} `I FlexLexer.h` `l elf z tinfo`" \
			-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
			-DPYTHON_CMD=python3 \
			|| return
		cmake --build ${bcc_bld_dir} -v -j ${jobs} || return
		cmake --install ${bcc_bld_dir} -v ${strip:+--${strip}} || return
		;;
	bpftrace)
		[ -x ${DESTDIR}${prefix}/bin/bpftrace -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		${0} ${cmdopt} --host ${build} --target ${build} bison || return
		${0} ${cmdopt} --host ${build} --target ${build} flex || return
		print_header_path FlexLexer.h > /dev/null || ${0} ${cmdopt} flex || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		print_header_path Version.h clang/Basic > /dev/null || ${0} ${cmdopt} clang || return
		print_header_path libelf.h > /dev/null || ${0} ${cmdopt} elfutils || return
		print_header_path bfd.h > /dev/null || ${0} ${cmdopt} binutils || return
		print_header_path bcc_version.h bcc > /dev/null || ${0} ${cmdopt} bcc || return
		fetch ${1} || return
		unpack ${1} || return
		sed -i -e 's/\(set(CMAKE_REQUIRED_LIBRARIES bcc\)\()\)/\1 tinfo\2/' ${bpftrace_src_dir}/CMakeLists.txt || return
		generate_gcc_wrapper ${bpftrace_bld_dir} || return
		generate_gxx_wrapper ${bpftrace_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${bpftrace_src_dir} -B ${bpftrace_bld_dir} \
			-DCMAKE_C_COMPILER=${bpftrace_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${bpftrace_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_C_FLAGS="${CFLAGS} `l elf z`" \
			-DCMAKE_CXX_FLAGS="${CXXFLAGS} `I bcc/compat/linux/bpf.h`/bcc/compat `I libelf.h bfd.h` `l elf z tinfo`" \
			-DBUILD_TESTING=OFF \
			-DLIBBCC_INCLUDE_DIRS=`print_header_dir bcc_version.h bcc` \
			-DLIBBCC_LIBRARIES=`print_library_path libbcc.so` \
			-DLIBBFD_INCLUDE_DIRS=`print_header_dir bfd.h` \
			-DLIBBFD_LIBRARIES="`print_library_path libbfd.so`;`print_library_path libcurl.so`;`print_library_path libzstd.so`" \
			-DLIBOPCODES_INCLUDE_DIRS=`print_header_dir dis-asm.h` \
			-DLIBOPCODES_LIBRARIES=`print_library_path libopcodes.so` \
			-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
			-DClang_DIR=`print_library_dir ClangConfig.cmake` \
			|| return
		cmake --build ${bpftrace_bld_dir} -v -j ${jobs} --target bpftrace man || return
		cmake --install ${bpftrace_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libtraceevent)
		[ -f ${DESTDIR}${prefix}/include/traceevent/kbuffer.h -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		make -C ${libtraceevent_src_dir} -j ${jobs} V=1 O=${libtraceevent_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			pkgconfig_dir=${prefix}/lib/pkgconfig || return
		make -C ${libtraceevent_src_dir} -j ${jobs} V=1 O=${libtraceevent_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			pkgconfig_dir=${prefix}/lib/pkgconfig install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib64/libtraceevent.so || return
		;;
	libtracefs)
		[ -f ${DESTDIR}${prefix}/include/tracefs/tracefs.h -a "${force_install}" != yes ] && return
		print_header_path kbuffer.h traceevent > /dev/null || ${0} ${cmdopt} libtraceevent || return
		fetch ${1} || return
		unpack ${1} || return
		sed -i -e 's/,-rpath=\$\$ORIGIN//' ${libtracefs_src_dir}/scripts/utils.mk || return
		(export \
			PKG_CONFIG_PATH= \
			PKG_CONFIG_LIBDIR=`print_library_dir libtraceevent.pc` \
			PKG_CONFIG_SYSROOT_DIR=${DESTDIR}
		make -C ${libtracefs_src_dir} -j ${jobs} V=1 O=${libtracefs_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			pkgconfig_dir=${prefix}/lib/pkgconfig etcdir=${prefix}/etc || return
		make -C ${libtracefs_src_dir} -j ${jobs} V=1 O=${libtracefs_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			pkgconfig_dir=${prefix}/lib/pkgconfig etcdir=${prefix}/etc install || return
		) || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib64/libtracefs.so || return
		;;
	trace-cmd)
		[ -x ${DESTDIR}${prefix}/bin/trace-cmd -a "${force_install}" != yes ] && return
		print_header_path kbuffer.h traceevent > /dev/null || ${0} ${cmdopt} libtraceevent || return
		print_header_path tracefs.h tracefs > /dev/null || ${0} ${cmdopt} libtracefs || return
		fetch ${1} || return
		unpack ${1} || return
		sed -i -e 's/ -Wl,-rpath=\$(libdir)//' ${trace_cmd_src_dir}/scripts/utils.mk || return
		PKG_CONFIG_PATH= \
		PKG_CONFIG_LIBDIR=`print_library_dir libtracefs.pc` \
		PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
		make -C ${trace_cmd_src_dir} -j ${jobs} V=1 O=${trace_cmd_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			etcdir=${prefix}/etc || return
		make -C ${trace_cmd_src_dir} -j ${jobs} V=1 O=${trace_cmd_bld_dir} \
			CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
			etcdir=${prefix}/etc install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/trace-cmd || return
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
				CPPFLAGS="${CPPFLAGS} `I pcap.h`" \
				LDFLAGS="${LDFLAGS} `L pcap`" \
				LIBS="${LIBS} -lpcap" \
				) || return
		make -C ${tcpdump_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tcpdump_bld_dir} -j ${jobs} -k check || return
		make -C ${tcpdump_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	procps)
		[ -x ${DESTDIR}${prefix}/bin/ps -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		which gettext > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} gettext || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${procps_src_dir}/configure ] ||
			(cd ${procps_src_dir}; gettext_datadir=$(dirname $(which gettext))/../share/gettext ./autogen.sh) || return
		[ -f ${procps_bld_dir}/configure ] || cp -Tvr ${procps_src_dir} ${procps_bld_dir} || return
		[ -f ${procps_bld_dir}/Makefile ] ||
			(cd ${procps_bld_dir}
			./configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				CFLAGS="${CFLAGS} `I ncurses.h`" \
				LDFLAGS="${LDFLAGS} `L ncurses`" \
				ac_cv_func_realloc_0_nonnull=yes \
				ac_cv_func_malloc_0_nonnull=yes \
				) || return
		make -C ${procps_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${procps_bld_dir} -j ${jobs} -k check || return
		make -C ${procps_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	sysstat)
		[ -x ${DESTDIR}${prefix}/bin/sar -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${sysstat_bld_dir}/configure ] || cp -Tvr ${sysstat_src_dir} ${sysstat_bld_dir} || return
		[ -f ${sysstat_bld_dir}/Makefile ] ||
			(cd ${sysstat_bld_dir}
			./configure --prefix=${prefix} --host=${host} \
				--with-systemdsystemunitdir=${prefix}/lib/systemd/system \
				--with-systemdsleepdir=${prefix}/lib/systemd/system-sleep \
				--enable-install-cron --enable-collect-all --enable-copy-only \
				sa_dir=${prefix}/var/log/sa \
				conf_dir=${prefix}/etc/sysconfig \
				) || return
		make -C ${sysstat_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${sysstat_bld_dir} -j ${jobs} -k check || return
		make -C ${sysstat_bld_dir} -j ${jobs} IGNORE_FILE_ATTRIBUTES=y DESTDIR=${DESTDIR} install || return
		;;
	inetutils)
		[ -x ${DESTDIR}${prefix}/bin/telnet -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${inetutils_bld_dir}/Makefile ] ||
			(cd ${inetutils_bld_dir}
			${inetutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			CFLAGS="${CFLAGS} `I curses.h` -DPATH_PROCNET_DEV=\\\"/proc/net/dev\\\"" \
			LDFLAGS="${LDFLAGS} `l tinfo`" \
			) || return
		make -C ${inetutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${inetutils_bld_dir} -j ${jobs} -k check || return
		make -C ${inetutils_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	iproute2)
		[ -d ${DESTDIR}${prefix}/include/iproute2 -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${iproute2_bld_dir}/Makefile ] || cp -Tvr ${iproute2_src_dir} ${iproute2_bld_dir} || return
		sed -i -e 's/^	\$(HOSTCC)/	gcc/' ${iproute2_bld_dir}/netem/Makefile || return
		sed -i -e 's!^    : \${CC=gcc}$!    CC="'"${CC:-${host:+${host}-}gcc}"'"!' ${iproute2_bld_dir}/configure || return
		PKG_CONFIG_PATH= \
			PKG_CONFIG_LIBDIR=`print_library_dir libelf.pc` \
			PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
			make -C ${iproute2_bld_dir} -j ${jobs} V=1 \
				PREFIX=${prefix} \
				CONFDIR=${prefix}/etc/iproute2 \
				NETNS_RUN_DIR=${prefix}/var/run/netns \
				NETNS_ETC_DIR=${prefix}/etc/netns \
				HOSTCC="${CC:-${host:+${host}-}gcc}" || return
		[ "${enable_check}" != yes ] ||
			make -C ${iproute2_bld_dir} -j ${jobs} -k check || return
		make -C ${iproute2_bld_dir} -j ${jobs} V=1 \
			PREFIX=${prefix} \
			CONFDIR=${prefix}/etc/iproute2 \
			NETNS_RUN_DIR=${prefix}/var/run/netns \
			NETNS_ETC_DIR=${prefix}/etc/netns \
			SBINDIR=${prefix}/sbin \
			ARPDDIR=${prefix}/var/lib/arpd \
			DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for b in bridge devlink genl ifstat ip lnstat nstat rdma rtacct rtmon ss tc tipc; do
			[ -f ${DESTDIR}${prefix}/sbin/${b} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/sbin/${b} || return
		done
		;;
	nmap)
		[ -x ${DESTDIR}${prefix}/bin/nmap -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${nmap_bld_dir}/configure ] || cp -Tvr ${nmap_src_dir} ${nmap_bld_dir} || return
		[ -f ${nmap_bld_dir}/Makefile ] ||
			(cd ${nmap_bld_dir}
			./configure --prefix=${prefix} --host=${host}) || return
		make -C ${nmap_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${nmap_bld_dir} -j ${jobs} -k check || return
		make -C ${nmap_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for b in ncat nmap nping; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	i2c-tools)
		[ -x ${DESTDIR}${prefix}/sbin/i2cdetect -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${i2c_tools_bld_dir}/Makefile ] || cp -Tvr ${i2c_tools_src_dir} ${i2c_tools_bld_dir} || return
		make -C ${i2c_tools_bld_dir} -j ${jobs} EXTRA= PYTHON=python3 CC="${CC:-${host:+${host}-}gcc}" AR="${AR:-${host:+${host}-}ar}" || return
		[ -z "${strip}" ] || make -C ${i2c_tools_bld_dir} -j ${jobs} EXTRA= STRIP="${STRIP:-${host:+${host}-}strip}" strip || return
		make -C ${i2c_tools_bld_dir} -j ${jobs} EXTRA= PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
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
		[ ${build} != ${host} ] && { echo WARNING: not implemented. can not build \'${1}\'. skipped. >&2; return 0;}
		[ -x ${DESTDIR}${prefix}/bin/perl -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${perl_bld_dir}/Makefile ] ||
			(cd ${perl_bld_dir}
			${perl_src_dir}/Configure -de `[ ${build} != ${host} ] && echo -- -Dusecrosscompile` \
				-Dprefix=`[ ${build} = ${host} ] && echo ${DESTDIR}`${prefix} \
				-Dcc="${CC:-${host:+${host}-}gcc}" \
				-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits -Duseshrplib -Dmksymlinks) || return
		make -C ${perl_bld_dir} -j 1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${perl_bld_dir} -j ${jobs} -k test || return
		make -C ${perl_bld_dir} -j ${jobs} DESTDIR=`[ ${build} != ${host} ] && echo ${DESTDIR}` install${strip:+-${strip}} || return
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
			${bison_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--enable-relocatable) || return
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
	sed)
		[ -x ${DESTDIR}${prefix}/bin/sed -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${sed_bld_dir}/Makefile ] ||
			(cd ${sed_bld_dir}
			${sed_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
		make -C ${sed_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${sed_bld_dir} -j ${jobs} -k check || return
		make -C ${sed_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	gawk)
		[ -x ${DESTDIR}${prefix}/bin/gawk -a "${force_install}" != yes ] && return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		print_header_path mpfr.h > /dev/null || ${0} ${cmdopt} mpfr || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${gawk_bld_dir}/Makefile ] ||
			(cd ${gawk_bld_dir}
			${gawk_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-static \
				--with-readline=`print_prefix readline.h readline` \
				--with-mpfr=`print_prefix mpfr.h`) || return
		make -C ${gawk_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${gawk_bld_dir} -j ${jobs} -k check || return
		make -C ${gawk_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
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
	git)
		[ -x ${DESTDIR}${prefix}/bin/git -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		print_binary_path curl-config > /dev/null || ${0} ${cmdopt} curl || return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path pcre2.h > /dev/null || ${0} ${cmdopt} pcre2 || return
		which msgfmt > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} gettext || return
		fetch ${1} || return
		unpack ${1} || return
		make -C ${git_src_dir} -j ${jobs} V=1 configure || return
		(cd ${git_src_dir}
		./configure --prefix=${prefix} --host=${host} \
			--with-openssl=`print_prefix ssl.h openssl` --with-libpcre=`print_prefix pcre2.h` \
			--with-curl=`print_prefix curl.h curl` --with-expat=`print_prefix expat.h` \
			--with-perl=perl --with-python=python3 --with-zlib=`print_prefix zlib.h` \
			--without-tcltk \
			CURL_CONFIG=`print_binary_path curl-config` \
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
	openssh)
		[ -x ${DESTDIR}${prefix}/bin/ssh -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${openssh_bld_dir}/Makefile ] ||
			(cd ${openssh_bld_dir}
			${openssh_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
				--with-zlib=`print_prefix zlib.h` --with-privsep-path=${prefix}/var/empty) || return
		make -C ${openssh_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${openssh_bld_dir} -j ${jobs} -k tests || return
		make -C ${openssh_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	lzip)
		[ -x ${DESTDIR}${prefix}/bin/lzip -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${lzip_bld_dir}/Makefile ] ||
			(cd ${lzip_bld_dir}
			sed -i -e "
				/^INSTALL_PROGRAM\>/{
					s!\( --strip-program=[[:graph:]]\+\)\?\$! --strip-program=${host:+${host}-}strip!
				}" ${lzip_src_dir}/Makefile.in || return
			${lzip_src_dir}/configure --prefix=${prefix} CXX="${CXX:-${host:+${host}-}g++}") || return
		make -C ${lzip_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${lzip_bld_dir} -j ${jobs} -k check || return
		make -C ${lzip_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	ed)
		[ -x ${DESTDIR}${prefix}/bin/ed -a "${force_install}" != yes ] && return
		which lzip > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} lzip || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ed_bld_dir}/Makefile ] ||
			(cd ${ed_bld_dir}
			sed -i -e "
				/^INSTALL_PROGRAM\>/{
					s!\( --strip-program=[[:graph:]]\+\)\?\$! --strip-program=${host:+${host}-}strip!
				}" ${ed_src_dir}/Makefile.in || return
			${ed_src_dir}/configure --prefix=${prefix} CC="${CC:-${host:+${host}-}gcc}") || return
		make -C ${ed_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${ed_bld_dir} -j ${jobs} -k check || return
		make -C ${ed_bld_dir} -j 1 DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	bc)
		[ -x ${DESTDIR}${prefix}/bin/bc -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path readline.h readline > /dev/null || ${0} ${cmdopt} readline || return
		which ed > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} ed || return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
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
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		print_header_path zstd.h > /dev/null || ${0} ${cmdopt} zstd || return
		print_header_path popt.h > /dev/null || ${0} ${cmdopt} popt || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${rsync_bld_dir}/Makefile ] ||
			(cd ${rsync_bld_dir}
			sed -i -e "
				/^INSTALLCMD\>/{
					s!\( --strip-program=[[:graph:]]\+\)\?\$! --strip-program=${host:+${host}-}strip!
				}" ${rsync_src_dir}/Makefile.in || return
			${rsync_src_dir}/configure --prefix=${prefix} --host=${host} --without-included-zlib \
				--disable-simd --disable-xxhash --disable-lz4 \
				CPPFLAGS="${CPPFLAGS} `I zlib.h popt.h`" \
				LDFLAGS="${LDFLAGS} `L z popt`" \
				) || return
		make -C ${rsync_bld_dir} -j ${jobs} || return
		make -C ${rsync_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	dtc)
		[ -x ${DESTDIR}${prefix}/bin/dtc -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${dtc_bld_dir}/Makefile ] || cp -Tvr ${dtc_src_dir} ${dtc_bld_dir} || return
		(export EXTRA_CFLAGS="${CFLAGS} -Wno-error"; unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1 NO_PYTHON=1 CC="${CC:-${host:+${host}-}gcc}") || return # XXX work around for parallel make
		(export EXTRA_CFLAGS="${CFLAGS} -Wno-error"; unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1 NO_PYTHON=1 PREFIX=${DESTDIR}${prefix} install) || return # XXX work around for parallel make
		[ -z "${strip}" ] && return
		for b in convert-dtsv0 dtc fdtdump fdtget fdtoverlay fdtput; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libfdt-`print_version dtc`.0.so || return
		;;
	kmod)
		[ -x ${DESTDIR}${prefix}/bin/kmod -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${kmod_bld_dir}/Makefile ] ||
			(cd ${kmod_bld_dir}
			${kmod_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
				--with-xz --with-zlib --with-openssl \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir liblzma.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				) || return
		make -C ${kmod_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${kmod_bld_dir} -j ${jobs} -k check || return
		make -C ${kmod_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for f in depmod insmod lsmod modinfo modprobe rmmod; do
			ln -fsv kmod ${DESTDIR}${prefix}/bin/${f} || return
		done
		truncate_path_in_elf ${DESTDIR}${prefix}/bin/kmod ${DESTDIR} ${prefix}/lib || return
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libkmod.so ${DESTDIR} ${prefix}/lib || return
		;;
	u-boot)
		[ -x ${DESTDIR}${prefix}/bin/mkimage -a "${force_install}" != yes ] && return
		print_header_path ssl.h openssl > /dev/null || ${0} ${cmdopt} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${u_boot_bld_dir}/Makefile ] || cp -Tvr ${u_boot_src_dir} ${u_boot_bld_dir} || return
		generate_gcc_wrapper ${u_boot_bld_dir} || return
		[ -f ${u_boot_bld_dir}/.config ] ||
			make -C ${u_boot_bld_dir} -j ${jobs} V=1 sandbox_defconfig || return
		sed -i -e 's/^	\$(Q)\$(MAKE) \$(build)=\$@$/& HOSTCC=$(MYCC)/' ${u_boot_bld_dir}/Makefile || return
		sed -i -e '/^\<hostc_flags\>/s! \$(__hostc_flags)$!& '`idirafter openssl/evp.h`'!' ${u_boot_bld_dir}/scripts/Makefile.host || return
		make -C ${u_boot_bld_dir} -j ${jobs} V=1 NO_SDL=1 MYCC=${u_boot_bld_dir}/${host:+${host}-}gcc HOSTLDFLAGS=`L ssl` tools || return
		mkdir -pv ${DESTDIR}${prefix}/bin || return
		find ${u_boot_bld_dir}/tools -maxdepth 1 -type f -perm /100 -exec install -vt ${DESTDIR}${prefix}/bin {} + || return
		[ -z "${strip}" ] && return
		for b in asn1_compiler dumpimage fdtgrep fit_check_sign fit_info gen_eth_addr gen_ethaddr_crc ifwitool img2srec \
			mkenvimage mkimage ncb proftool spl_size_limit; do
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	tar)
		[ -x ${DESTDIR}${prefix}/bin/tar -a "${force_install}" != yes ] && return
		print_binary_path xz > /dev/null || ${0} ${cmdopt} xz || return
		print_binary_path lzip > /dev/null || ${0} ${cmdopt} lzip || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${tar_bld_dir}/Makefile ] ||
			(cd ${tar_bld_dir}
			FORCE_UNSAFE_CONFIGURE=1 ${tar_src_dir}/configure --prefix=${prefix} \
				--build=${build} --host=${host} --disable-silent-rules) || return
		make -C ${tar_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tar_bld_dir} -j ${jobs} -k check || return
		make -C ${tar_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	cpio)
		[ -x ${DESTDIR}${prefix}/bin/cpio -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${cpio_bld_dir}/Makefile ] ||
			(cd ${cpio_bld_dir}
			${cpio_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
				CFLAGS="${CFLAGS} -fcommon") || return
		make -C ${cpio_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${cpio_bld_dir} -j ${jobs} -k check || return
		make -C ${cpio_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	e2fsprogs)
		[ -x ${DESTDIR}${prefix}/sbin/mkfs.ext2 -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${e2fsprogs_bld_dir}/Makefile ] ||
			(cd ${e2fsprogs_bld_dir}
			${e2fsprogs_src_dir}/configure --prefix=${prefix} --host=${host} --enable-verbose-makecmds --enable-elf-shlibs) || return
		make -C ${e2fsprogs_bld_dir} -j 1 || return # -j '1' is for workaround
		[ "${enable_check}" != yes ] ||
			make -C ${e2fsprogs_bld_dir} -j ${jobs} -k check || return
		make -C ${e2fsprogs_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		make -C ${e2fsprogs_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install-libs || return
		[ -z "${strip}" ] && return
		for b in chattr lsattr; do
			[ -f ${DESTDIR}${prefix}/bin/${b} ] || continue
			${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		;;
	v4l-utils)
		[ -x ${DESTDIR}${prefix}/bin/v4l2-ctl -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${v4l_utils_bld_dir}/Makefile ] ||
			(cd ${v4l_utils_bld_dir}
			${v4l_utils_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--disable-rpath --with-udevdir=${prefix}/lib/udev \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR= \
				) || return
		make -C ${v4l_utils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${v4l_utils_bld_dir} -j ${jobs} -k check || return
		make -C ${v4l_utils_bld_dir} -j 1 -k DESTDIR=${DESTDIR} install${strip:+-${strip}} || true # '-k': workaround for 'install-data-local' fails in utils/keytable/bpf_protocols
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
				LDFLAGS="${LDFLAGS} `L tinfo`") || return
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
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir openssl.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
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
				CPPFLAGS="${CPPFLAGS} `I curses.h event.h`" \
				LDFLAGS="${LDFLAGS} `L tinfo event`" \
				LIBTINFO_LIBS=-ltinfo) || return
		make -C ${tmux_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tmux_bld_dir} -j ${jobs} -k check || return
		make -C ${tmux_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/tmux || return
		;;
	zsh)
		[ -x ${DESTDIR}${prefix}/bin/zsh -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${zsh_bld_dir}/configure ] || cp -Tvr ${zsh_src_dir} ${zsh_bld_dir} || return
		[ -f ${zsh_bld_dir}/Makefile ] ||
			(cd ${zsh_bld_dir}
			./configure --prefix=${prefix} --build=${build} --host=${host} \
				--enable-multibyte --enable-unicode9 --with-tcsetpgrp \
				CPPFLAGS="${CPPFLAGS} `I curses.h`" \
				LDFLAGS="${LDFLAGS} `L curses`") || return
		make -C ${zsh_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${zsh_bld_dir} -j ${jobs} -k check || return
		make -C ${zsh_bld_dir} -j ${jobs} -k DESTDIR=${DESTDIR} install || true # XXX work around. if 'man' and 'nroff' are not found, 'make install' fails.
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/zsh || return
		;;
	bash)
		[ -x ${DESTDIR}${prefix}/bin/bash -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${bash_bld_dir}/Makefile ] ||
			(cd ${bash_bld_dir}
			${bash_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-rpath) || return
		make -C ${bash_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${bash_bld_dir} -j ${jobs} -k check || return
		make -C ${bash_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		ln -fsv bash ${DESTDIR}${prefix}/bin/sh || return
		;;
	tcsh)
		[ -x ${DESTDIR}${prefix}/bin/tcsh -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${tcsh_bld_dir}/Makefile ] ||
			(cd ${tcsh_bld_dir}
			${tcsh_src_dir}/configure --prefix=${prefix} --host=${host} --disable-rpath) || return
		make -C ${tcsh_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${tcsh_bld_dir} -j ${jobs} -k check || return
		make -C ${tcsh_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		ln -fsv tcsh ${DESTDIR}/${prefix}/bin/csh || return
		;;
	vim)
		[ -x ${DESTDIR}${prefix}/bin/vim -a "${force_install}" != yes ] && return
		which msgfmt > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} gettext || return
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
				LDFLAGS="${LDFLAGS} `L tinfo`" \
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
	emacs)
		[ -x ${DESTDIR}${prefix}/bin/emacs -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		print_header_path xmlversion.h libxml2/libxml > /dev/null || ${0} ${cmdopt} libxml2 || return
		fetch ${1} || return
		unpack ${1} || return
		sed -i -e '
			/^make-docfile\${EXEEXT}:/{
				n
				s/\$(CC)/gcc/
				s/\${ALL_CFLAGS}/${BASE_CFLAGS} ${PROFILING_CFLAGS}/
				s!\$(LOADLIBES)!$(top_srcdir)/lib/binary-io.c $(top_srcdir)/lib/c-ctype.c!
			}
			/^make-fingerprint\${EXEEXT}:/{
				n
				s/\$(CC)/gcc/
				s/\${ALL_CFLAGS}/${BASE_CFLAGS} ${PROFILING_CFLAGS}/
				s!\$(LOADLIBES)!$(top_srcdir)/lib/fingerprint.c $(top_srcdir)/lib/getopt.c $(top_srcdir)/lib/sha256.c!
			}' ${emacs_src_dir}/lib-src/Makefile.in || return
		[ -f ${emacs_bld_dir}/Makefile ] ||
			(cd ${emacs_bld_dir}
			CPPFLAGS="${CPPFLAGS} `I ncurses.h`" LDFLAGS="${LDFLAGS} `L ncurses` `l z lzma`" \
				${emacs_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
				--without-sound --with-dumping=none --without-dbus --without-gnutls --with-modules --without-x \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir libxml-2.0.pc` \
				PKG_CONFIG_SYSROOT_DIR=`print_pkg_config_sysroot libxml-2.0.pc` \
				) || return
		make -C ${emacs_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${emacs_bld_dir} -j ${jobs} -k check || return
		make -C ${emacs_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	nano)
		[ -x ${DESTDIR}${prefix}/bin/nano -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${nano_bld_dir}/Makefile ] ||
			(cd ${nano_bld_dir}
			${nano_src_dir}/configure --prefix=${prefix} --host=${host} --disable-rpath \
				CFLAGS="${CFLAGS} `I ncurses.h`" \
				LDFLAGS="${LDFLAGS} `L ncurses`" \
			) || return
		make -C ${nano_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${nano_bld_dir} -j ${jobs} -k check || return
		make -C ${nano_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
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
				PKG_CONFIG_PATH= \
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
				--with-ncurses=`print_prefix curses.h` CPPFLAGS="${CPPFLAGS} `I curses.h`" \
				CFLAGS="${CFLAGS} -fcommon" \
				ac_cv_posix1_2008_realpath=yes) || return
		make -C ${global_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${global_bld_dir} -j ${jobs} -k check || return
		make -C ${global_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	findutils)
		[ -x ${DESTDIR}${prefix}/bin/find -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${findutils_bld_dir}/Makefile ] ||
			(cd ${findutils_bld_dir}
			${findutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules --enable-threads) || return
		make -C ${findutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${findutils_bld_dir} -j ${jobs} -k check || return
		make -C ${findutils_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	help2man)
		[ -x ${DESTDIR}${prefix}/bin/help2man -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${help2man_bld_dir}/Makefile ] ||
			(cd ${help2man_bld_dir}
			${help2man_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
		make -C ${help2man_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${help2man_bld_dir} -j ${jobs} -k check || return
		make -C ${help2man_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	coreutils)
		[ -x ${DESTDIR}${prefix}/bin/cat -a "${force_install}" != yes ] && return
		print_header_path gmp.h > /dev/null || ${0} ${cmdopt} gmp || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${coreutils_bld_dir}/Makefile ] ||
			(cd ${coreutils_bld_dir}
			FORCE_UNSAFE_CONFIGURE=1 ${coreutils_src_dir}/configure --prefix=${prefix} \
				--build=${build} --host=${host} --disable-silent-rules --enable-threads) || return
		[ ${build} = ${host} ] || sed -i -e '/^run_help2man\>/s!help2man$!& --no-discard-stderr!' ${coreutils_bld_dir}/Makefile || return
		make -C ${coreutils_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${coreutils_bld_dir} -j ${jobs} -k check || return
		make -C ${coreutils_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	file)
		[ -x ${DESTDIR}${prefix}/bin/file -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} --target ${build} file || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${file_bld_dir}/Makefile ] ||
			(cd ${file_bld_dir}
			${file_src_dir}/configure --prefix=${prefix} --host=${host} --enable-static --disable-silent-rules \
				CFLAGS="${CFLAGS} `I zlib.h bzlib.h lzma.h`" \
				LDFLAGS="${LDFLAGS} `L z bz2 lzma`" \
				) || return
		make -C ${file_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${file_bld_dir} -j ${jobs} check || return
		make -C ${file_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		truncate_path_in_elf ${DESTDIR}${prefix}/bin/file ${DESTDIR} ${prefix}/lib || return
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libmagic.so ${DESTDIR} ${prefix}/lib || return
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
			GOROOT_FINAL=${prefix}/go GOARCH=`print_goarch ${host}` GOOS=linux bash -x ${go_src_dir}/src/make.bash -v) || return
		rm -v ${DESTDIR}${prefix}/go/bin/go || return
		cp -Tfvr ${go_src_dir} ${DESTDIR}${prefix}/go || return
		;;
	cmake)
		[ -x ${DESTDIR}${prefix}/bin/cmake -a "${force_install}" != yes ] && return
		print_header_path curl.h curl > /dev/null || ${0} ${cmdopt} curl || return
		print_header_path expat.h > /dev/null || ${0} ${cmdopt} expat || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path bzlib.h > /dev/null || ${0} ${cmdopt} bzip2 || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		[ ${build} = ${host} ] || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gcc_wrapper ${cmake_bld_dir} || return
		generate_gxx_wrapper ${cmake_bld_dir} || return
		[ -f ${cmake_bld_dir}/Makefile ] ||
			(cd ${cmake_bld_dir}
			CC= CXX= ${cmake_src_dir}/bootstrap --verbose --prefix=${DESTDIR}${prefix} --parallel=${jobs} \
				--system-curl --system-expat --system-zlib --system-bzip2 --system-liblzma -- \
				-DCMAKE_C_COMPILER=${cmake_bld_dir}/${host:+${host}-}gcc \
				-DCMAKE_CXX_COMPILER=${cmake_bld_dir}/${host:+${host}-}g++ \
				-DCMAKE_CXX_FLAGS="${CXXFLAGS} `l ssl crypto zstd`" \
				-DCURL_INCLUDE_DIR=`print_header_dir curl.h curl` \
				-DCURL_LIBRARY_RELEASE=`print_library_path libcurl.so` \
				-DEXPAT_INCLUDE_DIR=`print_header_dir expat.h` \
				-DEXPAT_LIBRARY=`print_library_path libexpat.so` \
				-DZLIB_ROOT=`print_prefix zlib.h` \
				-DBZIP2_INCLUDE_DIR=`print_header_dir bzlib.h` \
				-DBZIP2_LIBRARIES=`print_library_path libbz2.so` \
				-DLIBLZMA_INCLUDE_DIR=`print_header_dir lzma.h` \
				-DLIBLZMA_LIBRARY=`print_library_path liblzma.so`) || return
		make -C ${cmake_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${cmake_bld_dir} -j ${jobs} -k test || return
		[ ${build} = ${host} ] || sed -i -e 's/\<bin\/cmake\>/cmake/' ${cmake_bld_dir}/Makefile || return
		make -C ${cmake_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
		for b in cmake cpack ctest; do
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR}${prefix}/lib/ libz.so || return
		done
		;;
	ninja)
		[ -x ${DESTDIR}${prefix}/bin/ninja -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gxx_wrapper ${ninja_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${ninja_src_dir} -B ${ninja_bld_dir} \
			-DCMAKE_CXX_COMPILER=${ninja_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} \
			-DCMAKE_INSTALL_PREFIX=${prefix} || return
		cmake --build ${ninja_bld_dir} -v -j ${jobs} || return
		install -D ${strip:+-s --strip-program=${host:+${host}-}strip} -v -t ${DESTDIR}${prefix}/bin ${ninja_bld_dir}/ninja || return
		;;
	meson)
		[ -x ${DESTDIR}${prefix}/bin/meson -a "${force_install}" != yes ] && return
		print_binary_path python3 > /dev/null || ${0} ${cmdopt} Python || return
		print_binary_path ninja > /dev/null || ${0} ${cmdopt} ninja || return
		which python3 > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} Python || return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${meson_src_dir}
		python3 ${meson_src_dir}/setup.py install --prefix ${DESTDIR}${prefix}) || return
		sed -i -e '1s%^.\+$%\#!'${prefix}/bin/python3'%' ${DESTDIR}${prefix}/bin/meson || return
		;;
	libxml2)
		[ -d ${DESTDIR}${prefix}/include/libxml2 -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path lzma.h > /dev/null || ${0} ${cmdopt} xz || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libxml2_bld_dir}/Makefile ] ||
			(cd ${libxml2_bld_dir}
			${libxml2_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
				--without-python --disable-silent-rules \
				CFLAGS="${CFLAGS} `I zlib.h`" \
				LDFLAGS="${LDFLAGS} `L z`" \
				PKG_CONFIG_PATH= \
				PKG_CONFIG_LIBDIR=`print_library_dir zlib.pc` \
				PKG_CONFIG_SYSROOT_DIR=${DESTDIR} \
				) || return
		make -C ${libxml2_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libxml2_bld_dir} -j ${jobs} -k check || return
		make -C ${libxml2_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		for b in xmlcatalog xmllint; do
			truncate_path_in_elf ${DESTDIR}${prefix}/bin/${b} ${DESTDIR} ${prefix}/lib || return
		done
		truncate_path_in_elf ${DESTDIR}${prefix}/lib/libxml2.so ${DESTDIR} ${prefix}/lib || return
		;;
	llvm)
		[ -d ${DESTDIR}${prefix}/include/llvm -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		[ ${build} = ${host} ] || which llvm-tblgen > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gcc_wrapper ${llvm_bld_dir} || return
		generate_gxx_wrapper ${llvm_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${llvm_src_dir} -B ${llvm_bld_dir} \
			-DCMAKE_C_COMPILER=${llvm_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${llvm_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_CROSSCOMPILING=True \
			-DLLVM_ENABLE_RTTI=ON \
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
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gcc_wrapper ${compiler_rt_bld_dir} || return
		generate_gxx_wrapper ${compiler_rt_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${compiler_rt_src_dir} -B ${compiler_rt_bld_dir} \
			-DCMAKE_C_COMPILER=${compiler_rt_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${compiler_rt_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DCOMPILER_RT_USE_BUILTINS_LIBRARY=ON -DSANITIZER_CXX_ABI=libc++ \
			-DCMAKE_CXX_COMPILER_ID=Clang || return
		cmake --build ${compiler_rt_bld_dir} -v -j ${jobs} || return
		cmake --install ${compiler_rt_bld_dir} -v ${strip:+--${strip}} || return
# FIXME
#		mkdir -pv ${DESTDIR}${prefix}/lib/clang/`print_target_llvm_version`/lib || return
#		cp -Tfvr ${DESTDIR}${prefix}/lib/linux ${DESTDIR}${prefix}/lib/clang/`print_target_llvm_version`/lib/linux || return # XXX: workaround for mismatch between clang search path and compiler-rt installation path.
		;;
	libunwind)
		[ -e ${DESTDIR}${prefix}/lib/libunwind.so -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		init llvm || return
		fetch llvm || return
		unpack llvm || return
		init libcxx || return
		fetch libcxx || return
		unpack libcxx || return
		fetch ${1} || return
		unpack ${1} || return
		ln -Tfsv ${libcxx_src_dir} ${libunwind_src_dir}/../libcxx || return
		generate_gcc_wrapper ${libunwind_bld_dir} || return
		generate_gxx_wrapper ${libunwind_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libunwind_src_dir} -B ${libunwind_bld_dir} \
			-DCMAKE_C_COMPILER=${libunwind_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${libunwind_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DLIBUNWIND_USE_COMPILER_RT=ON \
			-DLLVM_PATH=${llvm_src_dir} || return
		cmake --build ${libunwind_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${libunwind_bld_dir} -v -j ${jobs} --target check-unwind || return
		cmake --install ${libunwind_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libcxxabi)
		[ -e ${DESTDIR}${prefix}/lib/libc++abi.so -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_library_path libunwind.so > /dev/null || ${0} ${cmdopt} libunwindnongnu || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		init llvm || return
		fetch llvm || return
		unpack llvm || return
		init libcxx || return
		fetch libcxx || return
		unpack libcxx || return
		fetch ${1} || return
		unpack ${1} || return
		ln -Tfsv ${libcxx_src_dir} ${libcxxabi_src_dir}/../libcxx || return
		generate_gcc_wrapper ${libcxxabi_bld_dir} || return
		generate_gxx_wrapper ${libcxxabi_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libcxxabi_src_dir} -B ${libcxxabi_bld_dir} \
			-DCMAKE_C_COMPILER=${libcxxabi_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${libcxxabi_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_CXX_FLAGS=`L unwind` \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' \
			-DLIBCXXABI_USE_LLVM_UNWINDER=ON \
			-DLLVM_PATH=${llvm_src_dir} || return
		cmake --build ${libcxxabi_bld_dir} -v -j ${jobs} || return
		cmake --install ${libcxxabi_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libcxx)
		[ -e ${DESTDIR}${prefix}/lib/libc++.so -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_library_path libc++abi.so > /dev/null || ${0} ${cmdopt} libcxxabi || return
		init llvm || return
		fetch llvm || return
		unpack llvm || return
		init libcxxabi || return
		fetch libcxxabi || return
		unpack libcxxabi || return
		fetch ${1} || return
		unpack ${1} || return
		ln -Tfsv ${llvm_src_dir} ${libcxx_src_dir}/../llvm || return
		ln -Tfsv ${libcxxabi_src_dir} ${libcxx_src_dir}/../libcxxabi || return
		generate_gcc_wrapper ${libcxx_bld_dir} || return
		generate_gxx_wrapper ${libcxx_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${libcxx_src_dir} -B ${libcxx_bld_dir} \
			-DCMAKE_C_COMPILER=${libcxx_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${libcxx_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_CXX_FLAGS=`L unwind` \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_INSTALL_RPATH=';' -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_CXX_ABI_INCLUDE_PATHS=${libcxx_src_dir}/../libcxxabi/include \
			-DLIBCXXABI_USE_LLVM_UNWINDER=ON || return
		cmake --build ${libcxx_bld_dir} -v -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			cmake --build ${libcxx_bld_dir} -v -j ${jobs} --target check-libcxx || return
		cmake --install ${libcxx_bld_dir} -v ${strip:+--${strip}} || return
		;;
	clang)
		[ -x ${DESTDIR}${prefix}/bin/clang -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		print_header_path allocator_interface.h sanitizer > /dev/null || ${0} ${cmdopt} compiler-rt || return
		print_library_path libunwind.so > /dev/null || ${0} ${cmdopt} libunwindnongnu || return
		print_library_path libc++abi.so > /dev/null || ${0} ${cmdopt} libcxxabi || return
		print_header_path iostream c++/v1 > /dev/null || ${0} ${cmdopt} libcxx || return
		print_binary_path lld > /dev/null || ${0} ${cmdopt} lld || return
		[ ${build} = ${host} ] || which clang-tblgen > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		init clang-tools-extra || return
		fetch clang-tools-extra || return
		[ -d ${clang_src_dir}/tools/extra ] ||
			(unpack clang-tools-extra &&
			mv -v ${clang_tools_extra_src_dir} ${clang_src_dir}/tools/extra) || return
		ln -Tfsv ${clang_src_dir}/tools/extra ${clang_src_dir}/../clang-tools-extra || return
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
		generate_gcc_wrapper ${clang_bld_dir} || return
		generate_gxx_wrapper ${clang_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${clang_src_dir} -B ${clang_bld_dir} \
			-DCMAKE_C_COMPILER=${clang_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${clang_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_CXX_FLAGS="`I llvm/Config/llvm-config.h` `L LLVM`" \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_CROSSCOMPILING=True \
			-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
			-DLLVM_TOOLS_BINARY_DIR=`which llvm-tblgen | xargs dirname` \
			-DLLVM_DEFAULT_TARGET_TRIPLE=${host} -DLLVM_TARGET_ARCH=`echo ${host} | cut -d- -f1` \
			-DLLVM_ENABLE_LIBXML2=OFF \
			`[ ${build} != ${host} ] && { echo -n -DCLANG_TABLEGEN=; which clang-tblgen;}` \
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
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		init llvm || return
		fetch llvm || return
		unpack llvm || return
		init libunwind || return
		fetch libunwind || return
		unpack libunwind || return
		fetch ${1} || return
		unpack ${1} || return
		ln -Tfsv ${libunwind_src_dir} ${llvm_src_dir}/../libunwind || return
		generate_llvm_config_dummy ${lld_bld_dir} || return
		generate_gcc_wrapper ${lld_bld_dir} || return
		generate_gxx_wrapper ${lld_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${lld_src_dir} -B ${lld_bld_dir} \
			-DCMAKE_C_COMPILER=${lld_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${lld_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DLLVM_CONFIG_PATH=${lld_bld_dir}/llvm-config \
			-DLLVM_TABLEGEN_EXE=`which llvm-tblgen` \
			-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON || return
		cmake --build ${lld_bld_dir} -v -j ${jobs} || return
		cmake --install ${lld_bld_dir} -v ${strip:+--${strip}} || return
		;;
	libedit)
		[ -f ${DESTDIR}${prefix}/include/histedit.h -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${libedit_bld_dir}/Makefile ] ||
			(cd ${libedit_bld_dir}
			${libedit_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
				--disable-silent-rules CFLAGS="${CFLAGS} `I curses.h`" \
				LDFLAGS="${LDFLAGS} `L ncurses`") || return
		make -C ${libedit_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${libedit_bld_dir} -j ${jobs} -k check || return
		make -C ${libedit_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	swig)
		[ -x ${DESTDIR}${prefix}/bin/swig -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} ${cmdopt} zlib || return
		print_header_path pcre.h > /dev/null || ${0} ${cmdopt} pcre || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${swig_bld_dir}/Makefile ] ||
			(cd ${swig_bld_dir}
			${swig_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-cpp11-testing \
				CFLAGS="${CFLAGS} `I pcre.h` `L z`" \
				LDFLAGS="${LDFLAGS} `L pcre`") || return
		make -C ${swig_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${swig_bld_dir} -j ${jobs} -k check || return
		make -C ${swig_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/swig ${DESTDIR}${prefix}/bin/ccache-swig || return
		;;
	lldb)
		[ -x ${DESTDIR}${prefix}/bin/lldb -a "${force_install}" != yes ] && return
		which cmake > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} cmake || return
		print_header_path curses.h > /dev/null || ${0} ${cmdopt} ncurses || return
		print_header_path histedit.h > /dev/null || ${0} ${cmdopt} libedit || return
		print_header_path xmlversion.h libxml2/libxml > /dev/null || ${0} ${cmdopt} libxml2 || return
		print_header_path llvm-config.h llvm/Config > /dev/null || ${0} ${cmdopt} llvm || return
		print_header_path Python.h > /dev/null || ${0} ${cmdopt} Python || return
		print_header_path Version.h clang/Basic > /dev/null || ${0} ${cmdopt} clang || return
		which python3 > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} Python || return
		which swig > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} swig || return
		[ ${build} = ${host} ] || which lldb-tblgen > /dev/null || ${0} ${cmdopt} --host ${build} --target ${build} ${1} || return
		fetch ${1} || return
		unpack ${1} || return
		generate_gcc_wrapper ${lldb_bld_dir} || return
		generate_gxx_wrapper ${lldb_bld_dir} || return
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${lldb_src_dir} -B ${lldb_bld_dir} \
			-DCMAKE_C_COMPILER=${lldb_bld_dir}/${host:+${host}-}gcc \
			-DCMAKE_CXX_COMPILER=${lldb_bld_dir}/${host:+${host}-}g++ \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DCMAKE_CROSSCOMPILING=True \
			-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
			-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON \
			-DCMAKE_C_FLAGS="${CFLAGS} `I clang/Basic/Version.h`" \
			-DCMAKE_CXX_FLAGS="${CXXFLAGS} `I curses.h histedit.h` `l edit python$(print_target_python_version)$(print_target_python_abi) ncurses panel xml2 lzma z`" \
			`[ ${build} != ${host} ] && { echo -n -DLLVM_TABLEGEN=; which llvm-tblgen;}` \
			`[ ${build} != ${host} ] && { echo -n -DLLDB_TABLEGEN_EXE=; which lldb-tblgen;}` \
			-DLibEdit_INCLUDE_DIRS=`print_header_dir histedit.h` \
			-DLibEdit_LIBRARIES=`print_library_path libedit.so` \
			-DCURSES_INCLUDE_DIRS=`print_header_dir curses.h` \
			-DCURSES_LIBRARIES=`print_library_path libcurses.so` \
			-DPANEL_LIBRARIES=`print_library_path libpanel.so` \
			-DPYTHON_INCLUDE_DIRS=`print_header_dir Python.h` \
			-DPYTHON_LIBRARIES=`print_library_path libpython$(print_target_python_version).so` \
			-DPYTHON_EXECUTABLE=`which python3` \
			-DSWIG_EXECUTABLE=`which swig` \
			-DLIBXML2_INCLUDE_DIR=`print_header_dir xmlversion.h libxml2/libxml`/libxml2 \
			-DLIBXML2_LIBRARIES="`print_library_path libxml2.so`;`print_library_path libz.so`" \
			|| return
		SWIG_LIB=`print_swig_lib_dir` cmake --build ${lldb_bld_dir} -v -j ${jobs} || return
		cmake --install ${lldb_bld_dir} -v ${strip:+--${strip}} || return
		[ ! -f ${lldb_bld_dir}/bin/lldb-tblgen ] && return
		install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${lldb_bld_dir}/bin/lldb-tblgen || return
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

update_ccache_wrapper()
{
	! which ccache > /dev/null && return

	while getopts f arg; do
		case ${arg} in
		f) force_update=yes;;
		esac
	done
	shift `expr ${OPTIND} - 1`

	mkdir -pv ${DESTDIR}${prefix}/lib/ccache || return
	find `echo ${PATH} | tr : ' '` -maxdepth 1 ! -type d -executable -regextype posix-extended \( \
			-regex '^/.+/(([^-]+-){2,4})?g(cc|\+\+)' \
			-o -name clang -o -name clang++ \
		\) -exec basename \{\} \; 2> /dev/null | sort | uniq | \
			sed -e s"%^.\\+\$%[ \"${force_update}\" != yes -a -f ${DESTDIR}${prefix}/lib/ccache/& ] || ln -fsv ../../bin/ccache ${DESTDIR}${prefix}/lib/ccache/&%;s/\$/ || return/" | sh || return
	unset force_update
}

generate_command_wrapper()
{
	cat << EOF > ${1}/${2} || return
#!/bin/sh
${3}
EOF
	chmod -v a+x ${1}/${2} || return
}

generate_gcc_wrapper()
{
	generate_command_wrapper ${1} ${host:+${host}-}gcc \
		"`{
			which ${host:+${host}-}gcc
			echo ${CC:-${host:+${host}-}gcc} | grep -oPe '(?<= ).+'
			echo \\"\\$@\\"
		} | tr '\n' ' '`" || return
}

generate_gxx_wrapper()
{
	generate_command_wrapper ${1} ${host:+${host}-}g++ \
		"`{
			which ${host:+${host}-}g++
			echo ${CXX:-${host:+${host}-}g++} | grep -oPe '(?<= ).+'
			echo \\"\\$@\\"
		} | tr '\n' ' '`" || return
}

generate_toolchain_wrapper()
{
	if [ $# -eq 1 ]; then
		generate_gcc_wrapper ${1} || return
		generate_gxx_wrapper ${1} || return
		for t in ar as nm objcopy objdump ranlib strip cpp ld; do
			generate_toolchain_wrapper ${1} ${t} || return
		done
		return
	fi
	generate_command_wrapper ${1} ${host:+${host}-}${2} \
		"`{
			which ${host:+${host}-}${2}
			eval echo \\\${$(echo ${2} | tr a-z A-Z):-\\\${host:+\\\${host}-}${2}} | grep -oPe '(?<= ).+'
			echo \\"\\$@\\"
		} | tr '\n' ' '`" || return
}

generate_llvm_config_dummy()
{
	generate_command_wrapper ${1} llvm-config \
		"\
while [ \$# -gt 0 ]; do
	case \$1 in
	--cmakedir)    echo `print_library_dir LLVMConfig.cmake`;;
	--includedir)  echo `print_header_dir llvm-config.h`;;
	--libdir)      echo `print_library_dir libLLVM.so`;;
	--libs)        echo -lLLVM-`print_version llvm 1`;;
	--obj-root)    echo `print_library_dir libLLVM.so`;;
	--src-root)    echo ${llvm_src_dir};;
	--system-libs) ;;
	esac
	shift
done
" || return
}

generate_python_config_dummy()
{
	generate_command_wrapper ${1} python-config \
		"\
while [ \$# -gt 0 ]; do
	case \$1 in
	--prefix)      echo ${prefix};;
	--exec-prefix) echo ${prefix};;
	--includes)    echo `I Python.h`;;
	--libs)        echo -lpython$(print_target_python_version)$(print_target_python_abi) -lpthread -ldl -lutil -lm;;
	--cflags)      echo `I Python.h`;;
	--ldflags)     echo -lpython$(print_target_python_version)$(print_target_python_abi) -lpthread -ldl -lutil -lm;;
	esac
	shift
done
" || return
}

truncate_path_in_elf()
{
	seek=`grep -aboe ${2}${3} ${1} 2> /dev/null | cut -d: -f1 | head -n 1`
	[ -z "${seek}" ] && return
	dirname_count=`echo -n ${2} | wc -c`
	dd bs=c count=`echo ${3} | wc -c` if=${1} of=${1} conv=notrunc seek=${seek} skip=`expr ${seek} + ${dirname_count}` || return
}

remove_rpath_option()
{
	eval d=\${${1}_bld_dir}
	[ ! -f ${d}/libtool ] ||
		{ sed -i -e 's/^\(\<runpath_var\>=\).\+/\1dummy_runpath/' ${d}/libtool && return;} || return

	eval d=\${${1}_src_dir}
	for f in `grep -le '\<rpath\>' -r ${d} --exclude=ltmain.sh --exclude=Makefile.in`; do
		sed -i -e 's/\(\$\(wl\|{wl}\)\)\?-\?-rpath[, ]\(\$\(wl\|{wl}\)\)\?\$\(libdir\|(libdir)\)//' ${f} || return
	done
	for f in `find ${d} -type f -name libtool.m4`; do
		sed -i -e 's/\(\<runpath_var\>=\).\+/\1dummy_runpath/' ${f} || return
	done
}

print_linux_arch()
{
	case ${1} in
	arm*)        echo arm;;
	aarch64*)    echo arm64;;
	i?86*)       echo x86;;
	microblaze*) echo microblaze;;
	nios2*)      echo nios2;;
	x86_64*)     echo x86;;
	*)           echo unknown; echo Unknown target architecture: ${1} >&2;;
	esac
}

print_goarch()
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
	extfile_name=`echo ${1} | sed -e 's/\(\.[-_.[:alnum:]]\+\)\?$/.ext&/;s!'^${DESTDIR}'!!;s!'^${prefix}'!${prefix}!'`
	cat << 'EOF' | sed -e '1,/^{$/{s%prefix_place_holder%'${prefix}'%;s%host_place_holder%'${host}'%;s%func_place_holder%'${func_name}'%};s!ext_place_holder!'${extfile_name}'!g;$s%func_place_holder%'${func_name}'%' > ${1} || return
prefix=$({ cd $(dirname ${BASH_SOURCE:-${(%):-%N}}); [ `pwd` = ${HOME} ] && echo prefix_place_holder || pwd;} | sed -e "s!^${DESTDIR}!!")
host=host_place_holder
func_place_holder()
{
	tmp_PATH=${PATH}
	for p in ${DESTDIR}${prefix}/bin ${DESTDIR}${prefix}/sbin ${DESTDIR}${prefix}/go/bin ${DESTDIR}${prefix}/lib/ccache; do
		[ -n "${DESTDIR}" -o -d ${p} ] || continue
		echo ${tmp_PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& tmp_PATH=${p}`echo ${tmp_PATH} | sed -e "
					s%\(^\|:\)${p}\(\$\|:\)%\1\2%g
					s/::/:/g
					s/^://
					s/:\$//
					s/^./:&/
				"` \
			|| tmp_PATH=${p}${tmp_PATH:+:${tmp_PATH}}
	done
	unset p

	tmp_LD_LIBRARY_PATH=${LD_LIBRARY_PATH}
	for p in ${DESTDIR}${prefix}/lib ${DESTDIR}${prefix}/lib64 ${prefix}/lib/${host} \
		`[ -d ${DESTDIR}${prefix}/${host} ] && find ${DESTDIR}${prefix}/${host} -mindepth 2 -maxdepth 2 -type d -name lib` \
		`[ -d ${DESTDIR}${prefix}/lib/gcc/${host} ] && find ${DESTDIR}${prefix}/lib/gcc/${host} -mindepth 1 -maxdepth 1 -type d -name '*.?.?' | sort -rn | head -n 1` \
		${DESTDIR}${prefix}/lib/`uname -m`-linux; do
		[ -n "${DESTDIR}" -o -d ${p} ] || continue
		echo ${tmp_LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& tmp_LD_LIBRARY_PATH=${p}`echo ${tmp_LD_LIBRARY_PATH} | sed -e "
					s%\(^\|:\)${p}\(\$\|:\)%\1\2%g
					s/::/:/g
					s/^://
					s/:\$//
					s/^./:&/
				"` \
			|| tmp_LD_LIBRARY_PATH=${p}${tmp_LD_LIBRARY_PATH:+:${tmp_LD_LIBRARY_PATH}}
	done
	unset p

	export PATH=${tmp_PATH} LD_LIBRARY_PATH=${tmp_LD_LIBRARY_PATH}
	unset tmp_PATH tmp_LD_LIBRARY_PATH

	echo ${MANPATH} | tr : '\n' | grep -qe ^${DESTDIR}${prefix}/share/man\$ \
		&& export MANPATH=${DESTDIR}${prefix}/share/man:`echo ${MANPATH} | sed -e '
				s%\(^\|:\)'${DESTDIR}${prefix}'/share/man\($\|:\)%\1\2%g
				s/::/:/g
				s/^://
			'` \
		|| export MANPATH=${DESTDIR}${prefix}/share/man:${MANPATH}

	[ "${TERM}" = linux ] && TERM=xterm-256color
	[ -z "${DESTDIR}" ] && export TERMINFO=${DESTDIR}${prefix}/share/terminfo

	[ -z "${DESTDIR}" -a -f ext_place_holder ] && . ext_place_holder

	return 0
}
func_place_holder
EOF
}

setup_pathconfig_for_build()
{
	orig_host=${host}
	orig_DESTDIR=${DESTDIR}

	host=${build}
	DESTDIR=`readlink -m ${build}`
	generate_pathconfig ${DESTDIR}${prefix}/pathconfig.sh || return
	. ${DESTDIR}${prefix}/pathconfig.sh || return

	host=${orig_host}
	DESTDIR=${orig_DESTDIR}
	unset orig_host orig_DESTDIR
}

set_compiler_as_env_vars()
{
	unset AR AS GDB NM OBJCOPY OBJDUMP RANLIB STRIP
	unset CC CXX CPP LD LDSHARED
	unset CFLAGS CXXFLAGS LDFLAGS
	unset CROSS_COMPILE CONFIGURE_FLAGS
	[ ${build} = ${host} ] && unset PKG_CONFIG_PATH

	[ ${build} = ${host} ] && return

	export CC="${host:+${host}-}gcc${SDKTARGETSYSROOT:+ --sysroot=${SDKTARGETSYSROOT}}"
	export CXX="${host:+${host}-}g++${SDKTARGETSYSROOT:+ --sysroot=${SDKTARGETSYSROOT}}"
	export CPP="${host:+${host}-}gcc -E${SDKTARGETSYSROOT:+ --sysroot=${SDKTARGETSYSROOT}}"
	export LD="${host:+${host}-}ld${SDKTARGETSYSROOT:+ --sysroot=${SDKTARGETSYSROOT}}"
	export LDSHARED="${host:+${host}-}ld${SDKTARGETSYSROOT:+ --sysroot=${SDKTARGETSYSROOT}}"
}

manipulate_libc()
{
	d=${DESTDIR}${prefix}`[ ${host} != ${target} ] && echo /${target}`/include
	mkdir -pv ${d} || return
	(cd `$([ ${host} = ${target} ] \
			&& echo ${CC:-${target:+${target}-}gcc} \
			|| echo ${target:+${target}-}gcc \
			) -print-sysroot`/usr/include
	find . -mindepth 1 \( -type f -o -type l \) | sed -e 's!^\./!!' | sort |
		case ${1} in
		copy)   sed -e "s!^.\+\$![ -e ${d}/& ] || install -DTv & ${d}/& || exit!";;
		remove) sed -e "s!^.\+\$!rm -fvr ${d}/& || exit!";;
		esac | sh || return
	) || return

	d=${DESTDIR}${prefix}`[ ${host} != ${target} ] && echo /${target}`/lib
	mkdir -pv ${d} || return

	(cd `$([ ${host} = ${target} ] \
			&& echo ${CC:-${target:+${target}-}gcc} \
			|| echo ${target:+${target}-}gcc \
			) -print-file-name=crti.o | xargs dirname`
	find . -mindepth 1 -name '*.o' | sed -e 's!^\./!!' | sort |
		case ${1} in
		copy)   sed -e "s!^.\+\$![ -e ${d}/& ] || install -DTv & ${d}/& || exit!";;
		remove) sed -e "s!^.\+\$!rm -fvr ${d}/& || exit!";;
		esac | sh || return
	) || return

	! echo ${target} | grep -qe linux ||
		for l in libc.so libc.so.6 libc_nonshared.a libm.so libm.so.6; do
			case ${1} in
			copy) [ -f ${d}/${l} ] || cp -fv `$([ ${host} = ${target} ] \
					&& echo ${CC:-${target:+${target}-}gcc} \
					|| echo ${target:+${target}-}gcc \
				) -print-file-name=${l}` ${d} || return;;
			remove) rm -fv ${d}/${l} || return;;
			esac
		done
	[ ! -f ${d}/libc.so ] ||
		sed -i -e '
			s! /usr/lib\(/libc_nonshared\.a\)! '${d}'\1!
			s! '${DESTDIR}'! !
		' ${d}/libc.so || return

	for l in libgcc.a libgcc.so libgcc_s.so; do
		(cd `$([ ${host} = ${target} ] \
				&& echo ${CC:-${target:+${target}-}gcc} \
				|| echo ${target:+${target}-}gcc \
				) -print-file-name=${l} | xargs dirname` || return
		[ -f ${l} ] || continue
		find . -mindepth 1 -maxdepth 1 -name "${l}*" | sed -e 's!^\./!!' | sort |
			case ${1} in
			copy)   sed -e "s!^.\+\$![ -e ${d}/& ] || install -DTv & ${d}/& || exit!";;
			remove) sed -e "s!^.\+\$!rm -fvr ${d}/& || exit!";;
			esac | sh || return
		) || return
	done
}

cleanup()
{
	_1=`echo ${1} | tr - _`
	[ -z "${cleanup}" ] && return
	eval [ -d \${${_1}_src_dir}/.git ] || eval rm -fvr \${${_1}_src_dir} || return
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
		--prefix|--host|--jobs|--target|--*-ver)
			opt=`echo ${1} | cut -d- -f3- | tr - _`
			cmdopt="${cmdopt:+${cmdopt} }${1}"
			shift
			eval ${opt}=\${1:-\${${opt}}}
			;;
		--prepare|--all|--fetch-only|--force|--strip|--cleanup|--with-libc|--without-libc|--help|--tmpdir)
			opt=`echo ${1} | cut -d- -f3- | tr - _`
			eval ${opt}=${opt}
			;;
		--exclude)
			opt=`echo ${1} | cut -d- -f3- | tr - _`
			shift; eval ${opt}=\"\${${opt}:+\${${opt}} }\${1:-\${${opt}}}\"; shift; continue;;
		-*|--*) echo ERROR: unknown option \'${1}\'. try \'--help\' for more information. >&2; return 1;;
		*) break;;
		esac
		case ${1} in
		--prepare|--all|--with-libc|--without-libc|--tmpdir) ;; # don't pass these options to child process.
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
	[ -z "${all}" ] || set -- `print_filtered_packages ${exclude}` || return
	[ $# -eq 0 ] && echo WARNING: no packages specified. try \'--help\' for more information. >&2
	[ -n "${force}" ] && force_install=yes

	${host}-gcc --version > /dev/null || return
	[ -z "${target}" ] && target=${host}
	DESTDIR=`readlink -m ${host}`

	[ -z "${prepare}" ] || ${0} ${cmdopt} --host ${build} --target ${build} binutils gcc cmake ccache || return
	[ -n "${fetch_only}" ] || setup_pathconfig_for_build || return

	! which ccache > /dev/null || ccache -M 8G || return
	set_compiler_as_env_vars || return
	[ -z "${without_libc}" ] || manipulate_libc remove || return

	for p in $@; do
		init ${p} || return
		if [ -n "${fetch_only}" ]; then
			fetch ${p} || return
			continue
		fi
		build ${p} || return
		cleanup ${p} || return
		setup_pathconfig_for_build || return
	done
	[ -n "${fetch_only}" ] || generate_pathconfig ${DESTDIR}${prefix}/pathconfig.sh || return
	[ -z "${with_libc}" ] || manipulate_libc copy || return
}

main "$@"
