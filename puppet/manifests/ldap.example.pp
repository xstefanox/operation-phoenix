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
class { locales:
  default_value  => 'en_US.UTF-8',
  available      => [
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

class { 'ldap::server':
  suffix  => 'dc=example,dc=org',
  rootdn  => 'cn=admin,dc=example,dc=org',
  rootpw  => 'admin',
}

class { 'ldap::client':
  uri  => 'ldap://localhost',
  base => 'dc=example,dc=org'
}

ldap_entry { 'cn=wordpress,ou=services,dc=example,dc=org':
  ensure      => present,
  host        => 'localhost',
  port        => 389,
  base        => 'dc=example,dc=org',
  username    => 'cn=admin,dc=example,dc=org',
  password    => 'admin',
  ssl => false,
  attributes  => { givenName => 'Wordpress',
    objectClass => ["top", "person", "inetorgPerson"]}
}

exec { 'phpldapadmin':
  command => 'apt-get install phpldapadmin',
  path    => '/usr/bin',
}