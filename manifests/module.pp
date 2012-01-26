define apache::module ($ensure='present') {

  include apache::params

  $a2enmod_deps = $operatingsystem ? {
    /RedHat|CentOS|Amazon/ => [
      Package["httpd"],
      File["/etc/httpd/mods-available"],
      File["/etc/httpd/mods-enabled"],
      File["/usr/local/sbin/a2enmod"],
      File["/usr/local/sbin/a2dismod"]
    ],
    /Debian|Ubuntu/ => Package["apache"],
  }

  if $selinux == "true" {
    apache::redhat::selinux {$name: }
  }

  case $ensure {
    'present' : {
      exec { "a2enmod ${name}":
        command => $operatingsystem ? {
          /RedHat|CentOS|Amazon/ => "/usr/local/sbin/a2enmod ${name}",
          default => "/usr/sbin/a2enmod ${name}"
        },
        unless => "[ -e ${apache::params::conf}/mods-enabled/${name}.load ] \\
                   && [ ${apache::params::conf}/mods-enabled/${name}.load -ef ${apache::params::conf}/mods-available/${name}.load ]'",
        require => $a2enmod_deps,
        notify  => Service["apache"],
      }
    }

    'absent': {
      exec { "a2dismod ${name}":
        command => $operatingsystem ? {
          /RedHat|CentOS|Amazon/ => "/usr/local/sbin/a2dismod ${name}",
          /Debian|Ubuntu/ => "/usr/sbin/a2dismod ${name}",
        },
        unless  => "/bin/sh -c '[ -e ${apache::params::conf}/mods-enabled/${name}.load ]'",
        require => $a2enmod_deps,
        notify  => Service["apache"],
       }
    }

    default: { 
      err ( "Unknown ensure value: '${ensure}'" ) 
    }
  }
}
