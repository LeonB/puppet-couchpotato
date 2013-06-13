class couchpotato::config {

    # do package before config
    Users::Account[$couchpotato::user] -> Class['couchpotato::package']

    $directory_ensure = $couchpotato::ensure ? { present => directory, default => $couchpotato::ensure }
    $link_ensure = $couchpotato::ensure ? { present => link, default => $couchpotato::ensure }

    users::account { $couchpotato::user:
      ensure     => $couchpotato::ensure,
      uid        => 170,
      # groups   => ['sabnzbdplus'],
      home       => $couchpotato::path,
      managehome => false,
      shell      => '/bin/false',
      comment    => 'couchpotato',
    }

    file { $couchpotato::path:
      ensure  => $directory_ensure,
      force   => $true,
      owner   => $couchpotato::user,
      group   => $couchpotato::user,
      mode    => 0640; # rwx,rx
    }

    nginx::vhost::snippet { 'couchpotato':
      ensure  => $couchpotato::ensure,
      vhost   => 'default',
      content => template('couchpotato/nginx_vhost.erb'),
    }

    file { '/etc/default/couchpotato':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('couchpotato/default/couchpotato.erb'),
    }

    file { "${couchpotato::path}/init/ubuntu":
      mode => '755',
    }

    file { '/etc/init.d/couchpotato':
      ensure => 'link',
      target => "${couchpotato::path}/init/ubuntu",
      require => Class['couchpotato::package'],
    }

    file {
      [
        $couchpotato::data_dir,
        # '/etc/couchpotato/',
      ]:
        ensure  => $directory_ensure,
        owner   => $couchpotato::user,
        group   => $couchpotato::user,
        mode    => '0640', # rw,r
    }

    file { "${couchpotato::path}/.couchpotato/settings.conf":
      ensure  => $couchpotato::ensure,
      content => template('couchpotato/settings.conf.erb'),
      owner   => $couchpotato::user,
      group   => $couchpotato::user,
      mode    => '0640', # rw,r
      require => Class['couchpotato::package'],
      notify  => Class['couchpotato::service'],
    }

    # file { "${couchpotato::data_dir}/config.ini":
    #   ensure  => $link_ensure,
    #   target  => '/etc/couchpotato/config.ini',
    #   require => Class['couchpotato::package'],
    # }

}
