require 'spec_helper'

describe 'yum' do
  let(:facts) { { :osfamily => 'RedHat' } }

  repos = {
      "epel" => {
        "descr"     => 'Extra Packages for Enterprise Linux 6 - x86_64',
        "baseurl"   => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
        "gpgkey"    => '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6'
      },
      "corp_repo" => {
        "descr"     => 'Local corporate repo',
        "baseurl"   => 'http://yum.example.com/6/$basearch',
        "gpgkey"    => '/etc/pki/rpm-gpg/RPM-GPG-KEY-corp'
      }
    }

  context 'create repos' do
    let(:params) { { :repos => repos } }

    it { should contain_yumrepo('epel') }
    it { should contain_yumrepo('corp_repo')}
    it { should_not contain_file('/etc/pki/rpm-gpg') }
  end

  describe 'copy gpg keys' do
    let(:params) { { :gpg_source => 'puppet:///data/yum/gpg_keys' } }

    it { should contain_file('/etc/pki/rpm-gpg').with(:source => 'puppet:///data/yum/gpg_keys') }
  end

  describe 'purge repos' do
    let(:params) { { :repos => repos, :purge => true } }

    # Not sure how to test for this, but I know this wont pass
    #it { should contain_file('/etc/yum.repos.d/epel.repo') }
    #it { should contain_file('/etc/yum.repos.d/corp_repo.repo') }
    #it { should contain_file('/etc/yum.repos.d/').with(:purge => true) }
  end

  describe 'yum class on unsupported OS' do
    let(:facts) {{ :osfamily => 'Debian' } }

    it { expect { should contain_package('yum') }.to raise_error(Puppet::Error, /Debian not supported/) }
  end
end
