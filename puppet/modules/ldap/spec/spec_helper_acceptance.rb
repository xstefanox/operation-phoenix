require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  if hosts.first.is_pe?
    install_pe
  else
    install_puppet
  end
end

UNSUPPORTED_PLATFORMS = ['AIX','windows','Solaris','Suse']

RSpec.configure do |c|
  # Readable test descriptions
  c.color     = true
  c.formatter = :documentation

  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Configure all nodes in nodeset
  c.before :suite do
    puppet_module_install(:source => proj_root, :module_name => 'ldap')
    hosts.each do |host|
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
