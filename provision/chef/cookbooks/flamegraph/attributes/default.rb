case node[:platform]
when 'redhat', 'centos'
  default['flamegraph']['packages'] = ['perf']
when 'ubuntu', 'debian'
  default['flamegraph']['packages'] = ['linux-tools-common']
end

default['flamegraph']['root'] = '/opt/flamegraph'
default['flamegraph']['git_revision'] = 'master'
default['flamegraph']['git_repository'] = 'https://github.com/brendangregg/FlameGraph'

default['flamegraph']['profile_dest'] = '/etc/profile.d/flamegraph.sh'
default['flamegraph']['profile_src'] = 'flamegraph.sh.erb'
