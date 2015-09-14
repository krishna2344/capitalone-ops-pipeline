#!/bin/bash

set -e
set -x

cd "${BASH_SOURCE%/*}/.." || exit
./packer/build-headless-boxes.sh
./packer/build-desktop-boxes.sh
./packer/build-docker-headless-images.sh
