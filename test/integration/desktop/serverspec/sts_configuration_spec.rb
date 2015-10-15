require 'spec_helper'

describe file('/usr/share/applications/STS.desktop') do
  it { should exist }
end
describe file('/home/vagrant/Desktop/STS.desktop') do
  it { should exist }
end
describe file('/opt/sts-bundle/') do
  it { should be_directory }
end
