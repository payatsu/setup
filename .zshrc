#!/bin/zsh

autoload -Uz compinit
compinit
bindkey -e
case ${UID} in
	0) PROMPT='%n@%m:%~# ';;
	*) PROMPT='%n@%m:%~$ ';;
esac
PROMPT2='%_> '
SPROMPT='zsh: correct '%R' to '%r' [nyae]?'
precmd()
{
	RPROMPT=\[`date '+%F %T'`\]
}
setopt share_history
setopt hist_ignore_dups
setopt hist_save_nodups
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end
# bindkey "" history-beginning-search-backward-end
# bindkey "" history-beginning-search-forward-end

setopt auto_cd
setopt auto_pushd
setopt correct
setopt listpacked
setopt nolistbeep
LISTMAX=0
autoload predict-on
# predict-on
autoload colors
colors
zstyle ':completion:*' list-colors ''
umask 022
setopt no_hup
[ -x /etc/zsh_command_not_found ] && source /etc/zsh_command_not_found
export WORDCHARS=''
setopt complete_aliases
[ "${TERM}" != dumb ] && alias ls='ls --color=auto'
[ "${TERM}" != dumb ] && alias grep='grep --color=auto'
alias l='ls -FGlhp'
alias less='less -R'
alias lv='lv -c'
alias tgif='tgif -geometry 960x1000'
alias xdvi='xdvi -geometry 900x1100-0+0'
alias my_indent='indent -bad -bap -bbb -bbo -bc -br -brs -cdb -cdw -ce -hnl -i4 -l80 -lp -ncs -nfc1 -npcs -nprs -npsl -nsaf -nsai -nsaw -nss -sc -ts4'
alias -s txt=view
alias -s tar.gz='tar xzf'
alias -s tgz='tar xzf'
alias -s tar.bz2='tar xjf'
alias -s tar.xz='tar xJf'
alias     gcc='gcc     -std=c11   -Wall -Wextra -Weffc++ -Wcast-align -Wcast-qual -Wformat -Woverloaded-virtual -Wpointer-arith -Wshadow -Wwrite-strings'
alias     g++='g++     -std=c++11 -Wall -Wextra -Weffc++ -Wcast-align -Wcast-qual -Wformat -Woverloaded-virtual -Wpointer-arith -Wshadow -Wwrite-strings'
alias   clang='clang   -std=c11   -Wall -Wextra -Weffc++ -Wcast-align -Wcast-qual -Wformat -Woverloaded-virtual -Wpointer-arith -Wshadow -Wwrite-strings'
alias clang++='clang++ -std=c++11 -Wall -Wextra -Weffc++ -Wcast-align -Wcast-qual -Wformat -Woverloaded-virtual -Wpointer-arith -Wshadow -Wwrite-strings -stdlib=libc++ -lc++abi'
[ -f ${HOME}/.zshrc.local ] && . ${HOME}/.zshrc.local
