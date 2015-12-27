#!/bin/sh -e

# [TODO] gcc 1st stage, gcc 2nd stageのconfigureオプションを色々変えてみて試す。
#        -> libgcc_s.soが見つからないのでgoコンパイラが作れない問題を解決する。
#          -> gccビルドのfinalステージを実装する
# [TODO] microblazeを指定するとglibc-1stでSYSCALL_CANCELが見つからずにコケる問題を解決する。
# [TODO] linux-2.6.18, glibc-2.16.0の組み合わせを試す。
# [TODO] 作成したクロスコンパイラで、C/C++/Goのネイティブコンパイラ作ってみる。
# [TODO] ネイティブ/クロス用のGDB入れる機能作る。
#        発展系としてGNU Toolchain一式を入れる機能作る。
# [TODO] ディレクトリあるか調べてtarする手続きを関数化する。

: ${binutils_ver:=2.25}
: ${kernel_ver:=3.18.13}
: ${glibc_ver:=2.22}
: ${gmp_ver:=6.1.0}
: ${mpfr_ver:=3.1.3}
: ${mpc_ver:=1.0.3}
: ${gcc_ver:=5.3.0}
: ${prefix:=/toolchains}
: ${target:=`uname -m`-linux}
: ${linux_arch:=`uname -m`}

help()
{
	cat <<EOF
[Usage]
	$0 [-p prefix] [-t target] [-a arch] [-j jobs] [-h] [variable=value]... tags...

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
	-a arch
		Target architecture of Linux kernel, currently '${linux_arch}'.
		ex. arm
			x86
			microblaze
	-j jobs
		The number of process run simultaneously by 'make', currently '${jobs}'.
		Recommended not to be more than the number of CPU cores.
	-h
		Show this help.

[Environmental variables]
	binutils_ver
		Specify the version of GNU Binutils, currently '${binutils_ver}'.
	kernel_ver
		Specify the version of Linux kernel, currently '${kernel_ver}'.
	glibc_ver
		Specify the version of GNU C Library, currently '${glibc_ver}'.
	gmp_ver
		Specify the version of GNU MP Bignum Library, currently '${gmp_ver}'.
	mpfr_ver
		Specify the version of GNU MPFR Library, currently '${mpfr_ver}'.
	mpc_ver
		Specify the version of GNU MPC Library, currently '${mpc_ver}'.
	gcc_ver
		Specify the version of GNU Compiler Collection, currently '${gcc_ver}'.

[Available tags]
	native
		Install GNU C/C++/Go native compiler(running on/compiles for '${build}').
	cross
		Install GNU C/C++ cross compiler(running on '${build}', compiles for '${target}').
	debug
		Enter debug(interactive) mode.

[Examples]
	For Raspberry pi2
	# $0 -p /toolchains -t armv7l-linux-gnueabihf -a arm -j 8 binutils_ver=2.25 kernel_ver=3.18.13 glibc_ver=2.22 gmp_ver=6.1.0 mpfr_ver=3.1.3 mpc_ver=1.0.3 gcc_ver=5.3.0 cross

EOF
}

set_variables()
{
	: ${sysroot:=${prefix}/${target}/sysroot}
	: ${jobs:=`grep -e processor /proc/cpuinfo | wc -l`}
	build=`uname -m`-linux
	os=`head -1 /etc/issue | cut -d ' ' -f 1`

	binutils_name=binutils-${binutils_ver}
	binutils_src_base=${prefix}/src/binutils
	binutils_org_src_dir=${binutils_src_base}/${binutils_name}
	binutils_src_dir_ntv=${binutils_src_base}/${target}-${binutils_name}-ntv
	binutils_src_dir_crs=${binutils_src_base}/${target}-${binutils_name}-crs
	binutils_src_dir_crs_ntv=${binutils_src_base}/${target}-${binutils_name}-crs-ntv

	kernel_name=linux-${kernel_ver}
	kernel_src_base=${prefix}/src/linux
	kernel_org_src_dir=${kernel_src_base}/${kernel_name}
	kernel_src_dir=${kernel_src_base}/${target}-${kernel_name}

	glibc_name=glibc-${glibc_ver}
	glibc_src_base=${prefix}/src/glibc
	glibc_org_src_dir=${glibc_src_base}/${glibc_name}
	glibc_bld_dir_hdr=${glibc_src_base}/${target}-${glibc_name}-header
	glibc_bld_dir_1st=${glibc_src_base}/${target}-${glibc_name}-1st
	glibc_bld_dir_2nd=${glibc_src_base}/${target}-${glibc_name}-2nd
	glibc_src_dir_hdr=${glibc_src_base}/${target}-${glibc_name}-header-src
	glibc_src_dir_1st=${glibc_src_base}/${target}-${glibc_name}-1st-src
	glibc_src_dir_2nd=${glibc_src_base}/${target}-${glibc_name}-2nd-src

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
	gcc_bld_dir_final=${gcc_src_base}/${target}-${gcc_name}-final
	gcc_bld_dir_crs_ntv=${gcc_src_base}/${target}-${gcc_name}-crs-ntv

	grep -q ${prefix}/bin <<EOF || PATH=${prefix}/bin:${PATH}
${PATH}
EOF
}

