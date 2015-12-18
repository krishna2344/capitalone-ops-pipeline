#!/bin/bash

set -e


# hope to pick up proxy settings if we can
. /etc/profile

# Updating and Upgrading dependencies
sudo apt-get update -y -qq > /dev/null
sudo apt-get upgrade -y -qq > /dev/null

# Install necessary dependencies
sudo apt-get -y -q install curl wget git vim
