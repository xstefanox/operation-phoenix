define alkivi_base::passwd (
  $file   = $title,
  $type   = 'user',
  $length = 15,
) {

  validate_string($type)

  # declare root dir
  if ($type == 'user')
  {
    $rootDir = '/root/.passwd'
  }
  elsif($type == 'backup')
  {
    $rootDir = '/root/.passwd/alkivi-backup'
  }
  else
  {
    $rootDir = "/root/.passwd/${type}"
  }

  # First generate password on the puppet master, to be able to reuse it other applications
  $password = alkivi_password($file,$type,$length)

  if(!defined(File[$rootDir]))
  {
    file { $rootDir:
      ensure => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0700',
    }
  }

  # Then apply file
  file { "${rootDir}/${file}":
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0400',
    content => "${password}\n",
  }

  #exec { "genpwd --save ${title} --savedir ${rootDir}":
  #  cwd     => '/root',
  #  creates => "${rootDir}/${title}",
  #  path    => ['/usr/bin', '/bin', '/usr/sbin', '/root/alkivi-scripts'],
  #  require => File['/root/alkivi-scripts/genpwd'],
  #}
}

