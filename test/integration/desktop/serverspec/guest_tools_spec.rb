require 'spec_helper'

describe 'guest tools present' do
  before :all do
    @cmd = 'lsmod | grep -io "\(vsock\|vboxguest\)"' \
           ' | xargs modinfo | grep -iw description'
    @ret = command(@cmd)
  end

  context @cmd do
    it 'it has guest tools' do
      expect(@ret.stdout).to match(/(VMware|VirtualBox)/)
    end
  end
end
