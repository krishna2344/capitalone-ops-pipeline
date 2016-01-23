#!/bin/sh
set -e

# hope to pick up proxy settings if we can
. /etc/profile

cd ~

if [ -f /.dockerinit ]; then
	# no host tools needed for docker
	exit 0

elif sudo virt-what | grep -q vmware; then
	if which apt-get; then
		sudo apt-get install -y git
		git clone https://github.com/rasa/vmware-tools-patches.git
		cd vmware-tools-patches
		sudo ./patched-open-vm-tools.sh
		cd ..
		sudo rm -rf vmware-tools-patches
	elif which yum; then
		sudo yum install -y git patch unzip fuse
		git clone https://github.com/rasa/vmware-tools-patches.git
		cd vmware-tools-patches
		sudo ./patched-open-vm-tools.sh
		cd ..
		sudo rm -rf vmware-tools-patches
	fi
elif sudo virt-what | grep -q virtualbox; then
	if which apt-get; then
		sudo apt-get install -y build-essential linux-headers-$(uname -r)
	elif which yum; then
		sudo yum install -y gcc kernel-devel-$(uname -r) fuse
	fi

	mkdir xxx
	sudo mount -oloop VBoxGuestAdditions*.iso xxx
	cd xxx
	# force a true. this may fail to load X drivers,
	# but those aren't needed
	sudo bash ./VBoxLinuxAdditions.run || true
	cd ..
	sudo umount xxx
	rmdir xxx
	sudo rm -f VBoxGuestAdditions*.iso
fi
