
cd ~
# install vmware tools
if hostname | grep -q vmware; then
	git clone https://github.com/rasa/vmware-tools-patches.git
	cd vmware-tools-patches
	apt-get install -y build-essential dkms gcc git linux-headers-$(uname -r) make patch perl psmisc unzip wget zip

	./download-tools.sh 7.1.2
	./untar-and-patch.sh
	./compile.sh
fi

cd ~
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
