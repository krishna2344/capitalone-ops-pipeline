include_recipe 'firewall'

# open nfs ports in firewall unless running
# in a docker container
unless ::File.exist?('/.dockerinit')
  %w(udp tcp).each do |p|
    firewall_rule "nfs_sunrpc_#{p}" do
      protocol p.to_sym
      port 111
      command :allow
    end
    firewall_rule "nfs_#{p}" do
      protocol p.to_sym
      port 2049
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
