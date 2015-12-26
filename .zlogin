#!/bin/zsh

export EDITOR=vi
export PAGER=less

if [ -n "${MANPATH}" ]
then
	export MANPATH=/usr/local/share/man:${MANPATH}
else
	export MANPATH=/usr/local/share/man:
fi
