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
Encoding.default_external = "UTF-8"
source 'https://supermarket.chef.io'

cookbook '7-zip',              '~> 1.0.2'
cookbook 'apt',                '~> 2.9.2'
cookbook 'ark',                '~> 0.4.0'
cookbook 'chef-dk',            '~> 3.1.0'
cookbook 'dmg',                '~> 2.2.2'
cookbook 'gem_installer',      '~> 0.1.2'
cookbook 'gradle',             '~> 1.5.1'
cookbook 'jenkins',            '~> 2.3.1'
cookbook 'maven',              '~> 1.2.0'
cookbook 'nodejs',             '~> 2.4.4'
cookbook 'packagecloud',       '~> 0.0.19'
cookbook 'packages',           '~> 0.4.0'
cookbook 'packer',             '~> 0.3.0'
cookbook 'runit',              '~> 1.7.2'
cookbook 'sonarqube',          '~> 0.3.2'
cookbook 'timezone_lwrp',      '~> 0.1.7'
cookbook 'user',               '~> 0.4.2'
cookbook 'udev',               '~> 0.2.0'
cookbook 'vagrant',            '~> 0.3.1'
cookbook 'virtualbox',         '~> 1.0.3'
cookbook 'vmware_workstation', '~> 0.2.0'

cookbook 'chef_solo_proxy', git: 'https://github.com/tompscanlan/chef-solo-proxy.git'

cookbook 'configure_desktop', path: 'provision/chef/cookbooks/configure_desktop'
cookbook 'configure_headless', path: 'provision/chef/cookbooks/configure_headless'
cookbook 'docker_install', path: 'provision/chef/cookbooks/docker_install'
cookbook 'firewall_wrap', path: 'provision/chef/cookbooks/firewall_wrap'
cookbook 'flamegraph', path: 'provision/chef/cookbooks/flamegraph'
cookbook 'install_chrome', path: 'provision/chef/cookbooks/install_chrome'
cookbook 'java_install', path: 'provision/chef/cookbooks/java_install'
cookbook 'jenkins-job', path: 'provision/chef/cookbooks/jenkins-job'
cookbook 'mysql_wrap', path: 'provision/chef/cookbooks/mysql_wrap'
cookbook 'nfs_wrap', path: 'provision/chef/cookbooks/nfs_wrap'
cookbook 'packer-boss-jenkins', path: 'provision/chef/cookbooks/packer-boss-jenkins'
cookbook 'spring_tool_suite', path: 'provision/chef/cookbooks/spring_tool_suite'
cookbook 'xubuntu-desktop-pkg', path: 'provision/chef/cookbooks/xubuntu-desktop-pkg'