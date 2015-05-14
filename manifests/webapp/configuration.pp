# == Class: sshkeymanager::webapp::configuration

class sshkeymanager::webapp::configuration {
  $django_secret_key = $sshkeymanager::webapp::django_secret_key
  $puppetdb          = $sshkeymanager::webapp::puppetdb
  $database_driver   = $sshkeymanager::webapp::database_driver
  $api_keys          = $sshkeymanager::webapp::api_keys

  $config = "${sshkeymanager::webapp::install_dir}/sshkeymanager/keymanager/settings.py"
  file { $config:
    ensure  => present,
    owner   => $sshkeymanager::webapp::user,
    group   => $sshkeymanager::webapp::group,
    mode    => '0640',
    content => template('sshkeymanager/settings.py.erb'),
  }
}
