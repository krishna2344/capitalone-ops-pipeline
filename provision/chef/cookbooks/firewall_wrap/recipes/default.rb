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

# open nfs ports in firewall, unless in a docker container
unless ::File.exist?('/.dockerinit')
  node['firewall_wrap']['tcp_ports'].each do |p|
    firewall_rule "firewall_wrap_open_#{p}_tcp" do
      protocol :tcp
      port p
      action :create
      command :allow
    end
  end
  node['firewall_wrap']['udp_ports'].each do |p|
    firewall_rule "firewall_wrap_open_#{p}_udp" do
      protocol :udp
      port p
      action :create
      command :allow
    end
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