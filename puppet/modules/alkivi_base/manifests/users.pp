class alkivi_base::users () {

  Exec {
    path => ['/usr/bin', '/bin', '/usr/sbin', '/root/alkivi-scripts'],
  }


  # default group & users
  group { 'alkivi':
    ensure => present,
    gid    => 1000,
  }

  # Define and store password
  $alkivi_password = alkivi_password('alkivi', 'user')
  $root_password = alkivi_password('alkivi', 'user')

  alkivi_base::passwd{ 'alkivi': }
  alkivi_base::passwd{ 'root': }

  # Create users
  user { 'alkivi':
    ensure     => present,
    comment    => 'Alkivi Default User',
    uid        => 1000,
    gid        => 1000,
    home       => '/home/alkivi',
    managehome => true,
    password   => sha1($alkivi_password),
    shell      => '/bin/bash',
  }

  user { 'root':
    ensure   => present,
    uid      => 0,
    gid      => 0,
    password => sha1($root_password),
    home     => '/root',
    shell    => '/bin/bash',
  }
}
