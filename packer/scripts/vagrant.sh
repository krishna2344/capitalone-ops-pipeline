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
set -e

# hope to pick up proxy settings if we can
. /etc/profile

# Installing vagrant keys
# assumed vagrant user has already been setup.
# for centos and ubuntu this happens in the kickstart/preeseed

if id -u vagrant; then
	mkdir -p ~vagrant/.ssh
	chmod 700 ~vagrant/.ssh
	wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O ~vagrant/.ssh/authorized_keys
	chmod 600 ~vagrant/.ssh/authorized_keys
	chown -R vagrant ~vagrant/.ssh
fi

if [ -e "/etc/alpine-release" ]; then
	sudo adduser -D -s /bin/sh vagrant
	sudo addgroup admin
	sudo addgroup vagrant admin
else
	getent group admin || sudo groupadd -r admin
	getent passwd vagrant || sudo useradd -m vagrant
	sudo usermod -a -G admin vagrant
	sudo cp /etc/sudoers /etc/sudoers.orig
	sudo sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=admin' /etc/sudoers
	sudo sed -i -e 's/%admin ALL=(ALL) ALL/%admin ALL=NOPASSWD:ALL/g' /etc/sudoers
fi