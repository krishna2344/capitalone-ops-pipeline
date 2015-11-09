include_recipe 'jenkins::master'

jenkins_user node['jenkins-master']['admin_username'] do
  password node['jenkins-master']['admin_password']
  full_name 'Jenkins admin user'
  public_keys [node['jenkins-master']['admin_public_key']]
end

node.run_state['jenkins_private_key'] =
  node['jenkins-master']['admin_private_key']

jenkins_script 'configure email' do
  command <<-EOH.gsub(/^ {4}/, '')
    import jenkins.model.*
    def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
    jenkinsLocationConfiguration.setAdminAddress("node['jenkins-master']['admin_email']")
    jenkinsLocationConfiguration.save()
  EOH

  action :nothing
end

node['jenkins-master']['users'].each do |user, hash|
  jenkins_user user do
    full_name hash['full_name']
    email hash['email']
    password hash['password']
    public_keys hash['public_keys']
  end
end

node['jenkins-master']['credentials'].each do |user, hash|
  if hash['password']
    jenkins_password_credentials user do
      id hash['id']
      description "password #{hash['full_name']}, #{hash['email']}"
      password hash['password']
    end
  end

  if hash['private_key']
    jenkins_private_key_credentials user do
      id hash['id']
      description "private keys #{hash['full_name']}, #{hash['email']}"
      private_key hash['private_key']
    end
  end
end

node['jenkins-master']['plugins'].each do |plugin|
  plugin, version = plugin.split('=')
  jenkins_plugin plugin do
    version version if version
    notifies :restart, 'service[jenkins]'
  end
end
