# == Class nerve::params
#
# This class is meant to be called from nerve
# It sets variables according to platform
#
class nerve::params {
  case $::osfamily {
    'Debian','RedHat','Amazon': {
      $package_name     = undef
      $package_provider = undef
      $service_ensure   = 'running'
      $service_enable   = true
      $service_upstart  = false
      $config_file      = '/etc/nerve/nerve.conf.json'
      $config_dir       = '/etc/nerve/conf.d/'
      $purge_config     = true
      $instance_id      = $::fqdn
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