install_prerequisites()
{
	case ${os} in
	Debian|Ubuntu)
		apt-get install -y make gcc g++ texinfo
		apt-get install -y libc6-dev-i386
		[ ${build} != ${target} ] && apt-get install -y gawk gperf
		apt-get install -y bison
		apt-get install -y unifdef
		;;
	Red|CentOS)
		yum install -y make gcc gcc-c++ texinfo
		yum install -y glibc-devel.i686 libstdc++-devel.i686
		[ ${build} != ${target} ] && yum install -y gawk gperf
		yum install -y bison
		yum install -y unifdef
		;;
	*) echo 'Your operating system is not supported, sorry :-(' >&2; return 1 ;;
	esac
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
	[ -f ${kernel_org_src_dir}.tar.gz ] ||
		wget -nv -O ${kernel_org_src_dir}.tar.gz \
			https://www.kernel.org/pub/linux/kernel/${dir}/${kernel_name}.tar.gz || return 1
}

prepare_glibc_source()
{
	mkdir -p ${glibc_src_base}
	[ -f ${glibc_org_src_dir}.tar.gz ] ||
		wget -nv -O ${glibc_org_src_dir}.tar.gz \
			http://ftp.gnu.org/gnu/glibc/${glibc_name}.tar.gz || return 1
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
			http://ftp.tsukuba.wide.ad.jp/software/gcc/releases/${gcc_name}/${gcc_name}.tar.gz || return 1
}

prepare_all_source()
{
	prepare_binutils_source || return 1
	prepare_kernel_source || return 1 
	prepare_glibc_source || return 1
	prepare_gmp_mpfr_mpc_source || return 1
	prepare_gcc_source || return 1
}

install_native_binutils()
{
	install_prerequisites || return 1
	prepare_binutils_source || return 1
	[ -d ${binutils_src_dir_ntv} ] ||
		(tar xzvf ${binutils_org_src_dir}.tar.gz -C ${binutils_src_base} &&
			mv ${binutils_org_src_dir} ${binutils_src_dir_ntv}) || return 1
	[ -f ${binutils_src_dir_ntv}/Makefile ] ||
		(cd ${binutils_src_dir_ntv} 
		./configure --prefix=${prefix} --with-sysroot=/ --enable-gold) || return 1
	make -C ${binutils_src_dir_ntv} -j${jobs} || return 1
	make -C ${binutils_src_dir_ntv} -j${jobs} install-strip || return 1
}

