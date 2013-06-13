class couchpotato::service {

  service { 'couchpotato':
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => Class['couchpotato::package'],
  }
}
