
include_recipe 'jenkins::master'

directory node['jenkins-job']['job-dir'] do
  owner node['jenkins']['user']
  group node['jenkins']['group']
  recursive true
end

node['jenkins-job']['job-files'].each do |project, source_file|
  xml_filename = "#{node['jenkins-job']['job-dir']}/#{project}"

  cookbook_file xml_filename do
    source source_file
    owner node['jenkins']['user']
    group node['jenkins']['group']
    mode '0755'
    action :create
  end

  jenkins_job project do
    config xml_filename
    action :create
  end
end
