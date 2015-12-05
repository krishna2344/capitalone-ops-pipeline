#!/bin/bash

set -e

org=tompscanlan
#./packer/build-iso-to-vm.sh

#packer build -force -var "version=$version" packer/headless-stage-2.json

#packer build -only ubuntu-virtualbox -var "version=$version" packer/headless.json


if test ! -f "${org}-alpine-headless-${version}.tar"; then
  packer build -only alpine-docker -var "org=${org}" -var "version=$version" packer/headless.json
fi
if test ! -f "${org}-ubuntu-headless-${version}.tar"; then
  packer build -only ubuntu-docker -var "org=${org}" -var "version=$version" packer/headless.json
fi

if  test ! -f "${org}-headless-ubuntu-virtualbox-${version}.box"; then
  packer build -force -only ubuntu-virtualbox -var "org=${org}" -var "version=$version" packer/headless.json
fi
