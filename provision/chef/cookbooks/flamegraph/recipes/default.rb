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
include_recipe 'firewall'
include_recipe 'nodejs'
include_recipe 'apache2'

node['flamegraph']['packages'].each do |p|
  package p
end

git 'flamegraph_repo' do
  destination node['flamegraph']['root']
  repository node['flamegraph']['git_repository']
  revision node['flamegraph']['git_revision']
  action :sync
end

template node['flamegraph']['profile_dest'] do
  source node['flamegraph']['profile_src']
  mode '0755'
  action :create
end

web_app 'flamegraph' do
  server_name node['hostname']
  directory_index ['index.html', 'index.php']
  directory_options ['+Indexes']
  allow_override 'all'
  docroot node['flamegraph']['root']
  cookbook 'apache2'
end

# don't do firewall stuff in docker
unless ::File.exist?('/.dockerinit')

  # open standard http port to tcp traffic only; insert as first rule
  firewall_rule 'http' do
    port 80
    protocol :tcp
    command :allow
    action :create
  end

  firewall_rule 'node.js' do
    port 3000
    protocol :tcp
    command :allow
    action :create
  end

  # when using firewalld, you must specify saving the rules.
  if (node['os'] == 'rhel' || node['os'] == 'fedora') &&
     node['platform_version'].to_f >= 7.0 &&
     !node['firewall']['redhat7_iptables']
    firewall do
      action :save
    end
  end
end

nodejs_npm 'flamegraph-gui' do
  url 'github tompscanlan/flamegraph-gui'
  version 'latest'
end

nodejs_npm 'pm2'

execute 'start flamegraph-gui' do
  command 'pm2 start /usr/lib/node_modules/flamegraph-gui'
  not_if 'pm2 show flamegraph-gui'
end