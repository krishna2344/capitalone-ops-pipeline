#!/bin/bash
#
# Ops-Pipeline - Templates for automating the production and consumption of images
# and containers.
#
# Copyright 2016 Capital One Services, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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