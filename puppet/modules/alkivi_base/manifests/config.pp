class alkivi_base::config () {
  # make sur ssh directory is here
  file {  '/root/.ssh/':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  file {  '/etc/alkivi.conf.d/':
    ensure => directory,
    mode   => '0751',
  }

  # alkivi keys for root
  file {  '/root/.ssh/authorized_keys':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('alkivi_base/root_authorized_keys.erb'),
    require => [ File['/root/.ssh'], ],
  }

  # make sur ssh directory is here
  file {  '/home/alkivi/.ssh/':
    ensure  => directory,
    owner   => 'alkivi',
    group   => 'alkivi',
    mode    => '0700',
  }

  # alkivi keys for alkivi
  file {  '/home/alkivi/.ssh/authorized_keys':
    ensure  => present,
    owner   => 'alkivi',
    group   => 'alkivi',
    mode    => '0644',
    content => template('alkivi_base/alkivi_authorized_keys.erb'),
    require => [ File['/home/alkivi/.ssh/'] ],
  }


  # Alkivi configuration for alkivi
  file { '/home/alkivi/.alkivi-conf':
    ensure  => directory,
    source  => 'puppet:///modules/alkivi_base/linux-conf',
    recurse => true,
    ignore  => ['.git*', '.netrwhist' ],
  }

  file { '/home/alkivi/.vim':
    ensure  => link,
    target  => '/home/alkivi/.alkivi-conf/vim/.vim',
    force   => true,
    require => File['/home/alkivi/.alkivi-conf'],
    owner   => 'alkivi',
    group   => 'alkivi',
  }

  file { '/home/alkivi/.vimrc':
    ensure  => link,
    target  => '/home/alkivi/.alkivi-conf/vim/.vimrc',
    require => File['/home/alkivi/.alkivi-conf'],
    owner   => 'alkivi',
    group   => 'alkivi',
  }

  file { '/home/alkivi/.screenrc':
    ensure  => link,
    target  => '/home/alkivi/.alkivi-conf/screen/.screenrc',
    require => File['/home/alkivi/.alkivi-conf'],
    owner   => 'alkivi',
    group   => 'alkivi',
  }

  file { '/home/alkivi/.gitconfig':
    ensure  => link,
    target  => '/home/alkivi/.alkivi-conf/git/.gitconfig',
    require => File['/home/alkivi/.alkivi-conf'],
    owner   => 'alkivi',
    group   => 'alkivi',
  }

  file { '/home/alkivi/.bash_aliases':
    ensure  => link,
    target  => '/home/alkivi/.alkivi-conf/bash/.bash_aliases',
    require => File['/home/alkivi/.alkivi-conf'],
    owner   => 'alkivi',
    group   => 'alkivi',
  }

  # Alkivi configuration for root
  file { '/root/.alkivi-conf':
    ensure => link,
    target => '/home/alkivi/.alkivi-conf',
  }

  file { '/root/.vim':
    ensure  => link,
    force   => true,
    target  => '/root/.alkivi-conf/vim/.vim',
    require => File['/root/.alkivi-conf'],
  }

  file { '/root/.vimrc':
    ensure  => link,
    target  => '/root/.alkivi-conf/vim/.vimrc',
    require => File['/root/.alkivi-conf'],
  }

  file { '/root/.screenrc':
    ensure  => link,
    target  => '/root/.alkivi-conf/screen/.screenrc',
    require => File['/root/.alkivi-conf'],
  }

  file { '/root/.gitconfig':
    ensure  => link,
    target  => '/root/.alkivi-conf/git/.gitconfig',
    require => File['/root/.alkivi-conf'],
  }

  file { '/root/.bash_aliases':
    ensure  => link,
    target  => '/root/.alkivi-conf/bash/.bash_aliases',
    require => File['/root/.alkivi-conf'],
  }

  # Some alternative
  alternatives { 'editor':
    path => '/usr/bin/vim.basic'
  }

  # Tzdata
  file { "/etc/localtime":
    require => Package["tzdata"],
    source  => "file://${alkivi_base::localtime_file}",
  }

  # Locales
  class { locales:
      default_value => "en_US.UTF-8",
      available     => ["en_US.UTF-8 UTF-8" ],
  }

  # Console data
  class { console_data: }

  # NTP ntp.ovh.net
  class { '::ntp':
      servers  => $alkivi_base::ntp_servers,
  }

  # Use custom motd in profile.d ... allow more dynamic stuff
  # Motd symlink and repertory
  #
  file { '/etc/motd':
    ensure => absent,
  }

  file { '/var/run/motd.dynamic':
    ensure => absent,
  }

  file { '/etc/update-motd.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source  => 'puppet:///modules/alkivi_base/motd',
    recurse => true,
  }

  file { '/etc/profile.d/display_motd.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source  => 'puppet:///modules/alkivi_base/display_motd.sh',
  }

}
