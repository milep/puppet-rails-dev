include common

file {'/etc/nginx/conf':
  ensure => "directory"
}

node default {
  class {'nginx': }
  nginx::resource::upstream { 'unicorn_server_dev':
    ensure  => present,
    members => [
      'localhost:3030 fail_timeout=0'
      ]
  }
  nginx::resource::vhost { 'unicorn.dev':
    ensure   => present,
    server_name => ['_'],
    proxy  => 'http://unicorn_server_dev',
    listen_port => '3000',
  }
  nginx::resource::upstream { 'unicorn_server_prod':
    ensure  => present,
    members => [
      'localhost:4030 fail_timeout=0'
      ]
  }
  nginx::resource::vhost { 'unicorn.prod':
    ensure   => present,
    server_name => ['_'],
    www_root => '/home/milep/rails_app/public',
    try_files => ['$uri', '$uri/index.html', '@unicorn'],
    location => '@unicorn',
    proxy  => 'http://unicorn_server_prod',
    listen_port => '80',
  }
  $my_config = {
    'expires' => 'max',
  }
  nginx::resource::location { 'unicorn.prod.assets':
    location            => '~ ^/(assets)/',
    www_root => '/home/milep/rails_app/public',
    vhost               => 'unicorn.prod',
    index_files => ['index'],
    location_cfg_append => $my_config,
  }

}

rbenv::install { "milep":
}

rbenv::compile { "1.9.3-p194":
  user => "milep",
}
