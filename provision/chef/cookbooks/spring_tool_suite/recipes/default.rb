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

directory node['spring_tool_suite']['sts_homedir'] do
  owner 'root'
  group 'vagrant'
  mode '0775'
  action :create
  recursive true
end

tar_extract node['spring_tool_suite']['sts_download'] do
  target_dir node['spring_tool_suite']['sts_homedir']
  creates "#{node['spring_tool_suite']['sts_homedir']}/plugins"
  tar_flags ['-P', '--strip-components 2']
end

node['spring_tool_suite']['plugin_list'].each do |plugin_name|
  puts "Install_#{plugin_name}_Plugin"
  execute "Install_#{plugin_name}_Plugin" do
    cwd node['spring_tool_suite']['sts_homedir']
    command './STS -application org.eclipse.equinox.p2.director -repository ' <<
      node['spring_tool_suite'][plugin_name]['site'] <<
      ' -installIUs ' <<
      node['spring_tool_suite'][plugin_name]['ius'] <<
      ' -noSplash'
    not_if { File.exist?(node['spring_tool_suite'][plugin_name]['creates']) }
  end
end

execute 'set vagrant group on STS' do
  cwd node['spring_tool_suite']['sts_homedir']
  command "chown -R root:vagrant #{node['spring_tool_suite']['sts_homedir']}"
end

execute 'allow vagrant writes on STS' do
  cwd node['spring_tool_suite']['sts_homedir']
  command "chmod -R g+w #{node['spring_tool_suite']['sts_homedir']}"
end