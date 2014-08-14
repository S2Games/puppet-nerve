# == Class nerve::service
#
# This class is meant to be called from nerve
# It ensure the service is running
#
class nerve::service {
  $config_file = $nerve::config_file

  case $::osfamily {
    'Debian','RedHat','Amazon': {
      case $nerve::service_upstart {
        true,'true': {
          file { '/etc/init/nerve.conf':
            owner   => 'root',
            group   => 'root',
            mode    => 0444,
            content => template('nerve/nerve.conf.upstart.erb'),
          }
        }
        default: {
          file { '/etc/init.d/nerve' :
            ensure  => present,
            owner   => 'root',
            group   => 'root',
            mode    => '0744',
            content => template('nerve/nerve.init.erb'),
          }
        }
      }
    }
    default: {
      fail("no supported service script for ${::operatingsystem}")
    }
  }

  service { 'nerve':
    ensure     => $nerve::service_ensure,
    enable     => $nerve::service_enable,
    hasstatus  => true,
    hasrestart => true,
  }
}
