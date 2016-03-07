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
include_recipe 'apt'

node['configure_headless']['packages'].each do |name|
  package name
end

template '/etc/profile.d/bash_alias_iz.sh' do
  action [:create]
  source 'bash_aliases.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/home/vagrant/.m2' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  recursive true
end

template '/home/vagrant/.m2/settings.xml' do
  action [:create]
  source 'settings.xml.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

# prevent restart under centos
case node[:platform]
when 'ubuntu', 'debian'
  group 'docker' do
    action :create
    append true
    members 'vagrant'
    notifies :restart, 'service[docker]'
  end

  group 'vboxsf' do
    action :create
    append true
    members 'vagrant'
    notifies :restart, 'service[docker]'
  end

  service 'docker' do
    action :nothing
  end
end