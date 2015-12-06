
node['flamegraph']['packages'].each do |p|
  package p
end

git 'flamegraph_repo' do
  destination node['flamegraph']['root']
  repository node['flamegraph']['git_repository']
  revision node['flamegraph']['git_revision']
  action :sync
end

template node['flamegraph']['profile_dest'] do
  source node['flamegraph']['profile_src']
  mode '0755'
  action :create
end

web_app 'flamegraph' do
  server_name node['hostname']
  directory_index ['index.html', 'index.php']
  directory_options ['+Indexes']
  allow_override 'all'
  docroot node['flamegraph']['root']
  cookbook 'apache2'
end

firewall 'default'

# open standard http port to tcp traffic only; insert as first rule
firewall_rule 'http' do
  port 80
  protocol :tcp
  action :allow
end

firewall_rule 'node.js' do
  port 3000
  protocol :tcp
  action :allow
end

nodejs_npm 'flamegraph-gui' do
  url 'github tompscanlan/flamegraph-gui'
  version 'latest'
end

nodejs_npm 'pm2'

execute 'start flamegraph-gui' do
  command 'pm2 start /usr/lib/node_modules/flamegraph-gui'
  not_if 'pm2 show flamegraph-gui'
end
