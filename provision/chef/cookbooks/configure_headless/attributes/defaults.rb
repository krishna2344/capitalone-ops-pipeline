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
default['configure_headless']['packages'] =
  %w(bash ksh git subversion unzip libtool dos2unix)

case node[:platform]
when 'redhat', 'centos'
  default['configure_headless']['packages'] <<
    %w()
when 'ubuntu', 'debian'
  default['configure_headless']['packages'] <<
    %w(python-software-properties autotools-dev libltdl-dev)
end