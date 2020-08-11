#!/bin/sh

: ${zlib_ver:=1.2.11}
: ${binutils_ver:=2.35}
: ${gmp_ver:=6.2.0}
: ${mpfr_ver:=4.1.0}
: ${mpc_ver:=1.1.0}
: ${isl_ver:=0.20}
: ${gcc_ver:=10.2.0}
: ${make_ver:=4.3}

: ${ncurses_ver:=6.2}
: ${readline_ver:=8.0}
: ${expat_ver:=2.2.9}
: ${libffi_ver:=3.3}
: ${openssl_ver:=1.1.1g}
: ${Python_ver:=3.8.5}
: ${boost_ver:=1_73_0}
: ${source_highlight_ver:=3.1.9}
: ${gdb_ver:=9.2}

: ${m4_ver:=1.4.18}
: ${perl_ver:=5.30.3}
: ${autoconf_ver:=2.69}
: ${automake_ver:=1.16.2}
: ${bison_ver:=3.7.1}
: ${flex_ver:=2.6.4}
: ${libtool_ver:=2.4.6}

: ${screen_ver:=4.8.0}
: ${vim_ver:=8.2.1127}
: ${vimdoc_ja_ver:=master}

: ${prefix:=/usr/local}
: ${host:=aarch64-linux-gnu}
: ${jobs:=4}

init()
{
	_1=`echo ${1} | tr - _`
	case ${1} in
	boost)
		eval ${_1}_name=${1}_\${${_1}_ver};;
	*)
		eval ${_1}_name=${1}-\${${_1}_ver};;
	esac
	eval ${_1}_src_base=${src_dir}/${1}
	eval ${_1}_src_dir=${src_dir}/${1}/\${${_1}_name}
	eval ${_1}_bld_dir=${src_dir}/${1}/\${${_1}_name}-${target}
}

check_archive()
{
	[ -f ${1}.tar.gz  -a -s ${1}.tar.gz  ] && return
	[ -f ${1}.tar.bz2 -a -s ${1}.tar.bz2 ] && return
	[ -f ${1}.tar.xz  -a -s ${1}.tar.xz  ] && return
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
	binutils|gmp|mpfr|mpc|make|ncurses|readline|gdb|screen|m4|autoconf|automake|bison|libtool)
		for compress_format in xz bz2 gz; do
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
	perl)
		wget -O ${perl_src_dir}.tar.gz \
			http://www.cpan.org/src/5.0/${perl_name}.tar.gz || return;;
	flex)
		wget -O ${flex_src_dir}.tar.gz \
			https://github.com/westes/flex/releases/download/v${flex_ver}/${flex_name}.tar.gz || return;;
	vim)
		wget -O ${vim_src_dir}.tar.gz \
			http://github.com/vim/vim/archive/v${vim_ver}.tar.gz || return;;
	vimdoc-ja)
		wget -O ${vimdoc_ja_src_dir}.tar.gz \
			https://github.com/vim-jp/vimdoc-ja/archive/master.tar.gz || return;;
	*) echo not implemented. can not fetch \'${1}\'. 2>&1; return 1;;
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
	return 1
}

