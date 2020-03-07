#!/bin/sh

which docker docker-compose > /dev/null && exit

apt-get update || exit
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common || exit

curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z)/gpg | apt-key add - || exit
apt-key fingerprint 0EBFCD88 || exit

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z) $(lsb_release -cs) stable" || exit
apt-get update || exit
apt-get install -y docker-ce || exit

usermod -aG docker ${SUDO_USER:-${USER:-`whoami`}} || exit

curl -fsSL -o /usr/local/bin/docker-compose https://github.com$(curl -fsSL https://github.com/docker/compose/releases/latest | grep -oPe '(?<=").+docker-compose-'$(uname -s)-$(uname -m)'(?=")') || exit
chmod a+x /usr/local/bin/docker-compose || exit
