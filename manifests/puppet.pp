# == Class: sshkeymanager::puppet

class sshkeymanager::puppet(
  $directory = $sshkeymanager::puppet::params::directory
) inherits sshkeymanager::puppet::params {

  file { $directory:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
}
