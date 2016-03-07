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

include_recipe 'packer-boss-jenkins'

# add jenkins to the docker group, if we can
group 'add-jenkins-to-docker' do
  action :modify
  append true
  group_name 'docker'
  members node['jenkins']['master']['user']
  notifies :restart, 'service[jenkins]', :immediately
end

directory node['jenkins-job']['job-dir'] do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  recursive true
end

node.run_state[:jenkins_private_key] = node['jenkins-master']['admin_private_key']

# copy over files directly
node['jenkins-job']['job-files'].to_a.each do |project, source_file|
  xml_filename = "#{node['jenkins-job']['job-dir']}/#{project}"

  cookbook_file xml_filename do
    source source_file
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0755'
    action :create
  end

  jenkins_job project do
    config xml_filename
    action :create
    retries 5
    retry_delay 15
  end
end

# fill out and send over templates
node['jenkins-job']['job-templates'].to_a.each do |project, source_file|
  xml_filename = "#{node['jenkins-job']['job-dir']}/#{project}"

  template xml_filename do
    source source_file
    owner node['jenkins']['master']['user']
    group node['jenkins']['master']['group']
    mode '0755'
    action :create
  end

  jenkins_job project do
    config xml_filename
    action :create
    retries 5
    retry_delay 15
  end
end