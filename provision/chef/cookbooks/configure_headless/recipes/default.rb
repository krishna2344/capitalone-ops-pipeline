template '/etc/profile.d/bash_alias_iz.sh' do
  action [:create]
  source 'bash_aliases.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

directory '/home/vagrant/.m2' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  recursive true
end

template '/home/vagrant/.m2/settings.xml' do
  action [:create]
  source 'settings.xml.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

group 'docker' do
  action :create
  append true
  members 'vagrant'
  notifies :restart, 'service[docker]'
end

group 'vboxsf' do
  action :create
  append true
  members 'vagrant'
  notifies :restart, 'service[docker]'
end

service 'docker' do
  action :nothing
end
