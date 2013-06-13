class couchpotato(
  $path     = params_lookup( 'path' ),
  $user     = params_lookup( 'user' ),
  $data_dir = params_lookup( 'data_dir' ),
  $enabled  = params_lookup( 'enabled' )
  ) inherits couchpotato::params {

  # install php before couchpotato
  Class['python'] -> Class['couchpotato']

    $ensure = $enabled ? {
      true => present,
      false => absent
    }

  include couchpotato::package, couchpotato::config, couchpotato::service
}
