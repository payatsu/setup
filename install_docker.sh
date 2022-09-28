#!/bin/sh

install_docker_engine()
{
	! echo "$@" | grep -e '--force' > /dev/null 2>&1 && which docker > /dev/null && return

	. /etc/os-release
	case ${ID} in
	debian|ubuntu)
		apt-get update || return
		apt-get install -y ca-certificates curl gnupg lsb-release || return

		mkdir -p /etc/apt/keyrings || return
		curl -fsSL https://download.docker.com/linux/${ID}/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg || return
		echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/${ID} ${VERSION_CODENAME} stable" > /etc/apt/sources.list.d/docker.list || return

		apt-get update || return
		apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || return
		;;
	centos)
		yum install -y yum-utils device-mapper-persistent-data lvm2 || return
		yum-config-manager --add-repo https://download.docker.com/linux/${ID}/docker-ce.repo || return
		yum install -y docker-ce || return
		systemctl start docker || return
		systemctl enable docker || return
		systemctl enable containerd || return
		;;
	*)
		return 1;;
	esac
	usermod -aG docker ${SUDO_USER:-${USER:-`whoami`}} || return
}

install_docker_compose()
{
	! echo "$@" | grep -e '--force' > /dev/null 2>&1 && which docker-compose > /dev/null && return

	: ${latest_version:=`curl -fsSI https://github.com/docker/compose/releases/latest | grep -e '^\(L\|l\)ocation:' | grep -oPe '\d+(\.\d+)*'`}
	[ -n "${latest_version}" ] || return
	curl -fSL -o /usr/local/bin/docker-compose \
		https://github.com/docker/compose/releases/download/v${latest_version}/docker-compose-`uname -s`-`uname -m` || return
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
	install_docker_engine "$@" || return
	install_docker_compose "$@" || return
}

install_docker "$@" || exit
