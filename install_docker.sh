#!/bin/sh

install_docker()
{
	which docker > /dev/null && return

	apt-get update || return
	apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common || return

	curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z)/gpg | apt-key add - || return
	apt-key fingerprint 0EBFCD88 || return

	add-apt-repository "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z) $(lsb_release -cs) stable" || return
	apt-get update || return
	apt-get install -y docker-ce || return

	usermod -aG docker ${SUDO_USER:-${USER:-$(whoami)}} || return
}

install_docker_compose()
{
	which docker-compose > /dev/null && return

	latest_version=`curl -fsSI https://github.com/docker/compose/releases/latest | grep -e '^location:' | grep -oPe '\d+(\.\d+)*'`
	[ -n "${latest_version}" ] || return
	curl -fSL -o /usr/local/bin/docker-compose \
		https://github.com/docker/compose/releases/download/${latest_version}/docker-compose-`uname -s`-`uname -m` || return
	chmod a+x /usr/local/bin/docker-compose || return

	mkdir -pv /etc/bash_completion.d || return
	curl -fSL -o /etc/bash_completion.d/docker-compose \
		https://raw.githubusercontent.com/docker/compose/${latest_version}/contrib/completion/bash/docker-compose || return

	mkdir -pv /usr/share/zsh/vendor-completions || return
	curl -fSL -o /usr/share/zsh/vendor-completions/_docker-compose \
		https://raw.githubusercontent.com/docker/compose/${latest_version}/contrib/completion/zsh/_docker-compose || return
}

setup()
{
	install_docker || return
	install_docker_compose || return
}

setup || exit
