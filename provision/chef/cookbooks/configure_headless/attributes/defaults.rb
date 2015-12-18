default['configure_headless']['packages'] =
  %w(bash ksh git subversion unzip libtool dos2unix)

case node[:platform]
when 'redhat', 'centos'
  default['configure_headless']['packages'] <<
    %w()
when 'ubuntu', 'debian'
  default['configure_headless']['packages'] <<
    %w(python-software-properties autotools-dev libltdl-dev)
end
