#!/bin/sh -e

dir=`dirname \`readlink -f $0\``/dotfiles
find ${dir} -mindepth 1 -maxdepth 1 -exec cp -t ${HOME} -rf {} +
