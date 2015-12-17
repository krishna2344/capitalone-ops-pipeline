#!/bin/sh

# Remove traces of mac address from network configuration
if [ -e "/etc/sysconfig/network-scripts/ifcfg-eth0" ]; then
	sudo sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
fi
if [ -e "/etc/udev/rules.d/70-persistent-net.rules" ]; then
	sudo rm -f /etc/udev/rules.d/70-persistent-net.rules
fi