install_native_gmp_mpfr_mpc()
{
	prepare_gmp_mpfr_mpc_source || return 1

	[ -d ${gmp_src_dir_ntv} ] ||
		(tar xjvf ${gmp_org_src_dir}.tar.bz2 -C ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_ntv}) || return 1
	[ -f ${gmp_src_dir_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_ntv}
		 ${gmp_src_dir_ntv}/configure --prefix=${prefix}) || return 1
	make -C ${gmp_src_dir_ntv} -j${jobs} || return 1
	make -C ${gmp_src_dir_ntv} -j${jobs} install-strip || return 1

	[ -d ${mpfr_src_dir_ntv} ] ||
		(tar xzvf ${mpfr_org_src_dir}.tar.gz -C ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_ntv}) || return 1
	[ -f ${mpfr_src_dir_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_ntv}
		 ${mpfr_src_dir_ntv}/configure --prefix=${prefix} --with-gmp=${prefix}) || return 1
	make -C ${mpfr_src_dir_ntv} -j${jobs} || return 1
	make -C ${mpfr_src_dir_ntv} -j${jobs} install-strip || return 1

	[ -d ${mpc_src_dir_ntv} ] ||
		(tar xzvf ${mpc_org_src_dir}.tar.gz -C ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_ntv}) || return 1
	[ -f ${mpc_src_dir_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_ntv}
		${mpc_src_dir_ntv}/configure --prefix=${prefix} --with-gmp=${prefix} --with-mpfr=${prefix}) || return 1
	make -C ${mpc_src_dir_ntv} -j${jobs} || return 1
	make -C ${mpc_src_dir_ntv} -j${jobs} install-strip || return 1
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

native()
{
	install_prerequisites || return 1
	install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	make_symbolic_links || return 1
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_ntv}
	[ -f ${gcc_bld_dir_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_ntv}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			 --enable-languages=c,c++,go --enable-multilib --without-isl) || return 1
	make -C ${gcc_bld_dir_ntv} -j${jobs} || return 1
	make -C ${gcc_bld_dir_ntv} -j${jobs} install-strip || return 1
	echo ${prefix}/lib64/ > /etc/ld.so.conf.d/${gcc_name}.conf
	ldconfig
	clean
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
	make -C ${binutils_src_dir_crs} -j${jobs} || return 1
	make -C ${binutils_src_dir_crs} -j${jobs} install-strip || return 1
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
	make -C ${gcc_bld_dir_crs_1st} -j${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_1st} -j${jobs} install-gcc || return 1
}

install_kernel_header()
{
	prepare_kernel_source || return 1
	[ -d ${kernel_src_dir} ] ||
		(tar xzvf ${kernel_org_src_dir}.tar.gz -C ${kernel_src_base} &&
			mv ${kernel_org_src_dir} ${kernel_src_dir}) || return 1
	make -C ${kernel_src_dir} -j${jobs} mrproper || return 1
	make -C ${kernel_src_dir} -j${jobs} \
		ARCH=${linux_arch} INSTALL_HDR_PATH=${sysroot}/usr headers_install || return 1
}

install_glibc_headers()
{
	prepare_glibc_source || return 1
	[ -d ${glibc_src_dir_hdr} ] ||
		(tar xzvf ${glibc_org_src_dir}.tar.gz -C ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_hdr}) || return 1
	mkdir -p ${glibc_bld_dir_hdr}
	[ -f ${glibc_bld_dir_hdr}/Makefile ] ||
		(cd ${glibc_bld_dir_hdr}
		${glibc_src_dir_hdr}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes \
		) || return 1
	make -C ${glibc_bld_dir_hdr} -j${jobs} DESTDIR=${sysroot} install-headers || return 1
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
	make -C ${gcc_bld_dir_crs_2nd} -j${jobs} all-gcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j${jobs} install-gcc || return 1
	touch ${sysroot}/usr/include/gnu/stubs.h
	touch ${sysroot}/usr/include/gnu/stubs-soft.h
	make -C ${gcc_bld_dir_crs_2nd} -j${jobs} all-target-libgcc || return 1
	make -C ${gcc_bld_dir_crs_2nd} -j${jobs} install-target-libgcc || return 1
}

install_1st_glibc()
{
	[ -d ${glibc_src_dir_1st} ] ||
		(tar xzvf ${glibc_org_src_dir}.tar.gz -C ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_1st}) || return 1
	mkdir -p ${glibc_bld_dir_1st}
	[ -f ${glibc_bld_dir_1st}/Makefile ] ||
		(cd ${glibc_bld_dir_1st}
		${glibc_src_dir_1st}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include \
			libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_ctors_header=yes \
		) || return 1
	make -C ${glibc_bld_dir_1st} -j${jobs} DESTDIR=${sysroot} || return 1
	make -C ${glibc_bld_dir_1st} -j${jobs} DESTDIR=${sysroot} install || return 1
}

