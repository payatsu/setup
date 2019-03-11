#!/bin/sh

apt update || exit
apt install -y apt-transport-https ca-certificates curl software-properties-common || exit

curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z)/gpg | apt-key add - || exit
apt-key fingerprint 0EBFCD88 || exit

add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z) $(lsb_release -cs) stable" || exit
apt update || exit
apt install -y docker-ce docker-compose || exit

usermod -aG docker ${SUDO_USER:-${USER:-`whoami`}} || exit
