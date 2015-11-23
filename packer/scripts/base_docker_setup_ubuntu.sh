#!/bin/bash
set -x

# Setup sudo to allow no-password sudo for "admin"
#sudo useradd -m vagrant
#sudo groupadd -r admin
#sudo usermod -a -G admin vagrant
#sudo cp /etc/sudoers /etc/sudoers.orig
#sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
#sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Updating and Upgrading dependencies
sudo apt-get update -y
#sudo apt-get upgrade -y -qq > /dev/null

# Install necessary libraries for guest additions and Vagrant NFS Share
sudo apt-get -y install linux-headers-$(uname -r) build-essential dkms nfs-common

# Install necessary dependencies
sudo apt-get -y install curl wget git vim


# Installing vagrant keys
#mkdir ~vagrant/.ssh
#chmod 700 ~vagrant/.ssh
#cd ~vagrant/.ssh
#wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
#chmod 600 ~vagrant/.ssh/authorized_keys
#chown -R vagrant ~vagrant/.ssh


