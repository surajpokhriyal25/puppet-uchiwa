# == Class uchiwa::service
#
# This class is meant to be called from uchiwa
# It ensure the service is running
#
class uchiwa::service {

  if $uchiwa::manage_services == true {
  if $uchiwa::upstart == true {
    file { '/etc/init/uchiwa.conf':
      content => template('uchiwa/etc/init/uchiwa.conf'),
      owner   => root,
      group   => root,
      mode    => '0644',
    }
    service { $uchiwa::service_name:
      ensure     => running,
      enable     => true,
      provider   => 'upstart',
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init/uchiwa.conf'],
    }
  }
  elsif $uchiwa::upstart == false {
      service { $uchiwa::service_name:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }
   }
  }
}
