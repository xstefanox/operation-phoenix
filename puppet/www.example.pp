## refresh the package manager cache
exec { 'apt-update':
  command => 'apt-get update',
  path    => '/usr/bin',
}

## SYSTEM CONFIGURATION

# timezone
class { 'timezone':
  timezone => 'Europe/Rome'
}

# locale
class { 'locales':
  default_locale  => 'en_US.UTF-8',
  locales         => [
    'en_US.UTF-8 UTF-8',
    'it_IT.UTF-8 UTF-8',
    'fr_CH.UTF-8 UTF-8',
    'es_ES.UTF-8 UTF-8',
    'de_DE.UTF-8 UTF-8',
  ],
}

# needed to read Apache logs
group { 'adm':
  members => [ 'vagrant' ]
}

# enable Avahi
class { 'avahi': }

## WEB SERVER CONFIGURATION

# this is the web server document root
$docroot = '/vagrant/web'

# esure the document root exists and is a directory
file { $docroot:
  ensure  => 'directory'
}

# install Apache with preform mpm
class { 'apache':
  mpm_module => 'prefork'
}

# install php-apache2 SAPI
include apache::mod::php

# ensure the web server is reloaded when the configuration changes
# @see http://puppet-php.readthedocs.org/en/latest/installation.html
Php::Extension <| |>
# configure extensions
-> Php::Config <| |>
# reload webserver
~> Service["apache2"]

include '::mysql::server'

mysql::db { 'wordpress':
  user     => 'wordpress',
  password => 'wordpress',
  host     => 'localhost',
  grant    => ['ALL'],
}

class { 'wordpress':
  wp_owner    => 'wordpress',
  wp_group    => 'wordpress',
  db_user     => 'wordpress',
  db_password => 'wordpress',
}

#mysql_database { 'wordpress':
#  ensure  => 'present',
#  charset => 'utf8',
#  collate => 'utf8_bin',
#}
#
#mysql_user { 'wordpress@localhost':
#  ensure   => 'present',
#  password_hash => '*67AE5F7F2B344936FD7E35D96D389440FE7B36A4'
#}
#
#mysql_grant { 'wordpress@localhost/wordpress.*':
#  ensure     => 'present',
#  options    => ['GRANT'],
#  privileges => ['ALL'],
#  table      => 'wordpress.*',
#  user       => 'wordpress@localhost',
#}
