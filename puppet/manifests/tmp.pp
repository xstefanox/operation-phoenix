
# create a virtual host
apache::vhost { 'test.example.local':
  port    => '80',
  docroot => $docroot,
}

include php

# install php-cli SAPI
class { 'php::cli':

}

# install PHP extensions
class { 'php::extension::xdebug':

}

# install Composer
class { ['php::composer', 'php::composer::auto_update']:

}

class { 'ruby':
  gems_version  => 'latest'
}
