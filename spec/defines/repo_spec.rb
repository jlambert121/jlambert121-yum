require 'spec_helper'

describe 'yum::repo' do
  let(:title) { 'foo' }
  let(:facts) { { :osfamily => 'RedHat' } }

  context 'create repo' do
    let(:params) { { :baseurl => 'http://a' } }

    it { should contain_yumrepo('foo') }
    it { should_not contain_file('/etc/pki/rpm-gpg/foo-GPG-KEY')}
  end

  describe 'copy gpg keys' do
    let(:params) { { :baseurl => 'http://a', :gpg_source => 'puppet:///data/yum/gpg_keys/foo-KEY' } }
    it { should contain_file('/etc/pki/rpm-gpg/foo-GPG-KEY').with(:source => 'puppet:///data/yum/gpg_keys/foo-KEY') }
  end
end
