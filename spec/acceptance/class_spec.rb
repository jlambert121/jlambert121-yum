require 'spec_helper_acceptance'

describe 'yum classes' do

  context 'defaults' do
    case fact('operatingsystemmajrelease')
    when '6'
#      shell('curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6 https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6')
      pp = <<-EOS
      class { 'yum': repos => {
        "epel" => {
          "descr"     => 'Extra Packages for Enterprise Linux 6 - x86_64',
          "baseurl"   => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
          "gpgkey"    => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6'
        }
      }}
      EOS
    when '7'
#      shell('curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7')
      pp = <<-EOS
      class { 'yum': repos => {
        "epel" => {
          "descr"     => 'Extra Packages for Enterprise Linux 7 - x86_64',
          "baseurl"   => 'http://download.fedoraproject.org/pub/epel/7/$basearch',
          "gpgkey"    => 'https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'
        }
      }}
      EOS
    end

    it 'should work idempotently with no errors' do
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe command('yum -y install aspell-en') do
      its(:exit_status) { should eq 0 }
    end

  end

end
