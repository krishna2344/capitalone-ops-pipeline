#!/bin/bash

set -e

org=tompscanlan
export 'PACKER_LOG=1'

packer build -only ubuntu-ami -var "org=${org}" -var "version=$version" packer/headless.json
packer build -only centos-ami -var "org=${org}" -var "version=$version" packer/headless.json
