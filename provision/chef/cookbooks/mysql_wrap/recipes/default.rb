if node['mysql_wrap']['create']
  mysql_service 'mysqld' do
    port node['mysql_wrap']['port']
    version node['mysql_wrap']['version']
    initial_root_password node['mysql_wrap']['admin_password']
    action :create
  end
end

if node['mysql_wrap']['start']
  mysql_service 'mysqld' do
    action :start
  end
end

# open mysql port in firewall
# but not in docker containers
unless ::File.exist?('/.dockerinit')
  include_recipe 'firewall'

  firewall_rule 'mysql_tcp' do
    protocol :tcp
    port 3306
    command :allow
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
