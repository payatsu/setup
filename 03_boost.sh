#!/bin/sh -e

# @file This is program for installing boost C++ libraries.

SRC_DIR=/usr/local/src/boost

mkdir -p ${SRC_DIR}
wget -O- 'http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fboost%2Ffiles%2Fboost%2F1.59.0%2Fboost_1_59_0.tar.gz%2Fdownload&ts=1446039338&use_mirror=jaist' | tar xzf - -C ${SRC_DIR} || return 1

(cd ${SRC_DIR}/boost_1_59_0; ./bootstrap.sh && ./b2 && ./b2 install)
