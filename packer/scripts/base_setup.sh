#!/bin/sh
set -e

# hope to pick up proxy settings if we can
. /etc/profile

if which apk; then
	apk update
	apk add wget
	apk add curl
	apk add sudo
	apk add bash

elif which yum; then
	sudo yum update -y
	sudo yum install -y wget curl
elif which apt-get; then
	sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install -y wget curl
fi
