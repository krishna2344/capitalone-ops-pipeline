require 'spec_helper'

describe file('/home/vagrant/.m2/settings.xml') do
  it { should exist }
end
