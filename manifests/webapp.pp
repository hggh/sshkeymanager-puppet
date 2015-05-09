# == Class: sshkeymanager::webapp

class sshkeymanager::webapp(
  $django_secret_key,
  $skm_version             = sshkeymanager::webapp::params::skm_version,
  $database_driver         = $sshkeymanager::webapp::params::database_driver,
  $install_database_driver = sshkeymanager::webapp::params::install_database_driver,
  $install_python3         = $sshkeymanager::webapp::params::install_python3,
  $install_django          = $sshkeymanager::webapp::params::install_django,
  $install_bootstrap3      = $sshkeymanager::webapp::params::install_bootstrap3,
  $user                    = $sshkeymanager::webapp::params::user,
  $group                   = $sshkeymanager::webapp::params::group,
  $home                    = $sshkeymanager::webapp::params::home
) inherits sshkeymanager::webapp::params {

  validate_string($database_driver)
  validate_string($django_secret_key)
  validate_bool($install_python3)
  validate_bool($install_django)
  validate_bool($install_bootstrap3)

  # install python3 / django / bootstrap3 dependency:
  class { 'sshkeymanager::webapp::python':
    install_database_driver => $install_database_driver,
    database_driver         => $database_driver,
    install_python3         => $install_python3,
    install_django          => $install_django,
    install_bootstrap3      => $install_bootstrap3,
  }->
  class { 'sshkeymanager::webapp::user':
    user  => $user,
    group => $group,
    home  => $home,
  }->
  class { 'sshkeymanager::webapp::install':
  }->
  class { 'sshkeymanager::webapp::configuration':
  }

}
