#!/bin/sh -e

EMACS_VERSION=24.5
FULLNAME=emacs-${EMACS_VERSION}
SRC_DIR=/usr/local/src/emacs

if [ "${DISTRIBUTION}" = Debian ]; then
	apt-get install --yes make libncurses-dev libgtk-3-dev libxpm-dev libgif-dev libtiff5-dev
else if [ "${DISTRIBUTION}" = RedHat ]; then
	yum install -y make ncurses-devel gtk3-devel libXpm-devel giflib-devel libtiff-devel libjpeg-devel
else
	echo distribution not supported, set environmental variable DISTRIBUTION 1>&2
	exit 1
fi fi

mkdir -p ${SRC_DIR}
[ -d ${SRC_DIR}/${EMACS_FULLNAME} ] || wget -O- http://ftpmirror.gnu.org/emacs/${EMACS_FULLNAME}.tar.gz | tar xzf - -C ${SRC_DIR} || exit 1
[ -f ${SRC_DIR}/${EMACS_FULLNAME}/Makefile ] || (cd ${SRC_DIR}/${EMACS_FULLNAME}; ./configure) || exit 1
make -j4 && make install-strip || exit 1 
