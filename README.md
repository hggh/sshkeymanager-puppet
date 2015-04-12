# sshkeymanager [![Build Status](https://api.travis-ci.org/hggh/sshkeymanager-puppet.svg)](https://travis-ci.org/hggh/sshkeymanager-puppet)

publish your SSH Key Manager configuration to your hosts via Puppet.

Source: https://github.com/hggh/sshkeymanager-puppet

#### Table of Contents

1. [Overview](#overview)
2. [Requirements](#requirements)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Parameters](#parameters)
5. [Hiera configuration](#hiera)
6. [SSH configuration](#ssh)

## Overview

Puppet module to publish your SSH Key Manager configuration for your hosts via
Puppet. This module requires to use the SSH Key Manager Application
(Django Webapp) and export the configuration to JSON format for Hiera.

## Requirements

* puppetlabs/stdlib
* Hiera

## Usage

For your hosts to get the SSH Public Keys:

```
class { 'sshkeymanager':
}
```

For your Puppet Server/Master to create the JSON Hiera data directory:

```
cass { 'sshkeymanager::puppet':
  directory => '/etc/sshkeymanager-hiera',
}
```




## Parameters

```
class { 'sshkeymanager':
  directory => '/etc/sshkeymanager',
}
```

Per default the `sshkeymanager` class uses the directory `/etc/sshkeymanager`.
You can change the directory to your needs.

## Hiera configuration

You need to add the json backend to your Hiera configuration:

```
---
:backends:
   - json
   - yaml
:hierarchy:
  - "nodes/%{clientcert}"
  - "%{environment}"
  - common
:json:
  :datadir: '/etc/sshkeymanager-hiera/%{environment}'
```

## SSH configuration

You need to edit on all servers that uses the `sshkeymanager` class the
SSHd configration to point to the directory there all keys are saved:

```
AuthorizedKeysFile /etc/sshkeymanager/%u 
```

To allow also user key in there own homedirectory you need to setup this:

```
AuthorizedKeysFile /etc/sshkeymanager/%u .ssh/authorized_keys
```

Using the SSH module(https://forge.puppetlabs.com/saz/ssh) from Puppet Forge it looks like:
```
class { 'ssh::server':
  options => {
    'AuthorizedKeysFile' => '/etc/sshkeymanager/%u',
  }
}
```
