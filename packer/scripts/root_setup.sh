#!/bin/bash

set -e

# Updating and Upgrading dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null

# Install necessary libraries for guest additions and Vagrant NFS Share
sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms nfs-common

# Install necessary dependencies
sudo apt-get -y -q install curl wget git vim


# Installing vagrant keys
mkdir ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 ~/.ssh/authorized_keys
chown -R vagrant ~/.ssh


# Setup sudo to allow no-password sudo for "admin"
sudo groupadd -r admin
sudo usermod -a -G admin vagrant
sudo cp /etc/sudoers /etc/sudoers.orig
sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

cd ~
# install vmware tools
if hostname | grep -q vmware; then
	git clone https://github.com/rasa/vmware-tools-patches.git
	cd vmware-tools-patches
	sudo apt-get install -y build-essential dkms gcc git linux-headers-$(uname -r) make patch perl psmisc unzip wget zip

	sudo ./download-tools.sh 7.1.2
	sudo ./untar-and-patch.sh
	sudo ./compile.sh
fi

cd ~
# install virtualbox tools
if hostname | grep -q virtualbox; then
	mkdir xxx
	sudo mount -oloop VBoxGuestAdditions*.iso xxx
	cd xxx
	# force a true. this mayu fail to load X drivers, but aren't needed
	sudo bash ./VBoxLinuxAdditions.run || true
fi
