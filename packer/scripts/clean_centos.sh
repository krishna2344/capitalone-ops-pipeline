
# hope to pick up proxy settings if we can
. /etc/profile

sudo yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
sudo yum -y clean all
sudo rm -rf /etc/yum.repos.d/{puppetlabs,epel}.repo
sudo rm -rf VBoxGuestAdditions_*.iso

# Remove traces of mac address from network configuration
sudo sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
sudo rm /etc/udev/rules.d/70-persistent-net.rules