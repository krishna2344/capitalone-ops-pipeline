#!/bin/bash

set -e


# hope to pick up proxy settings if we can
. /etc/profile

sudo yum -y update
sudo yum -y install curl wget git vim openssh-server ca-certificates

sudo yum -y install gcc make gcc-c++ kernel-devel-`uname -r` dkms nfs-utils patch


# Installing vagrant keys
mkdir -p ~/.ssh
chmod 700 ~/.ssh
cd ~/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chmod 600 ~/.ssh/authorized_keys
chown -R vagrant ~/.ssh


cd ~
# install vmware tools
if hostname | grep -q vmware; then
	git clone https://github.com/rasa/vmware-tools-patches.git
	cd vmware-tools-patches
	sudo ./patched-open-vm-tools.sh
fi

# install virtualbox tools
if hostname | grep -q virtualbox; then
	mkdir xxx
	mount -oloop VBoxGuestAdditions*.iso xxx
	cd xxx
	# force a true. this mayu fail to load X drivers, but aren't needed
	bash ./VBoxLinuxAdditions.run || true
	cd ..
	umount xxx
	rmdir xxx
fi
