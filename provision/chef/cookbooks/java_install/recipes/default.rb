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

if node['java_install']['java7']
  java_ark 'java_install_7' do
    default node['java_install']['default'] == 7

    url node['java']['jdk']['7'][node['java']['arch']]['url']
    checksum node['java']['jdk']['7'][node['java']['arch']]['checksum']
    app_home node['java']['java_home']
    bin_cmds node['java']['jdk']['7']['bin_cmds']
    alternatives_priority node['java']['jdk']['7']['alternatives_priority']
    retries node['java']['ark_retries']
    retry_delay node['java']['ark_retry_delay']
    connect_timeout node['java']['ark_timeout']
    use_alt_suffix node['java']['use_alt_suffix']
    reset_alternatives node['java']['reset_alternatives']
    action :install
  end
end

if node['java_install']['java8']
  java_ark 'java_install_8' do
    default node['java_install']['default'] == 8

    url node['java']['jdk']['8'][node['java']['arch']]['url']
    checksum node['java']['jdk']['8'][node['java']['arch']]['checksum']
    app_home node['java']['java_home']
    bin_cmds node['java']['jdk']['8']['bin_cmds']
    alternatives_priority node['java']['jdk']['8']['alternatives_priority']
    retries node['java']['ark_retries']
    retry_delay node['java']['ark_retry_delay']
    connect_timeout node['java']['ark_timeout']
    use_alt_suffix node['java']['use_alt_suffix']
    reset_alternatives node['java']['reset_alternatives']
    action :install
  end
end