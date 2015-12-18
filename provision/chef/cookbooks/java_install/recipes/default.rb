
if node['java_install']['java7']
  java_ark 'java_install_7' do
    default node['java_install']['default'] == 7

    url node['java']['jdk']['7'][node['java']['arch']]['url']
    checksum node['java']['jdk']['7'][node['java']['arch']]['checksum']
    app_home node['java']['java_home']
    bin_cmds node['java']['jdk']['7']['bin_cmds']
    alternatives_priority node['java']['jdk']['7']['alternatives_priority']
    retries node['java']['ark_retries']
    retry_delay node['java']['ark_retry_delay']
    connect_timeout node['java']['ark_timeout']
    use_alt_suffix node['java']['use_alt_suffix']
    reset_alternatives node['java']['reset_alternatives']
    action :install
  end
end

if node['java_install']['java8']
  java_ark 'java_install_8' do
    default node['java_install']['default'] == 8

    url node['java']['jdk']['8'][node['java']['arch']]['url']
    checksum node['java']['jdk']['8'][node['java']['arch']]['checksum']
    app_home node['java']['java_home']
    bin_cmds node['java']['jdk']['8']['bin_cmds']
    alternatives_priority node['java']['jdk']['8']['alternatives_priority']
    retries node['java']['ark_retries']
    retry_delay node['java']['ark_retry_delay']
    connect_timeout node['java']['ark_timeout']
    use_alt_suffix node['java']['use_alt_suffix']
    reset_alternatives node['java']['reset_alternatives']
    action :install
  end
end
