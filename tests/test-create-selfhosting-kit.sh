#!/bin/sh

target_script=$(dirname $(readlink -e $0))/../create-selfhosting-kit.sh

pkgs="`${target_script} --help | sed -e '/\[PACKAGES\]/,$p;d' | sed -e 1d`"

{
	echo -n 'Test started at '
	date
} >> test-result.log

for p in ${pkgs}; do
	if ! ${target_script} --strip --cleanup $@ ${p}; then
		echo ERROR: build of \'$p\' failed. >> test-result.log
	fi
done

{
	echo -n 'Test finished at '
	date
} >> test-result.log
