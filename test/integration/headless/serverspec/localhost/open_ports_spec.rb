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
require 'spec_helper'

tcp_ports = %w(22 2049 111)
udp_ports = %w(2049 111)

set :path, '/sbin:/usr/local/sbin:$PATH'
describe command('whoami') do
  its(:stdout) { should match(/root/) }
end

describe command('iptables -S') do

  if ::File.exist?('/.dockerinit')
    context "in docker" do
      its(:stdout) { should_not match(/tcp.*dport.* #{port}.*ACCEPT/) }
    end
  else
    context "not in docker" do
      tcp_ports.each do |port|
        its(:stdout) { should match(/tcp.*dport.* #{port}.*ACCEPT/) }
      end
      udp_ports.each do |port|
        its(:stdout) { should match(/udp.*dport.* #{port}.*ACCEPT/) }
      end

      describe iptables do
        it { should have_rule('INPUT') }
      end
    end
  end
end