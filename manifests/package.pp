class couchpotato::package {

    git::repo { 'couchpotato':
        path   => $couchpotato::path,
        source => 'git://github.com/RuudBurger/CouchPotatoServer.git',
        owner  => $couchpotato::user,
        group  => $couchpotato::user,
        mode   => 0644,
    }

}
