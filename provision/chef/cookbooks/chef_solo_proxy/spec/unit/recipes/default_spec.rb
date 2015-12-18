require 'chefspec'

RSpec.configure do |config|
  #empty
end

describe 'chef_solo_proxy::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(step_into: ['chef_solo_proxy_profile']).converge(described_recipe)
  end
  it 'doesn\'t render_file' do
    expect(chef_run).to_not create_template('/tmp/with_attributes')
  end
  it 'renders_file' do
    expect(chef_run).to render_file("/etc/profile.d/chef_solo_proxy.sh")
  end
end
