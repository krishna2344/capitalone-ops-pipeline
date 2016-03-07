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
if node['mysql_wrap']['create']
  mysql_service 'mysqld' do
    port node['mysql_wrap']['port']
    version node['mysql_wrap']['version']
    initial_root_password node['mysql_wrap']['admin_password']
    action :create
  end
end

if node['mysql_wrap']['start']
  mysql_service 'mysqld' do
    action :start
  end
end

# open mysql port in firewall
# but not in docker containers
unless ::File.exist?('/.dockerinit')
  include_recipe 'firewall'

  firewall_rule 'mysql_tcp' do
    protocol :tcp
    port 3306
    command :allow
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