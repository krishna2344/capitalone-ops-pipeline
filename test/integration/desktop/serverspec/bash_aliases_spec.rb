require 'spec_helper'

describe file('/etc/profile.d/bash_alias_iz.sh') do
  it { should exist }
end
