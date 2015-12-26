#!/bin/sh -e

dir=`dirname \`readlink -f $0\``
ln -sf ${dir}/.exrc ${HOME}
ln -sf ${dir}/.vimrc ${HOME}
ln -sf ${dir}/.zshrc ${HOME}
ln -sf ${dir}/.zlogin ${HOME}
ln -sf ${dir}/.gdbinit ${HOME}
ln -sf ${dir}/.screenrc ${HOME}
ln -sf ${dir}/init.el ${HOME}/.emacs.d
