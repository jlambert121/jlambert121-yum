# == Class yum::params
#
# This class is meant to be called from yum.
# It sets variables according to platform.
#
class yum::params {
  case $::osfamily {
    'RedHat', 'Amazon': {
      $repos      = {}
      $defaults   = { enabled => '1' }
      $purge      = false
      $gpg_source = undef
    }
    default: {
      fail("${::osfamily} not supported")
    }
  }
}
