
directory node['spring_tool_suite']['sts_homedir'] do
  owner 'root'
  group 'vagrant'
  mode '0775'
  action :create
  recursive true
end

tar_extract node['spring_tool_suite']['sts_download'] do
  target_dir node['spring_tool_suite']['sts_homedir']
  creates "#{node['spring_tool_suite']['sts_homedir']}/plugins"
  tar_flags ['-P', '--strip-components 2']
end

node['spring_tool_suite']['plugin_list'].each do |plugin_name|
  puts "Install_#{plugin_name}_Plugin"
  execute "Install_#{plugin_name}_Plugin" do
    cwd node['spring_tool_suite']['sts_homedir']
    command './STS -application org.eclipse.equinox.p2.director -repository ' <<
      node['spring_tool_suite'][plugin_name]['site'] <<
      ' -installIUs ' <<
      node['spring_tool_suite'][plugin_name]['ius'] <<
      ' -noSplash'
    not_if { File.exist?(node['spring_tool_suite'][plugin_name]['creates']) }
  end
end

execute 'set vagrant group on STS' do
  cwd node['spring_tool_suite']['sts_homedir']
  command "chown -R root:vagrant #{node['spring_tool_suite']['sts_homedir']}"
end

execute 'allow vagrant writes on STS' do
  cwd node['spring_tool_suite']['sts_homedir']
  command "chmod -R g+w #{node['spring_tool_suite']['sts_homedir']}"
end
