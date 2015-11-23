require 'spec_helper'
require 'mkmf'

pin_version = false

binaries = {
  mvn:  {
    version_arg: '-v',
    version: '3.3.'
  },
  git: {
    version_arg: '--version',
    version: '1.9.'
  },
  gradle: {
    version_arg: '--version',
    version: '1.5'
  },
  docker: {
    version_arg: '-v',
    version: '1.6.'
  },
  java: {
    version_arg: '-version 2>&1',
    version: '1.8.'
  },

  ksh: {
    version_arg: '--version 2>&1',
    version: '2012-08-01'
  },

  node: {
    version_arg: '-v',
    version: '0.10.'
  }
}

binaries.each do |name, hash|
  describe "binary named #{name}" do
    subject { find_executable name.to_s }
    it { should_not be_nil }
  end

  describe "#{hash[:bin]} #{hash[:version_arg]}", if: os[:family] == 'ubuntu' do
    before(:all) do
      @out = command("#{hash[:bin]} #{hash[:version_arg]}")
    end

    it "it reports /#{ hash[:version] }/", if: pin_version == true do
      expect(@out.stdout).to match(/#{ hash[:version] }/)
    end
  end
end
