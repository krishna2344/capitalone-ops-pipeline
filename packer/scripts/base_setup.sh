#!/bin/sh
set -e
set -x

# hope to pick up proxy settings if we can
. /etc/profile

if which apk; then
	apk update
	apk add wget
	apk add curl
	apk add sudo
	apk add bash
	apk add git

elif which yum; then
	sudo yum update -y
	sudo yum update -y kernel
	sudo yum install -y wget curl virt-what net-tools git yum-utils
	if [ ! -f /.dockerinit ]; then
		sudo reboot
	fi
elif which apt-get; then
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get install -y wget curl virt-what git
	sudo apt-get remove -y juju juju-core libgl1-mesa-dri chef linux-firmware
	sudo apt-get -y autoremove
	sudo apt-get clean
	sudo apt-get autoclean
	if [ ! -f /.dockerinit ]; then
		sudo reboot
	fi
fi
