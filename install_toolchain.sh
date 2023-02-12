#!/bin/sh -e
# [TODO] ulibc
# [TODO] qemu-kvm
# [TODO] haskell(stack<-(ghc, cabal))
# [TODO] libav<-
# [TODO] webkitgtk<-libsoup
# [TODO] libmount
# [TODO] rsvg
# [TODO] Polly, MySQL, grub
# [TODO] update-alternatives

: ${tar_ver:=1.34}
: ${cpio_ver:=2.13}
: ${xz_ver:=5.4.1}
: ${bzip2_ver:=1.0.8}
: ${gzip_ver:=1.12}
: ${zip_ver:=3.0}
: ${unzip_ver:=6.0}
: ${lzip_ver:=1.22}
: ${lunzip_ver:=1.12}
: ${lzo_ver:=2.10}
: ${lzop_ver:=1.04}
: ${lz4_ver:=1.9.4}
: ${zstd_ver:=1.5.4}
: ${libarchive_ver:=3.5.2}
: ${wget_ver:=1.21.3}
: ${libffi_ver:=3.4.4}
: ${libiconv_ver:=1.16}
: ${pcre_ver:=8.45}
: ${glib_ver:=2.70.1}
: ${pkg_config_ver:=0.29.2}
: ${help2man_ver:=1.47.16}
: ${texinfo_ver:=7.0.2}
: ${coreutils_ver:=9.1}
: ${busybox_ver:=1.34.1}
: ${bison_ver:=3.8.1}
: ${flex_ver:=2.6.4}
: ${m4_ver:=1.4.19}
: ${autoconf_ver:=2.71}
: ${autoconf_archive_ver:=2022.09.03}
: ${automake_ver:=1.16.5}
: ${autogen_ver:=5.18.16}
: ${libtool_ver:=2.4.7}
: ${sed_ver:=4.9}
: ${gawk_ver:=5.1.0}
: ${gnulib_ver:=git}
: ${make_ver:=4.3}
: ${binutils_ver:=2.40}
: ${elfutils_ver:=0.188}
: ${systemtap_ver:=4.8}
: ${ed_ver:=1.19}
: ${bc_ver:=1.07.1}
: ${rsync_ver:=3.2.7}
: ${linux_ver:=6.0}
: ${perf_ver:=${linux_ver}}
: ${libcap_ver:=2.49}
: ${numactl_ver:=2.0.16}
: ${OpenCSD_ver:=1.2.1}
: ${libunwindnongnu_ver:=1.6.2}
: ${libpfm_ver:=4.11.0}
: ${libbpf_ver:=1.1.0}
: ${bcc_ver:=0.26.0}
: ${cereal_ver:=1.3.2}
: ${bpftrace_ver:=0.16.0}
: ${libtraceevent_ver:=1.6.0}
: ${libtracefs_ver:=1.4.0}
: ${trace_cmd_ver:=v3.1}
: ${kmod_ver:=30}
: ${dtc_ver:=1.6.0}
: ${u_boot_ver:=2022.01}
: ${qemu_ver:=7.0.0}
: ${gperf_ver:=3.1}
: ${glibc_ver:=2.36}
: ${newlib_ver:=4.1.0}
: ${mingw_w64_ver:=9.0.0}
: ${gmp_ver:=6.2.1}
: ${mpfr_ver:=4.2.0}
: ${mpc_ver:=1.3.1}
: ${isl_ver:=0.20}
: ${gcc_ver:=12.2.0}
: ${readline_ver:=8.1}
: ${ncurses_ver:=6.4}
: ${popt_ver:=1.18}
: ${babeltrace_ver:=1.5.8}
: ${gdb_ver:=12.1}
: ${crash_ver:=8.0.2}
: ${lcov_ver:=1.16}
: ${strace_ver:=6.1}
: ${ltrace_ver:=0.7.3}
: ${valgrind_ver:=3.18.1}
: ${zlib_ver:=1.2.13}
: ${pigz_ver:=2.7}
: ${libpng_ver:=1.6.37}
: ${tiff_ver:=4.2.0}
: ${jpeg_ver:=v9d}
: ${giflib_ver:=5.2.1}
: ${libwebp_ver:=1.2.1}
: ${emacs_ver:=28.2}
: ${vim_ver:=9.0.0814}
: ${vimdoc_ja_ver:=master}
: ${ctags_ver:=git}
: ${neovim_ver:=0.8.3}
: ${nano_ver:=7.2}
: ${grep_ver:=3.8}
: ${global_ver:=6.6.6}
: ${pcre2_ver:=10.42}
: ${the_silver_searcher_ver:=2.2.0}
: ${the_platinum_searcher_ver:=2.2.0}
: ${highway_ver:=1.1.0}
: ${ripgrep_ver:=13.0.0}
: ${ghostscript_ver:=9.52}
: ${graphviz_ver:=2.44.1}
: ${doxygen_ver:=1.9.6}
: ${freetype_ver:=2.11.0}
: ${fontconfig_ver:=2.13.1}
: ${plantuml_ver:=1.2021.1}
: ${diffutils_ver:=3.9}
: ${patch_ver:=2.7.6}
: ${findutils_ver:=4.9.0}
: ${procps_ver:=3.3.17}
: ${lsof_ver:=4.98.0}
: ${sysstat_ver:=12.5.4}
: ${less_ver:=581.2}
: ${groff_ver:=1.22.4}
: ${gdbm_ver:=1.23}
: ${libpipeline_ver:=1.5.3}
: ${man_db_ver:=2.9.4}
: ${file_ver:=5.41}
: ${source_highlight_ver:=3.1.9}
: ${screen_ver:=4.9.0}
: ${libevent_ver:=2.1.12-stable}
: ${tmux_ver:=3.3a}
: ${expect_ver:=5.45.4}
: ${dejagnu_ver:=1.6.3}
: ${zsh_ver:=5.8}
: ${bash_ver:=5.2}
: ${dash_ver:=0.5.11.5}
: ${tcsh_ver:=TCSH6_23_00}
: ${inetutils_ver:=2.4}
: ${iproute2_ver:=5.9.0}
: ${util_linux_ver:=2.37.2}
: ${pciutils_ver:=3.8.0}
: ${lsscsi_ver:=r0.32}
: ${parted_ver:=3.5}
: ${e2fsprogs_ver:=1.46.2}
: ${btrfs_progs_ver:=5.19.1}
: ${squashfs_ver:=4.4}
: ${openssl_ver:=3.0.8}
: ${openssh_ver:=9.1p1}
: ${nghttp2_ver:=1.51.0}
: ${brotli_ver:=1.0.9}
: ${libssh_ver:=0.9.6}
: ${curl_ver:=7.84.0}
: ${expat_ver:=2.4.7}
: ${asciidoc_ver:=10.1.4}
: ${libxml2_ver:=2.9.11}
: ${libxslt_ver:=1.1.34}
: ${xmlto_ver:=0.0.28}
: ${gettext_ver:=0.21}
: ${git_ver:=2.39.1}
: ${git_manpages_ver:=${git_ver}}
: ${git_lfs_ver:=3.3.0}
: ${mercurial_ver:=6.1.1}
: ${sqlite_ver:=3390200}
: ${apr_ver:=1.7.0}
: ${apr_util_ver:=1.6.1}
: ${utf8proc_ver:=2.8.0}
: ${subversion_ver:=1.14.2}
: ${ninja_ver:=1.11.1}
: ${meson_ver:=1.0.0}
: ${cmake_ver:=3.25.2}
: ${bazel_ver:=5.4.0}
: ${json_ver:=3.11.2}
: ${fmt_ver:=9.1.0}
: ${spdlog_ver:=1.11.0}
: ${Bear_ver:=3.1.0}
: ${ccache_ver:=4.7.4}
: ${distcc_ver:=3.4}
: ${libedit_ver:=20210910-3.1}
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
: ${cling_ver:=git}
: ${ccls_ver:=git}
: ${boost_ver:=1_81_0}
: ${Python_ver:=3.10.8}
: ${Python2_ver:=2.7.18}
: ${cython_ver:=0.29.33}
: ${OpenBLAS_ver:=0.3.21}
: ${numpy_ver:=1.24.2}
: ${rustc_ver:=1.67.1}
: ${rustup_ver:=1.25.1}
: ${libyaml_ver:=0.2.5}
: ${ruby_ver:=3.2.1}
: ${go_ver:=1.19.5}
: ${perl_ver:=5.36.0}
: ${tcl_ver:=8.6.11}
: ${tk_ver:=8.6.11}
: ${libunistring_ver:=1.1}
: ${libidn2_ver:=2.3.4}
: ${libpsl_ver:=0.21.2}
: ${libatomic_ops_ver:=7.6.14}
: ${gc_ver:=8.2.2}
: ${guile_ver:=3.0.9}
: ${lua_ver:=5.4.3}
: ${node_ver:=16.13.0}
: ${jdk_ver:=18.0.2.1}
: ${nasm_ver:=2.15.05}
: ${yasm_ver:=1.3.0}
: ${x264_ver:=master}
: ${x265_ver:=3.2.1}
: ${libav_ver:=11.9}
: ${gflags_ver:=2.2.2}
: ${glog_ver:=0.6.0}
: ${openjpeg_ver:=2.5.0}
: ${Imath_ver:=3.1.6}
: ${openexr_ver:=3.1.3}
: ${eigen_ver:=3.4.0}
: ${hdf5_ver:=1.12.1}
: ${VTK_ver:=9.1.0}
: ${opencv_ver:=4.7.0}
: ${opencv_contrib_ver:=${opencv_ver}}
: ${v4l_utils_ver:=1.22.1}
: ${yavta_ver:=git}
: ${gstreamer_ver:=1.22.0}
: ${gst_plugins_base_ver:=${gstreamer_ver}}
: ${gst_plugins_good_ver:=${gstreamer_ver}}
: ${gst_editing_services_ver:=${gstreamer_ver}}
: ${gst_rtsp_server_ver:=${gstreamer_ver}}
: ${gst_omx_ver:=${gstreamer_ver}}
: ${gst_python_ver:=${gstreamer_ver}}
: ${orc_ver:=0.4.33}
: ${lcms2_ver:=2.14}
: ${liblqr_ver:=0.4.2}
: ${fftw_ver:=3.3.10}
: ${LibRaw_ver:=0.21.1}
: ${ImageMagick_ver:=7.1.0-61}
: ${googletest_ver:=1.12.1}
: ${fzf_ver:=0.37.0}
: ${bat_ver:=0.22.1}
: ${jq_ver:=1.6}
: ${libpcap_ver:=1.10.1}
: ${tcpdump_ver:=4.99.1}
: ${nmap_ver:=7.90}
: ${npth_ver:=1.6}
: ${libgpg_error_ver:=1.46}
: ${libgcrypt_ver:=1.10.1}
: ${libksba_ver:=1.6.3}
: ${libassuan_ver:=2.5.5}
: ${gnupg_ver:=2.4.0}
: ${protobuf_ver:=3.20.3}
: ${cares_ver:=1.19.0}
: ${re2_ver:=2023-02-01}
: ${abseil_ver:=20220623.1}
: ${grpc_ver:=1.52.0}
: ${libbacktrace_ver:=git}
: ${poke_ver:=2.4}

: ${xproto_ver:=7.0.31}
: ${libXau_ver:=1.0.9}
: ${libXdmcp_ver:=1.1.3}
: ${xtrans_ver:=1.4.0}
: ${libICE_ver:=1.0.10}
: ${libSM_ver:=1.2.3}
: ${xcb_proto_ver:=1.15}
: ${libxcb_ver:=1.15}
: ${xextproto_ver:=7.3.0}
: ${inputproto_ver:=2.3.2}
: ${kbproto_ver:=1.0.7}
: ${libX11_ver:=1.8}
: ${libXext_ver:=1.3.4}
: ${libXt_ver:=1.2.1}
: ${libXmu_ver:=1.1.3}
: ${libXpm_ver:=3.5.13}
: ${libXaw_ver:=1.0.14}
: ${libXi_ver:=1.7}
: ${fixesproto_ver:=5.0}
: ${libXfixes_ver:=5.0.3}
: ${damageproto_ver:=1.2.1}
: ${libXdamage_ver:=1.1.5}
: ${renderproto_ver:=0.11.1}
: ${libXrender_ver:=0.9.10}
: ${randrproto_ver:=1.5.0}
: ${libXrandr_ver:=1.5.2}
: ${libXcursor_ver:=1.2.1}
: ${xineramaproto_ver:=1.2.1}
: ${libXinerama_ver:=1.1.4}
: ${libxkbcommon_ver:=1.4.0}
: ${libpciaccess_ver:=0.16}
: ${libdrm_ver:=2.4.110}
: ${libxshmfence_ver:=1.3}
: ${wayland_ver:=1.21.0}
: ${wayland_protocols_ver:=1.31}
: ${glproto_ver:=1.4.17}
: ${dri2proto_ver:=2.8}
: ${dri3proto_ver:=1.0}
: ${libglvnd_ver:=1.4.0}
: ${mesa_ver:=21.3.1}
: ${glu_ver:=9.0.2}
: ${libepoxy_ver:=1.5.10}
: ${gobject_introspection_ver:=1.72.0}
: ${pixman_ver:=0.40.0}
: ${cairo_ver:=1.16.0}
: ${fribidi_ver:=1.0.12}
: ${harfbuzz_ver:=7.0.0}
: ${pango_ver:=1.50.7}
: ${pygobject_ver:=3.42.1}
: ${itstool_ver:=2.0.7}
: ${shared_mime_info_ver:=2.2}
: ${gdk_pixbuf_ver:=2.42.8}
: ${atk_ver:=2.38.0}
: ${dbus_ver:=1.14.0}
: ${recordproto_ver:=1.14.2}
: ${libXtst_ver:=1.2.3}
: ${at_spi2_core_ver:=AT_SPI2_CORE_2_44_1}
: ${at_spi2_atk_ver:=AT_SPI2_ATK_2_38_0}
: ${graphene_ver:=1.10.8}
: ${gtk_ver:=3.24.34}
: ${webkitgtk_ver:=2.14.0}
: ${qt_ver:=5.15.6}
: ${xauth_ver:=1.1.2}

: ${prefix:=/toolchain}
: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
: ${enable_ccache:=no}
: ${enable_check:=no}
: ${languages:=c,c++,go,fortran}
: ${host:=`gcc -dumpmachine`}
: ${target:=${host}}

: ${build:=${host}}
: ${strip:=strip}
: ${cmake_build_type:=Release}

usage()
# Show usage.
{
	cat <<EOF
[Usage]
	${0} [-p prefix] [-s src] [-j jobs] [-f yes|no] [-c yes|no] [-h host] [-t target] [variable=value]... commands...

[Options]
	-p prefix
		Installation directory, currently '${prefix}'.
		'/usr/local' is NOT strongly recommended.
	-s src
		Source directory, currently '${src}'.
		Not necessary to be '${prefix}/src'.
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
			x86_64-w64-mingw32
			i686-w64-mingw32

[Examples]
	For everything which can be installed by this tool:
	# ${0} -p /toolchain -t armv7l-linux-gnueabihf -j 8 auto

	For Raspberry pi 2 cross compiler:
	# ${0} -p /toolchain -t armv7l-linux-gnueabihf -j 8 binutils_ver=2.25 linux_ver=3.18.13 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

	For microblaze cross compiler:
	# ${0} -p /toolchain -t microblaze-linux-gnu -j 8 binutils_ver=2.25 linux_ver=4.3.3 glibc_ver=2.22 gcc_ver=5.3.0 'install cross'

	For MinGW64 cross compiler(x86_64):
	# ${0} -p /toolchain -t x86_64-w64-mingw32 -l c,c++ install_cross_gcc
	or(i686):
	# ${0} -p /toolchain -t i686-w64-mingw32 -l c,c++ install_cross_gcc

EOF
	list_major_commands
	echo
}

auto()
# Perform auto installation for all available toolchain and other tools.
{
	fetch || return
	full || return
	clean || return
	archive || return
}

fetch()
# Fetch source files.
{
	[ $# -ne 0 ] || fetch `sed -e '/^fetch()$/,/^}$/p;d' ${0} | sed -e '/\([-_[:alnum:]]\+|\?\)\+\(\\\\\|)\)$/{y/|)\\\/   /;p};d'` || return
	for p in "$@"; do
		_p=`echo ${p} | tr - _`
		eval [ -n \"\${${_p}_src_base}\" ] && eval mkdir -pv \${${_p}_src_base} || return
		eval check_archive \${${_p}_src_dir} || eval [ -d \${${_p}_src_dir} -o -h \${${_p}_src_dir} ] && continue
		[ ${_p} != perf ] || { fetch linux || return; continue;}
		case ${p} in
		tar|cpio|gzip|wget|help2man|texinfo|coreutils|bison|m4|autoconf|autoconf-archive|automake|libtool|sed|gawk|\
		gnulib|make|binutils|ed|bc|gperf|glibc|gmp|mpfr|mpc|readline|ncurses|gdb|emacs|libiconv|nano|grep|global|\
		diffutils|patch|findutils|less|groff|gdbm|screen|dejagnu|bash|inetutils|gettext|libunistring|guile|poke|parted)
			eval [ "\${${p}_ver}" = git ] && {
				case ${p} in
				binutils|gdb)
					eval git clone --depth 1 \
						git://sourceware.org/git/binutils-gdb.git \${${_p}_src_dir} || return;;
				*)
					eval git clone --depth 1 \
						https://git.savannah.gnu.org/git/${p}.git \${${_p}_src_dir} || return
					case ${p} in
					gperf|emacs|gettext|libunistring|guile)
						(eval cd \${${_p}_src_dir}; ./autogen.sh) || return;;
					libiconv)
						(fetch gnulib) || return
						(eval cd \${${_p}_src_dir}; GNULIB_SRCDIR=${gnulib_src_dir} ./autogen.sh) || return;;
					tar|cpio|automake|libtool|gdbm)
						(eval cd \${${_p}_src_dir}; ./bootstrap) || return;;
					gzip|wget|coreutils|bison|sed|make|grep|diffutils|patch|findutils|groff|inetutils)
						(fetch gnulib) || return
						(eval cd \${${_p}_src_dir}; ./bootstrap --gnulib-srcdir=${gnulib_src_dir} --no-git) || return;;
					esac
					;;
				esac
			} || for compress_format in xz bz2 gz lz; do
				eval wget -O \${${_p}_src_dir}.tar.${compress_format} \
					https://ftp.gnu.org/gnu/${p}/\${${_p}_name}.tar.${compress_format} \
					&& break \
					|| eval rm -v \${${_p}_src_dir}.tar.${compress_format}
			done || return;;
		autogen)
			wget -O ${autogen_src_dir}.tar.xz \
				https://ftp.gnu.org/gnu/autogen/rel${autogen_ver}/${autogen_name}.tar.xz || return;;
		xz)
			wget -O ${xz_src_dir}.tar.bz2 \
				https://tukaani.org/xz/${xz_name}.tar.bz2 || return;;
		bzip2)
			wget -O ${bzip2_src_dir}.tar.gz \
				https://www.sourceware.org/pub/bzip2/${bzip2_name}.tar.gz || return;;
		zip)
			wget -O ${zip_src_dir}.tar.gz \
				https://sourceforge.net/projects/infozip/files/Zip%203.x%20%28latest%29/${zip_ver}/zip`echo ${zip_ver} | tr -d .`.tar.gz/download || return;;
		unzip)
			wget -O ${unzip_src_dir}.tar.gz \
				https://sourceforge.net/projects/infozip/files/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip`echo ${unzip_ver} | tr -d .`.tar.gz/download || return;;
		lzip)
			wget -O ${lzip_src_dir}.tar.gz \
				https://download.savannah.gnu.org/releases/lzip/${lzip_name}.tar.gz || return;;
		lunzip)
			wget -O ${lunzip_src_dir}.tar.gz \
				https://download.savannah.gnu.org/releases/lzip/lunzip/${lunzip_name}.tar.gz || return;;
		lzo)
			wget -O ${lzo_src_dir}.tar.gz \
				https://www.oberhumer.com/opensource/lzo/download/${lzo_name}.tar.gz || return;;
		lzop)
			wget -O ${lzop_src_dir}.tar.gz \
				https://www.lzop.org/download/${lzop_name}.tar.gz || return;;
		lz4)
			wget -O ${lz4_src_dir}.tar.gz \
				https://github.com/lz4/lz4/archive/v${lz4_ver}.tar.gz || return;;
		zstd)
			wget -O ${zstd_src_dir}.tar.gz \
				https://github.com/facebook/zstd/releases/download/v${zstd_ver}/${zstd_name}.tar.gz || return;;
		libarchive)
			wget -O ${libarchive_src_dir}.tar.xz \
				https://www.libarchive.org/downloads/${libarchive_name}.tar.xz || return;;
		busybox)
			wget -O ${busybox_src_dir}.tar.bz2 \
				https://www.busybox.net/downloads/${busybox_name}.tar.bz2 || return;;
		flex)
			wget -O ${flex_src_dir}.tar.gz \
				https://github.com/westes/flex/releases/download/v${flex_ver}/${flex_name}.tar.gz || return;;
		elfutils)
			wget -O ${elfutils_src_dir}.tar.bz2 \
				https://sourceware.org/elfutils/ftp/${elfutils_ver}/${elfutils_name}.tar.bz2 || return;;
		systemtap)
			wget -O ${systemtap_src_dir}.tar.gz \
				https://sourceware.org/systemtap/ftp/releases/${systemtap_name}.tar.gz || return;;
		rsync)
			wget -O ${rsync_src_dir}.tar.gz \
				https://download.samba.org/pub/rsync/src/${rsync_name}.tar.gz || return;;
		linux|perf)
			case `print_version linux` in
			2.6) linux_major_ver=v2.6;;
			*)   linux_major_ver=v`print_version linux 1`.x;;
			esac
			wget -O ${linux_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/kernel/${linux_major_ver:-v`print_version linux 1`.x}/${linux_name}.tar.xz || return;;
		libcap)
			wget -O ${libcap_src_dir}.tar.gz \
				https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/${libcap_name}.tar.gz || return;;
		numactl)
			wget -O ${numactl_src_dir}.tar.gz \
				https://github.com/numactl/numactl/archive/refs/tags/v${numactl_ver}.tar.gz || return;;
		OpenCSD)
			wget -O ${OpenCSD_src_dir}.tar.gz \
				https://github.com/Linaro/OpenCSD/archive/refs/tags/v${OpenCSD_ver}.tar.gz || return;;
		libunwindnongnu)
			wget -O ${libunwindnongnu_src_dir}.tar.gz \
				https://download.savannah.nongnu.org/releases/libunwind/${libunwindnongnu_name}.tar.gz || return;;
		libpfm)
			wget -O ${libpfm_src_dir}.tar.gz \
				https://sourceforge.net/projects/perfmon2/files/libpfm4/${libpfm_name}.tar.gz/download || return;;
		libbpf)
			wget -O ${libbpf_src_dir}.tar.gz \
				https://github.com/libbpf/libbpf/archive/v${libbpf_ver}.tar.gz || return;;
		bcc)
			wget -O ${bcc_src_dir}.tar.gz \
				https://github.com/iovisor/bcc/archive/v${bcc_ver}.tar.gz || return;;
		cereal)
			wget -O ${cereal_src_dir}.tar.gz \
				https://github.com/USCiLab/cereal/archive/v${cereal_ver}.tar.gz || return;;
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
		kmod)
			wget -O ${kmod_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/utils/kernel/kmod/${kmod_name}.tar.xz || return;;
		dtc)
			wget -O ${dtc_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/utils/dtc/${dtc_name}.tar.xz || return;;
		u-boot)
			wget -O ${u_boot_src_dir}.tar.bz2 \
				https://ftp.denx.de/pub/u-boot/${u_boot_name}.tar.bz2 || return;;
		qemu)
			wget -O ${qemu_src_dir}.tar.xz \
				https://download.qemu.org/${qemu_name}.tar.xz || return;;
		newlib)
			wget -O ${newlib_src_dir}.tar.gz \
				ftp://sourceware.org/pub/newlib/${newlib_name}.tar.gz || return;;
		mingw-w64)
			wget -O ${mingw_w64_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/mingw-w64-v${mingw_w64_ver}.tar.bz2/download || return;;
		isl)
			wget -O ${isl_src_dir}.tar.xz \
				https://libisl.sourceforge.io/${isl_name}.tar.xz || return;;
		gcc)
			[ "${gcc_ver}" = git ] && {
				git clone -b master --depth 1 \
					git://gcc.gnu.org/git/gcc.git ${gcc_src_dir} || return
			} || for compress_format in xz bz2 gz; do
				wget -O ${gcc_src_dir}.tar.${compress_format:-xz} \
					https://ftp.gnu.org/gnu/gcc/${gcc_name}/${gcc_name}.tar.${compress_format:-xz} \
					&& break \
					|| rm -v ${gcc_src_dir}.tar.${compress_format:-xz}
			done || return;;
		popt)
			wget -O ${popt_src_dir}.tar.gz \
				http://ftp.rpm.org/popt/releases/popt-1.x/${popt_name}.tar.gz || return;;
		babeltrace)
			wget -O ${babeltrace_src_dir}.tar.gz \
				https://github.com/efficios/babeltrace/archive/v${babeltrace_ver}.tar.gz || return;;
		crash)
			wget -O ${crash_src_dir}.tar.gz \
				https://github.com/crash-utility/crash/archive/${crash_ver}.tar.gz || return;;
		lcov)
			wget -O ${lcov_src_dir}.tar.gz \
				https://github.com/linux-test-project/lcov/archive/v${lcov_ver}.tar.gz || return;;
		strace)
			wget -O ${strace_src_dir}.tar.xz \
				https://github.com/strace/strace/releases/download/v${strace_ver}/${strace_name}.tar.xz || return;;
		ltrace)
			wget -O ${ltrace_src_dir}.tar.bz2 \
				https://www.ltrace.org/ltrace_${ltrace_ver}.orig.tar.bz2 || return;;
		valgrind)
			wget -O ${valgrind_src_dir}.tar.bz2 \
				https://sourceware.org/pub/valgrind/${valgrind_name}.tar.bz2 || return;;
		zlib)
			wget -O ${zlib_src_dir}.tar.xz \
				https://zlib.net/${zlib_name}.tar.xz || return;;
		pigz)
			wget -O ${pigz_src_dir}.tar.gz \
				https://zlib.net/pigz/${pigz_name}.tar.gz || return;;
		libpng)
			wget -O ${libpng_src_dir}.tar.xz \
				https://download.sourceforge.net/libpng/${libpng_name}.tar.xz || return;;
		tiff)
			wget -O ${tiff_src_dir}.tar.gz \
				https://download.osgeo.org/libtiff/${tiff_name}.tar.gz || return;;
		jpeg)
			wget -O ${jpeg_src_dir}.tar.gz \
				https://www.ijg.org/files/${jpeg_name}.tar.gz || return;;
		giflib)
			wget -O ${giflib_src_dir}.tar.gz \
				https://sourceforge.net/projects/giflib/files/${giflib_name}.tar.gz/download || return;;
		libwebp)
			wget -O ${libwebp_src_dir}.tar.gz \
				https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${libwebp_name}.tar.gz || return;;
		libffi)
			wget -O ${libffi_src_dir}.tar.gz \
				https://github.com/libffi/libffi/releases/download/v${libffi_ver}/${libffi_name}.tar.gz || return;;
		vim)
			wget -O ${vim_src_dir}.tar.gz \
				https://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return;;
		vimdoc-ja)
			wget -O ${vimdoc_ja_src_dir}.tar.gz \
				https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz || return;;
		ctags)
			git clone --depth 1 \
				https://github.com/universal-ctags/ctags.git ${ctags_src_dir} || return;;
		neovim)
			wget -O ${neovim_src_dir}.tar.gz \
				https://github.com/neovim/neovim/archive/v${neovim_ver}.tar.gz || return;;
		pcre)
			wget -O ${pcre_src_dir}.tar.bz2 \
				https://sourceforge.net/projects/pcre/files/pcre/${pcre_ver}/${pcre_name}.tar.bz2/download || return;;
		pcre2)
			wget -O ${pcre2_src_dir}.tar.bz2 \
				https://github.com/PhilipHazel/pcre2/releases/download/${pcre2_name}/${pcre2_name}.tar.bz2 || return;;
		the_silver_searcher)
			wget -O ${the_silver_searcher_src_dir}.tar.gz \
				https://github.com/ggreer/the_silver_searcher/archive/${the_silver_searcher_ver}.tar.gz || return;;
		the_platinum_searcher)
			wget -O ${the_platinum_searcher_src_dir}.tar.gz \
				https://github.com/monochromegane/the_platinum_searcher/archive/v${the_platinum_searcher_ver}.tar.gz || return;;
		highway)
			wget -O ${highway_src_dir}.tar.gz \
				https://github.com/tkengo/highway/archive/v${highway_ver}.tar.gz || return;;
		ripgrep)
			wget -O ${ripgrep_src_dir}.tar.gz \
				https://github.com/BurntSushi/ripgrep/archive/refs/tags/${ripgrep_ver}.tar.gz || return;;
		ghostscript)
			wget -O ${ghostscript_src_dir}.tar.xz \
				https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/gs`echo ${ghostscript_ver} | tr -d .`/${ghostscript_name}.tar.xz || return;;
		graphviz)
			wget -O ${graphviz_src_dir}.tar.gz \
				https://www2.graphviz.org/Packages/stable/portable_source/${graphviz_name}.tar.gz || return;;
		doxygen)
			wget -O ${doxygen_src_dir}.tar.gz \
				https://github.com/doxygen/doxygen/archive/Release_`echo ${doxygen_ver} | tr . _`.tar.gz || return;;
		freetype)
			wget -O ${freetype_src_dir}.tar.xz \
				https://download.savannah.gnu.org/releases/freetype/${freetype_name}.tar.xz || return;;
		fontconfig)
			wget -O ${fontconfig_src_dir}.tar.bz2 \
				https://www.freedesktop.org/software/fontconfig/release/${fontconfig_name}.tar.bz2 || return;;
		plantuml)
			wget -O ${plantuml_src_dir}.jar \
				https://sourceforge.net/projects/plantuml/files/${plantuml_name}.jar/download || return
			[ -f ${plantuml_src_dir}.pdf ] ||
				wget -O ${plantuml_src_dir}.pdf \
					http://pdf.plantuml.net/PlantUML_Language_Reference_Guide_ja.pdf || return;;
		procps)
			wget -O ${procps_src_dir}.tar.bz2 \
				https://gitlab.com/procps-ng/procps/-/archive/v${procps_ver}/procps-v${procps_ver}.tar.bz2 || return;;
		lsof)
			wget -O ${lsof_src_dir}.tar.gz \
				https://github.com/lsof-org/lsof/archive/${lsof_ver}.tar.gz || return;;
		sysstat)
			wget -O ${sysstat_src_dir}.tar.gz \
				https://github.com/sysstat/sysstat/archive/v${sysstat_ver}.tar.gz || return;;
		libpipeline|man-db)
			for compress_format in xz gz; do
				eval wget -O \${${_p}_src_dir}.tar.${compress_format:-xz} \
					https://download.savannah.nongnu.org/releases/${p:-man-db}/\${${_p:-man_db}_name}.tar.${compress_format:-xz} \
					&& break \
					|| eval rm -v \${${_p}_src_dir}.tar.${compress_format:-xz}
			done || return;;
		file)
			wget -O ${file_src_dir}.tar.gz \
				http://ftp.astron.com/pub/file/${file_name}.tar.gz || return;;
		source-highlight)
			wget -O ${source_highlight_src_dir}.tar.gz \
				https://ftp.gnu.org/gnu/src-highlite/${source_highlight_name}.tar.gz || return;;
		libevent)
			wget -O ${libevent_src_dir}.tar.gz \
				https://github.com/libevent/libevent/releases/download/release-${libevent_ver}/${libevent_name}.tar.gz || return;;
		tmux)
			wget -O ${tmux_src_dir}.tar.gz \
				https://github.com/tmux/tmux/releases/download/${tmux_ver}/${tmux_name}.tar.gz || return;;
		expect)
			wget -O ${expect_src_dir}.tar.gz \
				https://sourceforge.net/projects/expect/files/Expect/${expect_ver}/${expect_name}.tar.gz/download || return;;
		zsh)
			wget -O ${zsh_src_dir}.tar.xz \
				https://sourceforge.net/projects/zsh/files/zsh/${zsh_ver}/${zsh_name}.tar.xz/download || return;;
		dash)
			wget -O ${dash_src_dir}.tar.gz \
				https://git.kernel.org/pub/scm/utils/dash/dash.git/snapshot/${dash_name}.tar.gz || return;;
		tcsh)
			wget -O ${tcsh_src_dir}.tar.gz \
				https://github.com/tcsh-org/tcsh/archive/refs/tags/${tcsh_ver}.tar.gz || return;;
		iproute2)
			wget -O ${iproute2_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/utils/net/iproute2/${iproute2_name}.tar.xz || return;;
		util-linux)
			wget -O ${util_linux_src_dir}.tar.xz \
				https://www.kernel.org/pub/linux/utils/util-linux/v`print_version util-linux`/${util_linux_name}.tar.xz || return;;
		pciutils)
			wget -O ${pciutils_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/utils/pciutils/${pciutils_name}.tar.xz || return;;
		lsscsi)
			wget -O ${lsscsi_src_dir}.tar.gz \
				https://github.com/doug-gilbert/lsscsi/archive/refs/tags/${lsscsi_ver}.tar.gz || return;;
		e2fsprogs)
			wget -O ${e2fsprogs_src_dir}.tar.gz \
				https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/v${e2fsprogs_ver}/${e2fsprogs_name}.tar.gz/download || return;;
		btrfs-progs)
			wget -O ${btrfs_progs_src_dir}.tar.gz \
				https://github.com/kdave/btrfs-progs/archive/refs/tags/v${btrfs_progs_ver}.tar.gz || return;;
		squashfs)
			wget -O ${squashfs_src_dir}.tar.gz \
				https://sourceforge.net/projects/squashfs/files/squashfs/${squashfs_name}/${squashfs_name}.tar.gz/download || return;;
		openssl)
			wget -O ${openssl_src_dir}.tar.gz \
				https://www.openssl.org/source/${openssl_name}.tar.gz ||
					wget -O ${openssl_src_dir}.tar.gz \
						https://www.openssl.org/source/old/`echo ${openssl_ver} | sed -e 's/[a-z]//g'`/${openssl_name}.tar.gz || return;;
		openssh)
			wget -O ${openssh_src_dir}.tar.gz \
				https://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/${openssh_name}.tar.gz || return;;
		nghttp2)
			wget -O ${nghttp2_src_dir}.tar.xz \
				https://github.com/nghttp2/nghttp2/releases/download/v${nghttp2_ver}/${nghttp2_name}.tar.xz || return;;
		brotli)
			wget -O ${brotli_src_dir}.tar.gz \
				https://github.com/google/brotli/archive/refs/tags/v${brotli_ver}.tar.gz || return;;
		libssh)
			wget -O ${libssh_src_dir}.tar.xz \
				https://www.libssh.org/files/`print_version libssh`/${libssh_name}.tar.xz || return;;
		curl)
			wget -O ${curl_src_dir}.tar.xz \
				https://curl.se/download/${curl_name}.tar.xz || return;;
		expat)
			wget -O ${expat_src_dir}.tar.xz \
				https://github.com/libexpat/libexpat/releases/download/R_`echo ${expat_ver} | tr . _`/${expat_name}.tar.xz || return;;
		asciidoc)
			wget -O ${asciidoc_src_dir}.tar.gz \
				https://github.com/asciidoc-py/asciidoc-py/releases/download/${asciidoc_ver}/${asciidoc_name}.tar.gz || return;;
		libxml2|libxslt)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				http://xmlsoft.org/sources/\${${_p:-libxml2}_name}.tar.gz || return;;
		xmlto)
			wget -O ${xmlto_src_dir}.tar.bz2 \
				https://releases.pagure.org/xmlto/${xmlto_name}.tar.bz2 || return;;
		git)
			wget -O ${git_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/scm/git/${git_name}.tar.xz || return;;
		git-manpages)
			wget -O ${git_manpages_src_dir}.tar.xz \
				https://www.kernel.org/pub/software/scm/git/${git_manpages_name}.tar.xz || return;;
		git-lfs)
			wget -O ${git_lfs_src_dir}.tar.gz \
				https://github.com/git-lfs/git-lfs/releases/download/v${git_lfs_ver}/git-lfs-v${git_lfs_ver}.tar.gz || return;;
		mercurial)
			wget -O ${mercurial_src_dir}.tar.gz \
				https://www.mercurial-scm.org/release/${mercurial_name}.tar.gz || return;;
		sqlite)
			wget -O ${sqlite_src_dir}.tar.gz \
				https://www.sqlite.org/2022/${sqlite_name}.tar.gz || return;;
		apr|apr-util)
			eval wget -O \${${_p}_src_dir}.tar.bz2 \
				https://dlcdn.apache.org/apr/\${${_p:-apr}_name}.tar.bz2 || return;;
		utf8proc)
			wget -O ${utf8proc_src_dir}.tar.gz \
				https://github.com/JuliaStrings/utf8proc/archive/v${utf8proc_ver}.tar.gz || return;;
		subversion)
			wget -O ${subversion_src_dir}.tar.bz2 \
				https://dlcdn.apache.org/subversion/${subversion_name}.tar.bz2 || return;;
		ninja)
			wget -O ${ninja_src_dir}.tar.gz \
				https://github.com/ninja-build/ninja/archive/v${ninja_ver}.tar.gz || return;;
		meson)
			wget -O ${meson_src_dir}.tar.gz \
				https://github.com/mesonbuild/meson/archive/${meson_ver}.tar.gz || return;;
		cmake)
			wget -O ${cmake_src_dir}.tar.gz \
				https://cmake.org/files/v`print_version cmake`/${cmake_name}.tar.gz || return;;
		bazel)
			wget -O ${bazel_src_dir}.zip \
				https://github.com/bazelbuild/bazel/releases/download/${bazel_ver}/${bazel_name}-dist.zip || return;;
		json)
			wget -O ${json_src_dir}.tar.gz \
				https://github.com/nlohmann/json/archive/refs/tags/v${json_ver}.tar.gz || return;;
		fmt)
			wget -O ${fmt_src_dir}.tar.gz \
				https://github.com/fmtlib/fmt/archive/refs/tags/${fmt_ver}.tar.gz || return;;
		spdlog)
			wget -O ${spdlog_src_dir}.tar.gz \
				https://github.com/gabime/spdlog/archive/refs/tags/v${spdlog_ver}.tar.gz || return;;
		Bear)
			wget -O ${Bear_src_dir}.tar.gz \
				https://github.com/rizsotto/Bear/archive/${Bear_ver}.tar.gz || return;;
		ccache)
			wget -O ${ccache_src_dir}.tar.xz \
				https://github.com/ccache/ccache/releases/download/v${ccache_ver}/${ccache_name}.tar.xz || return;;
		distcc)
			wget -O ${distcc_src_dir}.tar.gz \
				https://github.com/distcc/distcc/releases/download/v${distcc_ver}/${distcc_name}.tar.gz || return;;
		libedit)
			wget -O ${libedit_src_dir}.tar.gz \
				https://www.thrysoee.dk/editline/${libedit_name}.tar.gz || return;;
		swig)
			wget -O ${swig_src_dir}.tar.gz \
				https://sourceforge.net/projects/swig/files/swig/${swig_name}/${swig_name}.tar.gz/download || return;;
		llvm|compiler-rt|libunwind|libcxxabi|libcxx|clang|clang-tools-extra|lld|lldb)
			eval [ "\${${_p}_ver}" = git ] && {
				mkdir -pv ${llvm_src_base} || return
				[ -d ${llvm_src_base}/llvm-project.git ] || git -C ${llvm_src_base} clone --depth 1 \
					https://github.com/llvm/llvm-project llvm-project.git || return
			} || eval wget -O \${${_p}_src_dir}.tar.xz \
				https://github.com/llvm/llvm-project/releases/download/llvmorg-\${${_p:-llvm}_ver}/\${${_p:-llvm}_name}.tar.xz || return;;
		cling)
			git clone --depth 1 \
				http://root.cern.ch/git/llvm.git ${cling_src_dir} -b cling-patches || return
			[ -d ${cling_src_dir}/tools/clang ] ||
				git clone --depth 1 \
					http://root.cern.ch/git/clang.git ${cling_src_dir}/tools/clang -b cling-patches || return
			[ -d ${cling_src_dir}/tools/cling ] ||
				git clone --depth 1 \
					http://root.cern.ch/git/cling.git ${cling_src_dir}/tools/cling || return;;
		ccls)
			git clone --depth 1 --recursive \
				https://github.com/MaskRay/ccls ${ccls_src_dir} || return;;
		boost)
			wget -O ${boost_src_dir}.tar.bz2 \
				https://boostorg.jfrog.io/artifactory/main/release/`echo ${boost_ver} | tr _ .`/source/${boost_name}.tar.bz2 || return;;
		Python2|Python)
			eval wget -O ${Python_src_base}/Python-\${${_p}_ver}.tar.xz \
				https://www.python.org/ftp/python/\${${_p:-Python}_ver}/Python-\${${_p:-Python}_ver}.tar.xz || return;;
		cython)
			wget -O ${cython_src_dir}.tar.gz \
				https://github.com/cython/cython/archive/refs/tags/${cython_ver}.tar.gz;;
		OpenBLAS)
			wget -O ${OpenBLAS_src_dir}.tar.gz \
				https://github.com/xianyi/OpenBLAS/releases/download/v${OpenBLAS_ver}/${OpenBLAS_name}.tar.gz || return;;
		numpy)
			wget -O ${numpy_src_dir}.tar.gz \
				https://github.com/numpy/numpy/releases/download/v${numpy_ver}/${numpy_name}.tar.gz;;
		rustc)
			wget -O ${rustc_src_dir}.tar.gz \
				https://static.rust-lang.org/dist/${rustc_name}.tar.gz || return;;
		rustup)
			wget -O ${rustup_src_dir}.tar.gz \
				https://github.com/rust-lang/rustup/archive/${rustup_ver}.tar.gz || return;;
		libyaml)
			wget -O ${libyaml_src_dir}.tar.gz \
				https://github.com/yaml/libyaml/releases/download/${libyaml_ver}/${libyaml_name}.tar.gz || return;;
		ruby)
			wget -O ${ruby_src_dir}.tar.xz \
				https://cache.ruby-lang.org/pub/ruby/`print_version ruby`/${ruby_name}.tar.xz || return;;
		go)
			wget -O ${go_src_dir}.tar.gz \
				https://storage.googleapis.com/golang/go${go_ver}.src.tar.gz || return;;
		perl)
			wget -O ${perl_src_dir}.tar.gz \
				https://www.cpan.org/src/5.0/${perl_name}.tar.gz || return;;
		tcl|tk)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://prdownloads.sourceforge.net/tcl/\${${_p:-tcl}_name}-src.tar.gz || return;;
		libidn2)
			wget -O ${libidn2_src_dir}.tar.gz \
				https://ftp.gnu.org/gnu/libidn/${libidn2_name}.tar.gz || return;;
		libpsl)
			wget -O ${libpsl_src_dir}.tar.gz \
				https://github.com/rockdaboot/libpsl/releases/download/${libpsl_ver}/${libpsl_name}.tar.gz || return;;
		gc)
			wget -O ${gc_src_dir}.tar.gz \
				https://github.com/ivmai/bdwgc/releases/download/v${gc_ver}/${gc_name}.tar.gz || return;;
		libatomic_ops)
			wget -O ${libatomic_ops_src_dir}.tar.gz \
				https://github.com/ivmai/libatomic_ops/releases/download/v${libatomic_ops_ver}/${libatomic_ops_name}.tar.gz || return;;
		lua)
			wget -O ${lua_src_dir}.tar.gz \
				https://www.lua.org/ftp/${lua_name}.tar.gz || return;;
		node)
			wget -O ${node_src_dir}.tar.gz \
				https://nodejs.org/dist/v${node_ver}/node-v${node_ver}.tar.gz || return;;
		jdk)
			wget -O ${jdk_src_dir}.tar.gz \
				`wget -O- https://jdk.java.net/\`print_version jdk 1\` |
					grep -oe 'https://download\.java\.net/java/GA/jdk'${jdk_ver}'/.\+/GPL/open'${jdk_name}'_linux-x64_bin\.tar\.gz' | uniq` || return;;
		nasm)
			wget -O ${nasm_src_dir}.tar.xz \
				https://www.nasm.us/pub/nasm/releasebuilds/${nasm_ver}/${nasm_name}.tar.xz || return;;
		yasm)
			wget -O ${yasm_src_dir}.tar.gz \
				https://www.tortall.net/projects/yasm/releases/${yasm_name}.tar.gz || return;;
		x264)
			wget -O ${x264_src_dir}.tar.bz2 \
				https://code.videolan.org/videolan/x264/-/archive/master/${x264_name}.tar.bz2 || return;;
		x265)
			wget -O ${x265_src_dir}.tar.gz \
				http://ftp.videolan.org/pub/videolan/x265/x265_${x265_ver}.tar.gz || return;;
		libav)
			wget -O ${libav_src_dir}.tar.xz \
				https://libav.org/releases/${libav_name}.tar.xz || return;;
		gflags)
			wget -O ${gflags_src_dir}.tar.gz \
				https://github.com/gflags/gflags/archive/refs/tags/v${gflags_ver}.tar.gz || return;;
		glog)
			wget -O ${glog_src_dir}.tar.gz \
				https://github.com/google/glog/archive/refs/tags/v${glog_ver}.tar.gz || return;;
		openjpeg)
			wget -O ${openjpeg_src_dir}.tar.gz \
				https://github.com/uclouvain/openjpeg/archive/refs/tags/v${openjpeg_ver}.tar.gz || return;;
		Imath)
			wget -O ${Imath_src_dir}.tar.gz \
				https://github.com/AcademySoftwareFoundation/Imath/archive/refs/tags/v${Imath_ver}.tar.gz || return;;
		openexr)
			wget -O ${openexr_src_dir}.tar.gz \
				https://github.com/AcademySoftwareFoundation/openexr/archive/refs/tags/v${openexr_ver}.tar.gz || return;;
		eigen)
			wget -O ${eigen_src_dir}.tar.bz2 \
				https://gitlab.com/libeigen/eigen/-/archive/${eigen_ver}/${eigen_name}.tar.bz2 || return;;
		hdf5)
			wget -O ${hdf5_src_dir}.tar.bz2 \
				https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-`print_version hdf5`/${hdf5_name}/src/${hdf5_name}.tar.bz2 || return;;
		VTK)
			wget -O ${VTK_src_dir}.tar.gz \
				https://www.vtk.org/files/release/`print_version VTK`/${VTK_name}.tar.gz || return;;
		opencv|opencv_contrib)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://github.com/opencv/${_p:-opencv}/archive/\${${_p:-opencv}_ver}.tar.gz || return;;
		v4l-utils)
			wget -O ${v4l_utils_src_dir}.tar.bz2 \
				https://linuxtv.org/downloads/v4l-utils/${v4l_utils_name}.tar.bz2 || return;;
		yavta)
			git clone --depth 1 \
				git://git.ideasonboard.org/yavta.git ${yavta_src_dir} || return;;
		gstreamer|gst-plugins-base|gst-plugins-good|gst-editing-services|gst-rtsp-server|gst-omx|gst-python|orc)
			eval wget -O \${${_p}_src_dir}.tar.xz \
				https://gstreamer.freedesktop.org/src/${p:-gstreamer}/\${${_p:-gstreamer}_name}.tar.xz || return;;
		lcms2)
			wget -O ${lcms2_src_dir}.tar.gz \
				https://sourceforge.net/projects/lcms/files/lcms/`print_version lcms2 2`/${lcms2_name}.tar.gz/download || return;;
		liblqr)
			wget -O ${liblqr_src_dir}.tar.gz \
				https://github.com/carlobaldassi/liblqr/archive/refs/tags/v${liblqr_ver}.tar.gz || return;;
		fftw)
			wget -O ${fftw_src_dir}.tar.gz \
				https://fftw.org/pub/fftw/${fftw_name}.tar.gz || return;;
		LibRaw)
			wget -O ${LibRaw_src_dir}.tar.gz \
				https://www.libraw.org/data/${LibRaw_name}.tar.gz || return;;
		ImageMagick)
			wget -O ${ImageMagick_src_dir}.tar.xz \
				https://imagemagick.org/archive/releases/${ImageMagick_name}.tar.xz || return;;
		googletest)
			wget -O ${googletest_src_dir}.tar.gz \
				https://github.com/google/googletest/archive/release-${googletest_ver}.tar.gz || return;;
		fzf)
			wget -O ${fzf_src_dir}.tar.gz \
				https://github.com/junegunn/fzf/archive/${fzf_ver}.tar.gz || return;;
		bat)
			wget -O ${bat_src_dir}.tar.gz \
				https://github.com/sharkdp/bat/archive/refs/tags/v${bat_ver}.tar.gz || return;;
		jq)
			wget -O ${jq_src_dir}.tar.gz \
				https://github.com/stedolan/jq/releases/download/${jq_name}/${jq_name}.tar.gz || return;;
		libpcap|tcpdump)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://www.tcpdump.org/release/\${${_p:-libpcap}_name}.tar.gz || return;;
		nmap)
			wget -O ${nmap_src_dir}.tar.bz2 \
				https://nmap.org/dist/${nmap_name}.tar.bz2 || return;;
		npth|libgpg-error|libgcrypt|libksba|libassuan|gnupg)
			eval wget -O \${${_p}_src_dir}.tar.bz2 \
				https://www.gnupg.org/ftp/gcrypt/${p:-gnupg}/\${${_p:-gnupg}_name}.tar.bz2 || return;;
		protobuf)
			wget -O ${protobuf_src_dir}.tar.gz \
				https://github.com/protocolbuffers/protobuf/releases/download/v${protobuf_ver}/protobuf-all-${protobuf_ver}.tar.gz || return;;
		cares)
			wget -O ${cares_src_dir}.tar.gz \
				https://c-ares.org/download/${cares_name}.tar.gz || return;;
		re2)
			wget -O ${re2_src_dir}.tar.gz \
				https://github.com/google/re2/archive/refs/tags/${re2_ver}.tar.gz || return;;
		abseil)
			wget -O ${abseil_src_dir}.tar.gz \
				https://github.com/abseil/abseil-cpp/archive/refs/tags/${abseil_ver}.tar.gz || return;;
		grpc)
			wget -O ${grpc_src_dir}.tar.gz \
				https://github.com/grpc/grpc/archive/refs/tags/v${grpc_ver}.tar.gz || return;;
		libbacktrace)
			git clone --depth 1 \
				https://github.com/ianlancetaylor/libbacktrace ${libbacktrace_src_dir} || return;;
		pkg-config)
			wget -O ${pkg_config_src_dir}.tar.gz \
				https://pkg-config.freedesktop.org/releases/${pkg_config_name}.tar.gz || return;;
		xproto|xcb-proto|xextproto|inputproto|kbproto|fixesproto|damageproto|renderproto|\
		randrproto|xineramaproto|glproto|dri2proto|dri3proto|recordproto)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://xorg.freedesktop.org/archive/individual/proto/\${${_p:-xproto}_name}.tar.gz || return;;
		libXau|libXdmcp|xtrans|libICE|libSM|libxcb|libX11|libXext|libXt|libXpm|libXmu|libXaw|\
		libXi|libXfixes|libXdamage|libXrender|libXrandr|libXcursor|libXinerama|libxshmfence|\
		libpciaccess|libXtst)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://www.x.org/releases/individual/lib/\${${_p:-libX11}_name}.tar.gz || return;;
		xauth)
			eval wget -O \${${_p}_src_dir}.tar.xz \
				https://xorg.freedesktop.org/releases/individual/app/\${${_p:-xauth}_name}.tar.xz || return;;
		libxkbcommon)
			wget -O ${libxkbcommon_src_dir}.tar.xz \
				https://xkbcommon.org/download/${libxkbcommon_name}.tar.xz || return;;
		libdrm)
			wget -O ${libdrm_src_dir}.tar.xz \
				https://dri.freedesktop.org/libdrm/${libdrm_name}.tar.xz || return;;
		wayland|wayland-protocols)
			eval wget -O \${${_p}_src_dir}.tar.xz \
				https://gitlab.freedesktop.org/wayland/${p:-wayland}/-/releases/\${${_p:-wayland}_ver}/downloads/\${${_p:-wayland}_name}.tar.xz || return;;
		libglvnd)
			wget -O ${libglvnd_src_dir}.tar.bz2 \
				https://gitlab.freedesktop.org/glvnd/libglvnd/-/archive/v${libglvnd_ver}/libglvnd-v${libglvnd_ver}.tar.bz2 || return;;
		mesa)
			wget -O ${mesa_src_dir}.tar.xz \
				https://mesa.freedesktop.org/archive/${mesa_name}.tar.xz || return;;
		glu)
			wget -O ${glu_src_dir}.tar.xz \
				https://archive.mesa3d.org//glu/${glu_name}.tar.xz || return;;
		libepoxy)
			wget -O ${libepoxy_src_dir}.tar.gz \
				https://github.com/anholt/libepoxy/archive/refs/tags/${libepoxy_ver}.tar.gz || return;;
		pixman)
			eval wget -O \${${_p}_src_dir}.tar.gz \
				https://www.cairographics.org/releases/\${${_p:-pixman}_name}.tar.gz || return;;
		cairo)
			eval wget -O \${${_p}_src_dir}.tar.xz \
				https://www.cairographics.org/releases/\${${_p:-cairo}_name}.tar.xz || return;;
		fribidi)
			wget -O ${fribidi_src_dir}.tar.xz \
				https://github.com/fribidi/fribidi/releases/download/v${fribidi_ver}/${fribidi_name}.tar.xz || return;;
		harfbuzz)
			wget -O ${harfbuzz_src_dir}.tar.xz \
				https://github.com/harfbuzz/harfbuzz/releases/download/${harfbuzz_ver}/${harfbuzz_name}.tar.xz || return;;
		itstool)
			wget -O ${itstool_src_dir}.tar.bz2 \
				http://files.itstool.org/itstool/${itstool_name}.tar.bz2 || return;;
		shared-mime-info)
			wget -O ${shared_mime_info_src_dir}.tar.bz2 \
				https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${shared_mime_info_ver}/${shared_mime_info_name}.tar.bz2 || return;;
		graphene)
			wget -O ${graphene_src_dir}.tar.gz \
				https://github.com/ebassi/graphene/archive/refs/tags/${graphene_ver}.tar.gz || return;;
		glib|gobject-introspection|pango|gdk-pixbuf|atk|pygobject|gtk)
			plus=`[ ${p} = gtk ] && eval echo \$\{${_p}_ver} | grep -qe '^3\.' && echo +`
			eval wget -O \${${_p}_src_dir}.tar.xz \
				https://ftp.gnome.org/pub/gnome/sources/${p:-glib}${plus}/\`print_version ${p:-glib}\`/\${${_p:-glib}_name}.tar.xz || return;;
		dbus)
			wget -O ${dbus_src_dir}.tar.xz \
				https://dbus.freedesktop.org/releases/dbus/${dbus_name}.tar.xz || return;;
		at-spi2-core|at-spi2-atk)
			eval wget -O \${${_p}_src_dir}.tar.bz2 \
				https://gitlab.gnome.org/GNOME/${p}/-/archive/\${${_p}_ver}/\${${_p}_name}.tar.bz2 || return;;
		webkitgtk)
			wget -O ${webkitgtk_src_dir}.tar.xz \
				https://webkitgtk.org/releases/${webkitgtk_name}.tar.xz || return;;
		qt)
			wget -O ${qt_src_dir}.tar.xz \
				https://download.qt.io/official_releases/qt/`print_version qt`/${qt_ver}/single/qt-everywhere-opensource-src-${qt_ver}.tar.xz || return;;
		*)
			echo fetch: no match: ${p} >&2; return 1;;
		esac
	done
}

