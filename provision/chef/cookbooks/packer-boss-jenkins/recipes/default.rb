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
include_recipe 'jenkins::master'

jenkins_user node['jenkins-master']['admin_username'] do
  password node['jenkins-master']['admin_password']
  full_name 'Jenkins admin user'
  email node['jenkins-master']['admin_email']
  public_keys [node['jenkins-master']['admin_public_key']]
end

node.run_state['jenkins_private_key'] =
  node['jenkins-master']['admin_private_key']

jenkins_script 'configure email' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
    jenkinsLocationConfiguration.setAdminAddress("node['jenkins-master']['admin_email']")
    jenkinsLocationConfiguration.save()
  EOH

  action :nothing
end

node['jenkins-master']['users'].to_a.each do |user, hash|
  jenkins_user user do
    full_name hash['full_name']
    email hash['email']
    password hash['password']
    public_keys hash['public_keys']
  end
end

node.run_state['jenkins_private_key'] =
  node['jenkins-master']['admin_private_key']

node['jenkins-master']['credentials'].to_a.each do |user, hash|
  if hash['password']
    jenkins_password_credentials user.dup do
      action :create
      id hash['id']
      description hash['description']
      password hash['password']
    end
  end

  if hash['private_key']
    jenkins_private_key_credentials user.dup do
      action :create
      id hash['id']
      description hash['description']
      private_key hash['private_key']
    end
  end
end

node['jenkins-master']['plugins'].to_a.each do |plugin|
  plugin, version = plugin.split('=')
  jenkins_plugin plugin do
    version version if version
    notifies :restart, 'service[jenkins]'
  end
end