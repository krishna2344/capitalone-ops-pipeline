#!/bin/bash

set -e
set -x

berks vendor provision/chef/vendor-cookbooks
packer build -force -var "version=$version" -var "username=$username" -var "password=$password" -var "email=$email" packer/docker-headless-ubuntu.json
packer build -force -var "version=$version" -var "username=$username" -var "password=$password" -var "email=$email" packer/docker-headless-slim.json
