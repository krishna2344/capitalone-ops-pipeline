require 'spec_helper'

set :path, '/bin:/sbin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH'

describe service('mysql-mysqld') do
  it { should be_running }
end

describe port(3306) do
  it { should be_listening.with('tcp') }
end
