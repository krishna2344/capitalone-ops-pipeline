#!/bin/bash

set -e
set -x

packer build -force -var "version=$version" packer/desktop-stage-2.json
