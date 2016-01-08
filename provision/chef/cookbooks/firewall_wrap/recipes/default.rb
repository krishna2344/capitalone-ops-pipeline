include_recipe 'firewall'

# open nfs ports in firewall, unless in a docker container
unless ::File.exist?('/.dockerinit')
  node['firewall_wrap']['tcp_ports'].each do |p|
    firewall_rule "firewall_wrap_open_#{p}_tcp" do
      protocol :tcp
      port p
      action :create
      command :allow
    end
  end
  node['firewall_wrap']['udp_ports'].each do |p|
    firewall_rule "firewall_wrap_open_#{p}_udp" do
      protocol :udp
      port p
      action :create
      command :allow
    end
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
