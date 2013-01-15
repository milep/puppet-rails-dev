# Setup for rails development machine

Clone this repo and edit user name in the manifests/site.pp file.

## Server setup (after fresh ubuntu 12.04.1 LTS install)

	sudo su
	apt-get update
	apt-get install puppet git
	exit

As user:

	git clone https://github.com/milep/puppet-rails-dev.git
	cd puppet-rails-dev
	git submodule init
	git submodule update

If you didn't already edit the site.pp, change the user name in there now.
	
	sudo su
	puppet apply -dv --modulepath /home/<user>/puppet/modules/ /home/<user>/puppet/manifests/site.pp

Postgres server_encoding is sql_ascii as default (in ubuntu?). Change it to UTF-8

	sudo su - postgres
	pg_dropcluster --stop 9.1 main
	pg_createcluster --locale=en_US.utf8 --start 9.1 main
        exit

Create database user

	sudo -u postgres createuser <user>
        # Shall the new role be a superuser? (y/n) n
        # Shall the new role be allowed to create databases? (y/n) y
        # Shall the new role be allowed to create more new roles? (y/n) y
	
## Ruby/Rails setup

Logout or reload the environment and check that rbenv is ok

	rbenv versions
	
Should output

	1.9.3-p194
	  
Set it as global ruby version

	rbenv global 1.9.3-p194
	
Confirm that the ruby version is in use

        ruby -v

Should output

        ruby 1.9.3p194 (2012-04-20 revision 35410) [x86_64-linux]

Install Rails

        gem install rails
        rbenv rehash #rehash is required after installing new commands

Create new app

        rails new myapp -d postgresql

Uncomment therubyracer from the Gemfile and run

        bundle install

Change postgres usernames from the config/database.yml and create empty database with command

        rake db:create


Test the rails app by running it

        rails s -p 3030

Nginx server is listening in the port 3000 and the upstream server is configured to the port 3030.

Open your browser to the location: http://<your vm ip>:3000 to see if everything is working.

