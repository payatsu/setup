#!/bin/sh

# TODO: perf
# TODO: pdfdocs htmldocs

init()
{
	: ${linux_ver:=4.15.13}
	: ${jobs:=`grep -ce '^processor\>' /proc/cpuinfo`}
	: ${ARCH:=arm}
	: ${CROSS_COMPILE:=arm-none-linux-gnueabi-}
	: ${INSTALL_HDR_PATH:=./usr}
	: ${INSTALL_MOD_PATH:=/}
	make_opts="-j ${jobs} V=1 W=1 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} INSTALL_HDR_PATH=${INSTALL_HDR_PATH} INSTALL_MOD_PATH=${INSTALL_MOD_PATH}"
}

fetch()
{
	case `echo ${linux_ver} | cut -d. -f1,2` in
	2.6) linux_major_ver=v2.6;;
	3.*) linux_major_ver=v3.x;;
	4.*) linux_major_ver=v4.x;;
	*)   echo unsupported linux version >&2; return 1;;
	esac
	[ -f Kbuild ] || {
		[ -f linux-${linux_ver}.tar.xz ] || wget https://www.kernel.org/pub/linux/kernel/${linux_major_ver}/linux-${linux_ver}.tar.xz || return
		[ -d linux-${linux_ver} ] || tar xJvf linux-${linux_ver}.tar.xz || return
		cd linux-${linux_ver}
	} || return
}

build()
{
	[ -f .config ] || make ${make_opts} olddefconfig || return
	make ${make_opts} || return
	make ${make_opts} modules_install || return
	make ${make_opts} headers_install || return
	make ${make_opts} tags gtags || return
	make ${make_opts} -C tools cgroup || return
	make ${make_opts} -C tools gpio || return
	make ${make_opts} -C tools perf || return
	make ${make_opts} -C tools spi || return
}

main()
{
	init || return
	fetch || return
	build || return
}

main
