define alkivi_base::firewall_rule (
  $source_port = undef,
  $dest_port   = undef,
  $comment     = $title,
  $priority    = 80,
  $table       = 'filter',
  $chain       = 'INPUT',
  $rule        = 'ACCEPT',
  $protocol    = 'tcp',
  $ip_version  = 'both',
) {

  # TODO fix all parameters and improve checks
  validate_string($chain)
  validate_string($source_port)
  validate_string($dest_port)
  validate_string($comment)
  validate_string($rule)
  validate_string($protocol)

  validate_re($protocol, [ '^tcp$', '^udp$', '^icmp$' ])
  validate_re($table, [ '^filter', ])
  validate_re($chain, [ '^INPUT', ])
  validate_re($rule, [ '^ACCEPT', ])

  if(!$source_port and !$dest_port)
  {
    fail("You must pass either source_port or dest_port or both")
  }

  if($ip_version == 'both')
  {
    $filename = "/etc/iptables.d/${priority}-${title}.rules"
  }
  elsif($ip_version == 'ipv4')
  {
    $filename = "/etc/iptables.d/${priority}-${title}.rules.ipv4"
  }
  elsif($ip_version == 'ipv6')
  {
    $filename = "/etc/iptables.d/${priority}-${title}.rules.ipv6"
  }
  else
  {
    fail("Parameter ip_version is not valid : ${ip_version}. Should be both, ipv4 or ipv6")
  }

  # Then apply file
  file { $filename:
    ensure     => present,
    owner      => 'root',
    group      => 'root',
    mode       => '0600',
    content    => template('alkivi_base/firewall_rule.erb'),
    require    => Package['alkivi-iptables'],
    notify     => Service['alkivi-iptables'],    
  }
}

