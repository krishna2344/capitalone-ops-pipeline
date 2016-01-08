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
