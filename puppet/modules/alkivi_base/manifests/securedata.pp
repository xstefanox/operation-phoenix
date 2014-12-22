define alkivi_base::securedata (
  $file,
  $type,
  $host              = undef,
  $user              = undef,
  $dbname            = undef,
  $applicationKey    = undef,
  $applicationSecret = undef,
  $consumerKey       = undef,
) {

  validate_string($type)
  validate_string($file)

  # declare root dir
  if ($type == 'sql')
  {
    validate_string($user)
    validate_string($host)
    validate_string($dbname)
    $rootDir = '/alkivi/.secureData/sql'
    $command = "gensecuredata --type ${type} --save ${file} --savedir ${rootDir} --host ${host} --user ${user} --dbname ${dbname}"

  }
  elsif($type == 'api_ovh')
  {
    validate_string($applicationKey)
    validate_string($applicationSecret)
    validate_string($consumerKey)
    $rootDir = '/alkivi/.secureData/api_ovh'
    $command = "gensecuredata --type ${type} --save ${file} --savedir ${rootDir}  --applicationKey ${applicationKey} --applicationSecret ${applicationSecret} --consumerKey ${consumerKey}"
  }
  else
  {
    fail('Param type is not correct, must be user, db or hosts')
  }

  exec { "secureData ${type} ${file}":
    command => $command,
    cwd     => '/root',
    creates => "${rootDir}/${file}",
    path    => ['/usr/bin', '/bin', '/usr/sbin', '/root/alkivi-scripts'],
    require => File['/root/alkivi-scripts/gensecuredata'],
  }
}

