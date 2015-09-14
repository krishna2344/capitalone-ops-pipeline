
node['configure_desktop']['application_dirs'].each do |dir|
  directory dir do
    owner 'root'
    group 'vagrant'
    mode '0775'
    action :create
  end

  template "#{dir}/STS.desktop" do
    action [:create]
    source 'STS.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end

  template "#{dir}/firefox.desktop" do
    action [:create]
    source 'firefox.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end

  template "#{dir}/google-chrome.desktop" do
    action [:create]
    source 'google-chrome.desktop.erb'
    owner 'root'
    group 'vagrant'
    mode '0775'
  end
end

directory '~vagrant/.mozilla' do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  action :create
  recursive true
end

template '/usr/lib/firefox/browser/defaults/preferences/syspref.js' do
  action [:create]
  source 'prefs.js.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  variables(
    project_homepage: node[:configure_desktop][:project_homepage]
  )
end
