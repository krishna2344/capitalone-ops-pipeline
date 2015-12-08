if node['chef_solo_proxy']['http_proxy']
    ENV['http_proxy'] = node['chef_solo_proxy']['http_proxy']
end

if node['chef_solo_proxy']['https_proxy']
    ENV['https_proxy'] = node['chef_solo_proxy']['https_proxy']
end