install_cross_gcc_with_c_cxx_functionality()
{
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_3rd}
	[ -f ${gcc_bld_dir_crs_3rd}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_3rd}
		 ${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c,c++ --with-sysroot=${sysroot}) || return 1
	make -C ${gcc_bld_dir_crs_3rd} -j${jobs} || return 1
	make -C ${gcc_bld_dir_crs_3rd} -j${jobs} install-strip || return 1
}

cross()
{
	install_prerequisites || return 1
	install_cross_binutils || return 1
	install_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	install_cross_gcc_without_headers || return 1
	install_kernel_header || return 1
	install_glibc_headers || return 1
	install_cross_gcc_with_glibc_headers || return 1
	install_1st_glibc || return 1
	install_cross_gcc_with_c_cxx_functionality || return 1
	clean
}

install_2nd_glibc()
{
	[ -d ${glibc_src_dir_2nd} ] ||
		(tar xzvf ${glibc_org_src_dir}.tar.gz -C ${glibc_src_base} &&
			mv ${glibc_org_src_dir} ${glibc_src_dir_2nd}) || return 1
	mkdir -p ${glibc_bld_dir_2nd}
	[ -f ${glibc_bld_dir_2nd}/Makefile ] ||
		(cd ${glibc_bld_dir_2nd}
		${glibc_src_dir_2nd}/configure --prefix=/usr --build=${build} --host=${target} \
			--with-headers=${sysroot}/usr/include) || return 1
	make -C ${glibc_bld_dir_2nd} -j${jobs} DESTDIR=${sysroot} || return 1
	make -C ${glibc_bld_dir_2nd} -j${jobs} DESTDIR=${sysroot} install || return 1
}

install_complete_gcc()
{
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_final}
# LDFLAGS="-Wl,-rpath ${binutils_src_dir_crs}/libiberty -Wl,-rpath /usr/local/lib64 -L/usr/local/lib64"
	LDFLAGS="-Wl,-rpath ${binutils_src_dir_crs}/libiberty -Wl,-rpath ${prefix}/${target}/lib -L${prefix}/${target}/lib"
	export LDFLAGS
	[ -f ${gcc_bld_dir_final}/Makefile ] ||
		(cd ${gcc_bld_dir_final}
		${gcc_org_src_dir}/configure --prefix=${prefix} --build=${build} --target=${target} --with-gmp=${prefix} --with-mpfr=${prefix} --with-mpc=${prefix} \
			--enable-languages=c,c++,go --with-sysroot=${sysroot}) || return 1
	make -C ${gcc_bld_dir_final} -j${jobs} || return 1
	make -C ${gcc_bld_dir_final} -j${jobs} install-strip || return 1
}

