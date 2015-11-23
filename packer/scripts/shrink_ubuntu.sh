#!/bin/bash

# hope to pick up proxy settings if we can
. /etc/profile

set -x

# wipe documents
sudo rm -rf /usr/share/doc/
sudo rm -rf /usr/share/man/
sudo rm -rf /usr/share/locale/

sudo apt-get remove -y juju juju-core libgl1-mesa-dri
sudo apt-get -y autoremove
sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/cache/oracle-jdk[78]-installer
sudo rm -rf /usr/lib/jvm/jdk1.7.0_75_alt /usr/lib/jvm/java-7-oracle-amd64_alt

sudo dd if=/dev/zero of=/free-space bs=1M
sudo rm -f /free-space

#sudo su -c "cat /dev/null > ~/.bash_history && history -c" - vagrant
#sudo cat /dev/null > ~/.bash_history && history -c
