#!/bin/bash

set -e

org=tompscanlan
export 'PACKER_LOG=0'
#./packer/build-iso-to-vm.sh
build_only=

if test ! -f "${org}-alpine-headless-${version}.tar"; then
  build_only="alpine-docker"
fi
if test ! -f "${org}-ubuntu-headless-${version}.tar"; then
  build_only="$build_only,ubuntu-docker"
fi
if  test ! -f "${org}-headless-ubuntu-virtualbox-${version}.box"; then
  build_only="$build_only,ubuntu-virtualbox"
fi
if  test ! -f "${org}-headless-ubuntu-vmware-${version}.box"; then
  build_only="$build_only,ubuntu-vmware"
fi
if  test ! -f "${org}-headless-centos-vmware-${version}.box"; then
  build_only="$build_only,centos-vmware"
fi
if  test ! -f "${org}-headless-centos-virtualbox-${version}.box"; then
  build_only="$build_only,centos-virtualbox"
fi

if  [ -n "$build_only" ]; then
	packer build -force -only $build_only -var "org=${org}" -var "version=$version" packer/headless.json
fi
