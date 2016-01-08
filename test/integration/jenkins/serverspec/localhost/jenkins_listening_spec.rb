require 'spec_helper'

set :path, '/bin:/sbin:/usr/local/sbin:/usr/bin:/usr/sbin:$PATH'

describe service('jenkins') do
  it { should be_running }
end

describe port(8080) do
  it { should be_listening }
end
