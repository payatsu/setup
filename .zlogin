#!/bin/zsh

export EDITOR=vi
export PAGER=less

echo ${MANPATH} | grep -q /usr/local/share/man || export MANPATH=/usr/local/share/man:${MANPATH}
[ -f ${HOME}/.zlogin.local ] && . ${HOME}/.zlogin.local
