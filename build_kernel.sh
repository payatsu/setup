#!/bin/sh

help()
{
	cat <<EOF
[NAME]
	`basename ${0} - build kernel`
[SYNOPSIS]
	`basename ${0}` [-c] [-d] [-g] [-h] [-k] [-m] [-p] [-s] [-t]
[OPTIONS]
	-c
		install cgroup.
	-d
		build documents.
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

prepare()
{
	[ -z "${kernel_build}" ] || {
		which ed > /dev/null 2>&1 || apt install -y ed || return
		find `echo | LANG=C ${CC:-gcc} -x c -v -E - -o /dev/null 2>&1 |
			sed -e '/^#include "\.\.\." search starts here:$/,/^End of search list\.$/p;d' |
			grep -e '^ /' | xargs readlink -e` \( -type f -o -type l \) -name 'curses.h' > /dev/null 2>&1 ||
				apt install -y libncurses5-dev || return
	}
	[ -z "${perf_install}" ] || {
		which xmlto > /dev/null 2>&1 || apt install -y xmlto || return
		which asciidoc > /dev/null 2>&1 || apt install -y asciidoc || return
	}
	[ -z "${documents_build}" ] || {
		which virtualenv > /dev/null 2>&1 || apt install -y virtualenv || return
	}
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
	[ -z "${documents_build}" ] || {
		virtualenv sphinx_1.4 || return
		. sphinx_1.4/bin/activate || return
		pip install -r Documentation/sphinx/requirements.txt || return
		make ${make_opts} -k pdfdocs
		deactivate || return
	}
}

main()
{
	cgroup_install=
	documents_build=
	gpio_install=
	headers_install=
	kernel_build=
	modules_install=
	perf_install=
	spi_install=
	tags_create=
	while getopts cdghkmpst arg; do
		case ${arg} in
		c) cgroup_install=yes;;
		d) documents_build=yes;;
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
	while [ $# -gt 0 ]; do
		case ${1} in
		*=*) eval "${1}";;
		esac
		shift
	done

	init || return
	fetch || return
	build || return
}

[ -n "$-" ] && return
main "$@"