install_full_functional_cross_gcc()
{
	cross || return 1
	install_2nd_glibc || return 1
	install_complete_gcc
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
	make -C ${binutils_src_dir_crs_ntv} -j${jobs} || return 1
	make -C ${binutils_src_dir_crs_ntv} -j${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_gmp_mpfr_mpc()
{
	prepare_gmp_mpfr_mpc_source || return 1

	[ -d ${gmp_src_dir_crs_ntv} ] ||
		(tar xjvf ${gmp_org_src_dir}.tar.bz2 -C ${gmp_src_base} &&
			mv ${gmp_org_src_dir} ${gmp_src_dir_crs_ntv}) || return 1
	[ -f ${gmp_src_dir_crs_ntv}/Makefile ] ||
		(cd ${gmp_src_dir_crs_ntv}
		${gmp_src_dir_crs_ntv}/configure --prefix=/usr --host=${target}) || return 1
	make -C ${gmp_src_dir_crs_ntv} -j${jobs} || return 1
	make -C ${gmp_src_dir_crs_ntv} -j${jobs} DESTDIR=${sysroot} install-strip || return 1

# XXX クロス先のネイティブ環境用なので、with-gmp, --with-mpfrの指定が間違ってるかも。

	[ -d ${mpfr_src_dir_crs_ntv} ] ||
		(tar xzvf ${mpfr_org_src_dir}.tar.gz -C ${mpfr_src_base} &&
			mv ${mpfr_org_src_dir} ${mpfr_src_dir_crs_ntv}) || return 1
	[ -f ${mpfr_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpfr_src_dir_crs_ntv}
		${mpfr_src_dir_crs_ntv}/configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr) || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j${jobs} || return 1
	make -C ${mpfr_src_dir_crs_ntv} -j${jobs} DESTDIR=${sysroot} install-strip || return 1

	[ -d ${mpc_src_dir_crs_ntv} ] ||
		(tar xzvf ${mpc_org_src_dir}.tar.gz -C ${mpc_src_base} &&
			mv ${mpc_org_src_dir} ${mpc_src_dir_crs_ntv}) || return 1
	[ -f ${mpc_src_dir_crs_ntv}/Makefile ] ||
		(cd ${mpc_src_dir_crs_ntv}
		${mpc_src_dir_crs_ntv}/configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr) || return 1
	make -C ${mpc_src_dir_crs_ntv} -j${jobs} || return 1
	make -C ${mpc_src_dir_crs_ntv} -j${jobs} DESTDIR=${sysroot} install-strip || return 1
}

install_crossed_native_gcc()
{
	install_prerequisites || return 1
	install_crossed_native_gmp_mpfr_mpc || return 1
	prepare_gcc_source || return 1
	[ -d ${gcc_org_src_dir} ] ||
		tar xzvf ${gcc_org_src_dir}.tar.gz -C ${gcc_src_base} || return 1
	mkdir -p ${gcc_bld_dir_crs_ntv}
	[ -f ${gcc_bld_dir_crs_ntv}/Makefile ] ||
		(cd ${gcc_bld_dir_crs_ntv}
		${gcc_org_src_dir}/configure --prefix=/usr --host=${target} --with-gmp=${sysroot}/usr --with-mpfr=${sysroot}/usr --with-mpc=${sysroot}/usr \
			 --enable-languages=c,c++,go --with-sysroot=/ --without-isl) || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j${jobs} || return 1
	make -C ${gcc_bld_dir_crs_ntv} -j${jobs} DESTDIR=${sysroot} install-strip || return 1
}

list_install()
{
	grep -e '^install_.\+()$' $0 | sed -e 's/^/\t- /;s/()//'
}

list_all()
{
	grep -e '[[:alpha:]]\+()$' $0 | sed -e 's/^/\t- /;s/()//'
}

list()
{
	list_all
}

clean()
{
	rm -rf ${binutils_org_src_dir} ${binutils_src_dir_ntv} ${binutils_src_dir_crs} ${binutils_src_dir_crs_ntv} \
		${kernel_org_src_dir} ${kernel_src_dir} \
		${glibc_org_src_dir} ${glibc_bld_dir_hdr} ${glibc_bld_dir_1st} ${glibc_bld_dir_2nd} \
		${glibc_src_dir_hdr} ${glibc_src_dir_1st} ${glibc_src_dir_2nd} \
		${gmp_src_dir_ntv} ${gmp_src_dir_crs_ntv} ${mpfr_src_dir_ntv} ${mpfr_src_dir_crs_ntv} ${mpc_src_dir_ntv} ${mpc_src_dir_crs_ntv} \
		${gcc_org_src_dir} ${gcc_bld_dir_ntv} ${gcc_bld_dir_crs_1st} ${gcc_bld_dir_crs_2nd} ${gcc_bld_dir_crs_3rd} ${gcc_bld_dir_final} ${gcc_bld_dir_crs_ntv}
}

while getopts p:t:a:j:h arg; do
	case ${arg} in
	p)  prefix=${OPTARG};;
	t)  target=${OPTARG};;
	a)  linux_arch=${OPTARG};;
	j)  jobs=${OPTARG};;
	h)  set_variables; help; exit 0;;
	\?) set_variables; help >&2; exit 1;;
	esac
done
shift `expr ${OPTIND} - 1`

set_variables

while [ $# -gt 0 ]; do
	case $1 in
	native|cross) $1;;
	*=*)   eval $1; set_variables;;
	debug) shift; [ $# -eq 0 ] && while true ;do read -p 'debug> ' cmd; eval ${cmd} || true; done; eval $1;;
	*)     echo "Unknown tag: $1" >&2; help; exit 1;;
	esac
	shift
done