unpack()
# Unpack source files.
{
	case ${1} in
	'')
		clean || return
		for f in `find ${src} -name '*.tar.gz' -o -name '*.tar.bz2' -o -name '*.tar.xz' -o -name '*.tar.lz' -o -name '*.zip'`; do
			unpack `echo $f | sed -e 's/\.tar\.gz$//;s/\.tar\.bz2$//;s/\.tar\.xz$//;s/\.tar\.lz$//;s/\.zip$//'` `dirname $f`
		done;;
	*)
		_1=`echo ${1} | tr - _`
		eval mkdir -pv \${${_1}_bld_dir} || return
		eval d=\${${_1}_src_dir}
		[ -z "${2}" -a -d ${d} ] && return
		[ -n "${2}" -a -d ${2}/`basename ${d}` ] && return
		${2:+eval mkdir -pv ${2} || return}
		[ -f ${d}.tar.gz  -a -s ${d}.tar.gz  ] && tar xvf  ${d}.tar.gz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} `which pigz > /dev/null && echo -I pigz` && return
		[ -f ${d}.tar.bz2 -a -s ${d}.tar.bz2 ] && tar xjvf ${d}.tar.bz2 --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
		[ -f ${d}.tar.xz  -a -s ${d}.tar.xz  ] && tar xJvf ${d}.tar.xz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
		[ -f ${d}.tar.lz  -a -s ${d}.tar.lz  ] && tar xvf  ${d}.tar.lz  --no-same-owner --no-same-permissions -C ${2:-`dirname ${d}`} && return
		[ -f ${d}.zip     -a -s ${d}.zip     ] && unzip -d ${2:-`dirname ${d}`} ${d}.zip && return
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
		install_cross_gcc || return;;
	*)
		echo install: no match: ${1} >&2; return 1;;
	esac
}

full()
# Install native/cross GNU toolchain and other tools. as many as possible.
{
	for f in `sed -e '
		/^install_native_[_[:alnum:]]\+()$/{
			s/()$//
			s/install_native_linux_header//
			s/install_native_glibc//
			p
		}
		d' ${0}`; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	for f in install_cross_gcc; do
		$f \
			&& echo \'$f\' succeeded. | logger -p user.notice -t `basename ${0}` \
			|| echo \'$f\' failed.    | logger -p user.notice -t `basename ${0}`
	done || return

	(target=x86_64-w64-mingw32; host=${build}; languages=c,c++; set_variables; install_cross_gcc) \
		&& echo "'install_cross_gcc(mingw)'" succeeded. | logger -p user.notice -t `basename ${0}` \
		|| echo "'install_cross_gcc(mingw)'" failed.    | logger -p user.notice -t `basename ${0}`

	return 0
}

clean()
# Delete no longer required source trees.
{
	[ ! -d ${src} ] && return
	find ${src} -mindepth 2 -maxdepth 2 \
		! -name '*.tar.gz' ! -name '*.tar.bz2' ! -name '*.tar.xz' ! -name '*.tar.lz' ! -name '*.zip' \
		! -name '*.jar' ! -name '*.pdf' ! -name '*[-.]git' -exec rm -fvr {} +
	find ${src} -mindepth 2 -maxdepth 2 \
		-name '*-git' | xargs -I \{\} find \{\} -type d -name .git -execdir git clean -dfx \; -execdir git checkout -- . \;
	return 0
}

archive()
# Archive related files.
{
	[ ${src} = `dirname ${0}` ] || cp -fv ${0} ${src} || return
	shrink_archives || return
	tar cJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		-C `dirname ${prefix}` `basename ${prefix}` || return
}

deb()
# Make .deb package.
{
	deb_prefix=${src}/toolchain
	export DESTDIR=${deb_prefix}
	for pkg in $@; do
		${pkg} || return
	done
	update_shell_run_command ${set_path_sh}
	unset DESTDIR
	mkdir -pv ${deb_prefix}/DEBIAN || return
	cat <<EOF > ${deb_prefix}/DEBIAN/control || return
Package: mytoolchain
Maintainer: ${USER}
Version: 0.1.0
Architecture: `dpkg-architecture -q DEB_HOST_ARCH`
Section: non-free/devel
Priority: extra
Description: my toolchain
EOF
	(cd ${deb_prefix}
	find * -type d -name DEBIAN -prune -o -type f -exec md5sum {} +) > ${deb_prefix}/DEBIAN/md5sums || return
	`which fakeroot || true` dpkg -b ${deb_prefix} || return
}

deploy()
# Deploy related files.
{
	tar xJvf `echo ${prefix} | sed -e 's+/$++'`.tar.xz \
		--no-same-owner --no-same-permissions -C `dirname ${prefix}` || return
	update_library_search_path || return
	echo Please add ${prefix}/bin to PATH
}

docker()
# Build Docker container.
{
	DOCKER_BUILDKIT=1 COMPOSE_DOCKER_CLI_BUILD=1 docker-compose build --build-arg njobs=${jobs} --progress plain dev || return
}

list()
# List all commands, which include the ones not listed here.
{
	list_all_commands
}

reset()
# Reset '${prefix}' except '${prefix}/src'.
{
	clean || return
	[ "${enable_ccache}" != yes ] || ccache -C > /dev/null || return
	find ${prefix} -mindepth 1 -maxdepth 1 ! -name src ! -name .git -exec sh -c 'chmod -Rv u+w {}; rm -fvr {}' \;
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

	eval ${_1}_src_base=${src}/${1}
	[ ${_1} = Python2 ] && Python2_src_base=${src}/Python

	case ${1} in
	llvm|compiler-rt|libunwind|libcxxabi|libcxx|clang|clang-tools-extra|lld|lldb)
		eval ${_1}_ver=${llvm_ver}
		eval [ "\${${_1}_ver}" = git ] && {
			eval ${_1}_name=${1}
			eval ${_1}_src_dir=${llvm_src_base}/llvm-project.git/\${${_1}_name}
			eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-bld
		} || {
			eval ${_1}_name=${1}-\${${_1}_ver}.src
			eval ${_1}_src_dir=\${${_1}_src_base}/\${${_1}_name}
			eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-bld
		}
		return 0
		;;
	esac

	case ${1} in
	zip|unzip)
		eval ${_1}_name=${1}`eval echo \\${${_1}_ver} | tr -d .`;;
	libunwindnongnu)
		eval ${_1}_name=libunwind-\${${_1}_ver};;
	jpeg)
		eval ${_1}_name=${1}src.\${${_1}_ver};;
	plantuml)
		eval ${_1}_name=${1}.\${${_1}_ver};;
	sqlite)
		eval ${_1}_name=${1}-autoconf-\${${_1}_ver};;
	boost|x265)
		eval ${_1}_name=${1}_\${${_1}_ver};;
	rustc)
		eval ${_1}_name=${1}-\${${_1}_ver}-src;;
	libyaml)
		eval ${_1}_name=yaml-\${${_1}_ver};;
	procps|node|mingw-w64|libglvnd)
		eval ${_1}_name=${1}-v\${${_1}_ver};;
	squashfs|expect|tcl|tk)
		eval ${_1}_name=${1}\${${_1}_ver};;
	googletest)
		eval ${_1}_name=${1}-release-\${${_1}_ver};;
	cares)
		eval ${_1}_name=c-ares-\${${_1}_ver};;
	abseil)
		eval ${_1}_name=abseil-cpp-\${${_1}_ver};;
	gtk)
		plus=`eval echo \$\{${_1}_ver} | grep -qe '^3\.' && echo + || true`
		eval ${_1}_name=${1}${plus}-\${${_1}_ver};;
	qt)
		eval ${_1}_name=${1}-everywhere-src-\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac
	eval [ "\${${_1}_ver}" = git ] && eval ${_1}_name=${1}.git

	eval ${_1}_src_dir=\${${_1}_src_base}/\${${_1}_name}
	eval ${_1}_bld_dir=\${${_1}_src_base}/\${${_1}_name}-bld-${host}`[ ${host} != ${target} ] && echo -${target}`

	case ${1} in
	glibc|newlib|mingw-w64)
		eval ${_1}_bld_dir_crs=\${${_1}_src_base}/\${${_1}_name}-bld-${target}
		eval ${_1}_bld_dir_crs_hdr=\${${_1}_src_base}/\${${_1}_name}-bld-${target}-hdr # mingw-w64 only.
		;;
	gcc)
		eval ${_1}_bld_dir_crs_1st=\${${_1}_src_base}/${target}-\${${_1}_name}-1st
		eval ${_1}_bld_dir_crs_2nd=\${${_1}_src_base}/${target}-\${${_1}_name}-2nd
		;;
	jpeg)
		eval ${_1}_src_dir=\${${_1}_src_base}/${_1}-\`echo \${${_1}_ver} \| sed -e 's/^v//'\`
		eval ${_1}_bld_dir=\${${_1}_src_base}/${_1}-\`echo \${${_1}_ver} \| sed -e 's/^v//'\`-bld-${host}`[ ${host} != ${target} ] && echo -${target}`
		;;
	esac
}

setup_ccache()
{
	[ "${enable_ccache}" != yes ] && return
	which ccache || { echo command not found: ccache >&2; return 1;}
	mkdir -pv ${src} || return
	export USE_CCACHE=1 CCACHE_BASEDIR=${src}
	echo ${CC} | grep -qe ccache || export CC="ccache ${CC:-${host:+${host}-}gcc}" CXX="ccache ${CXX:-${host:+${host}-}g++}"
}

teardown_ccache()
{
	[ "${enable_ccache}" = yes ] && return
	echo ${CC} | grep -qe ccache && export CC=`echo ${CC} | sed -e 's/ccache //'` CXX=`echo ${CXX} | sed -e 's/ccache //'` || true
}

set_variables()
{
	prefix=`realpath -m ${prefix}`
	[ -n "${src}" ] && src=`realpath -m ${src}` || src=${prefix}/src
	[ ${build} = ${host} ] && sysroot=${prefix}/${target}/sysroot || sysroot=${prefix}/${host}/sysroot
	sysroot_mingw='C:/MinGW64'
	[ ${build} = ${host} -o -n "${DESTDIR}" ] || export DESTDIR=${sysroot}
	set_path_sh=${DESTDIR}${prefix}/set_path.sh
	echo ${host} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' && exe=.exe || exe=''
	[ -f /etc/issue ] && os=`head -n 1 /etc/issue | cut -d' ' -f1`

	case ${target} in
	arm*)        linux_arch=arm;;
	aarch64*)    linux_arch=arm64;;
	i?86*)       linux_arch=x86;;
	microblaze*) linux_arch=microblaze;;
	nios2*)      linux_arch=nios2;;
	x86_64*)     linux_arch=x86;;
	*)           linux_arch=unknown; echo Unknown target architecture: ${target} >&2;;
	esac

	for pkg in `sed -e '
		/^: \${\(.\+\)_ver:=.\+}$/{
			s//\1/
			s/pkg_config/pkg-config/
			s/autoconf_archive/autoconf-archive/
			s/trace_cmd/trace-cmd/
			s/u_boot/u-boot/
			s/mingw_w64/mingw-w64/
			s/vimdoc_ja/vimdoc-ja/
			s/man_db/man-db/
			s/source_highlight/source-highlight/
			s/util_linux/util-linux/
			s/btrfs_progs/btrfs-progs/
			s/git_manpages/git-manpages/
			s/git_lfs/git-lfs/
			s/apr_util/apr-util/
			s/compiler_rt/compiler-rt/
			s/clang_tools_extra/clang-tools-extra/
			s/libgpg_error/libgpg-error/
			s/xcb_proto/xcb-proto/
			s/wayland_protocols/wayland-protocols/
			s/shared_mime_info/shared-mime-info/
			s/gdk_pixbuf/gdk-pixbuf/
			s/at_spi2_core/at-spi2-core/
			s/at_spi2_atk/at-spi2-atk/
			s/gobject_introspection/gobject-introspection/
			s/v4l_utils/v4l-utils/
			s/gst_plugins_base/gst-plugins-base/
			s/gst_plugins_good/gst-plugins-good/
			s/gst_editing_services/gst-editing-services/
			s/gst_rtsp_server/gst-rtsp-server/
			s/gst_omx/gst-omx/
			s/gst_python/gst-python/
			p
		}
		d' ${0}`; do
		set_src_directory ${pkg}
	done

	update_ccache_wrapper || return
	[ -f ${set_path_sh} ] || update_shell_run_command ${set_path_sh} || true
	[ ! -f ${set_path_sh} ] || source_path || return
	echo ${PATH} | tr : '\n' | grep -qe ^/sbin\$ || PATH=/sbin:${PATH}
	setup_ccache || return
	teardown_ccache # never fails
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

check_archive()
{
	[ -f ${1}.tar.gz  -a -s ${1}.tar.gz  ] && return
	[ -f ${1}.tar.bz2 -a -s ${1}.tar.bz2 ] && return
	[ -f ${1}.tar.xz  -a -s ${1}.tar.xz  ] && return
	[ -f ${1}.tar.lz  -a -s ${1}.tar.lz  ] && return
	[ -f ${1}.zip     -a -s ${1}.zip     ] && return
	[ -f ${1}.jar     -a -s ${1}.jar     ] && return
	return 1
}

shrink_archives()
{
	which xz > /dev/null || return
	! which gzip  > /dev/null || find ${src} -mindepth 2 -maxdepth 2 -name '*.tar.gz'  -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.gz\$/.xz/"`;  [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; gzip  -cd {} | xz -T '${jobs}' -cv > ${xzfile}' \; -delete || return
	! which bzip2 > /dev/null || find ${src} -mindepth 2 -maxdepth 2 -name '*.tar.bz2' -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.bz2\$/.xz/"`; [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; bzip2 -cd {} | xz -T '${jobs}' -cv > ${xzfile}' \; -delete || return
	! which lzip  > /dev/null || find ${src} -mindepth 2 -maxdepth 2 -name '*.tar.lz'  -exec sh -c 'xzfile=`echo {} | sed -e "s/\\.lz\$/.xz/"`;  [ -f ${xzfile} ] && exit 0; echo converting {} into ${xzfile} ...; lzip  -cd {} | xz -T '${jobs}' -cv > ${xzfile}' \; -delete || return
	! which unzip > /dev/null || find ${src} -mindepth 2 -maxdepth 2 -name '*.zip'  -execdir sh -c '[ -f `basename {} .zip`.tar.xz ] && exit 0; unzip {} && tar cJvf `basename {} .zip`.tar.xz `basename {} .zip`' \; -delete || return
}

archive_sources()
{
	fetch || return
	clean || return
	shrink_archives || return
	tar cJvf ${src}.tar.xz -C `dirname ${src}` `basename ${src}`
}

list_duplication()
{
	find ${src} -mindepth 2 -maxdepth 2 \( -name '*.tar.gz' -o -name '*.tar.bz2' -o -name '*.tar.xz' -o -name '*.tar.lz' -o -name '*.zip' \) -exec dirname {} \; | sort | uniq -d | xargs -I @ find @ -mindepth 1 -maxdepth 1 -type f
}

