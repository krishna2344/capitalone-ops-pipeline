#!/bin/sh

# hope to pick up proxy settings if we can
. /etc/profile

# install python
if which apk; then
	# handle alpine
	apk add alpine-sdk
	apk add py-pip
	apk add python-dev

elif which yum; then
	# handle yum based
	sudo yum install -y wget python python-devel
elif which apt-get; then
	# handle ubuntu based
	sudo apt-get install -y wget build-essential python python-dev
fi

# install easy_install on the way to ansible
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo easy_install pip
sudo pip install ansible
