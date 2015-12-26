#!/bin/sh -e

if [ -f /etc/debian_version ]; then
	DISTRIBUTION=Debian
else if [ -f /etc/redhat-release ]; then
	DISTRIBUTION=RedHat
else
	echo distribution not supported, set environmental variable DISTRIBUTION 1>&2
	exit 1
fi fi
export DISTRIBUTION

DIR=`dirname $0`
for SCRIPT in 01_basic_tools.sh 02_binutils.sh 03_glibc.sh 04_gcc.sh 05_boost.sh 06_emacs.sh; do
	${DIR}/${SCRIPT} || exit 1
done

exit 0