list_major_commands()
{
	echo '[Available commands]'
	grep -A 1 -e '^[[:alnum:]]\+()$' ${0} |
		sed -e '
			/^--$/d
			/^{$/d
			s/()$//
			/^\(I\|idirafter\|L\|l\)$/d
			s/^# /\t/
			s/^/\t/
		'
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
	done | tr -d '\0' | sed -e 's/ \+$//'
}

list_repositories()
{
	cat <<EOF
[All repositories]
EOF
	eval eval echo `grep -e '^[[:space:]]\+\(https\?\|git\|ftp\)://.\+/' ${0} | sed -e 's/ ||\( return\(\;\;\)\?\)\?$//;s/ \\\\$//;s/^[[:space:]]\+//'` |
		tr ' ' '\n' | grep -oe '^\(https\?\|git\|ftp\)://[[:graph:]]\+'
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

	mkdir -pv ${prefix}/lib/ccache || return
	find `echo ${PATH} | tr : ' '` -maxdepth 1 ! -type d -executable -regextype posix-extended \( \
			-regex '^/.+/(([^-]+-){2,4})?g(cc|\+\+)' \
			-o -name clang -o -name clang++ \
		\) -exec basename \{\} \; 2> /dev/null | sort | uniq | \
			sed -e s"%^.\\+\$%[ \"${force_update}\" != yes -a -f ${prefix}/lib/ccache/& ] || ln -fsv `which ccache` ${prefix}/lib/ccache/&%;s/\$/ || return/" | sh || return
	unset force_update
}

write_if_not_match()
{
	[ ! -d ${2} ] && return
	dir=`find ${2} -mindepth 1 -maxdepth 1 -type d -name '*.?.?' | sort -rV | head -n 1` || return
	[ -z "${dir}" ] && return
	grep -qe ^${dir}\$ ${1} || echo ${dir} > ${1} || return
}

update_library_search_path()
{
	[ `whoami` != root ] && return
	ld_so_conf=/etc/ld.so.conf.d/`basename ${prefix}`.conf
	ld_so_conf_gcc=/etc/ld.so.conf.d/`basename ${prefix}`.gcc.conf
	[ -f ${ld_so_conf} ] || cat <<EOF > ${ld_so_conf} || return
${prefix}/lib
${prefix}/lib64
${prefix}/lib32
EOF
	write_if_not_match ${ld_so_conf_gcc} ${prefix}/lib/gcc/${host} || return
	ldconfig || return
}

update_pkg_config_path()
{
	PKG_CONFIG_PATH=`([ -d ${DESTDIR}${prefix}/lib ] && find ${DESTDIR}${prefix}/lib -type d -name pkgconfig 2> /dev/null
						[ -d ${DESTDIR}${prefix}/lib64 ] && find ${DESTDIR}${prefix}/lib64 -type d -name pkgconfig
						[ -d ${DESTDIR}${prefix}/share ] && find ${DESTDIR}${prefix}/share -type d -name pkgconfig
						LANG=C ${CC:-${host:+${host}-}gcc} -print-search-dirs | sed -e '/^libraries: =/{s/^libraries: =//;p};d' |
							tr : '\n' | xargs realpath -eq | xargs -I dir find dir -maxdepth 1 -type d -name pkgconfig
						[ -d /usr/share ] && find /usr/share -type d -name pkgconfig) | tr '\n' : | sed -e 's/:$//'`
	export PKG_CONFIG_PATH
}

update_shell_run_command()
{
	mkdir -pv `dirname ${1}` || return
	func_name=`basename ${1} | tr . _ | tr -cd '[:alpha:]_'`
	cat <<\EOF | sed -e '1,/^{$/{s%prefix_place_holder%'${prefix}'%;s%host_place_holder%'${host}'%;s%func_place_holder%'${func_name}'%}' > ${1} || return
prefix=prefix_place_holder
host=host_place_holder
func_place_holder()
{
	for p in ${prefix}/cling/bin ${prefix}/bin ${prefix}/sbin ${prefix}/go/bin ${prefix}/lib/ccache; do
		[ -d ${p} ] || continue
		echo ${p} | grep -qe "/usr/local/s\?bin" && continue
		echo ${PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& PATH=${p}`echo ${PATH} | sed -e "s%\(^\|:\)${p}\(\$\|:\)%\1\2%g;s/::/:/g;s/^://;s/:\$//;s/^./:&/"` \
			|| PATH=${p}${PATH:+:${PATH}}
	done
	unset p
	echo ${GOPATH} | tr : '\n' | grep -qe ^${prefix}/.go\$ \
		&& export GOPATH=${prefix}/.go`echo ${GOPATH} | sed -e 's%\(^\|:\)'${prefix}'/.go\($\|:\)%\1\2%g;s/::/:/g;s/^://;s/:$//;s/^./:&/'` \
		|| export GOPATH=${prefix}/.go${GOPATH:+:${GOPATH}}
	[ ${prefix} = /usr/local -a "${force_set}" != yes ] && return
	for p in ${prefix}/lib ${prefix}/lib64 ${prefix}/lib/${host} `[ -d ${prefix}/${host} ] && find ${prefix}/${host} -mindepth 2 -maxdepth 2 -type d -name lib` \
		`[ -d ${prefix}/lib/gcc/${host} ] && find ${prefix}/lib/gcc/${host} -mindepth 1 -maxdepth 1 -type d -name '*.?.?' | sort -rV | head -n 1`; do
		[ -d ${p} ] || continue
		echo ${LD_LIBRARY_PATH} | tr : '\n' | grep -qe ^${p}\$ \
			&& export LD_LIBRARY_PATH=${p}`echo ${LD_LIBRARY_PATH} | sed -e "s%\(^\|:\)${p}\(\$\|:\)%\1\2%g;s/::/:/g;s/^://;s/:\$//;s/^./:&/"` \
			|| export LD_LIBRARY_PATH=${p}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
	done
	unset p
	echo ${MANPATH} | tr : '\n' | grep -qe ^${prefix}/share/man\$ \
		&& export MANPATH=${prefix}/share/man:`echo ${MANPATH} | sed -e 's%\(^\|:\)'${prefix}'/share/man\($\|:\)%\1\2%g;s/::/:/g;s/^://'` \
		|| export MANPATH=${prefix}/share/man:${MANPATH}
EOF
	! which python3 > /dev/null 2>&1 && { echo '}'; echo ${func_name};} >> ${1} && return
	python_site_packages=`python3 -c 'import sys; print("lib/python{}.{}/site-packages".format(*sys.version_info[:2]))'`
	cat <<\EOF | sed -e 's%py_place_holder%'${python_site_packages}'%g;$s%func_place_holder%'${func_name}'%' >> ${1} || return
	[ ! -d ${prefix}/py_place_holder ] && return
	echo ${PYTHONPATH} | tr : '\n' | grep -qe ^${prefix}/py_place_holder\$ \
		&& export PYTHONPATH=${prefix}/py_place_holder`echo ${PYTHONPATH} | sed -e 's%\(^\|:\)'${prefix}'/py_place_holder\($\|:\)%\1\2%g;s/::/:/g;s/^://;s/:$//;s/^./:&/'` \
		|| export PYTHONPATH=${prefix}/py_place_holder${PYTHONPATH:+:${PYTHONPATH}}
}
func_place_holder
EOF
}

source_path()
{
	while getopts f arg; do
		case ${arg} in
		f) force_set=yes;;
		esac
	done
	shift `expr ${OPTIND} - 1`
	! check_platform ${build} ${host} ${target} | grep -qe '\<native\>\|\<cross\>' || . ${set_path_sh} || return
	unset force_set
}

update_path()
{
	update_library_search_path || return
	update_pkg_config_path || return
	update_shell_run_command ${set_path_sh} || return
	source_path || return
}

filter_shortest_hierarchy()
{
	awk '{print split($0, a, /\//), $0}' | sort -n | cut -d ' ' -f 2 | head -n 1
}

squash_options()
{
	sort | uniq | tr '\n' ' ' | sed -e 's/ $//' || return
}

print_library_path()
{
	for dir in ${DESTDIR}${prefix}/lib64 ${DESTDIR}${prefix}/lib \
		`echo ${1} | grep -qe '\.pc$' && echo ${DESTDIR}${prefix}/share` \
		`LANG=C ${CC:-${host:+${host}-}gcc} -print-search-dirs |
			sed -e '/^libraries: =/{s/^libraries: =//;p};d' | tr : '\n' | xargs realpath -eq`; do
		[ -d ${dir}${2:+/${2}} ] || continue
		candidates=`find ${dir}${2:+/${2}} \( -type f -o -type l \) -name ${1} | filter_shortest_hierarchy`
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

Wl_rpath_link()
{
	for l in "$@"; do
		echo ${l} | grep -qe '/' && d=`dirname ${l}` || d=
		f=lib`basename ${l}`.so
		print_library_dir ${f} ${d} || return
	done | sed -e 's/^/-Wl,-rpath-link,/' | squash_options || return
}

l()
{
	L "$@" || return
	echo "$@" | sed -e 's/^/ /;s/ / -l/g' || return
}

print_header_path()
{
	for dir in ${DESTDIR}${prefix}/include \
		`LANG=C ${CC:-${host:+${host}-}gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
			sed -e '/^#include /,/^End of search list.$/p;d' | xargs realpath -eq`; do
		[ -d ${dir}${2:+/${2}} ] || continue
		candidates=`find -H ${dir}${2:+/${2}} \( -type f -o -type l \) -name ${1} | filter_shortest_hierarchy`
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

print_prefix()
{
	path=`print_header_path $@`
	[ $? = 0 ] && echo ${path} | sed -e 's/\/include\/.\+//' || return
}

print_version()
{
	_1=`echo ${1} | tr - _`
	eval echo \${${_1}_ver} | cut -d. -f-${2:-2}
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

install_prerequisites()
{
	[ -n "${prerequisites_have_been_already_installed}" ] && return
	case ${os} in
	Debian|Ubuntu|Raspbian)
		apt install -y make gcc g++ || return
		apt install -y unifdef || return # for linux kernel(microblaze)
		apt install -y libgtk-3-dev libgnomeui-dev || return # for emacs
		apt install -y libudev-dev || return # for webkitgtk
		apt install -y libwebkit2gtk-4.0-dev python-dev # libicu-dev # for emacs(xwidgets)
		apt install -y libgtk-3-dev libgnomeui-dev libxt-dev || return # for vim
		;;
	Red|CentOS|\\S)
		yum install -y make gcc gcc-c++ || return
		yum install -y unifdef || return
		yum install -y gtk3-devel || return
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1;;
	esac
	prerequisites_have_been_already_installed=yes
}

install_native_tar()
{
	[ -x ${prefix}/bin/tar -a "${force_install}" != yes ] && return
	which xz > /dev/null || install_native_xz || return
	which lzip > /dev/null || install_native_lzip || return
	fetch tar || return
	unpack tar || return
	[ -f ${tar_bld_dir}/Makefile ] ||
		(cd ${tar_bld_dir}
		FORCE_UNSAFE_CONFIGURE=1 ${tar_src_dir}/configure --prefix=${prefix} \
			--build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${tar_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tar_bld_dir} -j ${jobs} -k check || return
	make -C ${tar_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_cpio()
{
	[ -x ${prefix}/bin/cpio -a "${force_install}" != yes ] && return
	fetch cpio || return
	unpack cpio || return
	[ -f ${cpio_bld_dir}/Makefile ] ||
		(cd ${cpio_bld_dir}
		${cpio_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			CFLAGS="${CFLAGS} -fcommon") || return
	make -C ${cpio_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cpio_bld_dir} -j ${jobs} -k check || return
	make -C ${cpio_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_xz()
{
	[ -x ${prefix}/bin/xz -a "${force_install}" != yes ] && return
	fetch xz || return
	unpack xz || return
	[ -f ${xz_bld_dir}/Makefile ] ||
		(cd ${xz_bld_dir}
		remove_rpath_option xz || return
		${xz_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-rpath) || return
	make -C ${xz_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${xz_bld_dir} -j ${jobs} -k check || return
	make -C ${xz_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_bzip2()
{
	[ -x ${prefix}/bin/bzip2 -a "${force_install}" != yes ] && return
	fetch bzip2 || return
	unpack bzip2 || return
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
	update_path || return
	[ -z "${strip}" ] && return
	for b in bunzip2 bzcat bzip2 bzip2recover; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libbz2.so || return
}

install_native_gzip()
{
	[ -x ${prefix}/bin/gzip -a "${force_install}" != yes ] && return
	fetch gzip || return
	unpack gzip || return
	[ -f ${gzip_bld_dir}/Makefile ] ||
		(cd ${gzip_bld_dir}
		${gzip_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${gzip_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gzip_bld_dir} -j ${jobs} -k check || return
	make -C ${gzip_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_zip()
{
	[ -x ${prefix}/bin/zip -a "${force_install}" != yes ] && return
	fetch zip || return
	unpack zip || return
	[ -f ${zip_bld_dir}/unix/Makefile ] || cp -Tvr ${zip_src_dir} ${zip_bld_dir} || return
	make -C ${zip_bld_dir} -f unix/Makefile -j ${jobs} CC=${CC:-${host:+${host}-}gcc} BIND=${host}-gcc AS=${host}-as generic || return
	make -C ${zip_bld_dir} -f unix/Makefile -j ${jobs} prefix=${DESTDIR}${prefix} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in zip zipcloak zipnote zipsplit; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_unzip()
{
	[ -x ${prefix}/bin/unzip -a "${force_install}" != yes ] && return
	fetch unzip || return
	unpack unzip || return
	[ -f ${unzip_bld_dir}/unix/Makefile ] || cp -Tvr ${unzip_src_dir} ${unzip_bld_dir} || return
	make -C ${unzip_bld_dir} -f unix/Makefile -j ${jobs} CC=${CC:-${host:+${host}-}gcc} AS=${host}-gcc LOCAL_UNZIP=-DNO_LCHMOD generic || return
	make -C ${unzip_bld_dir} -f unix/Makefile -j ${jobs} prefix=${DESTDIR}${prefix} install || return
	update_path || return
}

install_native_lzip()
{
	[ -x ${prefix}/bin/lzip -a "${force_install}" != yes ] && return
	fetch lzip || return
	unpack lzip || return
	[ -f ${lzip_bld_dir}/Makefile ] ||
		(cd ${lzip_bld_dir}
		${lzip_src_dir}/configure --prefix=${prefix} CXX=${CXX:-${host:+${host}-}g++}) || return
	make -C ${lzip_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lzip_bld_dir} -j ${jobs} -k check || return
	make -C ${lzip_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_lunzip()
{
	[ -x ${prefix}/bin/lunzip -a "${force_install}" != yes ] && return
	fetch lunzip || return
	unpack lunzip || return
	[ -f ${lunzip_bld_dir}/Makefile ] ||
		(cd ${lunzip_bld_dir}
		${lunzip_src_dir}/configure --prefix=${prefix} CC=${CC:-${host:+${host}-}gcc}) || return
	make -C ${lunzip_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lunzip_bld_dir} -j ${jobs} -k check || return
	make -C ${lunzip_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_lzo()
{
	[ -f ${prefix}/include/lzo/lzoconf.h -a "${force_install}" != yes ] && return
	fetch lzo || return
	unpack lzo || return
	[ -f ${lzo_bld_dir}/Makefile ] ||
		(cd ${lzo_bld_dir}
		${lzo_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules --enable-shared) || return
	make -C ${lzo_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lzo_bld_dir} -j ${jobs} -k test || return
	make -C ${lzo_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_lzop()
{
	[ -x ${prefix}/bin/lzop -a "${force_install}" != yes ] && return
	print_header_path lzoconf.h lzo > /dev/null || install_native_lzo || return
	fetch lzop || return
	unpack lzop || return
	[ -f ${lzop_bld_dir}/Makefile ] ||
		(cd ${lzop_bld_dir}
		${lzop_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${lzop_bld_dir} -j ${jobs} || return
	make -C ${lzop_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_lz4()
{
	[ -x ${prefix}/bin/lz4 -a "${force_install}" != yes ] && return
	fetch lz4 || return
	unpack lz4 || return
	[ -f ${lz4_bld_dir}/Makefile ] || cp -Tvr ${lz4_src_dir} ${lz4_bld_dir} || return
	make -C ${lz4_bld_dir} -j ${jobs} V=1 CC=${CC:-${host:+${host}-}gcc} || return
	for f in lz4c lz4cat unlz4; do
		rm -fv ${DESTDIR}${prefix}/bin/${f} || return
	done
	make -C ${lz4_bld_dir} -j ${jobs} V=1 PREFIX=${prefix} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/lz4 || return
}

install_native_zstd()
{
	[ -x ${prefix}/bin/zstd -a "${force_install}" != yes ] && return
	fetch zstd || return
	unpack zstd || return
	[ -f ${zstd_bld_dir}/Makefile ] || cp -Tvr ${zstd_src_dir} ${zstd_bld_dir} || return
	make -C ${zstd_bld_dir} -j ${jobs} V=1 prefix=${prefix} CC=${CC:-${host:+${host}-}gcc} || return
	make -C ${zstd_bld_dir} -j ${jobs} V=1 prefix=${DESTDIR}${prefix} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/zstd || return
}

install_native_libarchive()
{
	[ -x ${prefix}/bin/bsdtar -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path lz4.h > /dev/null || install_native_lz4 || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	print_header_path lzoconf.h lzo > /dev/null || install_native_lzo || return
	print_header_path xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	fetch libarchive || return
	unpack libarchive || return
	[ -f ${libarchive_bld_dir}/Makefile ] ||
		(cd ${libarchive_bld_dir}
		${libarchive_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules --disable-rpath \
			CPPFLAGS="${CPPFLAGS} `I zlib.h bzlib.h lz4.h zstd.h lzma.h lzo/lzoconf.h libxml2/libxml/xmlversion.h`" \
			LDFLAGS="${LDFLAGS} `L z bz2 lz4 zstd lzma lzo2 xml2`" \
			) || return
	make -C ${libarchive_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libarchive_bld_dir} -j ${jobs} -k check || return
	make -C ${libarchive_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_wget()
{
	[ -x ${prefix}/bin/wget -a "${force_install}" != yes ] && return
	print_header_path libpsl.h > /dev/null || install_native_libpsl || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	fetch wget || return
	unpack wget || return
	[ -f ${wget_bld_dir}/Makefile ] ||
		(cd ${wget_bld_dir}
		${wget_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--disable-rpath --enable-threads --with-ssl=openssl) || return
	make -C ${wget_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${wget_bld_dir} -j ${jobs} -k check || return
	make -C ${wget_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_libffi()
{
	[ -f ${prefix}/include/ffi.h -a "${force_install}" != yes ] && return
	fetch libffi || return
	unpack libffi || return
	[ -f ${libffi_bld_dir}/Makefile ] ||
		(cd ${libffi_bld_dir}
		${libffi_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${libffi_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libffi_bld_dir} -j ${jobs} -k check || return
	make -C ${libffi_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	[ -d ${DESTDIR}${prefix}/include ] || mkdir -pv ${DESTDIR}${prefix}/include || return
	for f in `find ${DESTDIR}${prefix}/lib/${libffi_name}/include -type f -name '*.h'`; do
		ln -fsv ../lib/${libffi_name}/include/`basename ${f}` ${DESTDIR}${prefix}/include/`basename ${f}` || return
	done
	for f in `find ${DESTDIR}${prefix}/lib64 -name 'libffi.a' -o -name 'libffi.la' -o -name 'libffi.so' -o -name 'libffi.so.?'`; do
		ln -fsv ../lib64/`basename ${f}` ${DESTDIR}${prefix}/lib || return
	done
	update_path || return
}

install_native_libiconv()
{
	[ -x ${prefix}/bin/iconv -a "${force_install}" != yes ] && return
	fetch libiconv || return
	unpack libiconv || return
	[ -f ${libiconv_bld_dir}/Makefile ] ||
		(cd ${libiconv_bld_dir}
		${libiconv_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-static) || return
	make -C ${libiconv_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libiconv_bld_dir} -j ${jobs} -k check || return
	make -C ${libiconv_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
	[ -z "${strip}" ] && return
	for l in libcharset libiconv; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
	done
}

install_native_pcre()
{
	[ -f ${prefix}/include/pcre.h -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	fetch pcre || return
	unpack pcre || return
	[ -f ${pcre_bld_dir}/Makefile ] ||
		(cd ${pcre_bld_dir}
		${pcre_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--enable-pcre16 --enable-pcre32 --enable-jit --enable-utf --enable-unicode-properties \
			--enable-newline-is-any --enable-pcregrep-libz --enable-pcregrep-libbz2 \
			--enable-pcretest-libreadline CPPFLAGS="${CPPFLAGS} `I zlib.h bzlib.h`" \
			LDFLAGS="${LDFLAGS} `L z bz2`") || return
	make -C ${pcre_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pcre_bld_dir} -j ${jobs} -k check || return
	make -C ${pcre_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_glib()
{
	[ -f ${prefix}/include/glib-2.0/glib.h -a "${force_install}" != yes ] && return
	print_header_path iconv.h > /dev/null || install_native_libiconv || return
	print_header_path ffi.h > /dev/null || install_native_libffi || return
	print_header_path pcre.h > /dev/null || install_native_pcre || return
	which meson > /dev/null || install_native_meson || return
	fetch glib || return
	unpack glib || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both \
		-Diconv=auto -Dc_args="${CFLAGS} -DLIBICONV_PLUG" ${glib_src_dir} ${glib_bld_dir} || return
	ninja -v -C ${glib_bld_dir} || return
	ninja -v -C ${glib_bld_dir} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in gapplication gdbus gio gio-launch-desktop gio-querymodules glib-compile-resources glib-compile-schemas gobject-query gresource gsettings gtester; do
		[ -f ${DESTDIR}${prefix}/bin/${b} ] || continue
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_pkg_config()
{
	[ -x ${prefix}/bin/pkg-config -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	fetch pkg-config || return
	unpack pkg-config || return
	[ -f ${pkg_config_bld_dir}/Makefile ] ||
		(cd ${pkg_config_bld_dir}
		${pkg_config_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			GLIB_CFLAGS="`I glib.h` -I`print_library_dir libglib-2.0.so`/glib-2.0/include" \
			GLIB_LIBS="`l glib-2.0`") || return
	make -C ${pkg_config_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pkg_config_bld_dir} -j ${jobs} -k check || return
	make -C ${pkg_config_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_help2man()
{
	[ -x ${prefix}/bin/help2man -a "${force_install}" != yes ] && return
	fetch help2man || return
	unpack help2man || return
	[ -f ${help2man_bld_dir}/Makefile ] ||
		(cd ${help2man_bld_dir}
		${help2man_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${help2man_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${help2man_bld_dir} -j ${jobs} -k check || return
	make -C ${help2man_bld_dir} -j ${jobs} install || return
}

install_native_texinfo()
{
	[ -x ${prefix}/bin/makeinfo -a "${force_install}" != yes ] && return
	fetch texinfo || return
	unpack texinfo || return
	[ -f ${texinfo_bld_dir}/Makefile ] ||
		(cd ${texinfo_bld_dir}
		${texinfo_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-rpath) || return
	make -C ${texinfo_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${texinfo_bld_dir} -j ${jobs} -k check || return
	make -C ${texinfo_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_coreutils()
{
	[ -x ${prefix}/bin/cat -a "${force_install}" != yes ] && return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	fetch coreutils || return
	unpack coreutils || return
	[ -f ${coreutils_bld_dir}/Makefile ] ||
		(cd ${coreutils_bld_dir}
		FORCE_UNSAFE_CONFIGURE=1 ${coreutils_src_dir}/configure --prefix=${prefix} \
			--build=${build} --host=${host} --disable-silent-rules --enable-threads) || return
	make -C ${coreutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${coreutils_bld_dir} -j ${jobs} -k check || return
	make -C ${coreutils_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_busybox()
{
	[ -x ${prefix}/busybox/bin/busybox -a "${force_install}" != yes ] && return
	fetch busybox || return
	unpack busybox || return
	make -C ${busybox_src_dir} -j ${jobs} V=1 O=${busybox_bld_dir} defconfig || return
	make -C ${busybox_bld_dir} -j ${jobs} V=1 || return
	make -C ${busybox_bld_dir} -j ${jobs} CONFIG_PREFIX=${DESTDIR}${prefix}/busybox install || return
}

install_native_bison()
{
	[ -x ${prefix}/bin/bison -a "${force_install}" != yes ] && return
	fetch bison || return
	unpack bison || return
	[ -f ${bison_bld_dir}/Makefile ] ||
		(cd ${bison_bld_dir}
		${bison_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules --disable-rpath --enable-relocatable) || return
	make -C ${bison_bld_dir} -j ${jobs} || return
	make -C ${bison_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_flex()
{
	[ -x ${prefix}/bin/flex -a "${force_install}" != yes ] && return
	which yacc > /dev/null || install_native_bison || return
	fetch flex || return
	unpack flex || return
	[ -f ${flex_bld_dir}/Makefile ] ||
		(cd ${flex_bld_dir}
		${flex_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${flex_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${flex_bld_dir} -j ${jobs} -k check || return
	make -C ${flex_bld_dir} -j ${jobs} install${strip:+-${strip}} install-man || return
	update_path || return
}

install_native_m4()
{
	[ -x ${prefix}/bin/m4 -a "${force_install}" != yes ] && return
	fetch m4 || return
	unpack m4 || return
	[ -f ${m4_bld_dir}/Makefile ] ||
		(cd ${m4_bld_dir}
		${m4_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-c++ --enable-changeword) || return
	make -C ${m4_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${m4_bld_dir} -j ${jobs} -k check || return
	make -C ${m4_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_autoconf()
{
	[ -x ${prefix}/bin/autoconf -a "${force_install}" != yes ] && return
	fetch autoconf || return
	unpack autoconf || return
	[ -f ${autoconf_bld_dir}/Makefile ] ||
		(cd ${autoconf_bld_dir}
		${autoconf_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${autoconf_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${autoconf_bld_dir} -j ${jobs} -k check || return
	make -C ${autoconf_bld_dir} -j ${jobs} install || return
}

install_native_autoconf_archive()
{
	[ -f ${prefix}/share/aclocal/ax_cxx_bool.m4 -a "${force_install}" != yes ] && return
	fetch autoconf-archive || return
	unpack autoconf-archive || return
	[ -f ${autoconf_archive_bld_dir}/Makefile ] ||
		(cd ${autoconf_archive_bld_dir}
		${autoconf_archive_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${autoconf_archive_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${autoconf_archive_bld_dir} -j ${jobs} -k check || return
	make -C ${autoconf_archive_bld_dir} -j ${jobs} install || return
}

install_native_automake()
{
	[ -x ${prefix}/bin/automake -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	fetch automake || return
	unpack automake || return
	[ -f ${automake_bld_dir}/Makefile ] ||
		(cd ${automake_bld_dir}
		${automake_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${automake_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${automake_bld_dir} -j ${jobs} -k check || return
	make -C ${automake_bld_dir} -j ${jobs} install || return
}

install_native_autogen()
{
	[ -x ${prefix}/bin/autogen -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	print_header_path libguile.h > /dev/null || install_native_guile || return
	fetch autogen || return
	unpack autogen || return
	sed -i -e '/^  \<_guile_versions_to_search\>/s/\[2.2/['`print_version guile`' 2.2/' ${autogen_src_dir}/config/guile.m4 || return
	sed -i -e '/^#elif GUILE_VERSION </s!$! || 1 /* workaround */!' ${autogen_src_dir}/agen5/guile-iface.h || return
	autoreconf -fiv ${autogen_src_dir} || return
	[ -f ${autogen_bld_dir}/Makefile ] ||
		(cd ${autogen_bld_dir}
		${autogen_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--disable-rpath --disable-dependency-tracking \
			CFLAGS="${CFLAGS} -Wno-error") || return
	make -C ${autogen_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${autogen_bld_dir} -j ${jobs} -k check || return
	make -C ${autogen_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	for b in autogen columns getdefs xml2ag; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_libtool()
{
	[ -x ${prefix}/bin/libtool -a "${force_install}" != yes ] && return
	which flex > /dev/null || install_native_flex || return
	fetch libtool || return
	unpack libtool || return
	[ -f ${libtool_bld_dir}/Makefile ] ||
		(cd ${libtool_bld_dir}
		${libtool_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libtool_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libtool_bld_dir} -j ${jobs} -k check || return
	make -C ${libtool_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libltdl.so || return
}

install_native_sed()
{
	[ -x ${prefix}/bin/sed -a "${force_install}" != yes ] && return
	fetch sed || return
	unpack sed || return
	[ -f ${sed_bld_dir}/Makefile ] ||
		(cd ${sed_bld_dir}
		${sed_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${sed_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${sed_bld_dir} -j ${jobs} -k check || return
	make -C ${sed_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_gawk()
{
	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	fetch gawk || return
	unpack gawk || return
	[ -f ${gawk_bld_dir}/Makefile ] ||
		(cd ${gawk_bld_dir}
		${gawk_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-static \
			--with-readline=`print_prefix readline.h readline` \
			--with-mpfr=`print_prefix mpfr.h`) || return
	make -C ${gawk_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gawk_bld_dir} -j ${jobs} -k check || return
	make -C ${gawk_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_make()
{
	[ -x ${prefix}/bin/make -a "${force_install}" != yes ] && return
	print_header_path libguile.h > /dev/null || install_native_guile || return
	fetch make || return
	unpack make || return
	[ -f ${make_bld_dir}/Makefile ] ||
		(cd ${make_bld_dir}
		${make_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--with-guile) || return
	make -C ${make_bld_dir} -j ${jobs} MAKE_MAINTAINER_MODE= || return
	[ "${enable_check}" != yes ] ||
		make -C ${make_bld_dir} -j ${jobs} -k check || return
	make -C ${make_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_binutils()
{
	[ -x ${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	fetch binutils || return
	unpack binutils || return
	[ -f ${binutils_bld_dir}/Makefile ] ||
		(cd ${binutils_bld_dir}
		${binutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --target=${target} \
			--enable-shared --enable-gold --enable-threads --enable-plugins \
			`echo ${target} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' || echo --enable-compressed-debug-sections=all` \
			--enable-targets=all --enable-64-bit-bfd \
			`check_platform ${build} ${host} ${target} | grep -qe '\<native\>' || echo --with-sysroot=${sysroot}` \
			--with-system-zlib --with-debuginfod \
			CFLAGS="${CFLAGS} `I zlib.h`" CXXFLAGS="${CXXFLAGS} `I zlib.h`" \
			LDFLAGS="${LDFLAGS} `L z`" \
			host_configargs=--enable-install-libiberty) || return
	make -C ${binutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${binutils_bld_dir} -j ${jobs} -k check || return
	source_path -f || return
	make -C ${binutils_bld_dir} -j 1 install${strip:+-${strip}} || return
	update_path || return
	for b in addr2line ar as c++filt coffdump dlltool dllwrap dwp \
		elfedit gprof ld ld.bfd ld.gold nm objcopy objdump ranlib \
		readelf size srconv strings strip sysdump windmc windres; do
		[ -f ${DESTDIR}${prefix}/bin/${target}-${b} ] && continue
		ln -fsv ${b} ${DESTDIR}${prefix}/bin/${target}-${b} || return
	done
}

install_native_elfutils()
{
	[ -x ${prefix}/bin/eu-addr2line -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	print_header_path curl.h curl > /dev/null || install_native_curl || return
	fetch elfutils || return
	unpack elfutils || return
	[ -f ${elfutils_bld_dir}/Makefile ] ||
		(cd ${elfutils_bld_dir}
		${elfutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--enable-libdebuginfod --disable-debuginfod \
			CFLAGS="${CFLAGS} `I zlib.h`" \
			LDFLAGS="${LDFLAGS} `l z bz2 lzma zstd`" \
			libcurl_CFLAGS=`I curl/curl.h` \
			libcurl_LIBS="`l curl`") || return
	make -C ${elfutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${elfutils_bld_dir} -j ${jobs} -k check || return
	make -C ${elfutils_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_systemtap()
{
	[ -x ${prefix}/bin/stap -a "${force_install}" != yes ] && return
	which cpio > /dev/null || install_native_cpio || return
	print_header_path sqlite3.h > /dev/null || install_native_sqlite || return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	fetch systemtap || return
	unpack systemtap || return
	[ -f ${systemtap_bld_dir}/Makefile ] ||
		(cd ${systemtap_bld_dir}
		${systemtap_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--without-python2-probes \
			CPPFLAGS="${CPPFLAGS} `I sqlite3.h`" \
			LDFLAGS="${LDFLAGS} `L sqlite3`" \
			) || return
	make -C ${systemtap_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${systemtap_bld_dir} -j ${jobs} -k check || return
	make -C ${systemtap_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_ed()
{
	[ -x ${prefix}/bin/ed -a "${force_install}" != yes ] && return
	fetch ed || return
	unpack ed || return
	[ -f ${ed_bld_dir}/Makefile ] ||
		(cd ${ed_bld_dir}
		${ed_src_dir}/configure --prefix=${prefix} CC=${CC:-${host:+${host}-}gcc}) || return
	make -C ${ed_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${ed_bld_dir} -j ${jobs} -k check || return
	make -C ${ed_bld_dir} -j 1 install${strip:+-${strip}} || return
}

install_native_bc()
{
	[ -x ${prefix}/bin/bc -a "${force_install}" != yes ] && return
	which ed > /dev/null || install_native_ed || return
	fetch bc || return
	unpack bc || return
	[ -f ${bc_bld_dir}/Makefile ] ||
		(cd ${bc_bld_dir}
		${bc_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules --with-readline) || return
	make -C ${bc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${bc_bld_dir} -j ${jobs} -k check || return
	make -C ${bc_bld_dir} -j 1 install${strip:+-${strip}} || return
}

install_native_rsync()
{
	[ -x ${prefix}/bin/rsync -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path popt.h > /dev/null || install_native_popt || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	print_header_path lz4.h > /dev/null || install_native_lz4 || return
	fetch rsync || return
	unpack rsync || return
	[ -f ${rsync_bld_dir}/Makefile ] ||
		(cd ${rsync_bld_dir}
		${rsync_src_dir}/configure --prefix=${prefix} --host=${host} --without-included-zlib \
			--disable-xxhash \
			CFLAGS="${CFLAGS} `I zstd.h lz4.h`" \
			CPPFLAGS="${CFLAGS} `I openssl/ssl.h`" \
			LDFLAGS="${LDFLAGS} `L ssl zstd lz4`") || return
	make -C ${rsync_bld_dir} -j ${jobs} || return
	make -C ${rsync_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_linux_header()
{
	fetch linux || return
	unpack linux || return
	make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} mrproper || return
	make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} \
		ARCH=${linux_arch} INSTALL_HDR_PATH=${DESTDIR}${prefix} headers_install || return
}

install_native_perf()
{
	[ -x ${prefix}/bin/perf -a "${force_install}" != yes ] && return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path babeltrace.h babeltrace > /dev/null || install_native_babeltrace || return
	print_header_path bpf.h bpf > /dev/null || install_native_libbpf || return
	print_header_path capability.h sys > /dev/null || install_native_libcap || return
	print_header_path numaif.h > /dev/null || install_native_numactl || return
	print_header_path ocsd_if_version.h opencsd > /dev/null || install_native_OpenCSD || return
	print_header_path libunwind.h > /dev/null || install_native_libunwindnongnu || return
	print_header_path pfmlib.h perfmon > /dev/null || install_native_libpfm || return
	print_header_path kbuffer.h traceevent > /dev/null || install_native_libtraceevent || return
	print_header_path tracefs.h tracefs > /dev/null || install_native_libtracefs || return
	fetch linux || return
	unpack linux || return
	mkdir -pv ${perf_bld_dir} || return
	make -C ${linux_src_dir}/tools/perf -j ${jobs} V=1 VF=1 W=1 O=${perf_bld_dir} \
		ARCH=${linux_arch} CROSS_COMPILE=${host:+${host}-} \
		EXTRA_CFLAGS="${CFLAGS} `I libelf.h event-parse.h` `L elf`" \
		EXTRA_CXXFLAGS="${CXXFLAGS} `idirafter libelf.h` `L elf bpf`" \
		LDFLAGS="${LDFLAGS} `l babeltrace popt elf bz2 lzma z curl zstd`" \
		NO_LIBPERL=1 NO_LIBPYTHON=1 WERROR=0 NO_SLANG=1 CORESIGHT=1 LIBPFM4=1 \
		LIBTRACEEVENT_DYNAMIC=1 LIBTRACEFS_DYNAMIC=1 \
		prefix=${prefix} all || return
	make -C ${linux_src_dir}/tools/perf -j ${jobs} V=1 VF=1 W=1 O=${perf_bld_dir} \
		ARCH=${linux_arch} CROSS_COMPILE=${host:+${host}-} \
		EXTRA_CFLAGS="${CFLAGS} `I libelf.h event-parse.h` `L elf`" \
		EXTRA_CXXFLAGS="${CXXFLAGS} `idirafter libelf.h` `L elf bpf`" \
		LDFLAGS="${LDFLAGS} `l babeltrace popt elf bz2 lzma z curl zstd`" \
		NO_LIBPERL=1 NO_LIBPYTHON=1 WERROR=0 NO_SLANG=1 CORESIGHT=1 LIBPFM4=1 \
		LIBTRACEEVENT_DYNAMIC=1 LIBTRACEFS_DYNAMIC=1 \
		prefix=${prefix} DESTDIR=${DESTDIR} install || return
}

install_native_libcap()
{
	[ -x ${prefix}/sbin/getcap -a "${force_install}" != yes ] && return
	fetch libcap || return
	unpack libcap || return
	[ -f ${libcap_bld_dir}/Makefile ] || cp -Tvr ${libcap_src_dir} ${libcap_bld_dir} || return
	make -C ${libcap_bld_dir} -j ${jobs} prefix=${prefix} lib=lib CROSS_COMPILE=${host:+${host}-} BUILD_CC=${CC:-gcc} GOLANG=no || return
	[ "${enable_check}" != yes ] ||
		make -C ${libcap_bld_dir} -j ${jobs} -k CROSS_COMPILE=${host:+${host}-} test || return
	make -C ${libcap_bld_dir} -j ${jobs} prefix=${prefix} lib=lib CROSS_COMPILE=${host:+${host}-} BUILD_CC=${CC:-gcc} GOLANG=no DESTDIR=${DESTDIR} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in capsh getcap getpcaps setcap; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/sbin/${b} || return
	done
	for l in libcap.so libpsx.so; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l} || return
	done
}

install_native_numactl()
{
	[ -x ${prefix}/bin/numactl -a "${force_install}" != yes ] && return
	fetch numactl || return
	unpack numactl || return
	[ -f ${numactl_src_dir}/configure ] || autoreconf -fiv ${numactl_src_dir} || return
	[ -f ${numactl_bld_dir}/Makefile ] ||
		(cd ${numactl_bld_dir}
		remove_rpath_option numactl || return
		${numactl_src_dir}/configure --prefix=${prefix} --host=${host}) || return
	make -C ${numactl_bld_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${numactl_bld_dir} -j ${jobs} -k check V=1 || return
	make -C ${numactl_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_OpenCSD()
{
	[ -f ${prefix}/include/opencsd/ocsd_if_version.h -a "${force_install}" != yes ] && return
	fetch OpenCSD || return
	unpack OpenCSD || return
	[ -f ${OpenCSD_bld_dir}/README.md ] || cp -Tvr ${OpenCSD_src_dir} ${OpenCSD_bld_dir} || return
	make -C ${OpenCSD_bld_dir}/decoder/build/linux -j ${jobs} CROSS_COMPILE=${host:+${host}-} || return
	make -C ${OpenCSD_bld_dir}/decoder/build/linux -j ${jobs} PREFIX=${prefix} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/trc_pkt_lister || return
	for l in libopencsd.so libopencsd_c_api.so; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l} || return
	done
}

install_native_libunwindnongnu()
{
	[ -f ${prefix}/include/libunwind.h -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	fetch libunwindnongnu || return
	unpack libunwindnongnu || return
	[ -f ${libunwindnongnu_bld_dir}/Makefile ] ||
		(cd ${libunwindnongnu_bld_dir}
		remove_rpath_option libunwindnongnu || return
		${libunwindnongnu_src_dir}/configure --prefix=${prefix} --host=${host} \
			--enable-coredump --enable-ptrace --enable-setjmp \
			--enable-cxx-exceptions --enable-debug-frame \
			--enable-minidebuginfo --enable-zlibdebuginfo \
			LDFLAGS="${LDFLAGS} -Wl,-rpath-link,${libunwindnongnu_bld_dir}/src/.libs" \
			|| return
		remove_rpath_option libunwindnongnu || return
		) || return
	make -C ${libunwindnongnu_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libunwindnongnu_bld_dir} -j ${jobs} -k check || return
	make -C ${libunwindnongnu_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libpfm()
{
	[ -f ${prefix}/include/perfmon/pfmlib.h -a "${force_install}" != yes ] && return
	fetch libpfm || return
	unpack libpfm || return
	[ -f ${libpfm_bld_dir}/Makefile ] || cp -Tvr ${libpfm_src_dir} ${libpfm_bld_dir} || return
	sed -i -e '/^DIRS=/s/\<tests\>//' ${libpfm_bld_dir}/Makefile || return
	sed -i -e '/^ARCH :=/s/\$(shell uname -m)/'${linux_arch}'/' ${libpfm_bld_dir}/config.mk || return
	make -C ${libpfm_bld_dir} -j ${jobs} PREFIX=${prefix} CC=${CC:-${host:+${host}-}gcc} || return
	make -C ${libpfm_bld_dir} -j ${jobs} PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libpfm.so || return
}

install_native_libbpf()
{
	[ -f ${prefix}/include/bpf/bpf.h -a "${force_install}" != yes ] && return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	fetch libbpf || return
	unpack libbpf || return
	make -C ${libbpf_src_dir}/src -j ${jobs} V=1 OBJDIR=${libbpf_bld_dir} CC="${CC:-${host:+${host}-}gcc}" PREFIX=${prefix} || return
	make -C ${libbpf_src_dir}/src -j ${jobs} V=1 OBJDIR=${libbpf_bld_dir} CC="${CC:-${host:+${host}-}gcc}" PREFIX=${prefix} DESTDIR=${DESTDIR} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for l in lib/libbpf.a lib/libbpf.so lib64/libbpf.a lib64/libbpf.so; do
		[ -f ${DESTDIR}${prefix}/${l} ] || continue
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/${l} || return
	done
}

install_native_bcc()
{
	[ -f ${prefix}/include/bcc/bcc_version.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path FlexLexer.h > /dev/null || install_native_flex || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	print_header_path Version.h clang/Basic > /dev/null || install_native_clang || return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	print_header_path bfd.h > /dev/null || install_native_binutils || return
	which python3 > /dev/null || install_native_Python || return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch bcc || return
	unpack bcc || return
	sed -i -e '/--install-layout/s/^ /#&/' ${bcc_src_dir}/src/python/CMakeLists.txt || return
	fetch libbpf || return
	unpack libbpf || return
	[ -f ${bcc_src_dir}/src/cc/libbpf/README.md ] || cp -Tvr ${libbpf_src_dir} ${bcc_src_dir}/src/cc/libbpf || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${bcc_src_dir} -B ${bcc_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DCMAKE_C_FLAGS="${CFLAGS} `L z`" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} `Wl_rpath_link z tinfo`" \
		-DENABLE_LLVM_SHARED=ON \
		-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
		-DPYTHON_CMD=python3 \
		-DFLEX_INCLUDE_DIRS=`print_header_dir FlexLexer.h` \
		-DFLEX_LIBRARIES=`print_library_path libfl.so` \
		-DLIBELF_INCLUDE_DIRS=`print_header_dir libelf.h` \
		|| return
	cmake --build ${bcc_bld_dir} -v -j 1 || return # don't run parallel build to avoid out of memory.
	cmake --install ${bcc_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_cereal()
{
	[ -f ${prefix}/include/cereal/version.hpp -a "${force_install}" != yes ] && return
	fetch cereal || return
	unpack cereal || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${cereal_src_dir} -B ${cereal_bld_dir} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DTHREAD_SAFE=ON \
		-DJUST_INSTALL_CEREAL=ON \
		|| return
	cmake --build ${cereal_bld_dir} -v -j ${jobs} || return
	cmake --install ${cereal_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_bpftrace()
{
	[ -x ${prefix}/bin/bpftrace -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path FlexLexer.h > /dev/null || install_native_flex || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	print_header_path Version.h clang/Basic > /dev/null || install_native_clang || return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	print_header_path bfd.h > /dev/null || install_native_binutils || return
	print_header_path bcc_version.h bcc > /dev/null || install_native_bcc || return
	print_header_path version.hpp cereal > /dev/null || install_native_cereal || return
	fetch bpftrace || return
	unpack bpftrace || return
	sed -i -e 's/\(set(CMAKE_REQUIRED_LIBRARIES bcc\)\()\)/\1 tinfo\2/' ${bpftrace_src_dir}/CMakeLists.txt || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${bpftrace_src_dir} -B ${bpftrace_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DCMAKE_C_FLAGS="${CFLAGS} `Wl_rpath_link debuginfod`" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} `I bfd.h libz.h` `I bcc/compat/linux/bpf.h`/bcc/compat `Wl_rpath_link debuginfod curl zstd tinfo`" \
		-DENABLE_MAN=OFF \
		-DBUILD_TESTING=OFF \
		-DKERNEL_INCLUDE_DIRS=`print_header_dir bpf.h bcc/compat/linux`/bcc/compat \
		-DLIBBCC_INCLUDE_DIRS=`print_header_dir bcc_version.h bcc` \
		-DLIBBCC_LIBRARIES=`print_library_path libbcc.so` \
		-DLIBBFD_INCLUDE_DIRS=`print_header_dir bfd.h` \
		-DLIBBFD_LIBRARIES=`print_library_path libbfd.so` \
		-DLIBBPF_INCLUDE_DIRS=`print_header_dir libbpf.h bpf` \
		-DLIBBPF_LIBRARIES=`print_library_path libbpf.so` \
		-DLIBDW_INCLUDE_DIRS=`print_header_dir libdw.h elfutils.h` \
		-DLIBDW_LIBRARIES=`print_library_path libdw.so` \
		-DLIBELF_INCLUDE_DIRS=`print_header_dir libelf.h` \
		-DLIBELF_LIBRARIES=`print_library_path libelf.so` \
		-DLIBOPCODES_INCLUDE_DIRS=`print_header_dir dis-asm.h` \
		-DLIBOPCODES_LIBRARIES=`print_library_path libopcodes.so` \
		-DLIBZ_LIBRARIES=`print_library_path libz.so` \
		-DLLVM_DIR=`print_library_dir LLVMConfig.cmake` \
		-DClang_DIR=`print_library_dir ClangConfig.cmake` \
		|| return
	cmake --build ${bpftrace_bld_dir} -v -j ${jobs} || return
	cmake --install ${bpftrace_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_libtraceevent()
{
	[ -f ${prefix}/include/traceevent/kbuffer.h -a "${force_install}" != yes ] && return
	fetch libtraceevent || return
	unpack libtraceevent || return
	make -C ${libtraceevent_src_dir} -j ${jobs} V=1 O=${libtraceevent_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		pkgconfig_dir=${prefix}/lib/pkgconfig || return
	make -C ${libtraceevent_src_dir} -j ${jobs} V=1 O=${libtraceevent_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		pkgconfig_dir=${prefix}/lib/pkgconfig install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib64/libtraceevent.so || return
}

install_native_libtracefs()
{
	[ -f ${prefix}/include/tracefs/tracefs.h -a "${force_install}" != yes ] && return
	print_header_path kbuffer.h traceevent > /dev/null || install_native_libtraceevent || return
	fetch libtracefs || return
	unpack libtracefs || return
	sed -i -e 's/,-rpath=\$\$ORIGIN//' ${libtracefs_src_dir}/scripts/utils.mk || return
	make -C ${libtracefs_src_dir} -j ${jobs} V=1 O=${libtracefs_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		pkgconfig_dir=${prefix}/lib/pkgconfig etcdir=${prefix}/etc || return
	make -C ${libtracefs_src_dir} -j ${jobs} V=1 O=${libtracefs_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		pkgconfig_dir=${prefix}/lib/pkgconfig etcdir=${prefix}/etc install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib64/libtracefs.so || return
}

install_native_trace_cmd()
{
	[ -x ${prefix}/bin/trace-cmd -a "${force_install}" != yes ] && return
	print_header_path kbuffer.h traceevent > /dev/null || install_native_libtraceevent || return
	print_header_path tracefs.h tracefs > /dev/null || install_native_libtracefs || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	fetch trace-cmd || return
	unpack trace-cmd || return
	sed -i -e 's/ -Wl,-rpath=\$(libdir)//' ${trace_cmd_src_dir}/scripts/utils.mk || return
	make -C ${trace_cmd_src_dir} -j ${jobs} V=1 O=${trace_cmd_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		etcdir=${prefix}/etc || return
	make -C ${trace_cmd_src_dir} -j ${jobs} V=1 O=${trace_cmd_bld_dir} \
		CROSS_COMPILE=${host:+${host}-} DESTDIR=${DESTDIR} prefix=${prefix} \
		etcdir=${prefix}/etc install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/trace-cmd || return
}

install_native_kmod()
{
	[ -x ${prefix}/bin/kmod -a "${force_install}" != yes ] && return
	fetch kmod || return
	unpack kmod || return
	[ -f ${kmod_bld_dir}/Makefile ] ||
		(cd ${kmod_bld_dir}
		${kmod_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--enable-python --with-xz --with-zlib --with-openssl) || return
	make -C ${kmod_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${kmod_bld_dir} -j ${jobs} -k check || return
	make -C ${kmod_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	for f in depmod insmod lsmod modinfo modprobe rmmod; do
		ln -fsv kmod ${DESTDIR}${prefix}/bin/${f} || return
	done
	update_path || return
}

install_native_dtc()
{
	[ -x ${prefix}/bin/dtc -a "${force_install}" != yes ] && return
	which swig > /dev/null || install_native_swig || return
	which bison > /dev/null || install_native_bison || return
	which flex > /dev/null || install_native_flex || return
	fetch dtc || return
	unpack dtc || return
	[ -f ${dtc_bld_dir}/Makefile ] || cp -Tvr ${dtc_src_dir} ${dtc_bld_dir} || return
	(export EXTRA_CFLAGS="${CFLAGS} -Wno-error"; unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1) || return # XXX work around for parallel make
	(export EXTRA_CFLAGS="${CFLAGS} -Wno-error"; unset CFLAGS; make -C ${dtc_bld_dir} -j 1 V=1 PREFIX=${DESTDIR}${prefix} install) || return # XXX work around for parallel make
	[ -z "${strip}" ] && return
	for b in convert-dtsv0 dtc fdtdump fdtget fdtoverlay fdtput; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libfdt-`print_version dtc`.0.so || return
}

install_native_u_boot()
{
	[ -x ${prefix}/bin/mkimage -a "${force_install}" != yes ] && return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	fetch u-boot || return
	unpack u-boot || return
	[ -f ${u_boot_bld_dir}/Makefile ] || cp -Tvr ${u_boot_src_dir} ${u_boot_bld_dir} || return
	[ -f ${u_boot_bld_dir}/.config ] ||
		make -C ${u_boot_bld_dir} -j ${jobs} V=1 sandbox_defconfig || return
	make -C ${u_boot_bld_dir} -j ${jobs} V=1 NO_SDL=1 tools || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	find ${u_boot_bld_dir}/tools -maxdepth 1 -type f -perm /100 -exec install -vt ${DESTDIR}${prefix}/bin {} + || return
}

install_native_qemu()
{
	[ -x ${prefix}/bin/qemu-img -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	print_header_path pixman.h pixman-1.0 > /dev/null || install_native_pixman || return
	fetch qemu || return
	unpack qemu || return
	(cd ${qemu_src_dir}
	./configure --prefix=${prefix} --cc=${CC:-${host:+${host}-}gcc} --host-cc=${CC:-${host:+${host}-}gcc} --cxx=${CXX:-${host:+${host}-}g++} \
		--extra-cflags=`I zlib.h` --extra-ldflags=`L z`) || return
	make -C ${qemu_src_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${qemu_src_dir} -j ${jobs} -k test || return
	make -C ${qemu_src_dir} -j ${jobs} install || return
}

install_native_gperf()
{
	[ -x ${prefix}/bin/gperf -a "${force_install}" != yes ] && return
	fetch gperf || return
	unpack gperf || return
	[ -f ${gperf_bld_dir}/Makefile ] ||
		(cd ${gperf_bld_dir}
		${gperf_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${gperf_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gperf_bld_dir} -j ${jobs} -k check || return
	make -C ${gperf_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/gperf || return
}

install_native_glibc()
{
	[ -e ${prefix}/lib/libc.so -a "${force_install}" != yes ] && return
	install_native_linux_header || return
	which gawk > /dev/null || install_native_gawk || return
	which gperf > /dev/null || install_native_gperf || return
	fetch glibc || return
	unpack glibc || return
	[ -f ${glibc_bld_dir}/Makefile ] ||
		(cd ${glibc_bld_dir}
		LD_LIBRARY_PATH='' ${glibc_src_dir}/configure \
			--prefix=${prefix} --build=${build} \
			--with-headers=${DESTDIR}${prefix}/include --without-selinux --enable-add-ons \
			CPPFLAGS="${CPPFLAGS} -I${prefix}/include -D_LIBC") || return
	make -C ${glibc_bld_dir} -j ${jobs} install-headers || return
	make -C ${glibc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${glibc_bld_dir} -j ${jobs} -k check || return
	make -C ${glibc_bld_dir} -j ${jobs} install || return
	make -C ${glibc_bld_dir} -j ${jobs} localedata/install-locales || return
	update_path || return
}

install_native_gmp()
{
	[ -f ${prefix}/include/gmp.h -a "${force_install}" != yes ] && return
	which m4 > /dev/null || install_native_m4 || return
	fetch gmp || return
	unpack gmp || return
	[ -f ${gmp_bld_dir}/Makefile ] ||
		(cd ${gmp_bld_dir}
		${gmp_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-cxx) || return
	make -C ${gmp_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gmp_bld_dir} -j ${jobs} -k check || return
	make -C ${gmp_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_mpfr()
{
	[ -f ${prefix}/include/mpfr.h -a "${force_install}" != yes ] && return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	fetch mpfr || return
	unpack mpfr || return
	[ -f ${mpfr_bld_dir}/Makefile ] ||
		(cd ${mpfr_bld_dir}
		echo ${host} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' && enable_static_disable_shared='--enable-static --disable-shared' || enable_static_disable_shared=''
		${mpfr_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--with-gmp=`print_prefix gmp.h` ${enable_static_disable_shared}) || return
	make -C ${mpfr_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpfr_bld_dir} -j ${jobs} -k check || return
	make -C ${mpfr_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
	sed -i -e /^dependency_libs=/s/\'.\*\'\$/\'\'/ ${DESTDIR}${prefix}/lib/libmpfr.la || return
	# [XXX] mpcビルド時に、mpfrが依存しているgmpを参照しようとしてlibmpfr.laの不整合に
	#       引っかからないようにするために、強行的にlibmpfr.la書き換えてる。
}

install_native_mpc()
{
	[ -f ${prefix}/include/mpc.h -a "${force_install}" != yes ] && return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	fetch mpc || return
	unpack mpc || return
	[ -f ${mpc_bld_dir}/Makefile ] ||
		(cd ${mpc_bld_dir}
		echo ${host} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' && enable_static_disable_shared='--enable-static --disable-shared' || enable_static_disable_shared=''
		${mpc_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h` ${enable_static_disable_shared}) || return
	make -C ${mpc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mpc_bld_dir} -j ${jobs} -k check || return
	make -C ${mpc_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_isl()
{
	[ -f ${prefix}/include/isl/version.h -a "${force_install}" != yes ] && return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	fetch isl || return
	unpack isl || return
	[ -f ${isl_bld_dir}/Makefile ] ||
		(cd ${isl_bld_dir}
		${isl_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--with-gmp-prefix=`print_prefix gmp.h` \
			LDFLAGS="${LDFLAGS} `L z`" LIBS=-lgmp) || return
	make -C ${isl_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${isl_bld_dir} -j ${jobs} -k check || return
	make -C ${isl_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_gcc()
{
	[ -x ${prefix}/bin/gcc -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	print_header_path mpc.h > /dev/null || install_native_mpc || return
	print_header_path version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	which makeinfo > /dev/null || install_native_texinfo || return
	fetch gcc || return
	unpack gcc || return
	gcc_base_ver=`cat ${gcc_src_dir}/gcc/BASE-VER` || return
	[ -f ${gcc_bld_dir}/Makefile ] ||
		(cd ${gcc_bld_dir}
		${gcc_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --target=${target} \
			--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h` --with-mpc=`print_prefix mpc.h` \
			--with-isl=`print_prefix version.h isl` --with-system-zlib \
			--enable-languages=${languages} --disable-multilib --enable-linker-build-id --enable-libstdcxx-debug \
			--program-suffix=-${gcc_base_ver} --enable-version-specific-runtime-libs \
		) || return
	make -C ${gcc_bld_dir} -j ${jobs} CPPFLAGS="${CPPFLAGS} -DLIBICONV_PLUG" CPPFLAGS_FOR_TARGET="${CPPFLAGS} -DLIBICONV_PLUG" || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	[ -f ${gcc_bld_dir}/gcc/xg++ -a "${force_install}" = yes ] &&
		which doxygen > /dev/null && make -C ${gcc_bld_dir}/${target}/libstdc++-v3 -j ${jobs} install-man
	ln -fsv gcc ${DESTDIR}${prefix}/bin/cc || return
	[ ! -f ${DESTDIR}${prefix}/bin/${target}-gcc-tmp ] || rm -v ${DESTDIR}${prefix}/bin/${target}-gcc-tmp || return
	for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool gfortran go gofmt; do
		[ -f ${DESTDIR}${prefix}/bin/${b}-${gcc_base_ver} ] || continue
		ln -fsv ${b}-${gcc_base_ver} ${DESTDIR}${prefix}/bin/${b} || return
		ln -fsv ${b} ${DESTDIR}${prefix}/bin/${target}-${b} || return
		ln -fsv ${b}-${gcc_base_ver}.1 ${DESTDIR}${prefix}/share/man/man1/${b}.1 || return
	done
	for l in libgcc_s.so libgcc_s.so.1; do
		[ -f ${DESTDIR}${prefix}/lib/gcc/${target}/${gcc_base_ver}/${l} ] ||
			ln -fsv ../lib64/${l} ${DESTDIR}${prefix}/lib/gcc/${target}/${gcc_base_ver} || return # XXX work around for --enable-version-specific-runtime-libs
	done
	update_path || return
}

install_native_readline()
{
	[ -f ${prefix}/include/readline/readline.h -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch readline || return
	unpack readline || return
	[ -f ${readline_bld_dir}/Makefile ] ||
		(cd ${readline_bld_dir}
		sed -i -e 's/\(-Wl,\)\?-rpath[, ]\$(libdir) \?//' ${readline_src_dir}/support/shobj-conf || return
		${readline_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-multibyte --with-curses) || return
	make -C ${readline_bld_dir} -j ${jobs} SHLIB_LIBS="`l tinfo`" || return
	[ "${enable_check}" != yes ] ||
		make -C ${readline_bld_dir} -j ${jobs} -k check || return
	make -C ${readline_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for l in libhistory libreadline; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
	done
}

install_native_ncurses()
{
	[ -f ${prefix}/include/ncurses/curses.h -a "${force_install}" != yes ] && return
	fetch ncurses || return
	unpack ncurses || return

	# [XXX] workaround for GCC 5.x
	which patch > /dev/null || install_native_patch || return
	patch -N -p0 -d ${ncurses_src_dir} <<\EOF || [ $? = 1 ] || return
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

	[ -f ${ncurses_bld_dir}/Makefile ] ||
		(cd ${ncurses_bld_dir}
		${ncurses_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-pc-files --with-shared --with-cxx-shared --with-termlib \
			--with-versioned-syms --enable-termcap --enable-colors \
			PKG_CONFIG_LIBDIR=${prefix}/lib/${host}/pkgconfig \
			) || return
	make -C ${ncurses_bld_dir} -j ${jobs} || return
	make -C ${ncurses_bld_dir} -j ${jobs} install || return
	make -C ${ncurses_bld_dir} -j ${jobs} distclean || return
	[ -f ${ncurses_bld_dir}/Makefile ] ||
		(cd ${ncurses_bld_dir}
		${ncurses_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-pc-files --with-shared --with-cxx-shared --with-termlib \
			--with-versioned-syms --enable-termcap --enable-widec --enable-colors --with-pthread --enable-reentrant \
			PKG_CONFIG_LIBDIR=${prefix}/lib/${host}/pkgconfig \
			) || return
	make -C ${ncurses_bld_dir} -j ${jobs} || return
	make -C ${ncurses_bld_dir} -j ${jobs} install || return
	update_path || return
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
	for l in libform libmenu libncurses++ libpanel libtinfo libformtw libmenutw libncurses++tw libncursestw libpaneltw libtinfotw; do
		[ -f ${DESTDIR}${prefix}/lib/${l}.so ] || continue
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
	done
}

install_native_popt()
{
	[ -f ${prefix}/include/popt.h -a "${force_install}" != yes ] && return
	fetch popt || return
	unpack popt || return
	[ -f ${popt_bld_dir}/Makefile ] ||
		(cd ${popt_bld_dir}
		${popt_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-rpath) || return

	make -C ${popt_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${popt_bld_dir} -j ${jobs} -k check || return
	make -C ${popt_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_babeltrace()
{
	[ -x ${prefix}/bin/babeltrace -a "${force_install}" != yes ] && return
	print_header_path pcre.h > /dev/null || install_native_pcre || return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path uuid.h uuid > /dev/null || install_native_util_linux || return
	print_header_path popt.h > /dev/null || install_native_popt || return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	fetch babeltrace || return
	unpack babeltrace || return
	[ -f ${babeltrace_src_dir}/configure ] ||
		autoreconf -fiv -I `print_prefix glib.h glib-2.0`/share/aclocal ${babeltrace_src_dir} || return
	[ -f ${babeltrace_bld_dir}/Makefile ] ||
		(cd ${babeltrace_bld_dir}
		${babeltrace_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${babeltrace_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${babeltrace_bld_dir} -j ${jobs} -k check || return
	make -C ${babeltrace_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_gdb()
{
	[ -x ${prefix}/bin/gdb -a "${force_install}" != yes ] && return
	print_header_path libelf.h > /dev/null || install_native_elfutils || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	print_header_path expat.h > /dev/null || install_native_expat || return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	print_library_path libpython`python3 --version | grep -oe '[[:digit:]]\.[[:digit:]]\+'`.so > /dev/null || install_native_Python || return
	print_header_path sourcehighlight.h srchilite > /dev/null || install_native_source_highlight || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	print_header_path babeltrace.h babeltrace > /dev/null || install_native_babeltrace || return
	which makeinfo > /dev/null || install_native_texinfo || return
	fetch gdb || return
	unpack gdb || return
	[ -f ${gdb_bld_dir}/Makefile ] ||
		(cd ${gdb_bld_dir}
		${gdb_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --target=${target} \
			--enable-targets=all --enable-64-bit-bfd --enable-tui --enable-source-highlight \
			--with-auto-load-dir='$debugdir:$datadir/auto-load:'${prefix}/lib/gcc/${target} --with-python=python3 \
			--with-debuginfod --with-system-zlib --with-system-readline \
			LDFLAGS="${LDFLAGS} `L z ncurses`" \
			host_configargs='--disable-rpath 'CFLAGS=\'"${CFLAGS} `I zlib.h curses.h`"\') || return
	make -C ${gdb_bld_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${gdb_bld_dir} -j ${jobs} -k check || return
	make -C ${gdb_bld_dir} -j ${jobs} install || return
	make -C ${gdb_bld_dir}/gdb -j ${jobs} install${strip:+-${strip}} || return
	make -C ${gdb_bld_dir}/sim -j ${jobs} install || return
}

install_native_crash()
{
	[ -x ${prefix}/bin/crash -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch crash || return
	unpack crash || return
	[ -f ${crash_bld_dir}/Makefile ] || cp -Tvr ${crash_src_dir} ${crash_bld_dir} || return
	sed -i -e "s!^\(INSTALLDIR=\${DESTDIR}\)/usr/bin\$!\1${prefix}/bin!" ${crash_bld_dir}/Makefile || return
	make -C ${crash_bld_dir} -j ${jobs} target=`echo ${target} | cut -d- -f1` || return
	make -C ${crash_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/crash || return
}

install_native_lcov()
{
	[ -x ${prefix}/bin/lcov -a "${force_install}" != yes ] && return
	fetch lcov || return
	unpack lcov || return
	[ -f ${lcov_bld_dir}/Makefile ] || cp -Tvr ${lcov_src_dir} ${lcov_bld_dir} || return
	make -C ${lcov_bld_dir} -j ${jobs} PREFIX=${DESTDIR}${prefix} install || return
}

install_native_strace()
{
	[ -x ${prefix}/bin/strace -a "${force_install}" != yes ] && return
	fetch strace || return
	unpack strace || return
	[ -f ${strace_bld_dir}/Makefile ] ||
		(cd ${strace_bld_dir}
		${strace_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --enable-mpers=check) || return
	make -C ${strace_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${strace_bld_dir} -j ${jobs} -k check || return
	make -C ${strace_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/strace || return
}

install_native_ltrace()
{
	[ -x ${prefix}/bin/ltrace -a "${force_install}" != yes ] && return
	print_library_path libelf.so > /dev/null || install_native_elfutils || return
	fetch ltrace || return
	unpack ltrace || return
	[ -f ${ltrace_bld_dir}/Makefile ] ||
		(cd ${ltrace_bld_dir}
		${ltrace_src_dir}/configure --prefix=${prefix} --build=${build} \
		CFLAGS="${CFLAGS} -Wno-error") || return
	make -C ${ltrace_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${ltrace_bld_dir} -j ${jobs} -k check || return
	make -C ${ltrace_bld_dir} -j ${jobs} install || return
}

install_native_valgrind()
{
	[ -x ${prefix}/bin/valgrind -a "${force_install}" != yes ] && return
	fetch valgrind || return
	unpack valgrind || return
	[ -f ${valgrind_bld_dir}/Makefile ] ||
		(cd ${valgrind_bld_dir}
		${valgrind_src_dir}/configure --prefix=${prefix} --build=${build}) || return
	make -C ${valgrind_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${valgrind_bld_dir} -j ${jobs} -k check || return
	make -C ${valgrind_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_zlib()
{
	[ -f ${prefix}/include/zlib.h -a "${force_install}" != yes ] && return
	fetch zlib || return
	unpack zlib || return
	(cd ${zlib_bld_dir}
	echo ${host} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' && static=--static || static=''
	eval `[ ${build} != ${host} ] && echo CHOST=${host}` ${zlib_src_dir}/configure --prefix=${prefix} --uname=linux ${static}) || return
	make -C ${zlib_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${zlib_bld_dir} -j ${jobs} -k check || return
	make -C ${zlib_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_pigz()
{
	[ -x ${prefix}/bin/pigz -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	fetch pigz || return
	unpack pigz || return
	[ -f ${pigz_bld_dir}/Makefile ] || cp -Tvr ${pigz_src_dir} ${pigz_bld_dir} || return
	sed -i -e "
		/^CC=.\+\$/s!!CC=${CC:-${host:+${host}-}gcc}!
		/^CFLAGS=/s!\$! `I zlib.h`!
		/^LDFLAGS=\$/s!\$! `L z`!
		" ${pigz_bld_dir}/Makefile || return
	make -C ${pigz_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pigz_bld_dir} -j ${jobs} -k test || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${pigz_bld_dir}/pigz || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${pigz_bld_dir}/unpigz || return
	command install -D -v -t ${DESTDIR}${prefix}/share/man/man1 ${pigz_bld_dir}/pigz.1 || return
}

install_native_libpng()
{
	[ -f ${prefix}/include/png.h -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	fetch libpng || return
	unpack libpng || return
	[ -f ${libpng_bld_dir}/Makefile ] ||
		(cd ${libpng_bld_dir}
		${libpng_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			CPPFLAGS="${CPPFLAGS} `I zlib.h`" \
			LDFLAGS="${LDFLAGS} `L z`") || return
	make -C ${libpng_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpng_bld_dir} -j ${jobs} -k check || return
	make -C ${libpng_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_tiff()
{
	[ -f ${prefix}/include/tiffio.h -a "${force_install}" != yes ] && return
	fetch tiff || return
	unpack tiff || return
	[ -f ${tiff_bld_dir}/Makefile ] ||
		(cd ${tiff_bld_dir}
		${tiff_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${tiff_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tiff_bld_dir} -j ${jobs} -k check || return
	make -C ${tiff_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_jpeg()
{
	[ -f ${prefix}/include/jpeglib.h -a "${force_install}" != yes ] && return
	fetch jpeg || return
	unpack jpeg || return
	[ -f ${jpeg_bld_dir}/Makefile ] ||
		(cd ${jpeg_bld_dir}
		${jpeg_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${jpeg_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${jpeg_bld_dir} -j ${jobs} -k check || return
	make -C ${jpeg_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_giflib()
{
	[ -f ${prefix}/include/gif_lib.h -a "${force_install}" != yes ] && return
	fetch giflib || return
	unpack giflib || return
	[ -f ${giflib_bld_dir}/Makefile ] || cp -Tvr ${giflib_src_dir} ${giflib_bld_dir} || return
	make -C ${giflib_bld_dir} -j ${jobs} CC=${CC:-${host:+${host}-}gcc} || return
	[ "${enable_check}" != yes ] ||
		make -C ${giflib_bld_dir} -j ${jobs} -k check || return
	make -C ${giflib_bld_dir} -j ${jobs} install PREFIX=${prefix} || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in gif2rgb  gifbuild  gifclrmp  giffix  giftext  giftool; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_libwebp()
{
	[ -f ${prefix}/include/webp/decode.h -a "${force_install}" != yes ] && return
	print_header_path png.h > /dev/null || install_native_libpng || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path gif_lib.h > /dev/null || install_native_giflib || return
	fetch libwebp || return
	unpack libwebp || return
	[ -f ${libwebp_bld_dir}/Makefile ] ||
		(cd ${libwebp_bld_dir}
		${libwebp_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libwebp_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libwebp_bld_dir} -j ${jobs} -k check || return
	make -C ${libwebp_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_gobject_introspection()
{
	[ -f ${prefix}/include/gobject-introspection-1.0/giversion.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	which meson > /dev/null || install_native_meson || return
	fetch gobject-introspection || return
	unpack gobject-introspection || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gobject_introspection_src_dir} ${gobject_introspection_bld_dir} || return
	ninja -v -C ${gobject_introspection_bld_dir} || return
	ninja -v -C ${gobject_introspection_bld_dir} install || return
	update_path || return
}

install_native_pixman()
{
	[ -f ${prefix}/include/pixman-1/pixman.h -a "${force_install}" != yes ] && return
	fetch pixman || return
	unpack pixman || return
	[ -f ${pixman_bld_dir}/Makefile ] ||
		(cd ${pixman_bld_dir}
		${pixman_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${pixman_bld_dir} -j ${jobs} || return
	make -C ${pixman_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_cairo()
{
	[ -f ${prefix}/include/cairo/cairo.h -a "${force_install}" != yes ] && return
	print_header_path ft2build.h freetype2 > /dev/null || install_native_freetype || return
	print_header_path fontconfig.h fontconfig > /dev/null || install_native_fontconfig || return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path pixman.h pixman-1.0 > /dev/null || install_native_pixman || return
	fetch cairo || return
	unpack cairo || return
	[ -f ${cairo_src_dir}/Makefile ] ||
		(cd ${cairo_src_dir}
		./configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${cairo_src_dir} -j ${jobs} || return
	make -C ${cairo_src_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_fribidi()
{
	[ -f ${prefix}/include/fribidi/fribidi.h -a "${force_install}" != yes ] && return
	fetch fribidi || return
	unpack fribidi || return
	[ -f ${fribidi_src_dir}/configure ] ||
		NOCONFIGURE=1 ${fribidi_src_dir}/autogen.sh || return
	[ -f ${fribidi_bld_dir}/Makefile ] ||
		(cd ${fribidi_bld_dir}
		${fribidi_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules --enable-static) || return
	make -C ${fribidi_bld_dir} -j ${jobs} || return
	make -C ${fribidi_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_harfbuzz()
{
	[ -f ${prefix}/include/harfbuzz/hb.h -a "${force_install}" != yes ] && return
	print_header_path cairo.h cairo > /dev/null || install_native_cairo || return
	print_header_path giversion.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return
	which meson > /dev/null || install_native_meson || return
	fetch harfbuzz || return
	unpack harfbuzz || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${harfbuzz_src_dir} ${harfbuzz_bld_dir} || return
	ninja -v -C ${harfbuzz_bld_dir} || return
	ninja -v -C ${harfbuzz_bld_dir} install || return
	update_path || return
}

install_native_pango()
{
	[ -f ${prefix}/include/pango-1.0/pango/pango.h -a "${force_install}" != yes ] && return
	print_header_path cairo.h cairo > /dev/null || install_native_cairo || return
	print_header_path fribidi.h fribidi > /dev/null || install_native_fribidi || return
	print_header_path hb.h harfbuzz > /dev/null || install_native_harfbuzz || return
	which meson > /dev/null || install_native_meson || return
	fetch pango || return
	unpack pango || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${pango_src_dir} ${pango_bld_dir} || return
	ninja -v -C ${pango_bld_dir} || return
	ninja -v -C ${pango_bld_dir} install || return
	update_path || return
}

install_native_pygobject()
{
	[ -f ${prefix}/include/pygobject-3.0/pygobject.h -a "${force_install}" != yes ] && return
	print_header_path giversion.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return
	which meson > /dev/null || install_native_meson || return
	fetch pygobject || return
	unpack pygobject || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${pygobject_src_dir} ${pygobject_bld_dir} || return
	ninja -v -C ${pygobject_bld_dir} || return
	ninja -v -C ${pygobject_bld_dir} install || return
}

install_native_itstool()
{
	[ -x ${prefix}/bin/itstool -a "${force_install}" != yes ] && return
	fetch itstool || return
	unpack itstool || return
	[ -f ${itstool_bld_dir}/Makefile ] ||
		(cd ${itstool_bld_dir}
		${itstool_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${itstool_bld_dir} -j ${jobs} || return
	make -C ${itstool_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_shared_mime_info()
{
	[ -x ${prefix}/bin/update-mime-database -a "${force_install}" != yes ] && return
	which itstool > /dev/null || install_native_itstool || return
	which meson > /dev/null || install_native_meson || return
	fetch shared-mime-info || return
	unpack shared-mime-info || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${shared_mime_info_src_dir} ${shared_mime_info_bld_dir} || return
	ninja -v -C ${shared_mime_info_bld_dir} || return
	ninja -v -C ${shared_mime_info_bld_dir} install || return
	update_path || return
	update-mime-database ${DESTDIR}${prefix}/share/mime || return
}

install_native_gdk_pixbuf()
{
	[ -f ${prefix}/include/gdk-pixbuf-2.0/gdk-pixbuf/gdk-pixbuf.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	which update-mime-database > /dev/null || install_native_shared_mime_info || return
	which meson > /dev/null || install_native_meson || return
	fetch gdk-pixbuf || return
	unpack gdk-pixbuf || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gdk_pixbuf_src_dir} ${gdk_pixbuf_bld_dir} || return
	ninja -v -C ${gdk_pixbuf_bld_dir} || return
	ninja -v -C ${gdk_pixbuf_bld_dir} install || return
	update_path || return
}

install_native_atk()
{
	[ -f ${prefix}/include/atk-1.0/atk/atk.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path giversion.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return
	which meson > /dev/null || install_native_meson || return
	fetch atk || return
	unpack atk || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${atk_src_dir} ${atk_bld_dir} || return
	ninja -v -C ${atk_bld_dir} || return
	ninja -v -C ${atk_bld_dir} install || return
	update_path || return
}

install_native_dbus()
{
	[ -f ${prefix}/include/dbus-1.0/dbus/dbus.h -a "${force_install}" != yes ] && return
	fetch dbus || return
	unpack dbus || return
	[ -f ${dbus_bld_dir}/Makefile ] ||
		(cd ${dbus_bld_dir}
		${dbus_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${dbus_bld_dir} -j ${jobs} || return
	make -C ${dbus_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_recordproto()
{
	[ -f ${prefix}/include/X11/extensions/recordproto.h -a "${force_install}" != yes ] && return
	fetch recordproto || return
	unpack recordproto || return
	[ -f ${recordproto_bld_dir}/Makefile ] ||
		(cd ${recordproto_bld_dir}
		${recordproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${recordproto_bld_dir} -j ${jobs} || return
	make -C ${recordproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXtst()
{
	[ -f ${prefix}/include/X11/extensions/XTest.h -a "${force_install}" != yes ] && return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path recordproto.h X11/extensions > /dev/null || install_native_recordproto || return
	print_header_path XI.h X11/extensions > /dev/null || install_native_inputproto || return
	print_header_path XInput.h X11/extensions > /dev/null || install_native_libXi || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	fetch libXtst || return
	unpack libXtst || return
	[ -f ${libXtst_bld_dir}/Makefile ] ||
		(cd ${libXtst_bld_dir}
		${libXtst_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXtst_bld_dir} -j ${jobs} || return
	make -C ${libXtst_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_at_spi2_core()
{
	[ -f ${prefix}/include/at-spi-2.0/atspi/atspi.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path dbus.h dbus-1.0/dbus > /dev/null || install_native_dbus || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path XTest.h X11/extensions > /dev/null || install_native_libXtst || return
	print_header_path XInput.h X11/extensions > /dev/null || install_native_libXi || return
	which meson > /dev/null || install_native_meson || return
	fetch at-spi2-core || return
	unpack at-spi2-core || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${at_spi2_core_src_dir} ${at_spi2_core_bld_dir} || return
	ninja -v -C ${at_spi2_core_bld_dir} || return
	ninja -v -C ${at_spi2_core_bld_dir} install || return
	update_path || return
}

install_native_at_spi2_atk()
{
	[ -f ${prefix}/include/at-spi2-atk/2.0/atk-bridge.h -a "${force_install}" != yes ] && return
	print_header_path atspi.h at-spi-2.0/atspi > /dev/null || install_native_at_spi2_core || return
	which meson > /dev/null || install_native_meson || return
	fetch at-spi2-atk || return
	unpack at-spi2-atk || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${at_spi2_atk_src_dir} ${at_spi2_atk_bld_dir} || return
	ninja -v -C ${at_spi2_atk_bld_dir} || return
	ninja -v -C ${at_spi2_atk_bld_dir} install || return
	update_path || return
}

install_native_xproto()
{
	[ -f ${prefix}/include/X11/Xproto.h -a "${force_install}" != yes ] && return
	fetch xproto || return
	unpack xproto || return
	[ -f ${xproto_bld_dir}/Makefile ] ||
		(cd ${xproto_bld_dir}
		${xproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xproto_bld_dir} -j ${jobs} || return
	make -C ${xproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXau()
{
	[ -f ${prefix}/include/X11/Xauth.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	fetch libXau || return
	unpack libXau || return
	[ -f ${libXau_bld_dir}/Makefile ] ||
		(cd ${libXau_bld_dir}
		${libXau_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXau_bld_dir} -j ${jobs} || return
	make -C ${libXau_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXdmcp()
{
	[ -f ${prefix}/include/X11/Xdmcp.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	fetch libXdmcp || return
	unpack libXdmcp || return
	[ -f ${libXdmcp_bld_dir}/Makefile ] ||
		(cd ${libXdmcp_bld_dir}
		${libXdmcp_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXdmcp_bld_dir} -j ${jobs} || return
	make -C ${libXdmcp_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_xtrans()
{
	[ -f ${prefix}/include/X11/Xtrans/Xtrans.h -a "${force_install}" != yes ] && return
	fetch xtrans || return
	unpack xtrans || return
	[ -f ${xtrans_bld_dir}/Makefile ] ||
		(cd ${xtrans_bld_dir}
		${xtrans_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xtrans_bld_dir} -j ${jobs} || return
	make -C ${xtrans_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libICE()
{
	[ -f ${prefix}/include/X11/ICE/ICE.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path Xtrans.h X11/Xtrans > /dev/null || install_native_xtrans || return
	fetch libICE || return
	unpack libICE || return
	[ -f ${libICE_bld_dir}/Makefile ] ||
		(cd ${libICE_bld_dir}
		${libICE_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libICE_bld_dir} -j ${jobs} || return
	make -C ${libICE_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libSM()
{
	[ -f ${prefix}/include/X11/SM/SM.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path Xtrans.h X11/Xtrans > /dev/null || install_native_xtrans || return
	print_header_path ICE.h X11/ICE > /dev/null || install_native_libICE || return
	fetch libSM || return
	unpack libSM || return
	[ -f ${libSM_bld_dir}/Makefile ] ||
		(cd ${libSM_bld_dir}
		${libSM_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libSM_bld_dir} -j ${jobs} || return
	make -C ${libSM_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_xcb_proto()
{
	[ -f ${prefix}/lib/pkgconfig/xcb-proto.pc -a "${force_install}" != yes ] && return
	fetch xcb-proto || return
	unpack xcb-proto || return
	[ -f ${xcb_proto_bld_dir}/Makefile ] ||
		(cd ${xcb_proto_bld_dir}
		${xcb_proto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xcb_proto_bld_dir} -j ${jobs} || return
	make -C ${xcb_proto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libxcb()
{
	[ -f ${prefix}/include/xcb/xcb.h -a "${force_install}" != yes ] && return
	print_library_path xcb-proto.pc > /dev/null || install_native_xcb_proto || return
	print_header_path Xauth.h X11 > /dev/null || install_native_libXau || return
	fetch libxcb || return
	unpack libxcb || return
	[ -f ${libxcb_bld_dir}/Makefile ] ||
		(cd ${libxcb_bld_dir}
		${libxcb_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libxcb_bld_dir} -j ${jobs} || return
	make -C ${libxcb_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_xextproto()
{
	[ -f ${prefix}/include/X11/extensions/lbx.h -a "${force_install}" != yes ] && return
	fetch xextproto || return
	unpack xextproto || return
	[ -f ${xextproto_bld_dir}/Makefile ] ||
		(cd ${xextproto_bld_dir}
		${xextproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xextproto_bld_dir} -j ${jobs} || return
	make -C ${xextproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_inputproto()
{
	[ -f ${prefix}/include/X11/extensions/XI.h -a "${force_install}" != yes ] && return
	fetch inputproto || return
	unpack inputproto || return
	[ -f ${inputproto_bld_dir}/Makefile ] ||
		(cd ${inputproto_bld_dir}
		${inputproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${inputproto_bld_dir} -j ${jobs} || return
	make -C ${inputproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_kbproto()
{
	[ -f ${prefix}/include/X11/extensions/XKBproto.h -a "${force_install}" != yes ] && return
	fetch kbproto || return
	unpack kbproto || return
	[ -f ${kbproto_bld_dir}/Makefile ] ||
		(cd ${kbproto_bld_dir}
		${kbproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${kbproto_bld_dir} -j ${jobs} || return
	make -C ${kbproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libX11()
{
	[ -f ${prefix}/include/X11/Xlib.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path xcb.h xcb > /dev/null || install_native_libxcb || return
	print_header_path Xtrans.h X11/Xtrans > /dev/null || install_native_xtrans || return
	print_header_path XI.h X11/extensions > /dev/null || install_native_inputproto || return
	print_header_path XKBproto.h X11 > /dev/null || install_native_kbproto || return
	fetch libX11 || return
	unpack libX11 || return
	[ -f ${libX11_bld_dir}/Makefile ] ||
		(cd ${libX11_bld_dir}
		${libX11_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libX11_bld_dir} -j ${jobs} || return
	make -C ${libX11_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXext()
{
	[ -f ${prefix}/include/X11/extensions/Xext.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXext || return
	unpack libXext || return
	[ -f ${libXext_bld_dir}/Makefile ] ||
		(cd ${libXext_bld_dir}
		${libXext_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXext_bld_dir} -j ${jobs} || return
	make -C ${libXext_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXt()
{
	[ -f ${prefix}/include/X11/Core.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path ICE.h X11/ICE > /dev/null || install_native_libICE || return
	print_header_path SM.h X11/SM > /dev/null || install_native_libSM || return
	print_header_path XKBproto.h X11 > /dev/null || install_native_kbproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXt || return
	unpack libXt || return
	[ -f ${libXt_bld_dir}/Makefile ] ||
		(cd ${libXt_bld_dir}
		${libXt_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXt_bld_dir} -j ${jobs} || return
	make -C ${libXt_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXmu()
{
	[ -f ${prefix}/include/X11/Xmu/Xmu.h -a "${force_install}" != yes ] && return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path Core.h X11 > /dev/null || install_native_libXt || return
	fetch libXmu || return
	unpack libXmu || return
	[ -f ${libXmu_bld_dir}/Makefile ] ||
		(cd ${libXmu_bld_dir}
		${libXmu_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXmu_bld_dir} -j ${jobs} || return
	make -C ${libXmu_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXpm()
{
	[ -f ${prefix}/include/X11/xpm.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXpm || return
	unpack libXpm || return
	[ -f ${libXpm_bld_dir}/Makefile ] ||
		(cd ${libXpm_bld_dir}
		${libXpm_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXpm_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libXpm_bld_dir} -j ${jobs} -k check || return
	make -C ${libXpm_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXaw()
{
	[ -f ${prefix}/include/X11/Xaw/XawInit.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path Core.h X11 > /dev/null || install_native_libXt || return
	print_header_path Xmu.h X11/Xmu > /dev/null || install_native_libXmu || return
	print_header_path xpm.h X11 > /dev/null || install_native_libXpm || return
	fetch libXaw || return
	unpack libXaw || return
	[ -f ${libXaw_bld_dir}/Makefile ] ||
		(cd ${libXaw_bld_dir}
		${libXaw_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXaw_bld_dir} -j ${jobs} || return
	make -C ${libXaw_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXi()
{
	[ -f ${prefix}/include/X11/extensions/XInput.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path XI.h X11/extensions > /dev/null || install_native_inputproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	fetch libXi || return
	unpack libXi || return
	[ -f ${libXi_bld_dir}/Makefile ] ||
		(cd ${libXi_bld_dir}
		${libXi_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXi_bld_dir} -j ${jobs} || return
	make -C ${libXi_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_fixesproto()
{
	[ -f ${prefix}/include/X11/extensions/xfixesproto.h -a "${force_install}" != yes ] && return
	fetch fixesproto || return
	unpack fixesproto || return
	[ -f ${fixesproto_bld_dir}/Makefile ] ||
		(cd ${fixesproto_bld_dir}
		${fixesproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${fixesproto_bld_dir} -j ${jobs} || return
	make -C ${fixesproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXfixes()
{
	[ -f ${prefix}/include/X11/extensions/Xfixes.h -a "${force_install}" != yes ] && return
	print_header_path xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXfixes || return
	unpack libXfixes || return
	[ -f ${libXfixes_bld_dir}/Makefile ] ||
		(cd ${libXfixes_bld_dir}
		${libXfixes_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXfixes_bld_dir} -j ${jobs} || return
	make -C ${libXfixes_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_damageproto()
{
	[ -f ${prefix}/include/X11/extensions/damageproto.h -a "${force_install}" != yes ] && return
	fetch damageproto || return
	unpack damageproto || return
	[ -f ${damageproto_bld_dir}/Makefile ] ||
		(cd ${damageproto_bld_dir}
		${damageproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${damageproto_bld_dir} -j ${jobs} || return
	make -C ${damageproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXdamage()
{
	[ -f ${prefix}/include/X11/extensions/Xdamage.h -a "${force_install}" != yes ] && return
	print_header_path damageproto.h X11/extensions > /dev/null || install_native_damageproto || return
	print_header_path xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return
	print_header_path Xfixes.h X11/extensions > /dev/null || install_native_libXfixes || return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXdamage || return
	unpack libXdamage || return
	[ -f ${libXdamage_bld_dir}/Makefile ] ||
		(cd ${libXdamage_bld_dir}
		${libXdamage_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXdamage_bld_dir} -j ${jobs} || return
	make -C ${libXdamage_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_renderproto()
{
	[ -f ${prefix}/include/X11/extensions/renderproto.h -a "${force_install}" != yes ] && return
	fetch renderproto || return
	unpack renderproto || return
	[ -f ${renderproto_bld_dir}/Makefile ] ||
		(cd ${renderproto_bld_dir}
		${renderproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${renderproto_bld_dir} -j ${jobs} || return
	make -C ${renderproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXrender()
{
	[ -f ${prefix}/include/X11/extensions/Xrender.h -a "${force_install}" != yes ] && return
	print_header_path renderproto.h X11/extensions > /dev/null || install_native_renderproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	fetch libXrender || return
	unpack libXrender || return
	[ -f ${libXrender_bld_dir}/Makefile ] ||
		(cd ${libXrender_bld_dir}
		${libXrender_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXrender_bld_dir} -j ${jobs} || return
	make -C ${libXrender_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_randrproto()
{
	[ -f ${prefix}/include/X11/extensions/randrproto.h -a "${force_install}" != yes ] && return
	fetch randrproto || return
	unpack randrproto || return
	[ -f ${randrproto_bld_dir}/Makefile ] ||
		(cd ${randrproto_bld_dir}
		${randrproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${randrproto_bld_dir} -j ${jobs} || return
	make -C ${randrproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXrandr()
{
	[ -f ${prefix}/include/X11/extensions/Xrandr.h -a "${force_install}" != yes ] && return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path renderproto.h X11/extensions > /dev/null || install_native_renderproto || return
	print_header_path Xrender.h X11/extensions > /dev/null || install_native_libXrender || return
	print_header_path randrproto.h X11/extensions > /dev/null || install_native_randrproto || return
	fetch libXrandr || return
	unpack libXrandr || return
	[ -f ${libXrandr_bld_dir}/Makefile ] ||
		(cd ${libXrandr_bld_dir}
		${libXrandr_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXrandr_bld_dir} -j ${jobs} || return
	make -C ${libXrandr_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXcursor()
{
	[ -f ${prefix}/include/X11/Xcursor/Xcursor.h -a "${force_install}" != yes ] && return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path xfixesproto.h X11/extensions > /dev/null || install_native_fixesproto || return
	print_header_path Xfixes.h X11/extensions > /dev/null || install_native_libXfixes || return
	print_header_path Xrender.h X11/extensions > /dev/null || install_native_libXrender || return
	fetch libXcursor || return
	unpack libXcursor || return
	[ -f ${libXcursor_bld_dir}/Makefile ] ||
		(cd ${libXcursor_bld_dir}
		${libXcursor_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXcursor_bld_dir} -j ${jobs} || return
	make -C ${libXcursor_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_xineramaproto()
{
	[ -f ${prefix}/include/X11/extensions/panoramiXproto.h -a "${force_install}" != yes ] && return
	fetch xineramaproto || return
	unpack xineramaproto || return
	[ -f ${xineramaproto_bld_dir}/Makefile ] ||
		(cd ${xineramaproto_bld_dir}
		${xineramaproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xineramaproto_bld_dir} -j ${jobs} || return
	make -C ${xineramaproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libXinerama()
{
	[ -f ${prefix}/include/X11/extensions/Xinerama.h -a "${force_install}" != yes ] && return
	print_header_path lbx.h X11/extensions > /dev/null || install_native_xextproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path panoramiXproto.h X11/extensions > /dev/null || install_native_xineramaproto || return
	fetch libXinerama || return
	unpack libXinerama || return
	[ -f ${libXinerama_bld_dir}/Makefile ] ||
		(cd ${libXinerama_bld_dir}
		${libXinerama_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libXinerama_bld_dir} -j ${jobs} || return
	make -C ${libXinerama_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libxkbcommon()
{
	[ -f ${prefix}/include/xkbcommon/xkbcommon.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch libxkbcommon || return
	unpack libxkbcommon || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both \
		-Denable-docs=false -Denable-wayland=false ${libxkbcommon_src_dir} ${libxkbcommon_bld_dir} || return
	ninja -v -C ${libxkbcommon_bld_dir} || return
	ninja -v -C ${libxkbcommon_bld_dir} install || return
	update_path || return
}

install_native_libpciaccess()
{
	[ -f ${prefix}/include/pciaccess.h -a "${force_install}" != yes ] && return
	fetch libpciaccess || return
	unpack libpciaccess || return
	[ -f ${libpciaccess_bld_dir}/Makefile ] ||
		(cd ${libpciaccess_bld_dir}
		${libpciaccess_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--with-zlib) || return
	make -C ${libpciaccess_bld_dir} -j ${jobs} || return
	make -C ${libpciaccess_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libdrm()
{
	[ -f ${prefix}/include/libdrm/drm.h -a "${force_install}" != yes ] && return
	print_header_path pciaccess.h > /dev/null || install_native_libpciaccess || return
	which meson > /dev/null || install_native_meson || return
	fetch libdrm || return
	unpack libdrm || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${libdrm_src_dir} ${libdrm_bld_dir} || return
	ninja -v -C ${libdrm_bld_dir} || return
	ninja -v -C ${libdrm_bld_dir} install || return
	update_path || return
}

install_native_libxshmfence()
{
	[ -f ${prefix}/include/X11/xshmfence.h -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	fetch libxshmfence || return
	unpack libxshmfence || return
	[ -f ${libxshmfence_bld_dir}/Makefile ] ||
		(cd ${libxshmfence_bld_dir}
		${libxshmfence_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libxshmfence_bld_dir} -j ${jobs} || return
	make -C ${libxshmfence_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_wayland()
{
	[ -f ${prefix}/include/wayland-version.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch wayland || return
	unpack wayland || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both -Ddocumentation=false ${wayland_src_dir} ${wayland_bld_dir} || return
	ninja -v -C ${wayland_bld_dir} || return
	ninja -v -C ${wayland_bld_dir} install || return
	update_path || return
}

install_native_wayland_protocols()
{
	[ -f ${prefix}/share/wayland-protocols/stable/xdg-shell/xdg-shell.xml -a "${force_install}" != yes ] && return
	which wayland-scanner > /dev/null || install_native_wayland || return
	which meson > /dev/null || install_native_meson || return
	fetch wayland-protocols || return
	unpack wayland-protocols || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${wayland_protocols_src_dir} ${wayland_protocols_bld_dir} || return
	ninja -v -C ${wayland_protocols_bld_dir} || return
	ninja -v -C ${wayland_protocols_bld_dir} install || return
	update_path || return
}

install_native_glproto()
{
	[ -f ${prefix}/include/GL/glxproto.h -a "${force_install}" != yes ] && return
	fetch glproto || return
	unpack glproto || return
	[ -f ${glproto_bld_dir}/Makefile ] ||
		(cd ${glproto_bld_dir}
		${glproto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${glproto_bld_dir} -j ${jobs} || return
	make -C ${glproto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_dri2proto()
{
	[ -f ${prefix}/include/X11/extensions/dri2proto.h -a "${force_install}" != yes ] && return
	fetch dri2proto || return
	unpack dri2proto || return
	[ -f ${dri2proto_bld_dir}/Makefile ] ||
		(cd ${dri2proto_bld_dir}
		${dri2proto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${dri2proto_bld_dir} -j ${jobs} || return
	make -C ${dri2proto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_dri3proto()
{
	[ -f ${prefix}/include/X11/extensions/dri3proto.h -a "${force_install}" != yes ] && return
	fetch dri3proto || return
	unpack dri3proto || return
	[ -f ${dri3proto_bld_dir}/Makefile ] ||
		(cd ${dri3proto_bld_dir}
		${dri3proto_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${dri3proto_bld_dir} -j ${jobs} || return
	make -C ${dri3proto_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_libglvnd()
{
	[ -f ${prefix}/include/glvnd/GLdispatchABI.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch libglvnd || return
	unpack libglvnd || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${libglvnd_src_dir} ${libglvnd_bld_dir} || return
	ninja -v -C ${libglvnd_bld_dir} || return
	ninja -v -C ${libglvnd_bld_dir} install || return
	update_path || return
}

install_native_mesa()
{
	[ -f ${prefix}/include/EGL/eglmesaext.h -a "${force_install}" != yes ] && return
	pkg-config --exists xcb-proto || install_native_xcb_proto || return
	print_header_path xcb.h xcb > /dev/null || install_native_libxcb || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path drm.h libdrm > /dev/null || install_native_libdrm || return
	print_header_path xshmfence.h X11 > /dev/null || install_native_libxshmfence || return
	print_header_path wayland-version.h > /dev/null || install_native_wayland || return
	pkg-config --exists wayland-protocols || install_native_wayland_protocols || return
	print_header_path glxproto.h GL > /dev/null || install_native_glproto || return
	print_header_path dri2proto.h X11/extensions > /dev/null || install_native_dri2proto || return
	print_header_path dri3proto.h X11/extensions > /dev/null || install_native_dri3proto || return
	print_header_path GLdispatchABI.h glvnd > /dev/null || install_native_libglvnd || return
	which meson > /dev/null || install_native_meson || return
	pip3 install mako || return
	fetch mesa || return
	unpack mesa || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both \
		-Dglvnd=true -Dglx-direct=false ${mesa_src_dir} ${mesa_bld_dir} || return
	ninja -v -C ${mesa_bld_dir} || return
	ninja -v -C ${mesa_bld_dir} install || return
	update_path || return
}

install_native_glu()
{
	[ -f ${prefix}/include/GL/glu.h -a "${force_install}" != yes ] && return
	print_header_path eglmesaext.h EGL > /dev/null || install_native_mesa || return
	which meson > /dev/null || install_native_meson || return
	fetch glu || return
	unpack glu || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${glu_src_dir} ${glu_bld_dir} || return
	ninja -v -C ${glu_bld_dir} || return
	ninja -v -C ${glu_bld_dir} install || return
	update_path || return
}

install_native_libepoxy()
{
	[ -f ${prefix}/include/epoxy/egl.h -a "${force_install}" != yes ] && return
	print_header_path Core.h X11 > /dev/null || install_native_libXt || return
	which meson > /dev/null || install_native_meson || return
	fetch libepoxy || return
	unpack libepoxy || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${libepoxy_src_dir} ${libepoxy_bld_dir} || return
	ninja -v -C ${libepoxy_bld_dir} || return
	ninja -v -C ${libepoxy_bld_dir} install || return
	update_path || return
}

install_native_graphene()
{
	[ -f ${prefix}/include/graphene-1.0/graphene.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch graphene || return
	unpack graphene || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${graphene_src_dir} ${graphene_bld_dir} || return
	ninja -v -C ${graphene_bld_dir} || return
	ninja -v -C ${graphene_bld_dir} install || return
	update_path || return
}

install_native_gtk()
{
	[ -f ${prefix}/include/gtk-`print_version gtk 1`.0/gtk/gtk.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path pango.h pango-1.0/pango > /dev/null || install_native_pango || return
	print_header_path gdk-pixbuf.h gdk-pixbuf-2.0/gdk-pixbuf > /dev/null || install_native_gdk_pixbuf || return
	print_header_path atk.h atk-1.0/atk > /dev/null || install_native_atk || return
	print_header_path giversionmacros.h gobject-introspection-1.0 > /dev/null || install_native_gobject_introspection || return
	print_header_path graphene.h graphene-1.0 > /dev/null || install_native_graphene || return
	print_header_path egl.h epoxy > /dev/null || install_native_libepoxy || return
	print_header_path atk-bridge.h at-spi2-atk/2.0 > /dev/null || install_native_at_spi2_atk || return # for GTK3 only.
	which meson > /dev/null || install_native_meson || return
	fetch gtk || return
	unpack gtk || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both \
		-Dc_link_args="${LDFLAGS} `L stdc++`" \
		${gtk_src_dir} ${gtk_bld_dir} || return
	ninja -v -C ${gtk_bld_dir} || return
	ninja -v -C ${gtk_bld_dir} install || return
	update_path || return
}

#install_native_webkitgtk()
#{
##	[ -x ${prefix}/bin/gawk -a "${force_install}" != yes ] && return
#	print_header_path gtk.h gtk-3.0/gtk > /dev/null || install_native_gtk || return
#	print_header_path sqlite3.h > /dev/null || install_native_sqlite || return
#	print_header_path png.h > /dev/null || install_native_libpng || return
#	print_header_path tiff.h > /dev/null || install_native_tiff || return
#	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
#	print_header_path gif_lib.h > /dev/null || install_native_giflib || return
#	print_header_path decode.h webp > /dev/null || install_native_libwebp || return
#	fetch webkitgtk || return
#	unpack webkitgtk || return
#	[ -f ${webkitgtk_bld_dir}/Makefile ] ||
#		(cd ${webkitgtk_bld_dir}
#		update_pkg_config_path
#		cmake -DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} -DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
#			-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} -L${prefix}/lib" \
#			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
#			-DPORT=GTK -DENABLE_CREDENTIAL_STORAGE=OFF \
#			-DENABLE_SPELLCHECK=OFF -DENABLE_WEB_AUDIO=OFF -DENABLE_VIDEO=OFF \
#			-DUSE_LIBNOTIFY=OFF -DUSE_LIBHYPHEN=OFF \
#			${webkitgtk_src_dir}) || return
#	make -C ${webkitgtk_bld_dir} -j ${jobs} || return
#	make -C ${webkitgtk_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
#}

install_native_qt()
{
	[ -f ${prefix}/include/QtCore/QtCoreVersion -a "${force_install}" != yes ] && return
	print_header_path Xrender.h X11/extensions > /dev/null || install_native_libXrender || return
	print_header_path xcb.h xcb > /dev/null || install_native_libxcb || return
	print_header_path xkbcommon.h xkbcommon > /dev/null || install_native_libxkbcommon || return
	print_header_path fontconfig.h fontconfig > /dev/null || install_native_fontconfig || return
	print_header_path ft2build.h freetype2 > /dev/null || install_native_freetype || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path SM.h X11/SM > /dev/null || install_native_libSM || return
	print_header_path ICE.h X11/ICE > /dev/null || install_native_libICE || return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	print_header_path atspi.h at-spi-2.0/atspi > /dev/null || install_native_at_spi2_core || return
	print_header_path eglmesaext.h EGL > /dev/null || install_native_mesa || return
	print_header_path pcre2.h > /dev/null || install_native_pcre2 || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path hb.h harfbuzz > /dev/null || install_native_harfbuzz || return
	print_header_path png.h > /dev/null || install_native_libpng || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
#	print_header_path sqlite3.h > /dev/null || install_native_sqlite || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	print_header_path decode.h webp > /dev/null || install_native_libwebp || return
	which ninja > /dev/null || install_native_ninja || return
	fetch qt || return
	unpack qt || return
	[ -f ${qt_bld_dir}/Makefile -o -f ${qt_bld_dir}/build.ninja ] ||
		(cd ${qt_bld_dir}
		${qt_src_dir}/configure -prefix ${prefix} \
			`[ $(print_version qt 1) -le 5 ] && echo -opensource -confirm-license` \
			-shared \
			-platform linux-g++ \
			-ccache \
			-DLIBICONV_PLUG \
			-nomake examples \
			-system-pcre \
			-system-zlib \
			-system-freetype \
			-system-harfbuzz \
			-system-libpng \
			-system-libjpeg \
			-qt-sqlite \
			-system-tiff \
			-system-webp \
			) || return
	if [ -f ${qt_bld_dir}/Makefile ]; then
		make -C ${qt_bld_dir} -j ${jobs} || return
		make -C ${qt_bld_dir} -j ${jobs} install || return
	else
		ninja -v -C ${qt_bld_dir} || return
		ninja -v -C ${qt_bld_dir} install || return
	fi
	update_path || return
}

install_native_xauth()
{
	[ -x ${prefix}/bin/xauth -a "${force_install}" != yes ] && return
	print_header_path Xproto.h X11 > /dev/null || install_native_xproto || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path Xauth.h X11 > /dev/null || install_native_libXau || return
	print_header_path Xext.h X11/extensions > /dev/null || install_native_libXext || return
	print_header_path Xmu.h X11/Xmu > /dev/null || install_native_libXmu || return
	fetch xauth || return
	unpack xauth || return
	[ -f ${xauth_bld_dir}/Makefile ] ||
		(cd ${xauth_bld_dir}
		${xauth_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${xauth_bld_dir} -j ${jobs} || return
	make -C ${xauth_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_emacs()
{
	[ -x ${prefix}/bin/emacs -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path png.h > /dev/null || install_native_libpng || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path gif_lib.h > /dev/null || install_native_giflib || return
	print_header_path xpm.h X11 > /dev/null || install_native_libXpm || return
	fetch emacs || return
	unpack emacs || return
	[ -f ${emacs_bld_dir}/Makefile ] ||
		(cd ${emacs_bld_dir}
		CPPFLAGS="${CPPFLAGS} -I${prefix}/include" LDFLAGS="${LDFLAGS} -L${prefix}/lib" \
			${emacs_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--with-modules --without-gnutls) || return
	make -C ${emacs_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${emacs_bld_dir} -j ${jobs} -k check || return
	make -C ${emacs_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_vim()
{
	[ -x ${prefix}/bin/vim -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	which gettext > /dev/null || install_native_gettext || return
	print_header_path lua.h > /dev/null || install_native_lua || return
	print_library_path libperl.so > /dev/null || install_native_perl || return
	print_header_path Python.h python`python3 --version | grep -oe '[[:digit:]]\.[[:digit:]]\{1,2\}'` > /dev/null || install_native_Python || return
	print_library_path tclConfig.sh > /dev/null || install_native_tcl || return
	print_header_path ruby.h > /dev/null || install_native_ruby || return
	fetch vim || return
	unpack vim || return
	[ -f ${vim_bld_dir}/configure ] || cp -Tvr ${vim_src_dir} ${vim_bld_dir} || return
	[ -f ${vim_bld_dir}/src/auto/config.h ] ||
		(cd ${vim_bld_dir}
		./configure --prefix=${prefix} --build=${build} \
			--with-features=huge --enable-fail-if-missing \
			--enable-luainterp=dynamic --with-lua-prefix=`print_prefix lua.h` \
			--enable-perlinterp=dynamic \
			--enable-python3interp=dynamic \
			--enable-tclinterp=dynamic --with-tclsh=tclsh \
			--enable-rubyinterp=dynamic \
			--enable-cscope --enable-terminal --enable-autoservername --enable-multibyte \
			--enable-xim --enable-fontset --enable-gui=auto \
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
	for l in eview evim ex gview gvim gvimdiff rgview rgvim rview rvim view vimdiff; do
		[ ! -h ${DESTDIR}${prefix}/bin/${l} ] || rm -fv ${DESTDIR}${prefix}/bin/${l} || return
	done
	make -C ${vim_bld_dir} -j ${jobs} install || return
	[ -f ${DESTDIR}${prefix}/bin/vi ] || ln -fsv vim ${DESTDIR}${prefix}/bin/vi || return
	fetch vimdoc-ja || return
	unpack vimdoc-ja || return
	mkdir -pv ${DESTDIR}${prefix}/share/vim/vimfiles || return
	cp -Tvr ${vimdoc_ja_src_dir} ${DESTDIR}${prefix}/share/vim/vimfiles || return
	vim -i NONE -u NONE -N -c "helptags ${DESTDIR}${prefix}/share/vim/vimfiles/doc" -c qall || return
}

install_native_ctags()
{
	[ -x ${prefix}/bin/ctags -a "${force_install}" != yes ] &&
		${prefix}/bin/ctags --version | grep -qe '\<Universal Ctags\>' && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	fetch ctags || return
	unpack ctags || return
	[ -f ${ctags_src_dir}/configure ] ||
		(cd ${ctags_src_dir}; ./autogen.sh) || return
	[ -f ${ctags_bld_dir}/Makefile ] ||
		(cd ${ctags_bld_dir}
		${ctags_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			LDFLAGS="${LDFLAGS} `l iconv`") || return
	make -C ${ctags_bld_dir} -j ${jobs} || return
	make -C ${ctags_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_neovim()
{
	[ -x ${prefix}/bin/nvim -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which ninja > /dev/null || install_native_ninja || return
	fetch neovim || return
	unpack neovim || return
	make -C ${neovim_src_dir} -j ${jobs} \
		CMAKE_BUILD_TYPE=${cmake_build_type} \
		CMAKE_INSTALL_PREFIX=${prefix} || return
	make -C ${neovim_src_dir} -j ${jobs} \
		install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${prefix}/bin/nvim || return
}

install_native_dein()
{
	mkdir -pv ${src}/vim || return
	[ -f ${src}/vim/installer.sh ] ||
		wget --no-check-certificate -O ${src}/vim/installer.sh \
			https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh || return
	[ `whoami` != root ] || ! echo Error. run as root is not recommended. >&2 || return
	sh ${src}/vim/installer.sh ${HOME}/.vim || return
}

install_native_nano()
{
	[ -x ${prefix}/bin/nano -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch nano || return
	unpack nano || return
	[ -f ${nano_bld_dir}/Makefile ] ||
		(cd ${nano_bld_dir}
		${nano_src_dir}/configure --prefix=${prefix} --host=${host} --disable-rpath) || return
	make -C ${nano_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${nano_bld_dir} -j ${jobs} -k check || return
	make -C ${nano_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_grep()
{
	[ -x ${prefix}/bin/grep -a "${force_install}" != yes ] && return
	print_header_path pcre2.h > /dev/null || install_native_pcre2 || return
	fetch grep || return
	unpack grep || return
	[ -f ${grep_bld_dir}/Makefile ] ||
		(cd ${grep_bld_dir}
		${grep_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${grep_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${grep_bld_dir} -j ${jobs} -k check || return
	make -C ${grep_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_global()
{
	[ -x ${prefix}/bin/global -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch global || return
	unpack global || return
	[ -f ${global_bld_dir}/Makefile ] ||
		(cd ${global_bld_dir}
		${global_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--with-ncurses=`print_prefix curses.h` CPPFLAGS="${CPPFLAGS} `I curses.h`") || return
	make -C ${global_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${global_bld_dir} -j ${jobs} -k check || return
	make -C ${global_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_pcre2()
{
	[ -f ${prefix}/include/pcre2.h -a "${force_install}" != yes ] && return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	fetch pcre2 || return
	unpack pcre2 || return
	[ -f ${pcre2_bld_dir}/Makefile ] ||
		(cd ${pcre2_bld_dir}
		${pcre2_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--enable-pcre2-16 --enable-pcre2-32 --enable-jit --enable-newline-is-any \
			--enable-pcre2grep-libz --enable-pcre2grep-libbz2 \
			CPPFLAGS="${CPPFLAGS} `I bzlib.h`" \
			LDFLAGS="${LDFLAGS} `L bz2`") || return
	make -C ${pcre2_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${pcre2_bld_dir} -j ${jobs} -k check || return
	make -C ${pcre2_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_the_silver_searcher()
{
	[ -x ${prefix}/bin/ag -a "${force_install}" != yes ] && return
	print_header_path pcre.h > /dev/null || install_native_pcre || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	fetch the_silver_searcher || return
	unpack the_silver_searcher || return
	[ -f ${the_silver_searcher_src_dir}/configure ] ||
		(cd ${the_silver_searcher_src_dir}; ./autogen.sh) || return
	[ -f ${the_silver_searcher_bld_dir}/Makefile ] ||
		(cd ${the_silver_searcher_bld_dir}
		update_pkg_config_path
		${the_silver_searcher_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			CFLAGS="${CFLAGS} -fcommon" \
			LDFLAGS="${LDFLAGS} `L z`" LIBS=-lz \
			PCRE_CFLAGS=`I pcre.h` PCRE_LIBS="`l pcre`" \
			LZMA_CFLAGS=`I lzma.h` LZMA_LIBS="`l lzma`") || return
	make -C ${the_silver_searcher_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${the_silver_searcher_bld_dir} -j ${jobs} -k check || return
	make -C ${the_silver_searcher_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_the_platinum_searcher()
{
	[ -x ${prefix}/bin/pt -a "${force_install}" != yes ] && return
	which go > /dev/null || install_native_go || return
	GOPATH=${DESTDIR}${prefix}/.go go install -v github.com/monochromegane/the_platinum_searcher/...@v${the_platinum_searcher_ver} || return
	mkdir -pv ${DESTDIR}${prefix}/bin && ln -fsv ../.go/bin/pt ${DESTDIR}${prefix}/bin || return
}

install_native_highway()
{
	[ -x ${prefix}/bin/hw -a "${force_install}" != yes ] && return
	which gperf > /dev/null || install_native_gperf || return
	which autoconf > /dev/null || install_native_autoconf || return
	which automake > /dev/null || install_native_automake || return
	fetch highway || return
	unpack highway || return
	sed -i -e "s%^\./configure %&--prefix=${prefix} --host=${host} %;
				s/^make\$/& -j ${jobs} \&\& make -j ${jobs} install${strip:+-${strip}}/" \
				${highway_src_dir}/tools/build.sh || return
	(cd ${highway_src_dir}
	./tools/build.sh) || return
}

install_native_ripgrep()
{
	[ -x ${prefix}/bin/rg -a "${force_install}" != yes ] && return
	which cargo > /dev/null || install_native_rustc || return
	fetch ripgrep || return
	unpack ripgrep || return
	(cd ${ripgrep_src_dir}
	cargo install -j ${jobs} -v --path . --no-track \
		--root ${DESTDIR}${prefix} --features pcre2) || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/rg || return
}

install_native_ghostscript()
{
	[ -x ${prefix}/bin/gs -a "${force_install}" != yes ] && return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	fetch ghostscript || return
	unpack ghostscript || return
	[ -f ${ghostscript_bld_dir}/Makefile ] ||
		(cd ${ghostscript_bld_dir}
		${ghostscript_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-dynamic --with-system-libtiff) || return
	make -C ${ghostscript_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${ghostscript_bld_dir} -j ${jobs} -k check || return
	make -C ${ghostscript_bld_dir} -j ${jobs} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/gs || return
}

install_native_graphviz()
{
	[ -x ${prefix}/bin/dot -a "${force_install}" != yes ] && return
	which swig > /dev/null || install_native_swig || return
	fetch graphviz || return
	unpack graphviz || return
	[ -f ${graphviz_bld_dir}/Makefile ] ||
		(cd ${graphviz_bld_dir}
		${graphviz_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-static --enable-shared --enable-swig --enable-go --enable-guile \
			--enable-perl --enable-python --enable-ruby --enable-tcl --disable-lua --disable-php \
			--without-qt) || return
	make -C ${graphviz_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${graphviz_bld_dir} -j ${jobs} -k check || return
	make -C ${graphviz_bld_dir} -j 1 install${strip:+-${strip}} || return # XXX work around for parallel make
	update_path || return
}

install_native_doxygen()
{
	[ -x ${prefix}/bin/doxygen -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which clang > /dev/null || install_native_clang || return
	which flex > /dev/null || install_native_flex || return
	which yacc > /dev/null || install_native_bison || return
	fetch doxygen || return
	unpack doxygen || return
	[ -d ${doxygen_src_dir} ] ||
		mv -v ${src}/doxygen/doxygen-Release_`echo ${doxygen_ver} | tr . _` ${doxygen_src_dir} || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${doxygen_src_dir} -B ${doxygen_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_C_FLAGS="${CFLAGS} -DLIBICONV_PLUG" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DLIBICONV_PLUG" \
		-Dbuild_parse=ON -Duse_libclang=ON ${doxygen_src_dir} || return
	cmake --build ${doxygen_bld_dir} -v -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		cmake --build ${doxygen_bld_dir} -v -j ${jobs} --target tests || return
	cmake --install ${doxygen_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_freetype()
{
	[ -f ${prefix}/include/freetype2/ft2build.h -a "${force_install}" != yes ] && return
	fetch freetype || return
	unpack freetype || return
	(cd ${freetype_bld_dir}
	${freetype_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
		--enable-freetype-config) || return
	make -C ${freetype_bld_dir} -j ${jobs} RC= || return
	[ "${enable_check}" != yes ] ||
		make -C ${freetype_bld_dir} -j ${jobs} -k check || return
	make -C ${freetype_bld_dir} -j ${jobs} RC= install || return
	update_path || return
}

install_native_fontconfig()
{
	[ -f ${prefix}/include/fontconfig/fontconfig.h -a "${force_install}" != yes ] && return
	fetch fontconfig || return
	unpack fontconfig || return
	[ -f ${fontconfig_bld_dir}/Makefile ] ||
		(cd ${fontconfig_bld_dir}
		${fontconfig_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules \
			--enable-static --disable-rpath \
			FREETYPE_CFLAGS="${CFLAGS} `I freetype2/freetype/freetype.h` `I freetype2/freetype/freetype.h`/freetype2" \
			FREETYPE_LIBS="${LIBS} `l freetype`") || return
	make -C ${fontconfig_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${fontconfig_bld_dir} -j ${jobs} -k check || return
	make -C ${fontconfig_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_plantuml()
{
	[ -x ${prefix}/bin/plantuml -a "${force_install}" != yes ] && return
	which dot > /dev/null || install_native_graphviz || return
	print_library_path libfreetype.so > /dev/null || install_native_freetype || return
	print_library_path libfontconfig.so > /dev/null || install_native_fontconfig || return
	fetch plantuml || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	cp -fv ${plantuml_src_dir}.jar ${DESTDIR}${prefix}/bin/plantuml.jar || return
	cat <<'EOF' > ${DESTDIR}${prefix}/bin/plantuml && chmod -v a+x ${DESTDIR}${prefix}/bin/plantuml || return
#!/bin/sh -e
exec java -Djava.awt.headless=true -jar `dirname ${0}`/plantuml.jar -graphvizdot `which dot` "$@"
EOF
	mkdir -pv ${DESTDIR}${prefix}/share/plantuml || return
	cp -fv ${plantuml_src_dir}.pdf ${DESTDIR}${prefix}/share/plantuml/plantuml.pdf || return
}

install_native_diffutils()
{
	[ -x ${prefix}/bin/diff -a "${force_install}" != yes ] && return
	fetch diffutils || return
	unpack diffutils || return
	[ -f ${diffutils_bld_dir}/Makefile ] ||
		(cd ${diffutils_bld_dir}
		${diffutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules --disable-rpath) || return
	make -C ${diffutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${diffutils_bld_dir} -j ${jobs} -k check || return
	make -C ${diffutils_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_patch()
{
	[ -x ${prefix}/bin/patch -a "${force_install}" != yes ] && return
	fetch patch || return
	unpack patch || return
	[ -f ${patch_bld_dir}/Makefile ] ||
		(cd ${patch_bld_dir}
		${patch_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${patch_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${patch_bld_dir} -j ${jobs} -k check || return
	make -C ${patch_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_findutils()
{
	[ -x ${prefix}/bin/find -a "${force_install}" != yes ] && return
	fetch findutils || return
	unpack findutils || return
	[ -f ${findutils_bld_dir}/Makefile ] ||
		(cd ${findutils_bld_dir}
		${findutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules --enable-threads) || return
	make -C ${findutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${findutils_bld_dir} -j ${jobs} -k check || return
	make -C ${findutils_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_procps()
{
	[ -x ${prefix}/bin/ps -a "${force_install}" != yes ] && return
	fetch procps || return
	unpack procps || return
	[ -f ${procps_src_dir}/configure ] ||
		(cd ${procps_src_dir}; ./autogen.sh) || return
	[ -f ${procps_bld_dir}/configure ] || cp -Tvr ${procps_src_dir} ${procps_bld_dir} || return
	[ -f ${procps_bld_dir}/Makefile ] ||
		(cd ${procps_bld_dir}
		./configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
	make -C ${procps_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${procps_bld_dir} -j ${jobs} -k check || return
	make -C ${procps_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_lsof()
{
	[ -x ${prefix}/bin/lsof -a "${force_install}" != yes ] && return
	fetch lsof || return
	unpack lsof || return
	[ -f ${lsof_bld_dir}/Makefile ] || cp -Tvr ${lsof_src_dir} ${lsof_bld_dir} || return
	[ -f ${lsof_bld_dir}/Makefile ] ||
		(cd ${lsof_bld_dir}
		echo nn | ./Configure linux) || return
	make -C ${lsof_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lsof_bld_dir} -j ${jobs} -k check || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${lsof_bld_dir}/lsof || return
}

install_native_sysstat()
{
	[ -x ${prefix}/bin/sar -a "${force_install}" != yes ] && return
	fetch sysstat || return
	unpack sysstat || return
	[ -f ${sysstat_bld_dir}/configure ] || cp -Tvr ${sysstat_src_dir} ${sysstat_bld_dir} || return
	[ -f ${sysstat_bld_dir}/Makefile ] ||
		(cd ${sysstat_bld_dir}
		./configure --prefix=${prefix} --host=${host} \
			--with-systemdsystemunitdir=${prefix}/lib/systemd/system \
			--with-systemdsleepdir=${prefix}/lib/systemd/system-sleep \
			--enable-install-cron --enable-collect-all --enable-copy-only \
			sa_dir=${prefix}/var/log/sa \
			conf_dir=${prefix}/etc/sysconfig) || return
	make -C ${sysstat_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${sysstat_bld_dir} -j ${jobs} -k check || return
	make -C ${sysstat_bld_dir} -j ${jobs} IGNORE_FILE_ATTRIBUTES=y install || return
}

install_native_less()
{
	[ -x ${prefix}/bin/less -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch less || return
	unpack less || return
	[ -f ${less_bld_dir}/Makefile ] ||
		(cd ${less_bld_dir}
		${less_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${less_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${less_bld_dir} -j ${jobs} -k check || return
	make -C ${less_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
}

install_native_groff()
{
	[ -x ${prefix}/bin/groff -a "${force_install}" != yes ] && return
	fetch groff || return
	unpack groff || return
	[ -f ${groff_bld_dir}/Makefile ] ||
		(cd ${groff_bld_dir}
		${groff_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --disable-rpath) || return
	make -C ${groff_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${groff_bld_dir} -j ${jobs} -k check || return
	make -C ${groff_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
}

install_native_gdbm()
{
	[ -f ${prefix}/include/gdbm.h -a "${force_install}" != yes ] && return
	fetch gdbm || return
	unpack gdbm || return
	[ -f ${gdbm_bld_dir}/Makefile ] ||
		(cd ${gdbm_bld_dir}
		${gdbm_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --disable-rpath) || return
	make -C ${gdbm_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gdbm_bld_dir} -j ${jobs} -k check || return
	make -C ${gdbm_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libpipeline()
{
	[ -f ${prefix}/include/pipeline.h -a "${force_install}" != yes ] && return
	fetch libpipeline || return
	unpack libpipeline || return
	[ -f ${libpipeline_bld_dir}/Makefile ] ||
		(cd ${libpipeline_bld_dir}
		${libpipeline_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --enable-static --disable-rpath) || return
	make -C ${libpipeline_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpipeline_bld_dir} -j ${jobs} -k check || return
	make -C ${libpipeline_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	update_path || return
}

install_native_man_db()
{
	[ -x ${prefix}/bin/man -a "${force_install}" != yes ] && return
	print_header_path gdbm.h > /dev/null || install_native_gdbm || return
	print_header_path pipeline.h > /dev/null || install_native_libpipeline || return
	fetch man-db || return
	unpack man-db || return
	[ -f ${man_db_bld_dir}/Makefile ] ||
		(cd ${man_db_bld_dir}
		${man_db_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--disable-setuid --enable-static --disable-rpath \
			--without-systemdtmpfilesdir --without-systemdsystemunitdir) || return
	make -C ${man_db_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${man_db_bld_dir} -j ${jobs} -k check || return
	make -C ${man_db_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
}

install_native_file()
{
	[ -x ${prefix}/bin/file -a "${force_install}" != yes ] && return
	fetch file || return
	unpack file || return
	[ -f ${file_bld_dir}/Makefile ] ||
		(cd ${file_bld_dir}
		${file_src_dir}/configure --prefix=${prefix} --host=${host} --enable-static --disable-silent-rules) || return
	make -C ${file_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${file_bld_dir} -j ${jobs} check || return
	make -C ${file_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	update_path || return
}

install_native_source_highlight()
{
	[ -x ${prefix}/bin/source-highlight -a "${force_install}" != yes ] && return
	print_header_path version.h boost > /dev/null || install_native_boost || return
	fetch source-highlight || return
	unpack source-highlight || return
	[ -f ${source_highlight_bld_dir}/Makefile ] ||
		(cd ${source_highlight_bld_dir}
		${source_highlight_src_dir}/configure --prefix=${prefix} --build=${build} \
			CXXFLAGS="${CXXFLAGS} -std=c++14") || return # XXX: workaround for Dynamic Exception Specification.
	make -C ${source_highlight_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${source_highlight_bld_dir} -j ${jobs} -k check || return
	make -C ${source_highlight_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_screen()
{
	[ -x ${prefix}/bin/screen -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch screen || return
	unpack screen || return
	[ -f ${screen_src_dir}/configure ] || autoreconf -fiv ${screen_src_dir} || return
	[ -f ${screen_bld_dir}/Makefile ] ||
		(cd ${screen_bld_dir}
		${screen_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-telnet --enable-colors256 --enable-rxvt_osc) || return
	make -C ${screen_bld_dir} -j ${jobs} || return
	mkdir -pv ${DESTDIR}${prefix}/share/screen/utf8encodings || return
	make -C ${screen_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${screen_name} || return
}

install_native_libevent()
{
	[ -f ${prefix}/include/event2/event.h -a "${force_install}" != yes ] && return
	fetch libevent || return
	unpack libevent || return
	[ -f ${libevent_bld_dir}/Makefile ] ||
		(cd ${libevent_bld_dir}
		${libevent_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libevent_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libevent_bld_dir} -j ${jobs} -k check || return
	make -C ${libevent_bld_dir} -j ${jobs} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for l in '' _core _extra _openssl _pthreads; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libevent${l}.so || return
	done
}

install_native_tmux()
{
	[ -x ${prefix}/bin/tmux -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	print_header_path event.h event2 > /dev/null || install_native_libevent || return
	fetch tmux || return
	unpack tmux || return
	[ -f ${tmux_bld_dir}/Makefile ] ||
		(cd ${tmux_bld_dir}
		${tmux_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			CPPFLAGS="${CPPFLAGS} `I curses.h`" LIBTINFO_LIBS=-ltinfo) || return
	make -C ${tmux_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tmux_bld_dir} -j ${jobs} -k check || return
	make -C ${tmux_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/tmux || return
}

install_native_expect()
{
	[ -x ${prefix}/bin/expect -a "${force_install}" != yes ] && return
	print_library_path tclConfig.sh > /dev/null || install_native_tcl || return
	fetch expect || return
	unpack expect || return
	[ -f ${expect_bld_dir}/Makefile ] ||
		(cd ${expect_bld_dir}
		${expect_src_dir}/configure --prefix=${prefix} --exec-prefix=${prefix} --build=${build} --enable-threads \
			--enable-64bit --with-tcl=`print_library_dir tclConfig.sh`) || return
	make -C ${expect_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${expect_bld_dir} -j ${jobs} -k check || return
	make -C ${expect_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
	ln -fsv ${expect_name}/lib${expect_name}.so ${DESTDIR}${prefix}/lib || return
	update_path || return
}

install_native_dejagnu()
{
	[ -x ${prefix}/bin/runtest -a "${force_install}" != yes ] && return
	which expect > /dev/null || install_native_expect || return
	fetch dejagnu || return
	unpack dejagnu || return
	[ -f ${dejagnu_bld_dir}/Makefile ] ||
		(cd ${dejagnu_bld_dir}
		${dejagnu_src_dir}/configure --prefix=${prefix} --build=${build}) || return
	make -C ${dejagnu_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${dejagnu_bld_dir} -j ${jobs} -k check || return
	make -C ${dejagnu_bld_dir} -j ${jobs} install || return
}

install_native_zsh()
{
	[ -x ${prefix}/bin/zsh -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch zsh || return
	unpack zsh || return
	[ -f ${zsh_bld_dir}/configure ] || cp -Tvr ${zsh_src_dir} ${zsh_bld_dir} || return
	[ -f ${zsh_bld_dir}/Makefile ] ||
		(cd ${zsh_bld_dir}
		./configure --prefix=${prefix} --build=${build} --host=${host} \
			--enable-multibyte --enable-unicode9 --with-tcsetpgrp) || return
	make -C ${zsh_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${zsh_bld_dir} -j ${jobs} -k check || return
	make -C ${zsh_bld_dir} -j ${jobs} install || return
}

install_native_bash()
{
	[ -x ${prefix}/bin/bash -a "${force_install}" != yes ] && return
	fetch bash || return
	unpack bash || return
	[ -f ${bash_bld_dir}/Makefile ] ||
		(cd ${bash_bld_dir}
		${bash_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-rpath) || return
	make -C ${bash_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${bash_bld_dir} -j ${jobs} -k check || return
	make -C ${bash_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	update_path || return
	[ -e ${DESTDIR}${prefix}/bin/sh ] || ln -fsv bash ${DESTDIR}${prefix}/bin/sh || return
}

install_native_dash()
{
	[ -x ${prefix}/bin/dash -a "${force_install}" != yes ] && return
	fetch dash || return
	unpack dash || return
	[ -f ${dash_src_dir}/configure ] || autoreconf -fiv ${dash_src_dir} || return
	[ -f ${dash_bld_dir}/Makefile ] ||
		(cd ${dash_bld_dir}
		${dash_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${dash_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${dash_bld_dir} -j ${jobs} -k check || return
	make -C ${dash_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	update_path || return
	[ -e ${DESTDIR}${prefix}/bin/sh ] || ln -fsv dash ${DESTDIR}${prefix}/bin/sh || return
}

install_native_tcsh()
{
	[ -x ${prefix}/bin/tcsh -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch tcsh || return
	unpack tcsh || return
	[ -f ${tcsh_bld_dir}/Makefile ] ||
		(cd ${tcsh_bld_dir}
		${tcsh_src_dir}/configure --prefix=${prefix} --host=${host} --disable-rpath) || return
	make -C ${tcsh_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tcsh_bld_dir} -j ${jobs} -k check || return
	make -C ${tcsh_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
	ln -fsv tcsh ${DESTDIR}/${prefix}/bin/csh || return
}

install_native_inetutils()
{
	[ -x ${prefix}/bin/telnet -a "${force_install}" != yes ] && return
	fetch inetutils || return
	unpack inetutils || return
	[ -f ${inetutils_bld_dir}/Makefile ] ||
		(cd ${inetutils_bld_dir}
		${inetutils_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules LDFLAGS=-ltinfo) || return
	make -C ${inetutils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${inetutils_bld_dir} -j ${jobs} -k check || return
	make -C ${inetutils_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_iproute2()
{
	[ -d ${prefix}/include/iproute2 -a "${force_install}" != yes ] && return
	fetch iproute2 || return
	unpack iproute2 || return
	[ -f ${iproute2_bld_dir}/Makefile ] || cp -Tvr ${iproute2_src_dir} ${iproute2_bld_dir} || return
	make -C ${iproute2_bld_dir} -j ${jobs} V=1 \
		PREFIX=${prefix} \
		CONFDIR=${prefix}/etc/iproute2 \
		NETNS_RUN_DIR=${prefix}/var/run/netns \
		NETNS_ETC_DIR=${prefix}/etc/netns \
		HOSTCC=${CC:-${host:+${host}-}gcc} || return
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
}

install_native_util_linux()
{
	[ -x ${prefix}/bin/hexdump -a "${force_install}" != yes ] && return
	fetch util-linux || return
	unpack util-linux || return
	[ -f ${util_linux_bld_dir}/Makefile ] ||
		(cd ${util_linux_bld_dir}
		${util_linux_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--enable-write --disable-use-tty-group --with-bashcompletiondir=${prefix}/share/bash-completion) || return
	make -C ${util_linux_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${util_linux_bld_dir} -j ${jobs} -k check || return
	make -C ${util_linux_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_pciutils()
{
	[ -x ${prefix}/bin/lspci -a "${force_install}" != yes ] && return
	print_header_path libkmod.h > /dev/null || install_native_kmod || return
	fetch pciutils || return
	unpack pciutils || return
	[ -f ${pciutils_bld_dir}/Makefile ] || cp -Tvr ${pciutils_src_dir} ${pciutils_bld_dir} || return
	sed -i -e "
		/^\(PREFIX=\).\+/s!!\1${prefix}!
		/^STRIP=-s\$/s!!& --strip-program=${host:+${host}-}strip!" ${pciutils_bld_dir}/Makefile || return
	make -C ${pciutils_bld_dir} -j ${jobs} PREFIX=${prefix} HOST=${host} \
		CROSS_COMPILE=${host:+${host}-} \
		LDFLAGS="${LDFLAGS} `Wl_rpath_link zstd lzma z crypto`" \
		|| return
	make -C ${pciutils_bld_dir} -j ${jobs} install DESTDIR=${DESTDIR} || return
}

install_native_lsscsi()
{
	[ -x ${prefix}/bin/lsscsi -a "${force_install}" != yes ] && return
	fetch lsscsi || return
	unpack lsscsi || return
	[ -f ${lsscsi_bld_dir}/Makefile ] ||
		(cd ${lsscsi_bld_dir}
		${lsscsi_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules) || return
	make -C ${lsscsi_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lsscsi_bld_dir} -j ${jobs} -k check || return
	make -C ${lsscsi_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
}

install_native_parted()
{
	[ -x ${prefix}/sbin/parted -a "${force_install}" != yes ] && return
	print_header_path uuid.h uuid > /dev/null || install_native_util_linux || return
	fetch parted || return
	unpack parted || return
	[ -f ${parted_bld_dir}/Makefile ] ||
		(cd ${parted_bld_dir}
		remove_rpath_option parted || return
		${parted_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--disable-device-mapper --disable-rpath) || return
	make -C ${parted_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${parted_bld_dir} -j ${jobs} -k check || return
	make -C ${parted_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_e2fsprogs()
{
	[ -x ${prefix}/sbin/mkfs.ext2 -a "${force_install}" != yes ] && return
	print_header_path uuid.h uuid > /dev/null || install_native_util_linux || return
	fetch e2fsprogs || return
	unpack e2fsprogs || return
	[ -f ${e2fsprogs_bld_dir}/Makefile ] ||
		(cd ${e2fsprogs_bld_dir}
		${e2fsprogs_src_dir}/configure --prefix=${prefix} --host=${host} \
			--enable-verbose-makecmds --enable-elf-shlibs --disable-rpath \
			) || return
	make -C ${e2fsprogs_bld_dir} -j 1 || return # -j '1' is for workaround
	[ "${enable_check}" != yes ] ||
		make -C ${e2fsprogs_bld_dir} -j ${jobs} -k check || return
	make -C ${e2fsprogs_bld_dir} -j ${jobs} install || return
	make -C ${e2fsprogs_bld_dir} -j ${jobs} install-libs || return
	update_path || return
}

install_native_btrfs_progs()
{
	[ -x ${prefix}/bin/mkfs.btrfs -a "${force_install}" != yes ] && return
	print_header_path uuid.h uuid > /dev/null || install_native_util_linux || return
	print_header_path ext2_fs.h ext2fs > /dev/null || install_native_e2fsprogs || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	print_header_path lzoconf.h lzo > /dev/null || install_native_lzo || return
	fetch btrfs-progs || return
	unpack btrfs-progs || return
	[ -f ${btrfs_progs_src_dir}/configure ] || (cd ${btrfs_progs_src_dir}; ./autogen.sh) || return
	[ -f ${btrfs_progs_bld_dir}/configure ] || cp -Tvr ${btrfs_progs_src_dir} ${btrfs_progs_bld_dir} || return
	[ -f ${btrfs_progs_bld_dir}/Makefile.inc ] ||
		(cd ${btrfs_progs_bld_dir}
		${btrfs_progs_src_dir}/configure --prefix=${prefix} --host=${host} \
			--disable-documentation --disable-libudev --disable-python \
			) || return
	make -C ${btrfs_progs_bld_dir} -j ${jobs} V=1 EXTRA_CFLAGS="${CFLAGS} `I uuid/uuid.h`" || return
	make -C ${btrfs_progs_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
	update_path || return
}

install_native_squashfs()
{
	[ -x ${prefix}/bin/mksquashfs -a "${force_install}" != yes ] && return
	fetch squashfs || return
	unpack squashfs || return
	[ -f ${squashfs_bld_dir}/Makefile ] || cp -Tvr ${squashfs_src_dir} ${squashfs_bld_dir} || return
	make -C ${squashfs_bld_dir}/squashfs-tools -j ${jobs} XZ_SUPPORT=1 || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	make -C ${squashfs_bld_dir}/squashfs-tools -j ${jobs} INSTALL_DIR=${DESTDIR}${prefix}/bin install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/mksquashfs ${DESTDIR}${prefix}/bin/unsquashfs || return
}

install_native_openssl()
{
	[ -d ${prefix}/include/openssl -a "${force_install}" != yes ] && return
	fetch openssl || return
	unpack openssl || return
	(cd ${openssl_bld_dir}
	${openssl_src_dir}/config --prefix=${prefix} shared linux-`echo ${host} | cut -d- -f1`) || return
	make -C ${openssl_bld_dir} -j ${jobs} CROSS_COMPILE=${host}- || return
	[ "${enable_check}" != yes ] ||
		make -C ${openssl_bld_dir} -j ${jobs} -k test || return
	mkdir -pv ${DESTDIR}${prefix}/ssl || return
	rm -fv ${DESTDIR}${prefix}/ssl/certs || return
	[ ! -d /etc/ssl/certs ] || ln -fsv /etc/ssl/certs ${DESTDIR}${prefix}/ssl/certs || return
	[   -d /etc/ssl/certs ] || mkdir -pv ${DESTDIR}${prefix}/ssl/certs || return
	make -C ${openssl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
	mkdir -pv ${DESTDIR}${prefix}/lib/pkgconfig || return
	for f in libcrypto.pc libssl.pc openssl.pc; do
		[ ! -f ${DESTDIR}${prefix}/lib64/pkgconfig/${f} ] || ln -fsv ../../lib64/pkgconfig/${f} ${DESTDIR}${prefix}/lib/pkgconfig || return
	done
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/openssl || return
}

install_native_openssh()
{
	[ -x ${prefix}/bin/ssh -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	fetch openssh || return
	unpack openssh || return
	[ -f ${openssh_bld_dir}/Makefile ] ||
		(cd ${openssh_bld_dir}
		${openssh_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--with-zlib=`print_prefix zlib.h` --with-privsep-path=${prefix}/var/empty \
			--with-default-path=${prefix}/bin:/usr/bin:/bin:${prefix}/sbin:/usr/sbin:/sbin) || return
	make -C ${openssh_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${openssh_bld_dir} -j ${jobs} -k tests || return
	make -C ${openssh_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
}

install_native_nghttp2()
{
	[ -f ${prefix}/include/nghttp2/nghttp2.h -a "${force_install}" != yes ] && return
	which pkg-config > /dev/null || install_native_pkg_config || return
	fetch nghttp2 || return
	unpack nghttp2 || return
	[ -f ${nghttp2_bld_dir}/Makefile ] ||
		(cd ${nghttp2_bld_dir}
		${nghttp2_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules --enable-lib-only) || return
	make -C ${nghttp2_bld_dir} -j ${jobs} || return
	make -C ${nghttp2_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_brotli()
{
	[ -x ${prefix}/bin/brotli -a "${force_install}" != yes ] && return
	fetch brotli || return
	unpack brotli || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${brotli_src_dir} -B ${brotli_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		|| return
	cmake --build ${brotli_bld_dir} -v -j ${jobs} || return
	cmake --install ${brotli_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_libssh()
{
	[ -f ${prefix}/include/libssh/libssh.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	fetch libssh || return
	unpack libssh || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${libssh_src_dir} -B ${libssh_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		|| return
	cmake --build ${libssh_bld_dir} -v -j ${jobs} || return
	cmake --install ${libssh_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_curl()
{
	[ -x ${prefix}/bin/curl -a "${force_install}" != yes ] && return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path libpsl.h > /dev/null || install_native_libpsl || return
	fetch curl || return
	unpack curl || return
	(cd ${curl_bld_dir}
	${curl_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
		--enable-optimize --disable-silent-rules \
		--enable-http --enable-ftp --enable-file \
		--disable-ldap --disable-ldaps --enable-rtsp --enable-proxy \
		--enable-dict --enable-telnet --enable-tftp --enable-pop3 \
		--enable-imap --enable-smb --enable-smtp --enable-gopher \
		--enable-mqtt --enable-manual --enable-ipv6 \
		--disable-versioned-symbols \
		--with-openssl=`print_prefix ssl.h openssl` \
		--with-libssh=`print_prefix libssh.h libssh || echo no` \
		LDFLAGS="${LDFLAGS} `L psl`") || return
	make -C ${curl_bld_dir} -j ${jobs} || return
	make -C ${curl_bld_dir} -j ${jobs} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/curl || return
}

install_native_expat()
{
	[ -f ${prefix}/include/expat.h -a "${force_install}" != yes ] && return
	fetch expat || return
	unpack expat || return
	[ -f ${expat_bld_dir}/Makefile ] ||
		(cd ${expat_bld_dir}
		${expat_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${expat_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${expat_bld_dir} -j ${jobs} -k check || return
	make -C ${expat_bld_dir} -j ${jobs} INSTALL_ROOT=${DESTDIR} install || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/xmlwf || return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libexpat.so || return
}

install_native_asciidoc()
{
	[ -x ${prefix}/bin/asciidoc -a "${force_install}" != yes ] && return
	which xsltproc > /dev/null || install_native_libxslt || return
	fetch asciidoc || return
	unpack asciidoc || return
	[ -f ${asciidoc_src_dir}/configure ] || autoreconf -fiv ${asciidoc_src_dir} || return
	sed -i -e 's!^\(	python3 -m pip install --root \$(DESTDIR)\)\( \.\)$!\1 --prefix '${prefix}'\2!' ${asciidoc_src_dir}/Makefile.in || return
	[ -f ${asciidoc_bld_dir}/configure ] || cp -Tvr ${asciidoc_src_dir} ${asciidoc_bld_dir} || return
	[ -f ${asciidoc_bld_dir}/Makefile ] ||
		(cd ${asciidoc_bld_dir}
		./configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${asciidoc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${asciidoc_bld_dir} -j ${jobs} -k test || return
	make -C ${asciidoc_bld_dir} -j ${jobs} install || return
}

install_native_libxml2()
{
	[ -d ${prefix}/include/libxml2 -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	print_header_path Python.h > /dev/null || install_native_Python || return
	fetch libxml2 || return
	unpack libxml2 || return
	[ -f ${libxml2_bld_dir}/Makefile ] ||
		(cd ${libxml2_bld_dir}
		remove_rpath_option libxml2 || return
		${libxml2_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules) || return
	make -C ${libxml2_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libxml2_bld_dir} -j ${jobs} -k check || return
	make -C ${libxml2_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libxslt()
{
	[ -d ${prefix}/include/libxslt -a "${force_install}" != yes ] && return
	print_header_path xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	fetch libxslt || return
	unpack libxslt || return
	[ -f ${libxslt_bld_dir}/Makefile ] ||
		(cd ${libxslt_bld_dir}
		${libxslt_src_dir}/configure --prefix=${prefix} --build=${build} --disable-silent-rules) || return
	make -C ${libxslt_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libxslt_bld_dir} -j ${jobs} -k check || return
	make -C ${libxslt_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_xmlto()
{
	[ -x ${prefix}/bin/xmlto -a "${force_install}" != yes ] && return
	print_header_path xslt.h libxslt > /dev/null || install_native_libxslt || return
	fetch xmlto || return
	unpack xmlto || return
	[ -f ${xmlto_bld_dir}/Makefile ] ||
		(cd ${xmlto_bld_dir}
		${xmlto_src_dir}/configure --prefix=${prefix} --build=${build}) || return
	make -C ${xmlto_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${xmlto_bld_dir} -j ${jobs} -k check || return
	make -C ${xmlto_bld_dir} -j ${jobs} install || return
}

install_native_gettext()
{
	[ -x ${prefix}/bin/gettext -a "${force_install}" != yes ] && return
	fetch gettext || return
	unpack gettext || return
	[ -f ${gettext_bld_dir}/Makefile ] ||
		(cd ${gettext_bld_dir}
		${gettext_src_dir}/configure --prefix=${prefix} --build=${build} \
			--enable-threads --disable-rpath) || return
	make -C ${gettext_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gettext_bld_dir} -j ${jobs} -k check || return
	make -C ${gettext_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_git()
{
	[ -x ${prefix}/bin/git -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path curl.h curl > /dev/null || install_native_curl || return
	print_header_path expat.h > /dev/null || install_native_expat || return
	print_header_path pcre2.h > /dev/null || install_native_pcre2 || return
	which asciidoc > /dev/null || install_native_asciidoc || return
	which xmlto > /dev/null || install_native_xmlto || install_native_git_manpages || return
	which msgfmt > /dev/null || install_native_gettext || return
	which perl > /dev/null || install_native_perl || return
	which wish > /dev/null || install_native_tk || return
	fetch git || return
	unpack git || return
	make -C ${git_src_dir} -j ${jobs} V=1 configure || return
	(cd ${git_src_dir}
	./configure --prefix=${prefix} --build=${build} \
		--with-openssl=`print_prefix ssl.h openssl` --with-libpcre=`print_prefix pcre2.h` \
		--with-iconv=`print_prefix iconv.h` --with-perl=`which perl` --with-python=`which python3` \
		--with-zlib=`print_prefix zlib.h`) || return
	sed -i -e 's/+= -DNO_HMAC_CTX_CLEANUP/+= # -DNO_HMAC_CTX_CLEANUP/' ${git_src_dir}/Makefile || return
	sed -i -e 's/^\(CC_LD_DYNPATH=\).\+/\1-L/' ${git_src_dir}/config.mak.autogen || return
	make -C ${git_src_dir} -j ${jobs} V=1 PROFILE=BUILD LDFLAGS="${LDFLAGS} -ldl" all || return
	make -C ${git_src_dir} -j ${jobs} V=1 doc || install_native_git_manpages || return
	[ "${enable_check}" != yes ] ||
		make -C ${git_src_dir} -j ${jobs} -k V=1 test || return
	make -C ${git_src_dir} -j ${jobs} V=1 ${strip} install || return
	make -C ${git_src_dir} -j ${jobs} -k V=1 install-doc install-html || true # git-manpagesでfallbackするのでmake install-docの失敗はシェル関数の失敗ではない。
	[ -z "${strip}" ] && return
	for b in git git-receive-pack git-upload-archive git-upload-pack; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_git_manpages()
{
	[ -f ${prefix}/share/man/man1/git.1 -a "${force_install}" != yes ] && return
	fetch git-manpages || return
	unpack git-manpages ${DESTDIR}${prefix}/share/man || return
}

install_native_git_lfs()
{
	[ -x ${prefix}/bin/git-lfs -a "${force_install}" != yes ] && return
	fetch git-lfs || return
	unpack git-lfs || return
	[ -f ${git_lfs_bld_dir}/Makefile ] || cp -Tvr ${git_lfs_src_dir} ${git_lfs_bld_dir} || return
	make -C ${git_lfs_bld_dir} -j ${jobs} || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	cp -fv ${git_lfs_bld_dir}/bin/git-lfs ${DESTDIR}${prefix}/bin || return
}

install_native_mercurial()
{
	[ -x ${prefix}/bin/hg -a "${force_install}" != yes ] && return
	which python3 > /dev/null || install_native_Python || return
	fetch mercurial || return
	unpack mercurial || return
	pip3 install docutils || return
	make -C ${mercurial_src_dir} -j ${jobs} PYTHON=python all || return
	[ "${enable_check}" != yes ] ||
		make -C ${mercurial_src_dir} -j ${jobs} PYTHON=python -k check || return
	make -C ${mercurial_src_dir} -j ${jobs} PREFIX=${prefix} install || return
}

install_native_sqlite()
{
	[ -f ${prefix}/include/sqlite3.h -a "${force_install}" != yes ] && return
	fetch sqlite || return
	unpack sqlite || return
	[ -f ${sqlite_bld_dir}/Makefile ] ||
		(cd ${sqlite_bld_dir}
		${sqlite_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${sqlite_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${sqlite_bld_dir} -j ${jobs} -k check || return
	make -C ${sqlite_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_apr()
{
	[ -d ${prefix}/include/apr-1 -a "${force_install}" != yes ] && return
	fetch apr || return
	unpack apr || return
	[ -f ${apr_bld_dir}/Makefile ] ||
		(cd ${apr_bld_dir}
		${apr_src_dir}/configure --prefix=${prefix} --build=${build} \
			--enable-threads --enable-posix-shm --enable-other-child) || return
	make -C ${apr_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${apr_bld_dir} -j ${jobs} -k check || return
	make -C ${apr_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_apr_util()
{
	[ -f ${prefix}/include/apr-1/apu.h -a "${force_install}" != yes ] && return
	print_header_path apr.h apr-1 > /dev/null || install_native_apr || return
	print_header_path sqlite3.h > /dev/null || install_native_sqlite || return
	fetch apr-util || return
	unpack apr-util || return
	[ -f ${apr_util_bld_dir}/Makefile ] ||
		(cd ${apr_util_bld_dir}
		${apr_util_src_dir}/configure --prefix=${prefix} --with-apr=`print_prefix apr.h apr-1` \
			--with-crypto --with-openssl=`print_prefix ssl.h openssl` --with-sqlite3=`print_prefix sqlite3.h`) || return
	make -C ${apr_util_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${apr_util_bld_dir} -j ${jobs} -k check || return
	make -C ${apr_util_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_utf8proc()
{
	[ -f ${prefix}/include/utf8proc.h -a "${force_install}" != yes ] && return
	fetch utf8proc || return
	unpack utf8proc || return
	[ -f ${utf8proc_bld_dir}/Makefile ] || cp -Tvr ${utf8proc_src_dir} ${utf8proc_bld_dir} || return
	make -C ${utf8proc_bld_dir} -j ${jobs} CC=${CC:-${host:+${host}-}gcc} || return
	[ "${enable_check}" != yes ] ||
		make -C ${utf8proc_bld_dir} -j ${jobs} -k check || return
	make -C ${utf8proc_bld_dir} -j ${jobs} prefix=${prefix} install || return
}

install_native_subversion()
{
	[ -x ${prefix}/bin/svn -a "${force_install}" != yes ] && return
	print_header_path apr.h apr-1 > /dev/null || install_native_apr || return
	print_header_path apu.h apr-1 > /dev/null || install_native_apr_util || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path lz4.h > /dev/null || install_native_lz4 || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path utf8proc.h > /dev/null || install_native_utf8proc || return
	which python3 > /dev/null || install_native_Python || return
	which perl > /dev/null || install_native_perl || return
	which ruby > /dev/null || install_native_ruby || return
	fetch subversion || return
	unpack subversion || return
	[ -f ${subversion_bld_dir}/Makefile ] ||
		(cd ${subversion_bld_dir}
		(cd ${subversion_src_dir}; ./autogen.sh || return) || return
		remove_rpath_option subversion || return
		${subversion_src_dir}/configure --prefix=${prefix} --build=${build} \
			--with-zlib=`print_prefix zlib.h` \
			--with-sqlite=`print_prefix sqlite3.h` \
			--with-lz4=`print_prefix lz4.h` ${strip:+--enable-optimize} \
			CFLAGS="${CFLAGS} `I utf8proc.h`" \
			LDFLAGS="${LDFLAGS} `L utf8proc`" \
			|| return
		remove_rpath_option subversion || return
		) || return
	make -C ${subversion_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${subversion_bld_dir} -j ${jobs} -k check || return
	make -C ${subversion_bld_dir} -j ${jobs} install || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in svn svnadmin svnbench svndumpfilter svnfsfs svnlook svnmucc svnrdump svnserve svnsync svnversion; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_ninja()
{
	[ -x ${prefix}/bin/ninja -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch ninja || return
	unpack ninja || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${ninja_src_dir} -B ${ninja_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${prefix} || return
	cmake --build ${ninja_bld_dir} -v -j ${jobs} || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${ninja_bld_dir}/ninja || return
}

install_native_meson()
{
	[ -x ${prefix}/bin/meson -a "${force_install}" != yes ] && return
	which python3 > /dev/null || install_native_Python || return
	which ninja > /dev/null || install_native_ninja || return
	fetch meson || return
	unpack meson || return
	python3 -c "
import os
import sys
d = '${prefix}/lib/python{}.{}/site-packages'.format(*sys.version_info[:2])
if not os.path.isdir(d):
	os.makedirs(d)
sys.exit(int(not d in sys.path))" || update_path || return
	(cd ${meson_src_dir}
	python3 ${meson_src_dir}/setup.py install ${DESTDIR:+--root ${DESTDIR}} --prefix ${DESTDIR}${prefix}) || return
}

install_native_cmake()
{
	[ -x ${prefix}/bin/cmake -a "${force_install}" != yes ] && return
	print_header_path curl.h curl > /dev/null || install_native_curl || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	fetch cmake || return
	unpack cmake || return
	[ -f ${cmake_bld_dir}/Makefile ] ||
		(cd ${cmake_bld_dir}
		${cmake_src_dir}/bootstrap --prefix=${prefix} --parallel=${jobs} \
			--system-curl --system-zlib --system-bzip2 --system-liblzma -- \
			-DCURL_INCLUDE_DIR=`print_header_dir curl.h curl` -DCURL_LIBRARY=`print_library_path libcurl.so` \
			-DBZIP2_INCLUDE_DIR=`print_header_dir bzlib.h` -DBZIP2_LIBRARIES=`print_library_path libbz2.so` \
			-DLIBLZMA_INCLUDE_DIR=`print_header_dir lzma.h` -DLIBLZMA_LIBRARY=`print_library_path liblzma.so`) || return
	make -C ${cmake_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${cmake_bld_dir} -j ${jobs} -k test || return
	make -C ${cmake_bld_dir} -j ${jobs} install${strip:+/${strip}} || return
}

install_native_bazel()
{
	[ -x ${prefix}/bin/bazel -a "${force_install}" != yes ] && return
	which bash > /dev/null || install_native_bash || return
	which zip > /dev/null || install_native_zip || return
	which unzip > /dev/null || install_native_unzip || return
	which javac > /dev/null || install_native_jdk || return
	which python3 > /dev/null || install_native_Python || return
	fetch bazel || return
	[ -d ${bazel_src_dir} ] || unpack bazel ${bazel_src_dir} || return
	[ -f ${bazel_bld_dir}/compile.sh ] || cp -Tvr ${bazel_src_dir} ${bazel_bld_dir} || return
	(cd ${bazel_bld_dir}
	EXTRA_BAZEL_ARGS='--host_javabase=@local_jdk//:jdk' VERBOSE=yes bash ./compile.sh) || return
	mkdir -pv ${DESTDI}${prefix}/bin || return
	cp -fv ${bazel_bld_dir}/output/bazel ${DESTDIR}${prefix}/bin/bazel || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/bazel || return
}

install_native_json()
{
	[ -f ${prefix}/include/nlohmann/json.hpp -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch json || return
	unpack json || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${json_src_dir} -B ${json_bld_dir} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		|| return
	cmake --build ${json_bld_dir} -v -j ${jobs} || return
	cmake --install ${json_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_fmt()
{
	[ -f ${prefix}/include/fmt/format.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch fmt || return
	unpack fmt || return
	for build_shared_libs in OFF ON; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${fmt_src_dir} -B ${fmt_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			|| return
		cmake --build ${fmt_bld_dir} -v -j ${jobs} || return
		cmake --install ${fmt_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_spdlog()
{
	[ -f ${prefix}/include/spdlog/spdlog.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path format.h fmt > /dev/null || install_native_fmt || return
	fetch spdlog || return
	unpack spdlog || return
	for build_shared_libs in OFF ON; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${spdlog_src_dir} -B ${spdlog_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
			-DSPDLOG_BUILD_SHARED=${build_shared_libs} \
			-DSPDLOG_FMT_EXTERNAL=ON \
			|| return
		cmake --build ${spdlog_bld_dir} -v -j ${jobs} || return
		cmake --install ${spdlog_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_Bear()
{
	[ -x ${prefix}/bin/bear -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which make > /dev/null || install_native_make || return
	which python > /dev/null || which python3 > /dev/null || install_native_Python || return
	print_header_path json.hpp nlohmann > /dev/null || install_native_json || return
	print_header_path format.h fmt > /dev/null || install_native_fmt || return
	print_header_path spdlog.h spdlog > /dev/null || install_native_spdlog || return
	which grpc_cpp_plugin > /dev/null || install_native_grpc || return
	fetch Bear || return
	unpack Bear || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${Bear_src_dir} -B ${Bear_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		|| return
	cmake --build ${Bear_bld_dir} -v -j ${jobs} || return
	cmake --install ${Bear_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_ccache()
{
	[ -x ${prefix}/bin/ccache -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	fetch ccache || return
	unpack ccache || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${ccache_src_dir} -B ${ccache_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DREDIS_STORAGE_BACKEND=OFF \
		|| return
	cmake --build ${ccache_bld_dir} -v -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		cmake --build ${ccache_bld_dir} -v -j ${jobs} --target check || return
	cmake --install ${ccache_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
	update_ccache_wrapper -f || return
}

install_native_distcc()
{
	[ -x ${prefix}/bin/distcc -a "${force_install}" != yes ] && return
	fetch distcc || return
	unpack distcc || return
	[ -f ${distcc_bld_dir}/Makefile ] ||
		(cd ${distcc_bld_dir}
		${distcc_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${distcc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${distcc_bld_dir} -j ${jobs} -k check || return
	make -C ${distcc_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	for b in distcc  distccd  distccmon-text  lsdistcc; do
		${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_libedit()
{
	[ -f ${prefix}/include/histedit.h -a "${force_install}" != yes ] && return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	fetch libedit || return
	unpack libedit || return
	[ -f ${libedit_bld_dir}/Makefile ] ||
		(cd ${libedit_bld_dir}
		${libedit_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules CFLAGS="${CFLAGS} `I curses.h`") || return
	make -C ${libedit_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libedit_bld_dir} -j ${jobs} -k check || return
	make -C ${libedit_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_swig()
{
	[ -x ${prefix}/bin/swig -a "${force_install}" != yes ] && return
	print_header_path pcre.h > /dev/null || install_native_pcre || return
	fetch swig || return
	unpack swig || return
	[ -f ${swig_bld_dir}/Makefile ] ||
		(cd ${swig_bld_dir}
		${swig_src_dir}/configure --prefix=${prefix} --build=${build} --enable-cpp11-testing) || return
	make -C ${swig_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${swig_bld_dir} -j ${jobs} -k check || return
	make -C ${swig_bld_dir} -j ${jobs} install || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/swig ${DESTDIR}${prefix}/bin/ccache-swig || return
}

install_native_llvm()
{
	[ -d ${prefix}/include/llvm -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack llvm || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${llvm_src_dir} -B ${llvm_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON -DLLVM_ENABLE_RTTI=ON \
		-DLLVM_INCLUDE_BENCHMARKS=OFF || return
	cmake --build ${llvm_bld_dir} -v -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		cmake --build ${llvm_bld_dir} -v -j ${jobs} --target check || return
	cmake --install ${llvm_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_compiler_rt()
{
	[ -d ${prefix}/include/sanitizer -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	fetch compiler-rt || return
	unpack compiler-rt || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${compiler_rt_src_dir} -B ${compiler_rt_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DSANITIZER_CXX_ABI=libc++ || return
	cmake --build ${compiler_rt_bld_dir} -v -j ${jobs} || return
	cmake --install ${compiler_rt_bld_dir} -v ${strip:+--${strip}} || return
	mkdir -pv ${DESTDIR}${prefix}/lib/clang/`llvm-config --version`/lib || return
	cp -Tfvr ${DESTDIR}${prefix}/lib/linux ${DESTDIR}${prefix}/lib/clang/`llvm-config --version`/lib/linux || return # XXX: workaround for mismatch between clang search path and compiler-rt installation path.
	update_path || return
}

install_native_libunwind()
{
	[ -e ${prefix}/lib/libunwind.so -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack llvm || return
	fetch libcxx || return
	unpack libcxx || return
	fetch libunwind || return
	unpack libunwind || return
	ln -Tfsv ${libcxx_src_dir} ${libunwind_src_dir}/../libcxx || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${libunwind_src_dir} -B ${libunwind_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DLIBUNWIND_USE_COMPILER_RT=ON \
		-DLLVM_PATH=${llvm_src_dir} || return
	cmake --build ${libunwind_bld_dir} -v -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		cmake --build ${libunwind_bld_dir} -v -j ${jobs} --target check-unwind || return
	cmake --install ${libunwind_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_libcxxabi()
{
	[ -e ${prefix}/lib/libc++abi.so -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_library_path libunwind.so > /dev/null || install_native_libunwindnongnu || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	fetch llvm || return
	unpack llvm || return
	fetch libcxx || return
	unpack libcxx || return
	fetch libcxxabi || return
	unpack libcxxabi || return
	ln -Tfsv ${libcxx_src_dir} ${libcxxabi_src_dir}/../libcxx || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${libcxxabi_src_dir} -B ${libcxxabi_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' \
		-DLIBCXXABI_USE_LLVM_UNWINDER=ON \
		-DLIBCXXABI_LIBCXX_INCLUDES=${libcxx_src_dir}/include \
		-DLLVM_PATH=${llvm_src_dir} || return
	cmake --build ${libcxxabi_bld_dir} -v -j ${jobs} || return
	cmake --install ${libcxxabi_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_libcxx()
{
	[ -e ${prefix}/lib/libc++.so -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_library_path libc++abi.so > /dev/null || install_native_libcxxabi || return
	fetch llvm || return
	unpack llvm || return
	fetch libcxxabi || return
	unpack libcxxabi || return
	fetch libcxx || return
	unpack libcxx || return
	ln -Tfsv ${llvm_src_dir} ${libcxx_src_dir}/../llvm || return
	ln -Tfsv ${libcxxabi_src_dir} ${libcxx_src_dir}/../libcxxabi || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${libcxx_src_dir} -B ${libcxx_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_CXX_ABI_INCLUDE_PATHS=${libcxx_src_dir}/../libcxxabi/include \
		-DLIBCXXABI_USE_LLVM_UNWINDER=ON || return
	cmake --build ${libcxx_bld_dir} -v -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		cmake --build ${libcxx_bld_dir} -v -j ${jobs} --target check-libcxx || return
	cmake --install ${libcxx_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_clang()
{
	[ -x ${prefix}/bin/clang -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	print_header_path allocator_interface.h sanitizer > /dev/null || install_native_compiler_rt || return
	print_library_path libunwind.so > /dev/null || install_native_libunwindnongnu || return
	print_library_path libc++abi.so > /dev/null || install_native_libcxxabi || return
	print_header_path iostream c++/v1 > /dev/null || install_native_libcxx || return
	fetch clang || return
	unpack clang || return
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
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${clang_src_dir} -B ${clang_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DENABLE_LINKER_BUILD_ID=ON \
		-DCLANG_DEFAULT_CXX_STDLIB=libc++ \
		-DCLANG_DEFAULT_RTLIB=compiler-rt \
		-DGCC_INSTALL_PREFIX=`print_prefix iostream c++` \
		`which lld > /dev/null && echo -DCLANG_DEFAULT_LINKER=lld` || return
	cmake --build ${clang_bld_dir} -v -j ${jobs} || return
	cmake --install ${clang_bld_dir} -v ${strip:+--${strip}} || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${clang_bld_dir}/bin/clang-tblgen || return
	update_path || return
}

install_native_lld()
{
	[ -x ${prefix}/bin/lld -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch llvm || return
	unpack llvm || return
	fetch libunwind || return
	unpack libunwind || return
	fetch lld || return
	unpack lld || return
	ln -Tfsv ${libunwind_src_dir} ${llvm_src_dir}/../libunwind || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${lld_src_dir} -B ${lld_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON \
		-DLLVM_CONFIG=`which llvm-config` || return
	cmake --build ${lld_bld_dir} -v -j ${jobs} || return
	cmake --install ${lld_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_lldb()
{
	[ -x ${prefix}/bin/lldb -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	print_header_path histedit.h > /dev/null || install_native_libedit || return
	print_header_path xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	which swig > /dev/null || install_native_swig || return
	fetch lldb || return
	unpack lldb || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${lldb_src_dir} -B ${lldb_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_INSTALL_RPATH=';' -DLLVM_LINK_LLVM_DYLIB=ON \
		-DCMAKE_C_FLAGS="${CFLAGS} `I clang/Basic/Version.h`" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} `I curses.h histedit.h`" \
		-DLLDB_TEST_C_COMPILER=${CC:-gcc} -DLLDB_TEST_CXX_COMPILER=${CXX:-g++} || return
	cmake --build ${lldb_bld_dir} -v -j ${jobs} || return
	cmake --install ${lldb_bld_dir} -v ${strip:+--${strip}} || return
	[ ! -f ${lldb_bld_dir}/bin/lldb-tblgen ] && return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${lldb_bld_dir}/bin/lldb-tblgen || return
}

install_native_cling()
{
	[ -x ${prefix}/bin/cling -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path llvm-config.h llvm/Config > /dev/null || install_native_llvm || return
	fetch cling || return
	unpack cling || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${cling_src_dir} -B ${cling_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix}/cling \
		-DENABLE_LINKER_BUILD_ID=ON || return
	cmake --build ${cling_bld_dir} -v -j ${jobs} || return
	cmake --install ${cling_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_ccls()
{
	[ -x ${prefix}/bin/ccls -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_library_path libclang.so || install_native_clang || return
	fetch ccls || return
	unpack ccls || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${ccls_src_dir} -B ${ccls_bld_dir} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} || return
	cmake --build ${ccls_bld_dir} -v -j ${jobs} || return
	cmake --install ${ccls_bld_dir} -v ${strip:+--${strip}} || return
}

install_native_boost()
{
	[ -d ${prefix}/include/boost -a "${force_install}" != yes ] && return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	fetch boost || return
	unpack boost || return
	(cd ${boost_src_dir}
	./bootstrap.sh --prefix=${DESTDIR}${prefix} --with-toolset=gcc &&
	./b2 --prefix=${DESTDIR}${prefix} --build-dir=${boost_bld_dir} \
		--layout=system --build-type=minimal -j ${jobs} -q \
		include=${prefix}/include library-path=${prefix}/lib install) || return
	update_path || return
}

install_cross_gcc_without_headers()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	which ${target}-as > /dev/null || install_native_binutils || return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	print_header_path mpc.h > /dev/null || install_native_mpc || return
	print_header_path version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	fetch gcc || return
	unpack gcc || return
	mkdir -pv ${gcc_bld_dir_crs_1st} || return
	gcc_base_ver=`cat ${gcc_src_dir}/gcc/BASE-VER` || return
	[ -f ${gcc_bld_dir_crs_1st}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_1st}
		${gcc_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h` --with-mpc=`print_prefix mpc.h` \
			--with-isl=`print_prefix version.h isl` --with-system-zlib --enable-languages=c,c++ --disable-multilib \
			--program-prefix=${target}- --program-suffix=-${gcc_base_ver} --enable-version-specific-runtime-libs \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` --without-headers \
			--disable-shared --disable-threads --disable-libssp --disable-libgomp \
			--disable-libmudflap --disable-libquadmath --disable-libatomic \
			--disable-libsanitizer --disable-nls --disable-libstdc++-v3 --disable-libvtv \
			CFLAGS="${CFLAGS} `I zlib.h`" LDFLAGS="${LDFLAGS} `L z`") || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-gcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_1st} -j ${jobs} -k check-gcc || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-gcc || return
	for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gcov gcov-dump gcov-tool; do
		[ ! -f ${DESTDIR}${prefix}/bin/${target}-${b}-${gcc_base_ver} ] || ln -fsv ${target}-${b}-${gcc_base_ver} ${DESTDIR}${prefix}/bin/${target}-${b} || return
	done
	update_path || return
	echo ${target} | grep -qe '^\(x86_64\|i686\)-w64-mingw32$' && return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} all-target-libgcc || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_1st} -j ${jobs} -k check-target-libgcc || return
	make -C ${gcc_bld_dir_crs_1st} -j ${jobs} install-target-libgcc || return
	update_path || return
}

install_cross_linux_header()
{
	[ -d ${sysroot}/usr/include/linux -a "${force_install}" != yes ] && return
	which rsync > /dev/null || install_native_rsync || return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	fetch linux || return
	unpack linux || return
	make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} mrproper || return
	make -C ${linux_src_dir} -j ${jobs} V=1 O=${linux_bld_dir} \
		ARCH=${linux_arch} INSTALL_HDR_PATH=${DESTDIR}${sysroot}/usr headers_install || return
}

install_cross_glibc()
{
	[ -f ${sysroot}/usr/include/stdio.h -a "${force_install}" != yes ] && return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	which gawk > /dev/null || install_native_gawk || return
	which gperf > /dev/null || install_native_gperf || return
	fetch glibc || return
	unpack glibc || return

	[ ${linux_arch} != microblaze ] ||
		patch -N -p0 -d ${glibc_src_dir} <<EOF || [ $? = 1 ] || return
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

	mkdir -pv ${glibc_bld_dir_crs} || return
	[ -f ${glibc_bld_dir_crs}/Makefile ] ||
		(cd ${glibc_bld_dir_crs}
		${glibc_src_dir}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${DESTDIR}${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes) || return
	make -C ${glibc_bld_dir_crs} -j ${jobs} DESTDIR=${DESTDIR}${sysroot} install-headers || return
	make -C ${glibc_bld_dir_crs} -j ${jobs} AR=${target}-ar || return
	[ "${enable_check}" != yes ] ||
		make -C ${glibc_bld_dir_crs} -j ${jobs} -k check || return
	make -C ${glibc_bld_dir_crs} -j ${jobs} DESTDIR=${DESTDIR}${sysroot} install || return
	mkdir -pv ${DESTDIR}${sysroot}/usr/lib || return # XXX: workaround for aarch64
}

install_cross_newlib()
{
	[ -f ${sysroot}/usr/include/stdio.h -a "${force_install}" != yes ] && return
	which ${target}-gcc > /dev/null || install_cross_gcc_without_headers || return
	fetch newlib || return
	unpack newlib || return
	mkdir -pv ${newlib_bld_dir_crs} || return
	[ -f ${newlib_bld_dir_crs}/Makefile ] ||
		(cd ${newlib_bld_dir_crs}
		${newlib_src_dir}/configure --prefix=/ --build=${build} --target=${target}) || return
	make -C ${newlib_bld_dir_crs} -j 1 || return
	make -C ${newlib_bld_dir_crs} -j 1 DESTDIR=${DESTDIR}${prefix} install || return
	mkdir -pv ${sysroot}/usr || return
	ln -fsv ../../include -t ${sysroot}/usr || return
}

install_mingw_w64_header()
{
	fetch mingw-w64 || return
	unpack mingw-w64 || return
	mkdir -pv ${mingw_w64_bld_dir_crs_hdr} || return
	[ -f ${mingw_w64_bld_dir_crs_hdr}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs_hdr}
		${mingw_w64_src_dir}/configure --prefix=${sysroot}/mingw --build=${build} --host=${target} \
			--disable-multilib --without-crt --with-sysroot=${sysroot}) || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs_hdr} -j ${jobs} install || return
}

install_mingw_w64_crt()
{
	fetch mingw-w64 || return
	unpack mingw-w64 || return
	mkdir -pv ${mingw_w64_bld_dir_crs} || return
	[ -f ${mingw_w64_bld_dir_crs}/Makefile ] ||
		(cd ${mingw_w64_bld_dir_crs}
		CFLAGS="${CFLAGS} -Wno-error=expansion-to-defined -Wno-error=cast-function-type" \
		CPPFLAGS="${CPPFLAGS} -I${sysroot}/mingw/include" \
			${mingw_w64_src_dir}/configure --prefix=${sysroot}/mingw --build=${build} --host=${target} \
			--disable-multilib --without-headers --with-sysroot=${sysroot} \
			`${target}-gcc -print-file-name=libmsvcrt.a | grep -qe ^/ && echo --with-libraries=all --with-tools=all`) || return
	make -C ${mingw_w64_bld_dir_crs} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${mingw_w64_bld_dir_crs} -j ${jobs} -k check || return
	make -C ${mingw_w64_bld_dir_crs} -j ${jobs} install || return
}

install_cross_functional_gcc()
{
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	which ${target}-as > /dev/null || install_native_binutils || return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	print_header_path mpfr.h > /dev/null || install_native_mpfr || return
	print_header_path mpc.h > /dev/null || install_native_mpc || return
	print_header_path version.h isl > /dev/null || install_native_isl || return
	which perl > /dev/null || install_native_perl || return
	which makeinfo > /dev/null || install_native_texinfo || return
	fetch gcc || return
	unpack gcc || return
	mkdir -pv ${gcc_bld_dir_crs_2nd} || return
	gcc_base_ver=`cat ${gcc_src_dir}/gcc/BASE-VER` || return
	[ -f ${gcc_bld_dir_crs_2nd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_2nd}
		${gcc_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} \
			--with-gmp=`print_prefix gmp.h` --with-mpfr=`print_prefix mpfr.h` --with-mpc=`print_prefix mpc.h` \
			--with-isl=`print_prefix version.h isl` --with-system-zlib --enable-languages=${languages} --disable-multilib \
			--enable-linker-build-id --enable-libstdcxx-debug \
			--program-prefix=${target}- --program-suffix=-${gcc_base_ver} --enable-version-specific-runtime-libs \
			--with-as=`which ${target}-as` --with-ld=`which ${target}-ld` --with-sysroot=${sysroot} \
			CFLAGS="${CFLAGS} `I zlib.h`" LDFLAGS="${LDFLAGS} `L z`") || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} LIBS=-lgcc_s || return
	[ "${enable_check}" != yes ] ||
		make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k check || return
	make -C ${gcc_bld_dir_crs_2nd} -j ${jobs} -k install${strip:+-${strip}} ${strip:+STRIP=${target}-strip} || true # [XXX] install-stripを強行する(現状gotoolsだけ失敗する)ため、-kと|| trueで暫定対応(WA)
	for b in c++ cpp g++ gcc gcc-ar gcc-nm gcc-ranlib gccgo gcov gcov-dump gcov-tool gfortran; do
		[ -f ${DESTDIR}${prefix}/bin/${target}-${b}-${gcc_base_ver} ] || continue
		ln -fsv ${target}-${b}-${gcc_base_ver} ${DESTDIR}${prefix}/bin/${target}-${b} || return
		ln -fsv ${target}-${b}-${gcc_base_ver}.1 ${DESTDIR}${prefix}/share/man/man1/${target}-${b}.1 || return
	done
	for d in lib lib64; do
		for e in a so so.1; do
			[ -f ${DESTDIR}${prefix}/lib/gcc/${target}/${d}/libgcc_s.${e} ] || continue
			ln -fsv ../${d}/libgcc_s.${e} ${DESTDIR}${prefix}/lib/gcc/${target}/${gcc_base_ver} || return # XXX work around for --enable-version-specific-runtime-libs
			[ -d ${sysroot}/usr/lib ] || continue
			cp -fv ${DESTDIR}${prefix}/lib/gcc/${target}/${d}/libgcc_s.${e} ${sysroot}/usr/lib || return
		done
	done
	update_path || return
}

install_cross_gcc()
{
	[ -x ${prefix}/bin/${target}-gcc -a "${force_install}" != yes ] && return
	[ `check_platform ${build} ${host} ${target}` = cross ] || return
	install_cross_gcc_without_headers || return
	case ${target} in
	x86_64-w64-mingw32|i686-w64-mingw32)
           install_mingw_w64_header || return
           install_mingw_w64_crt || return;;
	*-elf) install_cross_newlib || return;;
	*)     install_cross_linux_header || return
           install_cross_glibc || return;;
	esac
	install_cross_functional_gcc || return
	case ${target} in
	x86_64-w64-mingw32|i686-w64-mingw32)
		rm -fv ${mingw_w64_bld_dir_crs}/Makefile || return
		install_mingw_w64_crt || return;; # XXX: for --with-libraries, --with-tools to MinGW-w64
	esac
}

install_native_Python2()
{
	Python_ver=${Python2_ver} || return
	set_variables || return
	install_native_Python || return
}

install_native_Python()
{
	[ -x ${prefix}/bin/python3 -a "${force_install}" != yes ] && return
	print_header_path expat.h > /dev/null || install_native_expat || return
	print_header_path ffi.h > /dev/null || install_native_libffi || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	fetch Python || return
	unpack Python || return
	[ -f ${Python_bld_dir}/Makefile ] ||
		(cd ${Python_bld_dir}
		${Python_src_dir}/configure --prefix=${prefix} --build=${build} --enable-universalsdk \
			--enable-shared --enable-optimizations --enable-ipv6 \
			--with-lto --with-system-expat --with-system-ffi \
			--with-doc-strings --with-pymalloc --with-ensurepip=upgrade LDFLAGS="${LDFLAGS} `L ssl`") || return
	make -C ${Python_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${Python_bld_dir} -j ${jobs} -k test || return
	make -C ${Python_bld_dir} -j ${jobs} install || return
	update_path || return
	pip`print_version Python 1` install -U pip || return
	ln -fsv python3 ${DESTDIR}${prefix}/bin/python || return
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
}

install_native_cython()
{
	[ -x ${prefix}/bin/cython -a "${force_install}" != yes ] && return
	fetch cython || return
	unpack cython || return
	(cd ${cython_src_dir}
	CC=${CC:-${host:+${host}-}gcc} LDSHARED="${CC:-${host:+${host}-}gcc} --shared" \
		python3 setup.py build -j ${jobs} install ${DESTDIR:+--root ${DESTDIR}} --prefix ${prefix}) || return
}

install_native_OpenBLAS()
{
	[ -f ${prefix}/include/openblas/openblas_config.h -a "${force_install}" != yes ] && return
	fetch OpenBLAS || return
	unpack OpenBLAS || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${OpenBLAS_src_dir} -B ${OpenBLAS_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DDYNAMIC_ARCH=ON -DBUILD_STATIC_LIBS=ON -DBUILD_SHARED_LIBS=ON \
		|| return
	cmake --build ${OpenBLAS_bld_dir} -v -j ${jobs} || return
	cmake --install ${OpenBLAS_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_numpy()
{
	[ -x ${prefix}/bin/f2py -a "${force_install}" != yes ] && return
	which cython > /dev/null || install_native_cython || return
	print_header_path openblas_config.h openblas > /dev/null || install_native_OpenBLAS || return
	fetch numpy || return
	unpack numpy || return
	(cd ${numpy_src_dir}
	CC=${CC:-${host:+${host}-}gcc} LDSHARED="${CC:-${host:+${host}-}gcc} --shared" \
		python3 setup.py build -j ${jobs} install ${DESTDIR:+--root ${DESTDIR}} --prefix ${prefix}) || return
}

install_native_rustc()
{
	[ -x ${prefix}/bin/rustc -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which curl > /dev/null || install_native_curl || return
	which git > /dev/null || install_native_git || return
	which pkg-config > /dev/null || install_native_pkg_config || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	fetch rustc || return
	unpack rustc || return
	(cd ${rustc_src_dir}
	sed -e '
		/^#ninja = .\+/s//ninja = '`which ninja > /dev/null && echo true || echo false`'/
		/^#profiler = .\+/s//profiler = true/
		/^#prefix = .\+/s%%prefix = "'${prefix}'"%
		/^#sysconfdir = .\+/s//sysconfdir = "etc"/
		/^#parallel-compiler = .\+/s//parallel-compiler = true/
		/^#rpath = .\+/s//rpath = false/' \
			config.toml.example > config.toml || return
	./x.py build -j ${jobs} || return
	./x.py doc -j ${jobs} --stage 1 || return
	./x.py install -j ${jobs} || return
	./x.py install -j ${jobs} cargo || return
	) || return
	update_path || return
	[ -z "${strip}" ] && return
	for b in cargo cargo-clippy cargo-fmt cargo-miri clippy-driver miri rls rustc rustdoc rustfmt; do
		[ ! -f ${DESTDIR}${prefix}/bin/${b} ] || ${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/${b} || return
	done
}

install_native_rustup()
{
	which rustup > /dev/null && [ "${force_install}" != yes ] && return
	which cargo > /dev/null || install_native_rustc || return
	fetch rustup || return
	unpack rustup || return
	(cd ${rustup_src_dir}
	cargo run -j ${jobs} -v --release -- -v -y --no-modify-path) || return
}

install_native_libyaml()
{
	[ -f ${prefix}/include/yaml.h -a "${force_install}" != yes ] && return
	fetch libyaml || return
	unpack libyaml || return
	[ -f ${libyaml_bld_dir}/Makefile ] ||
		(cd ${libyaml_bld_dir}
		${libyaml_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} --disable-silent-rules) || return
	make -C ${libyaml_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libyaml_bld_dir} -j ${jobs} -k check || return
	make -C ${libyaml_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_ruby()
{
	[ -x ${prefix}/bin/ruby -a "${force_install}" != yes ] && return
	print_header_path yaml.h > /dev/null || install_native_libyaml || return
	fetch ruby || return
	unpack ruby || return
	[ -f ${ruby_bld_dir}/Makefile ] ||
		(cd ${ruby_bld_dir}
		${ruby_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host} \
			--disable-silent-rules --enable-multiarch --enable-shared \
			--with-compress-debug-sections) || return
	make -C ${ruby_bld_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${ruby_bld_dir} -j ${jobs} -k V=1 check || return
	make -C ${ruby_bld_dir} -j ${jobs} V=1 install || return
	update_path || return
	gem update || return
	mkdir -pv ${DESTDIR}${prefix}/lib/pkgconfig || return
	ruby_platform=`grep -e '^arch =' -m 1 ${ruby_bld_dir}/Makefile | grep -oe '[[:graph:]]\+$'`
	ln -fsv ${ruby_platform}/pkgconfig/ruby-`print_version ruby`.pc ${DESTDIR}${prefix}/lib/pkgconfig || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/ruby || return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/${ruby_platform}/libruby.so || return
	find ${DESTDIR}${prefix}/lib/${ruby_platform}/ruby/`print_version ruby`.0 -type f -name '*.so' -exec ${host:+${host}-}strip -v {} + || return
}

install_native_go()
{
	[ -x ${prefix}/go/bin/go -a "${force_install}" != yes ] && return
	[ -n "${GOPATH}" ] || ! echo Error. GOPATH not set. >&2 || return
	which go > /dev/null || return
	which git > /dev/null || install_native_git || return
	fetch go || return
	[ -d ${go_src_dir} ] || unpack go || return
	[ -d ${go_src_base}/go ] && mv -v ${go_src_base}/go ${go_src_dir}
	mkdir -pv ${DESTDIR}${prefix}/go/bin || return
	[ -f ${DESTDIR}${prefix}/go/bin/go ] || ln -sv `which go` ${DESTDIR}${prefix}/go/bin/go || return
	(cd ${go_src_dir}/src
	CGO_CPPFLAGS=-I${prefix}/include GOROOT_BOOTSTRAP=`go version | grep -qe '\<\(gccgo\|unknown\)\>' && echo ${DESTDIR}${prefix}/go` \
		GOROOT_FINAL=${prefix}/go bash -x ${go_src_dir}/src/make.bash -v) || return
	rm -v ${DESTDIR}${prefix}/go/bin/go || return
	cp -Tfvr ${go_src_dir} ${DESTDIR}${prefix}/go || return
	update_path || return
	GOPATH=${DESTDIR}${prefix}/.go go install golang.org/x/tools/cmd/...@latest || return
}

install_native_perl()
{
	[ -x ${prefix}/bin/perl -a "${force_install}" != yes ] && return
	fetch perl || return
	unpack perl || return
	[ -f ${perl_bld_dir}/Makefile ] ||
		(cd ${perl_bld_dir}
		${perl_src_dir}/Configure -de -Dprefix=${prefix} -Dcc=${CC:-${host:+${host}-}gcc} \
			-Dusethreads -Duse64bitint -Duse64bitall -Dusemorebits -Duseshrplib -Dmksymlinks) || return
	make -C ${perl_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${perl_bld_dir} -j ${jobs} -k test || return
	make -C ${perl_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	ln -fsv `find ${DESTDIR}${prefix}/lib -type f -name libperl.so | sed -e s%^${DESTDIR}${prefix}/lib/%%` ${DESTDIR}${prefix}/lib || return
}

install_native_tcl()
{
	[ -x ${prefix}/bin/tclsh -a "${force_install}" != yes ] && return
	fetch tcl || return
	unpack tcl || return
	[ -f ${tcl_bld_dir}/Makefile ] ||
		(cd ${tcl_bld_dir}
		${tcl_src_dir}/unix/configure --prefix=${prefix} -build=${build} --host=${host} \
			--disable-silent-rules --enable-64bit --enable-man-symlinks --disable-rpath) || return
	make -C ${tcl_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tcl_bld_dir} -j ${jobs} -k test || return
	make -C ${tcl_bld_dir} -j ${jobs} install || return
	make -C ${tcl_bld_dir} -j ${jobs} install-private-headers || return
	update_path || return
	ln -fsv tclsh`print_version tcl` ${DESTDIR}${prefix}/bin/tclsh || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/tclsh || return
	chmod -v u+w ${DESTDIR}${prefix}/lib/libtcl`print_version tcl`.so || return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libtcl`print_version tcl`.so || return
	chmod -v u-w ${DESTDIR}${prefix}/lib/libtcl`print_version tcl`.so || return
}

install_native_tk()
{
	[ -x ${prefix}/bin/wish -a "${force_install}" != yes ] && return
	print_library_path tclConfig.sh > /dev/null || install_native_tcl || return
	fetch tk || return
	unpack tk || return
	[ -f ${tk_bld_dir}/Makefile ] ||
		(cd ${tk_bld_dir}
		${tk_src_dir}/unix/configure --prefix=${prefix} -build=${build} \
			--disable-silent-rules --enable-64bit --enable-man-symlinks --disable-rpath) || return
	make -C ${tk_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tk_bld_dir} -j ${jobs} -k test || return
	make -C ${tk_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	ln -fsv wish`print_version tk` ${DESTDIR}${prefix}/bin/wish || return
	[ -z "${strip}" ] && return
	chmod -v u+w ${DESTDIR}${prefix}/lib/libtk`print_version tk`.so || return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/lib/libtk`print_version tk`.so || return
	chmod -v u-w ${DESTDIR}${prefix}/lib/libtk`print_version tk`.so || return
}

install_native_libunistring()
{
	[ -f ${prefix}/include/unistr.h -a "${force_install}" != yes ] && return
	fetch libunistring || return
	unpack libunistring || return
	[ -f ${libunistring_bld_dir}/Makefile ] ||
		(cd ${libunistring_bld_dir}
		${libunistring_src_dir}/configure --prefix=${prefix} -build=${build} --host=${host} \
			--disable-rpath --disable-silent-rules) || return
	make -C ${libunistring_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libunistring_bld_dir} -j ${jobs} -k check || return
	make -C ${libunistring_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libidn2()
{
	[ -f ${prefix}/include/idn2.h -a "${force_install}" != yes ] && return
	print_header_path unistr.h > /dev/null || install_native_libunistring || return
	fetch libidn2 || return
	unpack libidn2 || return
	[ -f ${libidn2_bld_dir}/Makefile ] ||
		(cd ${libidn2_bld_dir}
		${libidn2_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --disable-rpath) || return
	make -C ${libidn2_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libidn2_bld_dir} -j ${jobs} -k check || return
	make -C ${libidn2_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libpsl()
{
	[ -f ${prefix}/include/libpsl.h -a "${force_install}" != yes ] && return
	print_header_path idn2.h > /dev/null || install_native_libidn2 || return
	which python3 > /dev/null || install_native_Python || return
	fetch libpsl || return
	unpack libpsl || return
	[ -f ${libpsl_bld_dir}/Makefile ] ||
		(cd ${libpsl_bld_dir}
		${libpsl_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules --disable-rpath) || return
	make -C ${libpsl_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpsl_bld_dir} -j ${jobs} -k check || return
	make -C ${libpsl_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libatomic_ops()
{
	[ -f ${prefix}/include/atomic_ops.h -a "${force_install}" != yes ] && return
	fetch libatomic_ops || return
	unpack libatomic_ops || return
	[ -f ${libatomic_ops_bld_dir}/Makefile ] ||
		(cd ${libatomic_ops_bld_dir}
		${libatomic_ops_src_dir}/configure --prefix=${prefix} -build=${build} --host=${host} --disable-silent-rules \
			--enable-shared) || return
	make -C ${libatomic_ops_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libatomic_ops_bld_dir} -j ${jobs} -k check || return
	make -C ${libatomic_ops_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_gc()
{
	[ -f ${prefix}/include/gc.h -a "${force_install}" != yes ] && return
	print_header_path atomic_ops.h > /dev/null || install_native_libatomic_ops || return
	fetch gc || return
	unpack gc || return
	[ -f ${gc_bld_dir}/Makefile ] ||
		(cd ${gc_bld_dir}
		${gc_src_dir}/configure --prefix=${prefix} -build=${build} --host=${host} --disable-silent-rules \
			--enable-static \
			ATOMIC_OPS_CFLAGS=`I atomic_ops.h` \
			ATOMIC_OPS_LIBS=`L atomic_ops`) || return
	make -C ${gc_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gc_bld_dir} -j ${jobs} check || return
	make -C ${gc_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_guile()
{
	[ -x ${prefix}/bin/guile -a "${force_install}" != yes ] && return
	print_header_path gmp.h > /dev/null || install_native_gmp || return
	print_header_path unistr.h > /dev/null || install_native_libunistring || return
	print_header_path ffi.h > /dev/null || install_native_libffi || return
	print_header_path gc.h > /dev/null || install_native_gc || return
	fetch guile || return
	unpack guile || return
	[ -f ${guile_bld_dir}/Makefile ] ||
		(cd ${guile_bld_dir}
		remove_rpath_option guile || return
		${guile_src_dir}/configure --prefix=${prefix} -build=${build} --host=${host} \
			--disable-silent-rules --with-libunistring-prefix=`print_prefix unistr.h` \
			LIBFFI_CFLAGS=`I ffi.h` LIBFFI_LIBS="`l ffi`" \
			BDW_GC_CFLAGS="`I gc/gc.h` -DHAVE_GC_SET_FINALIZER_NOTIFIER -DHAVE_GC_GET_HEAP_USAGE_SAFE -DHAVE_GC_GET_FREE_SPACE_DIVISOR -DHAVE_GC_SET_FINALIZE_ON_DEMAND" \
			BDW_GC_LIBS="`l gc`") || return
	LD_LIBRARY_PATH=${guile_bld_dir}/libguile/.libs${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}} \
		make -C ${guile_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${guile_bld_dir} -j ${jobs} -k check || return
	make -C ${guile_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_lua()
{
	[ -x ${prefix}/bin/lua -a "${force_install}" != yes ] && return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	fetch lua || return
	unpack lua || return
	patch -N -p0 -d ${lua_src_dir} <<'EOF' || [ $? = 1 ] || return
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
 PLAT= guess

-CC= gcc -std=gnu99
+CC= gcc -std=gnu99 -fPIC
 CFLAGS= -O2 -Wall -Wextra -DLUA_COMPAT_5_3 $(SYSCFLAGS) $(MYCFLAGS)
 LDFLAGS= $(SYSLDFLAGS) $(MYLDFLAGS)
 LIBS= -lm $(SYSLIBS) $(MYLIBS)
@@ -33,6 +33,7 @@
 PLATS= guess aix bsd c89 freebsd generic linux linux-readline macosx mingw posix solaris

 LUA_A=	liblua.a
+LUA_SO=	liblua.so
 CORE_O=	lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o ltm.o lundump.o lvm.o lzio.o
 LIB_O=	lauxlib.o lbaselib.o lcorolib.o ldblib.o liolib.o lmathlib.o loadlib.o loslib.o lstrlib.o ltablib.o lutf8lib.o linit.o
 BASE_O= $(CORE_O) $(LIB_O) $(MYOBJS)
@@ -44,7 +45,7 @@
 LUAC_O=	luac.o

 ALL_O= $(BASE_O) $(LUA_O) $(LUAC_O)
-ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T)
+ALL_T= $(LUA_A) $(LUA_T) $(LUAC_T) $(LUA_SO)
 ALL_A= $(LUA_A)

 # Targets start here.
@@ -60,6 +61,9 @@
 	$(AR) $@ $(BASE_O)
 	$(RANLIB) $@

+$(LUA_SO): $(BASE_O)
+	$(CC) --shared -o $@ $^
+
 $(LUA_T): $(LUA_O) $(LUA_A)
 	$(CC) -o $@ $(LDFLAGS) $(LUA_O) $(LUA_A) $(LIBS)
EOF
	[ -f ${lua_bld_dir}/Makefile ] || cp -Tvr ${lua_src_dir} ${lua_bld_dir} || return
	make -C ${lua_bld_dir} -j ${jobs} \
		MYCFLAGS="${CFLAGS} `I readline/readline.h`" \
		MYLDFLAGS="${LDFLAGS} `L readline ncurses`" \
		MYLIBS=-lncurses linux || return # XXX linuxにしか対応していない。
	[ "${enable_check}" != yes ] ||
		make -C ${lua_bld_dir} -j ${jobs} -k test || return
	make -C ${lua_bld_dir} -j ${jobs} INSTALL_TOP=${DESTDIR}${prefix} install || return
	cp -fv ${DESTDIR}${prefix}/lib/liblua.so ${DESTDIR}${prefix}/lib/liblua.so.`print_version lua` || return
	ln -fsv liblua.so.`print_version lua` ${DESTDIR}${prefix}/lib/liblua.so || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/lua ${DESTDIR}${prefix}/bin/luac || return
}

install_native_node()
{
	[ -x ${prefix}/bin/node -a "${force_install}" != yes ] && return
	fetch node || return
	unpack node || return
	[ -f ${node_bld_dir}/configure ] || cp -Tvr ${node_src_dir} ${node_bld_dir} || return
	(cd ${node_bld_dir}
	./configure --prefix=${prefix} `which ninja > /dev/null && echo --ninja`) || return
	make -C ${node_bld_dir} -j ${jobs} V=1 || return
	[ "${enable_check}" != yes ] ||
		make -C ${node_bld_dir} test-only || return
	make -C ${node_bld_dir} -j ${jobs} doc || return
	make -C ${node_bld_dir} -j ${jobs} install || return
}

install_native_jdk()
{
	[ -x ${prefix}/bin/javac -a "${force_install}" != yes ] && return
	fetch jdk || return
	unpack jdk || return
	cp -Tfvr ${jdk_src_dir} ${DESTDIR}${prefix}/jdk || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	for f in `find ${DESTDIR}${prefix}/jdk/bin -type f`; do
		ln -fsv `echo ${f} | sed -e "s%${DESTDIR}${prefix}/jdk/bin%../jdk/bin%"` ${DESTDIR}${prefix}/bin/`basename ${f}` || return
	done
	mkdir -pv ${DESTDIR}${prefix}/include/linux || return
	for f in `find ${DESTDIR}${prefix}/jdk/include -mindepth 1 -type f`; do
		ln -fsv `echo ${f} | sed -e "s%${DESTDIR}${prefix}/jdk/include%../jdk/include%"` \
			${DESTDIR}${prefix}/include`echo ${f} | sed -e "s%${DESTDIR}${prefix}/jdk/include%%"` || return
	done
	mkdir -pv ${DESTDIR}${prefix}/lib || return
	for f in `find ${DESTDIR}${prefix}/jdk/lib -mindepth 1 -maxdepth 1 ! -name src.zip`; do
		ln -fsv `echo ${f} | sed -e "s%${DESTDIR}${prefix}/jdk/lib%../jdk/lib%"` ${DESTDIR}${prefix}/lib/`basename ${f}` || return
	done
}

install_native_nasm()
{
	[ -x ${prefix}/bin/nasm -a "${force_install}" != yes ] && return
	fetch nasm || return
	unpack nasm || return
	[ -f ${nasm_bld_dir}/Makefile ] ||
		(cd ${nasm_bld_dir}
		${nasm_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${nasm_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${nasm_bld_dir} -j ${jobs} -k test || return
	[ -z "${strip}" ] || make -C ${nasm_bld_dir} -j ${jobs} strip || return
	make -C ${nasm_bld_dir} -j ${jobs} INSTALLROOT=${DESTDIR} install || return
}

install_native_yasm()
{
	[ -x ${prefix}/bin/yasm -a "${force_install}" != yes ] && return
	fetch yasm || return
	unpack yasm || return
	[ -f ${yasm_bld_dir}/Makefile ] ||
		(cd ${yasm_bld_dir}
		${yasm_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${yasm_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${yasm_bld_dir} -j ${jobs} -k check || return
	make -C ${yasm_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_x264()
{
	[ -x ${prefix}/bin/x264 -a "${force_install}" != yes ] && return
	which nasm > /dev/null || install_native_nasm || return
	fetch x264 || return
	unpack x264 || return
	(cd ${x264_bld_dir}
	${x264_src_dir}/configure --prefix=${prefix} \
		--enable-shared --enable-static ${strip:+--enable-strip}) || return
	make -C ${x264_bld_dir} -j ${jobs} || return
	make -C ${x264_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_x265()
{
	[ -x ${prefix}/bin/x265 -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which yasm > /dev/null || install_native_yasm || return
	fetch x265 || return
	unpack x265 || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${x265_src_dir}/source -B ${x265_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DNATIVE_BUILD=ON || return
	cmake --build ${x265_bld_dir} -v -j ${jobs} || return
	cmake --install ${x265_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_libav()
{
	[ -x ${prefix}/bin/avconv -a "${force_install}" != yes ] && return
	which yasm > /dev/null || install_native_yasm || return
	print_header_path x264.h > /dev/null || install_native_x264 || return
	print_header_path x265.h > /dev/null || install_native_x265 || return
	fetch libav || return
	unpack libav || return
	(cd ${libav_bld_dir}
	${libav_src_dir}/configure --prefix=${prefix} --enable-gpl --enable-version3 --enable-nonfree --enable-shared \
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
	make -C ${libav_bld_dir} -j ${jobs} || return
	make -C ${libav_bld_dir} -j ${jobs} install || return
}

install_native_gflags()
{
	[ -f ${prefix}/include/gflags/gflags.h -a "${force_install}" != yes ] && return
	fetch gflags || return
	unpack gflags || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${gflags_src_dir} -B ${gflags_bld_dir} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DBUILD_SHARED_LIBS=ON \
		-DBUILD_STATIC_LIBS=ON \
		-DBUILD_gflags_LIB=ON \
		-DBUILD_gflags_nothreads_LIB=ON \
		|| return
	cmake --build ${gflags_bld_dir} -v -j ${jobs} || return
	cmake --install ${gflags_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_glog()
{
	[ -f ${prefix}/include/glog/logging.h -a "${force_install}" != yes ] && return
	print_header_path gflags.h gflags > /dev/null || install_native_gflags || return
	fetch glog || return
	unpack glog || return
	for build_shared_libs in ON OFF; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${glog_src_dir} -B ${glog_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} \
			-DCMAKE_INSTALL_PREFIX=${prefix} \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			|| return
		cmake --build ${glog_bld_dir} -v -j ${jobs} || return
		cmake --install ${glog_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_openjpeg()
{
	[ -f ${prefix}/include/openjpeg-`print_version openjpeg 2`/openjpeg.h -a "${force_install}" != yes ] && return
	fetch openjpeg || return
	unpack openjpeg || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${openjpeg_src_dir} -B ${openjpeg_bld_dir} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DBUILD_SHARED_LIBS=ON \
		-DBUILD_STATIC_LIBS=ON \
		|| return
	cmake --build ${openjpeg_bld_dir} -v -j ${jobs} || return
	cmake --install ${openjpeg_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_Imath()
{
	[ -f ${prefix}/include/Imath/half.h -a "${force_install}" != yes ] && return
	fetch Imath || return
	unpack Imath || return
	for build_shared_libs in ON OFF; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${Imath_src_dir} -B ${Imath_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} \
			-DCMAKE_INSTALL_PREFIX=${prefix} \
			-DCMAKE_SKIP_INSTALL_RPATH=TRUE \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			|| return
		cmake --build ${Imath_bld_dir} -v -j ${jobs} || return
		cmake --install ${Imath_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_openexr()
{
	[ -f ${prefix}/include/OpenEXR/openexr.h -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path half.h Imath > /dev/null || install_native_Imath || return
	fetch openexr || return
	unpack openexr || return
	for build_shared_libs in ON OFF; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${openexr_src_dir} -B ${openexr_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} \
			-DCMAKE_INSTALL_PREFIX=${prefix} \
			-DCMAKE_SKIP_INSTALL_RPATH=TRUE \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			|| return
		cmake --build ${openexr_bld_dir} -v -j ${jobs} || return
		cmake --install ${openexr_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_eigen()
{
	[ -f ${prefix}/include/eigen3/Eigen/Core -a "${force_install}" != yes ] && return
	fetch eigen || return
	unpack eigen || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${eigen_src_dir} -B ${eigen_bld_dir} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		|| return
	cmake --install ${eigen_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_hdf5()
{
	[ -f ${prefix}/include/hdf5.h -a "${force_install}" != yes ] && return
	fetch hdf5 || return
	unpack hdf5 || return
	[ -f ${hdf5_bld_dir}/src/Makefile ] ||
		(cd ${hdf5_bld_dir}
		${hdf5_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--enable-cxx --disable-sharedlib-rpath) || return
	make -C ${hdf5_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${hdf5_bld_dir} -j ${jobs} -k check || return
	make -C ${hdf5_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_VTK()
{
	[ -f ${prefix}/include/vtk-`print_version VTK`/vtkVersion.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	which python3 > /dev/null || install_native_Python || return
	print_header_path eglmesaext.h EGL > /dev/null || install_native_mesa || return
	fetch VTK || return
	unpack VTK || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${VTK_src_dir} -B ${VTK_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} \
		-DCMAKE_INSTALL_PREFIX=${prefix} \
		-DVTK_WRAP_PYTHON=ON \
		|| return
	cmake --build ${VTK_bld_dir} -v -j ${jobs} || return
	cmake --install ${VTK_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_opencv()
{
	[ -f ${prefix}/include/opencv`print_version opencv 1`/opencv2/opencv.hpp -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path QtCoreVersion QtCore > /dev/null || install_native_qt || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path decode.h webp > /dev/null || install_native_libwebp || return
	print_header_path png.h > /dev/null || install_native_libpng || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	print_header_path openjpeg.h > /dev/null || install_native_openjpeg || return
	print_header_path openexr.h OpenEXR > /dev/null || install_native_openexr || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	print_header_path video.h gstreamer-1.0/gst/video > /dev/null || install_native_gst_plugins_base || return
	print_header_path openblas_config.h openblas > /dev/null || install_native_OpenBLAS || return
	print_header_path Core eigen3/Eigen > /dev/null || install_native_eigen || return
	print_header_path message.h google/protobuf > /dev/null || install_native_protobuf || return
	print_header_path ft2build.h freetype2 > /dev/null || install_native_freetype || return
	print_header_path gflags.h gflags > /dev/null || install_native_gflags || return
	print_header_path logging.h glog > /dev/null || install_native_glog || return
	print_header_path hdf5.h > /dev/null || install_native_hdf5 || return
	fetch opencv || return
	unpack opencv || return
	fetch opencv_contrib || return
	unpack opencv_contrib || return
	libdirs="`L png tiff jpeg` `l harfbuzz pcre2-16`"
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${opencv_src_dir} -B ${opencv_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_CXX_STANDARD=17 \
		-DCMAKE_EXE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_SHARED_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_MODULE_LINKER_FLAGS="${LDFLAGS} ${libdirs}" \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DCMAKE_SKIP_INSTALL_RPATH=TRUE \
		-DENABLE_PRECOMPILED_HEADERS=OFF \
		-DOPENCV_EXTRA_MODULES_PATH=${opencv_contrib_src_dir}/modules \
		-DOPENCV_GENERATE_PKGCONFIG=ON \
		-DWITH_FREETYPE=ON \
		-DWITH_OPENGL=ON \
		-DWITH_OPENMP=ON \
		-DWITH_QT=ON \
		-DBUILD_PROTOBUF=OFF \
		-DPROTOBUF_UPDATE_FILES=ON \
		|| return
	cmake --build ${opencv_bld_dir} -v -j ${jobs} || return
	cmake --install ${opencv_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_v4l_utils()
{
	[ -x ${prefix}/bin/v4l2-ctl -a "${force_install}" != yes ] && return
	fetch v4l-utils || return
	unpack v4l-utils || return
	[ -f ${v4l_utils_bld_dir}/Makefile ] ||
		(cd ${v4l_utils_bld_dir}
		${v4l_utils_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--disable-rpath --disable-bpf) || return
	make -C ${v4l_utils_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${v4l_utils_bld_dir} -j ${jobs} -k check || return
	make -C ${v4l_utils_bld_dir} -j 1 -k install${strip:+-${strip}} || true # '-k': workaround for 'install-data-local' fails in utils/keytable/bpf_protocols
	update_path || return
}

install_native_yavta()
{
	[ -x ${prefix}/bin/yavta -a "${force_install}" != yes ] && return
	fetch yavta || return
	unpack yavta || return
	[ -f ${yavta_bld_dir}/Makefile ] || cp -Tvr ${yavta_src_dir} ${yavta_bld_dir} || return
	make -C ${yavta_bld_dir} -j ${jobs} CROSS_COMPILE=${host:+${host}-} || return
	command install -D ${strip:+-s} -v -t ${DESTDIR}${prefix}/bin ${yavta_bld_dir}/yavta || return
	update_path || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/yavta || return
}

install_native_gstreamer()
{
	[ -x ${prefix}/bin/gst-launch-1.0 -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch gstreamer || return
	unpack gstreamer || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gstreamer_src_dir} ${gstreamer_bld_dir} || return
	ninja -v -C ${gstreamer_bld_dir} || return
	ninja -v -C ${gstreamer_bld_dir} install || return
	update_path || return
}

install_native_gst_plugins_base()
{
	[ -f ${prefix}/include/gstreamer-1.0/gst/video/video.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	which orcc > /dev/null || install_native_orc || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path png.h > /dev/null || install_native_libpng || return
	fetch gst-plugins-base || return
	unpack gst-plugins-base || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gst_plugins_base_src_dir} ${gst_plugins_base_bld_dir} || return
	ninja -v -C ${gst_plugins_base_bld_dir} || return
	ninja -v -C ${gst_plugins_base_bld_dir} install || return
	update_path || return
}

install_native_gst_plugins_good()
{
	[ -e ${prefix}/lib64/gstreamer-1.0/libgstautodetect.so -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	print_header_path video.h gstreamer-1.0/gst/video > /dev/null || install_native_gst_plugins_base || return
	which orcc > /dev/null || install_native_orc || return
	fetch gst-plugins-good || return
	unpack gst-plugins-good || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gst_plugins_good_src_dir} ${gst_plugins_good_bld_dir} || return
	ninja -v -C ${gst_plugins_good_bld_dir} || return
	ninja -v -C ${gst_plugins_good_bld_dir} install || return
	update_path || return
}

install_native_gst_editing_services()
{
	[ -f ${prefix}/include/gstreamer-1.0/ges/ges-version.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	print_header_path video.h gstreamer-1.0/gst/video > /dev/null || install_native_gst_plugins_base || return
	fetch gst-editing-services || return
	unpack gst-editing-services || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both -Dtests=disabled ${gst_editing_services_src_dir} ${gst_editing_services_bld_dir} || return
	ninja -v -C ${gst_editing_services_bld_dir} || return
	ninja -v -C ${gst_editing_services_bld_dir} install || return
	update_path || return
}

install_native_gst_rtsp_server()
{
	[ -f ${prefix}/include/gstreamer-1.0/gst/rtsp-server/rtsp-server.h -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	print_header_path video.h gstreamer-1.0/gst/video > /dev/null || install_native_gst_plugins_base || return
	fetch gst-rtsp-server || return
	unpack gst-rtsp-server || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both -Dtests=disabled ${gst_rtsp_server_src_dir} ${gst_rtsp_server_bld_dir} || return
	ninja -v -C ${gst_rtsp_server_bld_dir} || return
	ninja -v -C ${gst_rtsp_server_bld_dir} install || return
	update_path || return
}

install_native_gst_omx()
{
	[ -e ${prefix}/lib64/gstreamer-1.0/libgstomx.so -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	print_header_path gstversion.h gstreamer-1.0/gst > /dev/null || install_native_gstreamer || return
	print_header_path video.h gstreamer-1.0/gst/video > /dev/null || install_native_gst_plugins_base || return
	fetch gst-omx || return
	unpack gst-omx || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both -Dtarget=generic ${gst_omx_src_dir} ${gst_omx_bld_dir} || return
	ninja -v -C ${gst_omx_bld_dir} || return
	ninja -v -C ${gst_omx_bld_dir} install || return
	update_path || return
}

install_native_gst_python()
{
	[ -e ${prefix}/lib64/gstreamer-1.0/libgstpython.so -a "${force_install}" != yes ] && return
	print_header_path pygobject.h pygobject-3.0 > /dev/null || install_native_pygobject || return
	which meson > /dev/null || install_native_meson || return
	fetch gst-python || return
	unpack gst-python || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${gst_python_src_dir} ${gst_python_bld_dir} || return
	ninja -v -C ${gst_python_bld_dir} || return
	ninja -v -C ${gst_python_bld_dir} install || return
	update_path || return
}

install_native_orc()
{
	[ -x ${prefix}/bin/orcc -a "${force_install}" != yes ] && return
	which meson > /dev/null || install_native_meson || return
	fetch orc || return
	unpack orc || return
	meson --prefix ${prefix} ${strip:+--${strip}} --default-library both ${orc_src_dir} ${orc_bld_dir} || return
	ninja -v -C ${orc_bld_dir} || return
	ninja -v -C ${orc_bld_dir} install || return
	update_path || return
}

install_native_lcms2()
{
	[ -f ${prefix}/include/lcms2.h -a "${force_install}" != yes ] && return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	fetch lcms2 || return
	unpack lcms2 || return
	[ -f ${lcms2_bld_dir}/Makefile ] ||
		(cd ${lcms2_bld_dir}
		remove_rpath_option lcms2 || return
		${lcms2_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules || return
		remove_rpath_option lcms2 || return
		) || return
	make -C ${lcms2_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${lcms2_bld_dir} -j ${jobs} -k check || return
	make -C ${lcms2_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_liblqr()
{
	[ -f ${prefix}/include/lqr-1/lqr.h -a "${force_install}" != yes ] && return
	print_header_path glib.h glib-2.0 > /dev/null || install_native_glib || return
	fetch liblqr || return
	unpack liblqr || return
	[ -f ${liblqr_bld_dir}/Makefile ] ||
		(cd ${liblqr_bld_dir}
		${liblqr_src_dir}/configure --prefix=${prefix} --host=${host} --enable-static || return
		) || return
	make -C ${liblqr_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${liblqr_bld_dir} -j ${jobs} -k check || return
	make -C ${liblqr_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_fftw()
{
	[ -f ${prefix}/include/fftw3.h -a "${force_install}" != yes ] && return
	fetch fftw || return
	unpack fftw || return
	[ -f ${fftw_bld_dir}/Makefile ] ||
		(cd ${fftw_bld_dir}
		${fftw_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--enable-shared --enable-openmp --enable-threads \
			|| return
		) || return
	make -C ${fftw_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${fftw_bld_dir} -j ${jobs} -k check || return
	make -C ${fftw_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_LibRaw()
{
	[ -f ${prefix}/include/libraw/libraw.h -a "${force_install}" != yes ] && return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path lcms2.h > /dev/null || install_native_lcms2 || return
	fetch LibRaw || return
	unpack LibRaw || return
	autoreconf -fiv ${LibRaw_src_dir} || return
	[ -f ${LibRaw_bld_dir}/Makefile ] ||
		(cd ${LibRaw_bld_dir}
		remove_rpath_option LibRaw || return
		${LibRaw_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			|| return
		) || return
	make -C ${LibRaw_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${LibRaw_bld_dir} -j ${jobs} -k check || return
	make -C ${LibRaw_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_ImageMagick()
{
	[ -f ${prefix}/include/ImageMagick-`print_version ImageMagick 1`/MagickCore/version.h -a "${force_install}" != yes ] && return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path fftw3.h > /dev/null || install_native_fftw || return
	print_header_path fontconfig.h fontconfig > /dev/null || install_native_fontconfig || return
	print_header_path ft2build.h freetype2 > /dev/null || install_native_freetype || return
	print_header_path jpeglib.h > /dev/null || install_native_jpeg || return
	print_header_path lcms2.h > /dev/null || install_native_lcms2 || return
	print_header_path lqr.h lqr-1 > /dev/null || install_native_liblqr || return
	print_header_path lzma.h > /dev/null || install_native_xz || return
	print_header_path openexr.h OpenEXR > /dev/null || install_native_openexr || return
	print_header_path openjpeg.h > /dev/null || install_native_openjpeg || return
	print_header_path pango.h pango-1.0/pango > /dev/null || install_native_pango || return
	print_header_path png.h > /dev/null || install_native_libpng || return
	print_header_path libraw.h libraw > /dev/null || install_native_LibRaw || return
	print_header_path tiff.h > /dev/null || install_native_tiff || return
	print_header_path decode.h webp > /dev/null || install_native_libwebp || return
	print_header_path Xlib.h X11 > /dev/null || install_native_libX11 || return
	print_header_path xmlversion.h libxml2/libxml > /dev/null || install_native_libxml2 || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path zstd.h > /dev/null || install_native_zstd || return
	fetch ImageMagick || return
	unpack ImageMagick || return
	[ -f ${ImageMagick_bld_dir}/Makefile ] ||
		(cd ${ImageMagick_bld_dir}
		${ImageMagick_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
			--with-modules --with-fftw || return
		) || return
	make -C ${ImageMagick_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${ImageMagick_bld_dir} -j ${jobs} -k check || return
	make -C ${ImageMagick_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_googletest()
{
	[ -f ${prefix}/include/gtest/gtest.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch googletest || return
	unpack googletest || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${googletest_src_dir} -B ${googletest_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${prefix} \
		-DBUILD_SHARED_LIBS=ON || return
	cmake --build ${googletest_bld_dir} -v -j ${jobs} || return
	cmake --install ${googletest_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_fzf()
{
	[ -x ${prefix}/bin/fzf -a "${force_install}" != yes ] && return
	which go > /dev/null || install_native_go || return
	fetch fzf || return
	unpack fzf || return
	make -C ${fzf_src_dir} -j ${jobs} FZF_VERSION=${fzf_ver} FZF_REVISION='tar-make' || return
	make -C ${fzf_src_dir} -j ${jobs} FZF_VERSION=${fzf_ver} FZF_REVISION='tar-make' install || return
	mkdir -pv ${DESTDIR}${prefix}/bin || return
	cp -fv ${fzf_src_dir}/bin/fzf ${DESTDIR}${prefix}/bin/fzf || return
	cp -fv ${fzf_src_dir}/bin/fzf-tmux ${DESTDIR}${prefix}/bin/fzf-tmux || return
	mkdir -pv ${DESTDIR}${prefix}/share/man || return
	cp -Tfvr ${fzf_src_dir}/man/man1 ${DESTDIR}${prefix}/share/man/man1 || return
	mkdir -pv ${DESTDIR}${prefix}/share/vim/vim`print_version vim | tr -d .`/plugin || return
	cp -fv ${fzf_src_dir}/plugin/fzf.vim ${DESTDIR}${prefix}/share/vim/vim`print_version vim | tr -d .`/plugin || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/fzf || return
}

install_native_bat()
{
	[ -x ${prefix}/bin/bat -a "${force_install}" != yes ] && return
	which cargo > /dev/null || install_native_rustc || return
	fetch bat || return
	unpack bat || return
	(cd ${bat_src_dir}
	cargo install -j ${jobs} -v --path . --force --no-track \
		--root ${DESTDIR}${prefix} --locked) || return
	[ -z "${strip}" ] && return
	${host:+${host}-}strip -v ${DESTDIR}${prefix}/bin/bat || return
}

install_native_jq()
{
	[ -x ${prefix}/bin/jq -a "${force_install}" != yes ] && return
	fetch jq || return
	unpack jq || return
	[ -f ${jq_src_dir}/Makefile ] ||
		(cd ${jq_src_dir}
		autoreconf -fiv || return
		./configure --prefix=${prefix} --build=${build} --disable-silent-rules \
			--disable-maintainer-mode --with-oniguruma=builtin) || return
	make -C ${jq_src_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${jq_src_dir} -j ${jobs} -k check || return
	make -C ${jq_src_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_libpcap()
{
	[ -f ${prefix}/include/pcap/pcap.h -a "${force_install}" != yes ] && return
	which yacc > /dev/null || install_native_bison || return
	which lex > /dev/null || which flex > /dev/null || install_native_flex || return
	fetch libpcap || return
	unpack libpcap || return
	[ -f ${libpcap_bld_dir}/Makefile ] ||
		(cd ${libpcap_bld_dir}
		${libpcap_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${libpcap_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libpcap_bld_dir} -j ${jobs} -k test || return
	make -C ${libpcap_bld_dir} -j ${jobs} install || return
	update_path || return
}

install_native_tcpdump()
{
	[ -x ${prefix}/bin/tcpdump -a "${force_install}" != yes ] && return
	print_header_path pcap.h pcap > /dev/null || install_native_libpcap || return
	fetch tcpdump || return
	unpack tcpdump || return
	[ -f ${tcpdump_bld_dir}/Makefile ] ||
		(cd ${tcpdump_bld_dir}
		${tcpdump_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${tcpdump_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${tcpdump_bld_dir} -j ${jobs} -k check || return
	make -C ${tcpdump_bld_dir} -j ${jobs} install || return
}

install_native_nmap()
{
	[ -x ${prefix}/bin/nmap -a "${force_install}" != yes ] && return
	fetch nmap || return
	unpack nmap || return
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
}

install_native_npth()
{
	[ -f ${prefix}/include/npth.h -a "${force_install}" != yes ] && return
	fetch npth || return
	unpack npth || return
	[ -f ${npth_bld_dir}/Makefile ] ||
		(cd ${npth_bld_dir}
		${npth_src_dir}/configure --prefix=${prefix}) || return
	make -C ${npth_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${npth_bld_dir} -j ${jobs} -k check || return
	make -C ${npth_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libgpg_error()
{
	[ -f ${prefix}/include/gpg-error.h -a "${force_install}" != yes ] && return
	fetch libgpg-error || return
	unpack libgpg-error || return
	[ -f ${libgpg_error_bld_dir}/Makefile ] ||
		(cd ${libgpg_error_bld_dir}
		${libgpg_error_src_dir}/configure --prefix=${prefix}) || return
	make -C ${libgpg_error_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libgpg_error_bld_dir} -j ${jobs} -k check || return
	make -C ${libgpg_error_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libgcrypt()
{
	[ -f ${prefix}/include/gcrypt.h -a "${force_install}" != yes ] && return
	print_header_path gpg-error.h > /dev/null || install_native_libgpg_error || return
	fetch libgcrypt || return
	unpack libgcrypt || return
	[ -f ${libgcrypt_bld_dir}/Makefile ] ||
		(cd ${libgcrypt_bld_dir}
		${libgcrypt_src_dir}/configure --prefix=${prefix}) || return
	make -C ${libgcrypt_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libgcrypt_bld_dir} -j ${jobs} -k check || return
	make -C ${libgcrypt_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libksba()
{
	[ -f ${prefix}/include/ksba.h -a "${force_install}" != yes ] && return
	print_header_path gpg-error.h > /dev/null || install_native_libgpg_error || return
	fetch libksba || return
	unpack libksba || return
	[ -f ${libksba_bld_dir}/Makefile ] ||
		(cd ${libksba_bld_dir}
		${libksba_src_dir}/configure --prefix=${prefix}) || return
	make -C ${libksba_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libksba_bld_dir} -j ${jobs} -k check || return
	make -C ${libksba_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_libassuan()
{
	[ -f ${prefix}/include/assuan.h -a "${force_install}" != yes ] && return
	print_header_path gpg-error.h > /dev/null || install_native_libgpg_error || return
	fetch libassuan || return
	unpack libassuan || return
	[ -f ${libassuan_bld_dir}/Makefile ] ||
		(cd ${libassuan_bld_dir}
		${libassuan_src_dir}/configure --prefix=${prefix}) || return
	make -C ${libassuan_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libassuan_bld_dir} -j ${jobs} -k check || return
	make -C ${libassuan_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_gnupg()
{
	[ -x ${prefix}/bin/gpg -a "${force_install}" != yes ] && return
	print_header_path npth.h > /dev/null || install_native_npth || return
	print_header_path gpg-error.h > /dev/null || install_native_libgpg_error || return
	print_header_path gcrypt.h > /dev/null || install_native_libgcrypt || return
	print_header_path ksba.h > /dev/null || install_native_libksba || return
	print_header_path assuan.h > /dev/null || install_native_libassuan || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path bzlib.h > /dev/null || install_native_bzip2 || return
	print_header_path curses.h > /dev/null || install_native_ncurses || return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	print_header_path sqlite3.h > /dev/null || install_native_sqlite || return
	fetch gnupg || return
	unpack gnupg || return
	[ -f ${gnupg_bld_dir}/Makefile ] ||
		(cd ${gnupg_bld_dir}
		${gnupg_src_dir}/configure --prefix=${prefix} --enable-symcryptrun --enable-all-tests) || return
	make -C ${gnupg_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${gnupg_bld_dir} -j ${jobs} -k check || return
	make -C ${gnupg_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
}

install_native_protobuf()
{
	[ -x ${prefix}/bin/protoc -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	which automake > /dev/null || install_native_automake || return
	which libtoolize > /dev/null || install_native_libtool || return
	which make > /dev/null || install_native_make || return
	fetch protobuf || return
	unpack protobuf || return
	[ -f ${protobuf_bld_dir}/Makefile ] ||
		(cd ${protobuf_bld_dir}
		${protobuf_src_dir}/configure --prefix=${prefix} --disable-silent-rules) || return
	make -C ${protobuf_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${protobuf_bld_dir} -j ${jobs} -k check || return
	make -C ${protobuf_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_cares()
{
	[ -f ${prefix}/include/ares.h -a "${force_install}" != yes ] && return
	which cmake > /dev/null || install_native_cmake || return
	fetch cares || return
	unpack cares || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${cares_src_dir} -B ${cares_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DCARES_STATIC=ON \
		|| return
	cmake --build ${cares_bld_dir} -v -j ${jobs} || return
	cmake --install ${cares_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_re2()
{
	[ -f ${prefix}/include/re2/re2.h -a "${force_install}" != yes ] && return
	fetch re2 || return
	unpack re2 || return
	for build_shared_libs in OFF ON; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${re2_src_dir} -B ${re2_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			|| return
		cmake --build ${re2_bld_dir} -v -j ${jobs} || return
		cmake --install ${re2_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_abseil()
{
	[ -f ${prefix}/include/absl/base/config.h -a "${force_install}" != yes ] && return
	fetch abseil || return
	unpack abseil || return
	for build_shared_libs in OFF ON; do
		cmake `which ninja > /dev/null && echo -G Ninja` \
			-S ${abseil_src_dir} -B ${abseil_bld_dir} \
			-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
			-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
			-DBUILD_SHARED_LIBS=${build_shared_libs} \
			-DABSL_PROPAGATE_CXX_STD=ON \
			|| return
		cmake --build ${abseil_bld_dir} -v -j ${jobs} || return
		cmake --install ${abseil_bld_dir} -v ${strip:+--${strip}} || return
	done
	update_path || return
}

install_native_grpc()
{
	[ -x ${prefix}/bin/grpc_cpp_plugin -a "${force_install}" != yes ] && return
	which autoconf > /dev/null || install_native_autoconf || return
	which libtoolize > /dev/null || install_native_libtool || return
	which pkg-config > /dev/null || install_native_pkg_config || return
	which cmake > /dev/null || install_native_cmake || return
	print_header_path zlib.h > /dev/null || install_native_zlib || return
	print_header_path ares.h > /dev/null || install_native_cares || return
	print_header_path re2.h re2 > /dev/null || install_native_re2 || return
	print_header_path ssl.h openssl > /dev/null || install_native_openssl || return
	print_header_path message.h google/protobuf > /dev/null || install_native_protobuf || return
	print_header_path config.h absl/base > /dev/null || install_native_abseil || return
	fetch grpc || return
	unpack grpc || return
	cmake `which ninja > /dev/null && echo -G Ninja` \
		-S ${grpc_src_dir} -B ${grpc_bld_dir} \
		-DCMAKE_C_COMPILER=${CC:-${host:+${host}-}gcc} \
		-DCMAKE_CXX_COMPILER=${CXX:-${host:+${host}-}g++} \
		-DCMAKE_BUILD_TYPE=${cmake_build_type} -DCMAKE_INSTALL_PREFIX=${DESTDIR}${prefix} \
		-DCMAKE_CXX_STANDARD=17 \
		-DBUILD_SHARED_LIBS=ON \
		-DgRPC_ZLIB_PROVIDER=package \
		-DgRPC_CARES_PROVIDER=package \
		-DgRPC_RE2_PROVIDER=package \
		-DgRPC_SSL_PROVIDER=package \
		-DgRPC_PROTOBUF_PROVIDER=package \
		-DgRPC_ABSL_PROVIDER=package \
		|| return
	cmake --build ${grpc_bld_dir} -v -j ${jobs} || return
	cmake --install ${grpc_bld_dir} -v ${strip:+--${strip}} || return
	update_path || return
}

install_native_libbacktrace()
{
	[ -f ${prefix}/include/backtrace.h -a "${force_install}" != yes ] && return
	fetch libbacktrace || return
	unpack libbacktrace || return
	[ -f ${libbacktrace_bld_dir}/Makefile ] ||
		(cd ${libbacktrace_bld_dir}
		${libbacktrace_src_dir}/configure --prefix=${prefix} --build=${build} --host=${host}) || return
	make -C ${libbacktrace_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${libbacktrace_bld_dir} -j ${jobs} -k check || return
	make -C ${libbacktrace_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

install_native_poke()
{
	[ -x ${prefix}/bin/poke -a "${force_install}" != yes ] && return
	print_header_path gc.h > /dev/null || install_native_gc || return
	print_header_path readline.h readline > /dev/null || install_native_readline || return
	which diff > /dev/null || install_native_diffutils || return
	which awk > /dev/null || install_native_gawk || return
	which pkg-config > /dev/null || install_native_pkg_config || return
	[ "${enable_check}" != yes ] || install_native_dejagnu || return
	fetch poke || return
	unpack poke || return
	[ -f ${poke_bld_dir}/Makefile ] ||
		(cd ${poke_bld_dir}
		autoreconf -fiv ${poke_src_dir} || return # copy missing 'build-aux/compile', which is removed at v1.3
		remove_rpath_option poke || return
		${poke_src_dir}/configure --prefix=${prefix} --host=${host} --disable-rpath --disable-gui) || return
	make -C ${poke_bld_dir} -j ${jobs} || return
	[ "${enable_check}" != yes ] ||
		make -C ${poke_bld_dir} -j ${jobs} -k check || return
	make -C ${poke_bld_dir} -j ${jobs} install${strip:+-${strip}} || return
	update_path || return
}

realpath -e ${0} | grep -qe ^/tmp/ || { tmpdir=`mktemp -dp /tmp` && trap 'rm -fvr ${tmpdir}' EXIT HUP INT QUIT TERM && cp -v ${0} ${tmpdir} && sh -$- ${tmpdir}/`basename ${0}` "$@"; exit;}
trap 'set' USR1
while getopts p:s:j:f:c:l:t:h: arg; do
	case ${arg} in
	p)  prefix=${OPTARG};;
	s)  src=${OPTARG};;
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
				|| exec bash --noprofile --norc --posix -e ${0} -p ${prefix} -s ${src} -j ${jobs} -l ${languages} -h ${host} -t ${target} shell
		   count=`expr ${count} + 1`;;
	*=*)   eval export ${1}; set_variables;;
	*)     eval ${1} || exit 1; count=`expr ${count} + 1`;;
	esac
	shift
done
[ ${count} -eq 0 ] && usage || exit 0
