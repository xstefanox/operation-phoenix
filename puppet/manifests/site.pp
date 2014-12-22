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
