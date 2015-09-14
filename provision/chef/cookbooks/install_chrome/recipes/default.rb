include_recipe 'chrome'

chrome 'custom_preferences' do
  template 'preferences.json.erb'
  params(
    homepage: node['install_chrome']['homepage']
  )
  action :master_preferences
end
