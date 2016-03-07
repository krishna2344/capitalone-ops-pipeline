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

sudo yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
sudo yum -y clean all
sudo rm -rf /etc/yum.repos.d/{puppetlabs,epel}.repo
sudo rm -rf VBoxGuestAdditions_*.iso

# Remove traces of mac address from network configuration
sudo sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
sudo rm /etc/udev/rules.d/70-persistent-net.rules