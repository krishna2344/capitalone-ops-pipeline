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
case node[:platform]
when 'redhat', 'centos'
  default['flamegraph']['packages'] = ['perf']
when 'ubuntu', 'debian'
  default['flamegraph']['packages'] = ['linux-tools-common']
end

default['flamegraph']['root'] = '/opt/flamegraph'
default['flamegraph']['git_revision'] = 'master'
default['flamegraph']['git_repository'] = 'https://github.com/brendangregg/FlameGraph'

default['flamegraph']['profile_dest'] = '/etc/profile.d/flamegraph.sh'
default['flamegraph']['profile_src'] = 'flamegraph.sh.erb'