print_library_path()
{
	for d in ${DESTDIR}${prefix}/lib64 ${DESTDIR}${prefix}/lib `LANG=C ${CC:-${target:+${target}-}gcc} -print-search-dirs |
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
		`LANG=C ${CC:-${target:+${target}-}gcc} -x c -E -v /dev/null -o /dev/null 2>&1 |
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

print_version()
{
	_1=`echo ${1} | tr - _`
	eval echo \${${_1}_ver} | cut -d. -f-${2:-2}
}

print_target_python_version()
{
	grep -e '\<PY_VERSION\>' `print_header_dir Python.h`/patchlevel.h | \
		grep -oPe '(?<=")\d\.\d(?=\.\d+")' || return
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
		[ -x ${DESTDIR}${prefix}/bin/${target}-as -a "${force_install}" != yes ] && return
		print_header_path zlib.h > /dev/null || ${0} zlib || return
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
		print_header_path gmp.h > /dev/null || ${0} gmp || return
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
		print_header_path mpfr.h > /dev/null || ${0} mpfr || return
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
		print_header_path gmp.h > /dev/null || ${0} gmp || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${isl_bld_dir}/Makefile ] ||
			(cd ${isl_bld_dir}
			${isl_src_dir}/configure --prefix=${prefix} --host=${host} --disable-silent-rules \
				--with-gmp-prefix=`print_prefix gmp.h` \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so`" LIBS=-lgmp) || return
		make -C ${isl_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${isl_bld_dir} -j ${jobs} -k check || return
		make -C ${isl_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		;;
	gcc)
		[ -x ${DESTDIR}${prefix}/bin/gcc -a "${force_install}" != yes ] && return
		[ -x ${DESTDIR}${prefix}/bin/${target}-as ] || ${0} binutils || return
		print_header_path zlib.h > /dev/null || ${0} zlib || return
		print_header_path gmp.h > /dev/null || ${0} gmp || return
		print_header_path mpfr.h > /dev/null || ${0} mpfr || return
		print_header_path mpc.h > /dev/null || ${0} mpc || return
		print_header_path version.h isl > /dev/null || ${0} isl || return
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
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${ncurses_bld_dir}/Makefile ] ||
			(cd ${ncurses_bld_dir}
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
			strip -v ${DESTDIR}${prefix}/bin/${b} || return
		done
		for l in libform libmenu libncurses++ libpanel libtinfo; do
			[ ! -f ${DESTDIR}${prefix}/lib/${l}.so ] || strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
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
			strip -v ${DESTDIR}${prefix}/lib/${l}.so || return
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
		strip -v ${DESTDIR}${prefix}/bin/xmlwf || return
		strip -v ${DESTDIR}${prefix}/lib/libexpat.so || return
		;;
	libffi)
		[ -f ${DESTDIR}${prefix}/lib/libffi-*/include/ffi.h -a "${force_install}" != yes ] && return
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
		ln -fsv /etc/ssl/certs ${DESTDIR}${prefix}/ssl/certs || return
		make -C ${openssl_bld_dir} -j 1 DESTDIR=${DESTDIR} install || return # XXX work around for parallel make
		mkdir -pv ${DESTDIR}${prefix}/lib/pkgconfig || return
		for f in libcrypto.pc libssl.pc openssl.pc; do
			[ ! -f ${DESTDIR}${prefix}/lib64/pkgconfig/${f} ] || ln -fsv ../../lib64/pkgconfig/${f} ${DESTDIR}${prefix}/lib/pkgconfig || return
		done
		[ -z "${strip}" ] && return
		strip -v ${DESTDIR}${prefix}/bin/openssl || return
		;;
	Python)
		[ -x ${DESTDIR}${prefix}/bin/python3 -a "${force_install}" != yes ] && return
		print_header_path expat.h > /dev/null || ${0} expat || return
		print_header_path ffi.h > /dev/null || ${0} libffi || return
		print_header_path ssl.h openssl > /dev/null || ${0} openssl || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${Python_bld_dir}/Makefile ] ||
			(cd ${Python_bld_dir}
			[ -f config.site ] || cat << EOF > config.site || return
ac_cv_file__dev_ptmx=yes
ac_cv_file__dev_ptc=no
EOF
			${Python_src_dir}/configure --prefix=${prefix} --build=`uname -m` --host=${host} --enable-universalsdk \
				--enable-shared --enable-optimizations --enable-ipv6 \
				--with-universal-archs=all --with-lto --with-system-expat --with-system-ffi \
				--with-openssl=`print_prefix ssl.h openssl` \
				--with-doc-strings --with-pymalloc --with-ensurepip CONFIG_SITE=config.site) || return
		make -C ${Python_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${Python_bld_dir} -j ${jobs} -k test || return
		make -C ${Python_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -z "${strip}" ] && return
		for v in `print_version Python` `print_version Python`m; do
			[ ! -f ${DESTDIR}${prefix}/bin/python${v} ] || strip -v ${DESTDIR}${prefix}/bin/python${v} || return
		done
		for soname_v in `print_version Python 1`.so `print_version Python`.so.1.0 `print_version Python`m.so.1.0; do
			[ ! -f ${DESTDIR}${prefix}/lib/libpython${soname_v} ] ||
				(chmod -v u+w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
				strip -v ${DESTDIR}${prefix}/lib/libpython${soname_v} || return
				chmod -v u-w ${DESTDIR}${prefix}/lib/libpython${soname_v} || return) || return
		done
		;;
	boost)
		[ -d ${DESTDIR}${prefix}/include/boost -a "${force_install}" != yes ] && return
		fetch ${1} || return
		unpack ${1} || return
		(cd ${boost_src_dir}
		./bootstrap.sh --prefix=${DESTDIR}${prefix} --with-toolset=gcc &&
  		sed -i -e "/^    using gcc /s//&: : ${target}-gcc /" project-config.jam &&
		./b2 --prefix=${DESTDIR}${prefix} --build-dir=${boost_bld_dir} \
			--layout=system --build-type=minimal -j ${jobs} -q \
			include=${prefix}/include library-path=${prefix}/lib install) || return
		;;
	source-highlight)
		[ -x ${DESTDIR}${prefix}/bin/source-highlight -a "${force_install}" != yes ] && return
		print_header_path version.hpp boost > /dev/null || ${0} boost || return
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
	gdb)
		[ -x ${DESTDIR}${prefix}/bin/gdb -a "${force_install}" != yes ] && return
		print_header_path readline.h readline > /dev/null || ${0} readline || return
		print_header_path curses.h > /dev/null || ${0} ncurses || return
		print_header_path Python.h > /dev/null || ${0} Python || return
		print_header_path sourcehighlight.h srchilite > /dev/null || ${0} source-highlight || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${gdb_bld_dir}/Makefile ] ||
			(cd ${gdb_bld_dir}
			[ -f host_configargs ] || cat << EOF | tr '\n' ' ' > host_configargs || return
--disable-rpath
CFLAGS='${CFLAGS} -I`print_header_dir zlib.h` -I`print_header_dir curses.h`'
CPPFLAGS='${CPPFLAGS} -I`print_header_dir zlib.h`'
PKG_CONFIG_SYSROOT_DIR=${DESTDIR}
EOF
			${gdb_src_dir}/configure --prefix=${prefix} --host=${host} --target=${target} \
				--enable-targets=all --enable-64-bit-bfd --enable-tui \
				--with-auto-load-dir='$debugdir:$datadir/auto-load:'${prefix}/lib/gcc/${target} --without-guile --with-python=python3 \
				--with-system-zlib --with-system-readline \
				LDFLAGS="${LDFLAGS} -L`print_library_dir libz.so` -L`print_library_dir libncurses.so`" \
				host_configargs="`cat host_configargs`") || return
		make -C ${gdb_bld_dir} -j ${jobs} V=1 || return
		[ "${enable_check}" != yes ] ||
			make -C ${gdb_bld_dir} -j ${jobs} -k check || return
		make -C ${gdb_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		make -C ${gdb_bld_dir}/gdb -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} || return
		make -C ${gdb_bld_dir}/sim -j ${jobs} DESTDIR=${DESTDIR} install || return
		;;
	screen)
		[ -x ${DESTDIR}${prefix}/bin/screen -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ncurses || return
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
		[ -z "${strip}" ] || strip -v ${DESTDIR}${prefix}/bin/${screen_name} || return
		;;
	m4|perl)
		# TODO: not implemented.
		echo \'${1}\' can not be installed with this script yet. skipped. 2>&1
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
		[ -x ${DESTDIR}${prefix}/bin/autoconf ] || ${0} autoconf || return
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
		[ -x ${DESTDIR}${prefix}/bin/bison ] || ${0} bison || return
		fetch ${1} || return
		unpack ${1} || return
		[ -f ${flex_bld_dir}/Makefile ] ||
			(cd ${flex_bld_dir}
			${flex_src_dir}/configure --prefix=${prefix} --host=${host}) || return
		make -C ${flex_bld_dir} -j ${jobs} || return
		[ "${enable_check}" != yes ] ||
			make -C ${flex_bld_dir} -j ${jobs} -k check || return
		make -C ${flex_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install${strip:+-${strip}} install-man || return
		;;
	libtool)
		[ -x ${DESTDIR}${prefix}/bin/libtool -a "${force_install}" != yes ] && return
		[ -x ${DESTDIR}${prefix}/bin/flex ] || ${0} flex || return
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
		strip -v ${DESTDIR}${prefix}/lib/libltdl.so || return
		;;
	vim)
		[ -x ${DESTDIR}${prefix}/bin/vim -a "${force_install}" != yes ] && return
		print_header_path curses.h > /dev/null || ${0} ncurses || return
		print_header_path Python.h > /dev/null || ${0} Python || return
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
vi_cv_var_python3_abiflags=
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
		for l in ex rview rvim view; do
			[ ! -h ${DESTDIR}${prefix}/bin/${l} ] || rm -fv ${DESTDIR}${prefix}/bin/${l} || return
		done
		make -C ${vim_bld_dir} -j ${jobs} DESTDIR=${DESTDIR} install || return
		[ -f ${DESTDIR}${prefix}/bin/vi ] || ln -fsv vim ${DESTDIR}${prefix}/bin/vi || return
		${0} vimdoc-ja || return
		;;
	vimdoc-ja)
		fetch ${1} || return
		unpack ${1} || return
		mkdir -pv ${DESTDIR}${prefix}/share/vim/vimfiles || return
		cp -Tvr ${vimdoc_ja_src_dir} ${DESTDIR}${prefix}/share/vim/vimfiles || return
		vim -i NONE -u NONE -N -c "helptags ${DESTDIR}${prefix}/share/vim/vimfiles/doc" -c qall || return
		;;
	*) echo not implemented. can not build \'${1}\'. 2>&1; return 1;;
	esac
	find ${DESTDIR}${prefix}/lib -type f -name '*.la' -exec \
		sed -i -e "
			/^dependency_libs='.\+'/{
				s/^/# /
				adependency_libs=''
			}
			/^libdir=/s!'${prefix}/lib'!'${DESTDIR}${prefix}/lib'!
			" {} + || return
}

main()
{
	target=${host}
	${target}-gcc --version > /dev/null || return

	mkdir -pv selfhosting-kit || return
	src_dir=`readlink -m selfhosting-kit/src`
	DESTDIR=`readlink -m selfhosting-kit/products`
	languages=c,c++,go

	for p in "${@:-`grep -oPe '(?<=^: \\${)\w+(?=_ver)' ${0} | sed -e 's/source_highlight/source-highlight/;s/vimdoc_ja/vimdoc-ja/'`}"; do
		init ${p} || return
		build ${p} || return
	done
}

main "$@"
