#!/bin/sh

set -e

apk update
apk add curl
apk add sudo



# Setup sudo to allow no-password sudo for "admin"
addgroup admin
adduser -D -G admin vagrant
sudo cp /etc/sudoers /etc/sudoers.orig
sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers

# Installing vagrant keys
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
curl -k -o ~vagrant/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh
