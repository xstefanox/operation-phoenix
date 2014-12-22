# Alkivi Base Module

This module will provide basic tools that we install on our machine.
It include :
- ssh keys 
- default software
- provide hability to quickly create password and credentials for our api
- remove default motd and add an executable in /etc/profile.d to allow dynamic motd
- provide firewall rules (version alpha, using alkivi-iptables (https://github.com/alkivi-sas/debian-iptables)

## Usage

You have to create your own templates in :
- templates/alkivi_authorized_keys.erb
- templates/root_authorized_keys.erb

## Usage passwords

```puppet
# Generate a reusable password (store in /root/.passwd/db)
$mysql_password = alkivi_password('mysql', 'db')

# Generate a long reusable password  (will be store in /root/.passwd/apps)
$long_password = alkivi_password('test', 'apps', 45)
```

## Usage firewall

Currently these is alpha, need to implement more option for firewalling
```puppet

# Generate a custom rules
alkivi_base::firewall_rule{ 'openerp_apache':
  dest_port => '4443',
  protocol  => 'tcp',
}

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
