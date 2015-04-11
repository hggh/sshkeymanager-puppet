require 'spec_helper'

describe 'sshkeymanager::puppet' do

  context 'with defaults for all parameters' do
    it { should contain_class('sshkeymanager::puppet') }

    it { should contain_file('/etc/sshkeymanager-hiera').with(
       'ensure' => 'directory',
       'owner'  => 'root',
       'group'  => 'root',
       'mode'   => '0755',
    )}
  end

  context 'with different parameters' do
    let (:params) {
       {
       :directory => '/etc/puppet/sshkeymanager'
       }
    }
    it { should contain_class('sshkeymanager::puppet') }
    it { should contain_file('/etc/puppet/sshkeymanager').with(
       'ensure' => 'directory',
       'owner'  => 'root',
       'group'  => 'root',
       'mode'   => '0755',
    )}
  end
end
