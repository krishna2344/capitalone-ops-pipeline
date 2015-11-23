#!/bin/bash

set -e
set -x

berks vendor provision/chef/vendor-cookbooks
packer build -force -var "version=$version" packer/docker-headless-ubuntu.json
packer build -force -var "version=$version" packer/docker-headless-slim.json
