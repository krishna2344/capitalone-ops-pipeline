#!/bin/bash

set -e

org=tompscanlan
export 'PACKER_LOG=1'
#./packer/build-iso-to-vm.sh

if test ! -f "${org}-alpine-headless-${version}.tar"; then
  packer build -only alpine-docker -var "org=${org}" -var "version=$version" packer/headless.json
fi
if test ! -f "${org}-ubuntu-headless-${version}.tar"; then
  packer build -only ubuntu-docker -var "org=${org}" -var "version=$version" packer/headless.json
fi
