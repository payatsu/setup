#!/bin/sh

# TODO: pdfdocs htmldocs

help()
{
	cat <<EOF
[NAME]
	`basename ${0} - build kernel`
[SYNOPSIS]
	`basename ${0}` [-c] [-g] [-h] [-k] [-m] [-p] [-s] [-t]
[OPTIONS]
	-c
		install cgroup.
	-g
		install gpio.
	-h
		install headers.
	-k
		build kernel.
	-m
		install modules.
	-p
		install perf.
	-s
		install spi.
	-t
		create tags.
EOF
}

init()
{
	: ${linux_ver:=4.15.13}
	: ${jobs:=`grep -ce '^processor\>' /proc/cpuinfo`}
	: ${ARCH:=arm}
	: ${CROSS_COMPILE:=arm-none-linux-gnueabi-}
	: ${INSTALL_HDR_PATH:=./usr}
	: ${INSTALL_MOD_PATH:=/}
	: ${prefix:=`pwd`}
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
	[ -z "${kernel_build}" ] || {
		[ -f .config ] || make ${make_opts} olddefconfig || return
		make ${make_opts} || return
	}
	[ -z "${modules_install}" ] || make ${make_opts} modules_install || return
	[ -z "${headers_install}" ] || make ${make_opts} headers_install || return
	[ -z "${tags_create}" ] || make ${make_opts} tags gtags || return
	[ -z "${cgroup_install}" ] || {
		make ${make_opts} -C tools cgroup || return
	}
	[ -z "${gpio_install}" ] || {
		make ${make_opts} -C tools gpio || return
	}
	[ -z "${perf_install}" ] || {
		make ${make_opts} -C tools/perf all || return
		make ${make_opts} -C tools/perf doc || return
		make ${make_opts} -C tools/perf DESTDIR=${prefix} install || return
	}
	[ -z "${spi_install}" ] || {
		make ${make_opts} -C tools spi || return
	}
}

main()
{
	cgroup_install=
	gpio_install=
	headers_install=
	kernel_build=
	modules_install=
	perf_install=
	spi_install=
	tags_create=
	while getopts cghkmpst arg; do
		case ${arg} in
		c) cgroup_install=yes;;
		g) gpio_install=yes;;
		h) headers_install=yes;;
		k) kernel_build=yes;;
		m) modules_install=yes;;
		p) perf_install=yes;;
		s) spi_install=yes;;
		t) tags_create=yes;;
		\?) help 2>&1; exit 1;;
		esac
	done
	shift `expr ${OPTIND} - 1`

	init || return
	fetch || return
	build || return
}

main "$@"
