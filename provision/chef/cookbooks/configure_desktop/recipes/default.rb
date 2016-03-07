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

node['configure_desktop']['application_dirs'].each do |dir|
  directory dir do
    owner 'root'
    group 'vagrant'
    mode '0775'
    action :create
  end

  template "#{dir}/STS.desktop" do
    action [:create]
    source 'STS.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end

  template "#{dir}/firefox.desktop" do
    action [:create]
    source 'firefox.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end

  template "#{dir}/google-chrome.desktop" do
    action [:create]
    source 'google-chrome.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end
end

directory '~vagrant/.mozilla' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  recursive true
end

template '/usr/lib/firefox/browser/defaults/preferences/syspref.js' do
  action [:create]
  source 'prefs.js.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables(
    project_homepage: node[:configure_desktop][:project_homepage]
  )
end