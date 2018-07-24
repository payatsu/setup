#!/bin/sh

sudo apt update
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z)/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/$(lsb_release -is | tr A-Z a-z) $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

sudo usermod -aG docker ${USER}
