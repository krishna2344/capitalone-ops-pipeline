#!/bin/sh
#
# Ops-Pipeline - Templates for automating the production and consumption of images
# and containers.
#
# Copyright 2016 Capital One Services, LLC.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# hope to pick up proxy settings if we can
. /etc/profile

# install python
if which apk; then
	# handle alpine
	apk add alpine-sdk
	apk add py-pip
	apk add python-dev

elif which yum; then
	# handle yum based
	sudo yum install -y wget python python-devel
elif which apt-get; then
	# handle ubuntu based
	sudo apt-get install -y wget build-essential python python-dev
fi

# install easy_install on the way to ansible
wget https://bootstrap.pypa.io/ez_setup.py -O - | sudo python
sudo easy_install pip
sudo pip install ansible