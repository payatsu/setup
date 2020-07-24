#!/bin/sh

help()
{
	cat <<EOF
[NAME]
	`basename ${0}` - build kernel
[SYNOPSIS]
	`basename ${0}` [-c] [-d] [-g] [-h] [-k] [-m] [-M] [-p] [-s] [-t] [-v]
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
	-M
		create my module.
	-p
		install perf.
	-s
		install spi.
	-t
		create tags.
	-v
		log verbosely.
EOF
}

init()
{
	: ${linux_ver:=5.5.13}
	: ${jobs:=`grep -ce '^processor\>' /proc/cpuinfo`}
	: ${ARCH:=arm}
	: ${CROSS_COMPILE:=arm-none-linux-gnueabi-}
	: ${O:=../linux-${linux_ver}-`echo ${CROSS_COMPILE} | sed -e 's/-$//'`}
	: ${prefix:=`pwd`/`basename ${CROSS_COMPILE} -`}
	make_opts="-j ${jobs} V=1 W=1 ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} O=${O} objtree=${O} INSTALL_MOD_PATH=${O}"
}

prepare()
{
	[ -z "${kernel_build}" ] || {
		which ed > /dev/null 2>&1 || apt install -y ed || return
		which bc > /dev/null 2>&1 || apt install -y bc || return
		find `echo | LANG=C ${CC:-${CROSS_COMPILE:+${CROSS_COMPILE}gcc}} -x c -v -E - -o /dev/null 2>&1 |
			sed -e '/^#include "\.\.\." search starts here:$/,/^End of search list\.$/p;d' |
			grep -e '^ /' | xargs readlink -e` \( -type f -o -type l \) -name 'curses.h' > /dev/null 2>&1 ||
				apt install -y libncurses5-dev || return
	}
	[ -z "${tags_create}" ] || which ctags > /dev/null 2>&1 || apt install -y exuberant-ctags || return
	[ -z "${perf_install}" ] || {
		which xmlto > /dev/null 2>&1 || apt install -y xmlto || return
		which asciidoc > /dev/null 2>&1 || apt install -y asciidoc || return
	}
	[ -z "${documents_build}" ] || {
		which virtualenv > /dev/null 2>&1 || apt install -y virtualenv || return
		which fc-list > /dev/null 2>&1 || apt install -y fontconfig || return
	}
}

fetch()
{
	case `echo ${linux_ver} | cut -d. -f1,2` in
	2.6) linux_major_ver=v2.6;;
	3.*) linux_major_ver=v3.x;;
	[456].*) linux_major_ver=v`echo ${linux_ver} | cut -d. -f1`.x;;
	*)   echo unsupported linux version >&2; return 1;;
	esac
	[ -f Kbuild ] || {
		[ -f linux-${linux_ver}.tar.xz ] || wget ${verbose:+-v} https://www.kernel.org/pub/linux/kernel/${linux_major_ver}/linux-${linux_ver}.tar.xz || return
		[ -d linux-${linux_ver} ] || tar xJ${verbose:+v}f linux-${linux_ver}.tar.xz || return
		cd linux-${linux_ver}
	} || return
}

make()
{
	echo make "$@"
	command make "$@"
}

build()
{
	[ -z "${kernel_build}" ] || {
		[ -f .config ] || make ${make_opts} defconfig || return
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
		virtualenv sphinx_1.7.9 || return
		. sphinx_1.7.9/bin/activate || return
		pip install -r Documentation/sphinx/requirements.txt || return
		make ${make_opts} -k htmldocs
		deactivate || return
	}
	[ -z "${mymodule_create}" ] || create_my_module || return
}

create_my_module()
{
	mkdir -p${verbose:+v} mymodules || return
	cat << EOF > mymodules/Makefile || return
ifneq (\$(KERNELRELEASE),)
	obj-m := mymodule.o
else
	KERNELDIR ?= /lib/modules/$(uname -r)/build
default:
	\$(MAKE) ${make_opts} -C \$(KERNELDIR) M=\`pwd\` modules
endif
EOF
	cat << EOF > mymodules/mymodule.c || return
#include <linux/init.h>
#include <linux/module.h>

static int __init mymodule_init(void)
{
	return 0;
}

static void __exit mymodule_exit(void)
{
}
module_init(mymodule_init);
module_exit(mymodule_exit);
EOF
	make -C mymodules KERNELDIR=`pwd` || return
}

main()
{
	cgroup_install=
	documents_build=
	gpio_install=
	headers_install=
	kernel_build=
	modules_install=
	mymodule_create=
	perf_install=
	spi_install=
	tags_create=
	verbose=
	while getopts cdghkmMpstv arg; do
		case ${arg} in
		c) cgroup_install=yes;;
		d) documents_build=yes;;
		g) gpio_install=yes;;
		h) headers_install=yes;;
		k) kernel_build=yes;;
		m) modules_install=yes;;
		M) mymodule_create=yes;;
		p) perf_install=yes;;
		s) spi_install=yes;;
		t) tags_create=yes;;
		v) verbose=yes;;
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
