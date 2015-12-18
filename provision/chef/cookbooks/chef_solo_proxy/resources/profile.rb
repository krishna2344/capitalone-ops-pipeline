property :https_proxy, String
property :http_proxy, String
property :no_proxy, Array
attribute :name, kind_of: String, name_attribute: true

default_action :create

action :create do
  template "/etc/profile.d/#{name}.sh" do
    source 'chef_solo_proxy.sh.erb'
    variables(
      https_proxy: https_proxy,
      http_proxy: http_proxy,
      no_proxy: no_proxy.to_a.join(',')
    )
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end

  log 'message' do
    message "/etc/profile.d/#{name}.sh"
    level :info
  end
end

action :remove do
  file "/etc/profile.d/#{name}.sh" do
    action :delete
  end
end
