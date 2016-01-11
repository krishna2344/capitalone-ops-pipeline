#!/bin/sh
set -e

# hope to pick up proxy settings if we can
. /etc/profile

cd ~

#if [ -f /.dockerinit ]; then
#	# no host tools needed for docker
#	exit 0

if which apk; then
	sudo apk del python-dev fakeroot pax-utils libattr attr tar abuild binutils-libs binutils libgomp pkgconf pkgconfig libgcc gmp mpfr3 mpc1 libstdc++ gcc make patch musl-dbg libc6-compat musl-dev libc-dev fortify-headers g++ build-base expat pcre git squashfs-tools file bzip2 libbz2 libcap cdrkit acct lddtree mkinitfs mtools alpine-sdk libffi gdbm ncurses-libs readline sqlite-libs py-pip

elif which apt-get; then
	# wipe documents
	sudo rm -rf /usr/share/doc/
	sudo rm -rf /usr/share/man/
	sudo rm -rf /usr/share/locale/

	sudo rm -rf /tmp/*
	sudo rm -rf /var/cache/oracle-jdk[78]-installer
	sudo rm -rf /usr/lib/jvm/jdk1.7.0_75_alt /usr/lib/jvm/java-7-oracle-amd64_alt
	sudo rm -rf ~vagrant/linux.iso

elif which yum; then
	# Remove traces of mac address from network configuration
	if [ -e "/etc/sysconfig/network-scripts/ifcfg-eth0" ]; then
		sudo sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
	fi
	if [ -e "/etc/udev/rules.d/70-persistent-net.rules" ]; then
		sudo rm -f /etc/udev/rules.d/70-persistent-net.rules
	fi

	# remove other kernels
	sudo package-cleanup --oldkernels --count=1 -y

	sudo yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts linux-firmware centos-logos chef kernel-devel
	sudo yum -y clean all
	sudo rm -rf /usr/lib/jvm/jdk1.8.0_65_alt
fi

sudo dd if=/dev/zero of=/free-space bs=1M || true
sudo rm -f /free-space
