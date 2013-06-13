# Class: couchpotato::params
#
# This class defines default parameters used by the main module class couchpotato
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to couchpotato class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class couchpotato::params {

  ### Application related parameters

  $path = $::operatingsystem ? {
    default => '/usr/share/couchpotato'
  }

  $user   = 'couchpotato'
  $data_dir = '/var/lib/couchpotato/'
  $port = '5050'

  $enabled = true

}
