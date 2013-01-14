class common {
  package { "build-essential":
    ensure => present,
  }
  package { "openssh-server":
    ensure => present,
  }
  package { "zlib1g":
    ensure => present,
  }
  package { "git":
    ensure => present,
  }
  package { "curl":
    ensure => present,
  }
  package { "libxml2":
    ensure => present,
  }
  package { "libxml2-dev":
    ensure => present,
  }
  package { "libxslt1-dev":
    ensure => present,
  }
  package { "libreadline6":
    ensure => present,
  }
  package { "libreadline6-dev":
    ensure => present,
  }
  package { "libyaml-dev":
    ensure => present,
  }
  package { "autoconf":
    ensure => present,
  }
  package { "libc6-dev":
    ensure => present,
  }
  package { "ncurses-dev":
    ensure => present,
  }
  package { "automake":
    ensure => present,
  }
  package { "libtool":
    ensure => present,
  }
  package { "bison":
    ensure => present,
  }
  package { "imagemagick":
    ensure => present,
  }
  package { "sendmail":
    ensure => present,
  }
  package { "postgresql-9.1":
    ensure => present,
  }
  package { "libpq-dev":
    ensure => present,
  }

  exec { "apt-get update":
    command => "/usr/bin/apt-get update"
  }
  Exec['apt-get update'] -> Package <| |>
}  
  
