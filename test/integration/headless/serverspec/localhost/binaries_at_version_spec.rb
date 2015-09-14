require 'spec_helper'

pin_version = false

binaries = {
  mvn:  {
    bin: '/usr/local/maven/bin/mvn',
    version_arg: '-v',
    version: '3.3.'
  },
  git: {
    bin: '/usr/bin/git',
    version_arg: '--version',
    version: '1.9.'
  },
  gradle: {
    bin: '/usr/local/gradle/bin/gradle',
    version_arg: '--version',
    version: '1.5'
  },
  docker: {
    bin: '/usr/bin/docker',
    version_arg: '-v',
    version: '1.6.'
  },
  java: {
    bin: '/usr/bin/java',
    version_arg: '-version 2>&1',
    version: '1.8.'
  },

  ksh: {
    bin: '/usr/bin/ksh',
    version_arg: '--version 2>&1',
    version: '2012-08-01'
  },

  node: {
    bin: '/usr/bin/node',
    version_arg: '-v',
    version: '0.10.'
  }
}

binaries.each do |_, hash|
  describe file(hash[:bin]) do
    it { should be_executable }
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
