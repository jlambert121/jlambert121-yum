#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with yum](#setup)
    * [What yum affects](#what-yum-affects)
    * [Beginning with yum](#beginning-with-yum)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Changelog/Contributors](#changelog-contributors)

## Overview

A puppet module to install (and purge) yum repositories as well as manage installed GPG keys.

## Module Description

Why another yum module with so many in the forge?  All of the modules I found in the forge either hardcode the available repositories,
contain no tests, or appear to be unmaintained given the untouched issues and/or pull requests.

This module will install repos (as defined by the `repos` parameter) and optionally purge unmanaged repos (based on the `purge` parameter)
and manage gpg keys (based on the `gpg_source` parameter).

## Setup

### What yum affects

* Repos in /etc/yum.repos.d
* GPG keys in /etc/pki/rpm-gpg (optional)

### Beginning with yum

Including yum with no parameters has the amazing effect of doing nothing:

```
    class { 'yum': }
```

## Usage

### Parameters

####`repos`

Hash of repos to include on the system

```
  class { 'yum':
    repos => {
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
  }
```

####`defaults`

A hash of parameters that should be used on all repos (unless overridden on the repo itself).  These parameters will only apply
to repos defined by `repos`.  In the below example, epel will be disabled, corp_repo will be enabled.

```
  class { 'yum':
    repos => {
      "epel" => {
        "descr"     => 'Extra Packages for Enterprise Linux 6 - x86_64',
        "baseurl"   => 'http://download.fedoraproject.org/pub/epel/6/$basearch',
        "gpgkey"    => '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
        "enabled"   => '0'
      },
      "corp_repo" => {
        "descr"     => 'Local corporate repo',
        "baseurl"   => 'http://yum.example.com/6/$basearch',
        "gpgkey"    => '/etc/pki/rpm-gpg/RPM-GPG-KEY-corp'
      }
    },
    defaults => { enabled => '1' },
  }
```

####`purge`

If set to true, unmanaged repos will be removed from the system.  This also applies to GPG keys (if `gpg_source` is defined - see below)
If no repos are defined and purge is true, all repos will be removed.

```
  class { 'yum':
    repos => ...,
    purge => true,
  }
```

####`gpg_source`

A puppet resource that contains all of the RPM GPG keys to be installed.  If `purge => true ` is also set, unamanged keys will be removed.

```
  class { 'yum':
    repos => ...,
    gpg_source => 'puppet:///data/yum/gpg',
  }
```

## Reference

### Public classes

* yum

## Limitations

This module is only relavent on RedHat-based machines.

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/evenup/evenup-yum/CONTRIBUTING.md) for
information on adding and validating tests for PRs.

## Changelog / Contributors

[Changelog](https://github.com/evenup/evenup-yum/CHANGELOG)
[Contributors](https://github.com/evenup/evenup-yum/graphs/contributors)