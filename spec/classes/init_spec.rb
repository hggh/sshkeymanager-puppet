require 'spec_helper'
describe 'sshkeymanager' do

  context 'with defaults for all parameters' do
    it { should contain_class('sshkeymanager') }
  end
end
