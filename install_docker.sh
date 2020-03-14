#!/bin/sh

install_docker_engine()
{
	which docker > /dev/null && return

	. /etc/os-release
	case ${ID} in
	debian|ubuntu)
		apt-get update || return
		apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common || return

		curl -fsSL https://download.docker.com/linux/${ID}/gpg | apt-key add - || return
		apt-key fingerprint 0EBFCD88 || return

		add-apt-repository "deb [arch=`dpkg --print-architecture`] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" || return
		apt-get update || return
		apt-get install -y docker-ce || return
		;;
	centos)
		yum install -y yum-utils device-mapper-persistent-data lvm2 || return
		yum-config-manager --add-repo https://download.docker.com/linux/${ID}/docker-ce.repo || return
		yum install -y docker-ce || return
		systemctl start docker || return
		;;
	*)
		return 1;;
	esac
	usermod -aG docker ${SUDO_USER:-${USER:-`whoami`}} || return
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

install_docker()
{
	install_docker_engine || return
	install_docker_compose || return
}

install_docker || exit
