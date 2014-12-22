class alkivi_base::scripts () {
  File {
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0700',
  }

  file {  '/root/alkivi-scripts/':
    ensure  => directory,
  }

  # script to generate password
  file { '/root/alkivi-scripts/genpwd':
    source  => 'puppet:///modules/alkivi_base/genpwd',
    require => File['/root/alkivi-scripts/'],
  }

  # symlink
  file { '/usr/bin/genpwd':
    ensure  => link,
    target  => '/root/alkivi-scripts/genpwd',
    require => File['/root/alkivi-scripts/genpwd'],
  }

  # script to set password
  file { '/root/alkivi-scripts/setpwd':
    source  => 'puppet:///modules/alkivi_base/setpwd',
    require => File['/root/alkivi-scripts/'],
  }

  file { '/usr/bin/setpwd':
    ensure  => link,
    target  => '/root/alkivi-scripts/setpwd',
    require => File['/root/alkivi-scripts/setpwd'],
  }

  # script to generate securedata files
  file { '/root/alkivi-scripts/gensecuredata':
    source  => 'puppet:///modules/alkivi_base/gensecuredata',
    require => File['/root/alkivi-scripts/'],
  }

  file { '/usr/bin/gensecuredata':
    ensure  => link,
    target  => '/root/alkivi-scripts/gensecuredata',
    require => File['/root/alkivi-scripts/gensecuredata'],
  }
}
