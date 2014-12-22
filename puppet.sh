#!/bin/sh
puppet module install saz-timezone -i puppet/modules
puppet module install attachmentgenie-locales -i puppet/modules
puppet module install alkivi-ldap -i puppet/modules
puppet module install maestrodev-avahi -i puppet/modules

# ruby-net-ldap
puppet module install datacentred-ldap -i puppet/modules

#puppet module install puppetlabs-stdlib -i puppet/modules
#puppet module install puppetlabs/apache -i puppet/modules
#puppet module install nodes-php -i puppet/modules
#puppet module install saz-locales -i puppet/modules
#puppet module install onyxpoint-gpasswd -i puppet/modules
#puppet module install puppetlabs-ruby -i puppet/modules
#puppet module install puppetlabs-mysql -i puppet/modules
#puppet module install hunner-wordpress -i puppet/modules