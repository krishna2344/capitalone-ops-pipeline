if node['chef_solo_proxy']['http_proxy']
  ENV['http_proxy'] = node['chef_solo_proxy']['http_proxy']
end

if node['chef_solo_proxy']['https_proxy']
  ENV['https_proxy'] = node['chef_solo_proxy']['https_proxy']
end

if node['chef_solo_proxy']['no_proxy']
  ENV['no_proxy'] = node['chef_solo_proxy']['no_proxy'].join(',')
end

chef_solo_proxy_profile 'chef_solo_proxy' do
  action :create
  https_proxy node['chef_solo_proxy']['https_proxy']
  http_proxy node['chef_solo_proxy']['http_proxy']
  no_proxy node['chef_solo_proxy']['no_proxy']
end
