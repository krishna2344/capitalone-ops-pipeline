apt_repository 'webupd8team' do
  uri 'http://ppa.launchpad.net/webupd8team/java/ubuntu'
  components ['main']
  distribution node['lsb']['codename']
  keyserver 'keyserver.ubuntu.com'
  key 'EEA14886'
  deb_src true
end

execute 'accept-license-7' do
  command 'echo oracle-java7-installer ' \
          'shared/accepted-oracle-license-v1-1 select true ' \
          '| /usr/bin/debconf-set-selections'
end
execute 'accept-license-8' do
  command 'echo oracle-java8-installer ' \
          'shared/accepted-oracle-license-v1-1 select true ' \
          '| /usr/bin/debconf-set-selections'
end

package 'oracle-java7-installer' do
  action :install
end

package 'oracle-java8-installer' do
  action :install
end

package 'oracle-java7-set-default' do
  action :install
end
