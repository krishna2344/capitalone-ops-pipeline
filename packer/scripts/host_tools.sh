#!/bin/sh
set -e

# hope to pick up proxy settings if we can
. /etc/profile

cd ~

if hostname | grep -q vmware; then
	if [ -e "/etc/alpine-release" ]; then
		sudo apk add open-vm-tools
	elif which apt-get; then
		sudo apt-get install -y open-vm-tools
	elif which yum; then
		sudo yum install -y open-vm-tools
	fi
elif hostname | grep -q virtualbox; then
	mkdir xxx
	sudo mount -oloop VBoxGuestAdditions*.iso xxx
	cd xxx
	# force a true. this may fail to load X drivers,
	# but those aren't needed
	sudo bash ./VBoxLinuxAdditions.run || true
	cd ..
	sudo umount xxx
	rmdir xxx
fi
