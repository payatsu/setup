#!/bin/sh

help()
{
	cat <<EOF
[NAME]
	`basename ${0}` - build kernel
[SYNOPSIS]
	`basename ${0}` [--help] [-v|--verbose] [-k|--kernel]
		[-h|--headers] [-m|--modules] [-t|--tags] [-d|--document]
		[--my-module]
		[-p|--perf] [-g|--gpio] [-s|--spi] [-c|--cgroup]
[OPTIONS]
		--help
			show this help.
		-v --verbose
			enable verbose log output. this is default.
		-q --quiet
			disable verbose log output.
		-k --kernel
			build kernel.
		-h --headers
			install kernel headers.
		-m --modules
			install kernel modules.
		-t --tags
			create tags.
		-d --document
			build documents.
		--my-module
			create your own module.
		-p --perf
			install perf.
		-g --gpio
			install gpio.
		-s --spi
			install spi.
		-c --cgroup
			install cgroup.
EOF
}

init()
{
	: ${linux_ver:=5.11.6}
	: ${jobs:=`grep -ce '^processor\>' /proc/cpuinfo`}
	: ${ARCH:=`uname -m`}
	: ${CROSS_COMPILE:=`gcc -dumpmachine`-}
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
	[ -z "${tags_generate}" ] || which ctags > /dev/null 2>&1 || apt install -y exuberant-ctags || return
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
	[ -z "${tags_generate}" ] || make ${make_opts} tags gtags || return
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
	verbose=yes
	kernel_build=
	headers_install=
	modules_install=
	tags_generate=
	documents_build=
	mymodule_create=
	perf_install=
	gpio_install=
	spi_install=
	cgroup_install=
	while [ $# -gt 0 ]; do
		case ${1} in
		--help) help; exit 0;;
		-v|--verbose)  verbose=yes;;
		-q|--quiet)    verbose=;;
		-k|--kernel)   kernel_build=yes;;
		-h|--headers)  headers_install=yes;;
		-m|--modules)  modules_install=yes;;
		-t|--tags)     tags_generate=yes;;
		-d|--document) documents_build=yes;;
		--my-module)   mymodule_create=yes;;
		-p|--perf)     perf_install=yes;;
		-g|--gpio)     gpio_install=yes;;
		-s|--spi)      spi_install=yes;;
		-c|--cgroup)   cgroup_install=yes;;
		*=*) eval "${1}";;
		-*|--*) echo unknown option \'${1}\'. try \'--help\'. >&2; exit 1;;
		esac
		shift
	done

	init || return
	fetch || return
	build || return
}

[ -n "$-" ] && return
main "$@"
