# == Class: yum
#
# Full description of class yum here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class yum (
  $repos      = $::yum::params::repos,
  $defaults   = $::yum::params::defaults,
  $purge      = $::yum::params::purge,
  $gpg_source = $::yum::params::gpg_source,
) inherits ::yum::params {

  validate_bool($purge)
  validate_hash($defaults)
  validate_hash($repos)

  if $purge {
    resources { 'yumrepo':
      purge => true,
    }
  }

  create_resources(yumrepo, $repos, $defaults)

  if $gpg_source {
    file { '/etc/pki/rpm-gpg':
      ensure  => directory,
      purge   => $purge,
      recurse => true,
      force   => true,
      owner   => 'root',
      group   => 'root',
      source  => $gpg_source,
    }
  }

}
