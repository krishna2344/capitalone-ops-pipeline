#!/bin/sh

set -x

# hope to pick up proxy settings if we can
. /etc/profile

apk update
apk add curl
apk add sudo

apk add alpine-sdk
apk add py-pip
apk add python-dev

pip install ansible

adduser -D -s /bin/sh vagrant
addgroup admin
addgroup vagrant admin

#sudo cp /etc/sudoers /etc/sudoers.orig
#echo "%admin ALL=NOPASSWD:ALL" /etc/sudoers.d/admin_nopass

# Installing vagrant keys
mkdir ~vagrant/.ssh
chmod 700 ~vagrant/.ssh
cd ~vagrant/.ssh
curl -k -o ~vagrant/.ssh/authorized_keys 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
chmod 600 ~vagrant/.ssh/authorized_keys
chown -R vagrant ~vagrant/.ssh
