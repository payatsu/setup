#!/bin/sh

sudo apt update || exit
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common || exit

curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z)/gpg | sudo apt-key add - || exit
sudo apt-key fingerprint 0EBFCD88 || exit

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z) $(lsb_release -cs) stable" || exit
sudo apt update || exit
sudo apt install -y docker-ce || exit

sudo usermod -aG docker ${SUDO_USER:-${USER}} || exit
