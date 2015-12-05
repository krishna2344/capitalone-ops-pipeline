#!/bin/bash

set -e

berks vendor provision/chef/vendor-cookbooks
if  test ! -f "output-ubuntu-virtualbox/ubuntu-virtualbox-iso.ovf"; then
    packer build -only ubuntu-virtualbox -force -var "version=$version" packer/iso-to-vm.json
else
    echo "skipping ubuntu-virtualbox"
fi
if  test ! -f "output-ubuntu-vmware/ubuntu-vmware-iso.vmx"; then
    packer build -only ubuntu-vmware -force -var "version=$version" packer/iso-to-vm.json
else
    echo "skipping ubuntu-vmware"
fi
if  test ! -f "output-centos-virtualbox/centos-virtualbox-iso.ovf"; then
    packer build -only centos-virtualbox -force -var "version=$version" packer/iso-to-vm.json
else
    echo "skipping centos-virtualbox"
fi
if  test ! -f "output-centos-vmware/centos-vmware-iso.vmx"; then
    packer build -only centos-vmware -force -var "version=$version" packer/iso-to-vm.json
else
    echo "skipping centos-vmware"
fi
