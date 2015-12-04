#!/bin/bash

set -e
set -x

berks vendor provision/chef/vendor-cookbooks
if  test ! -f "base-virtualbox/packer-virtualbox-iso.ovf" || test ! -f "base-vmware/packer-vmware-iso.vmx"; then
    packer build -force -var "version=$version" packer/headless-stage-1.json
fi
