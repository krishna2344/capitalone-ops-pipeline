
include_recipe 'jenkins::master'

node['jenkins-master']['users'].each do |user, hash|
  jenkins_user user do
    id hash['id']
    public_keys hash['public_keys']
  end
end

node.run_state['jenkins_private_key'] =
  node['jenkins-master']['users']['jenkins']['private_key']

node['jenkins-master']['plugins'].each do |plugin|
  plugin, version = plugin.split('=')
  jenkins_plugin plugin do
    version version if version
    notifies :restart, 'service[jenkins]'
  end
end
