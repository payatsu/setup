#!/bin/sh

target_script=$(dirname $(readlink -e $0))/../create-selfhosting-kit.sh

pkgs="`${target_script} --help | sed -e '/\[PACKAGES\]/,$p;d' | sed -e 1d`"

{
	echo -n 'Test started at '
	date
} >> test-result.log

for p in ${pkgs}; do
	case ${p} in
	gcc|gdb|crash|linux|qemu|e2fsprogs|tmux|emacs|texinfo|go)
		continue;;
	esac

	if ! ${target_script} --strip --cleanup --prepare $@ ${p}; then
		echo ERROR: build of \'${p}\' failed. >> test-result.log
		break
	fi

	find src -mindepth 2 -maxdepth 2 -type d -exec rm -fr {} +
done

{
	echo -n 'Test finished at '
	date
} >> test-result.log
