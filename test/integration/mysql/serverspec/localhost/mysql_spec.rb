require 'spec_helper'

describe port(3306) do
  it { should be_listening.with('tcp') }
end