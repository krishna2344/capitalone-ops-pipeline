#!/bin/bash

set -e

build_only=

berks vendor provision/chef/vendor-cookbooks
if  test ! -f "output-ubuntu-virtualbox/ubuntu-virtualbox-iso.ovf"; then
	build_only="$build_only,ubuntu-virtualbox"
else
    echo "skipping ubuntu-virtualbox"
fi
if  test ! -f "output-ubuntu-vmware/ubuntu-vmware-iso.vmx"; then
	build_only="$build_only,ubuntu-vmware"
else
    echo "skipping ubuntu-vmware"
fi
if  test ! -f "output-centos-virtualbox/centos-virtualbox-iso.ovf"; then
	build_only="$build_only,centos-virtualbox"
else
    echo "skipping centos-virtualbox"
fi
if  test ! -f "output-centos-vmware/centos-vmware-iso.vmx"; then
	build_only="$build_only,centos-vmware"
else
    echo "skipping centos-vmware"
fi

packer build -only $build_only -force -var "version=$version" packer/iso-to-vm.json
