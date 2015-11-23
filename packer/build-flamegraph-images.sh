#!/bin/bash

set -e

org=tompscanlan
role=flamegraph
export 'PACKER_LOG=1'


if test ! -f "${org}-alpine-${role}-${version}.tar"; then
  packer build -only alpine-docker -var "org=${org}" -var "version=$version" ./packer/${role}.json
fi
if test ! -f "${org}-ubuntu-${role}-${version}.tar"; then
  packer build -only ubuntu-docker -var "org=${org}" -var "version=$version" packer/${role}.json
fi
if  test ! -f "${org}-${role}-ubuntu-virtualbox-${version}.box"; then
  packer build -force -only ubuntu-virtualbox -var "org=${org}" -var "version=$version" packer/${role}.json
fi
if  test ! -f "${org}-${role}-ubuntu-vmware-${version}.box"; then
  packer build -force -only ubuntu-vmware -var "org=${org}" -var "version=$version" packer/${role}.json
fi
if  test ! -f "${org}-${role}-centos-vmware-${version}.box"; then
  packer build -force -only centos-vmware -var "org=${org}" -var "version=$version" packer/${role}.json
fi
if  test ! -f "${org}-${role}-ubuntu-virtualbox-${version}.box"; then
  packer build -force -only ubuntu-virtualbox -var "org=${org}" -var "version=$version" packer/${role}.json
fi
if  test ! -f "${org}-${role}-centos-virtualbox-${version}.box"; then
  packer build -force -only centos-virtualbox -var "org=${org}" -var "version=$version" packer/${role}.json
fi
