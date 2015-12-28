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
	sudo yum install -y wget curl virt-what net-tools git
	sudo reboot
elif which apt-get; then
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt-get install -y wget curl virt-what git
fi
