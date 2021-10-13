# Koha Installation #

Attempting to install [Koha 21.05](https://wiki.koha-community.org/wiki/System_requirements_and_recommendations#Koha_21.05) in [Vagrant](https://vagrantup.com)

1. Initialize the vagrant file

	``` sh
	vagrant init bento/ubuntu-20.04' --box-version=202107.28.0
	```

2. Start the VM

	``` sh
	vagrant up
	```

3. Following instructions from https://wiki.koha-community.org/wiki/Debian. Setup package sources
   
   ``` sh
   apt-get update
   apt-get -y install sudo wget gnupg
   wget -q -O- https://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -
   apt-get update
   ```

4. Add new repository and update

	``` sh
	echo 'deb http://debian.koha-community.org/koha stable main' | sudo tee /etc/apt/sources.list.d/koha.list
	apt-get update
	```


5. Install MariaDB Server

	``` sh
	apt-get install -y mariadb-server
	```

6. Install Apache

	``` sh
	apt-get install -y apache2
	a2enmod headers proxy_http rewrite cgi

	```

7. Install Koha

	``` sh
	apt-get install -y koha-common
	```

8. Create database

	``` sh
	sudo koha-create --create-db my-library
	```

9. Enable plack

	``` sh
	sudo koha-plack --enable my-library
	sudo koha-plack --start my-library
	```

10. Restart apache

	``` sh
	sudo service apache2 restart
	```

## Run in Docker ##

From https://hub.docker.com/r/digibib/koha

``` sh
docker run -d --name koha \
    -p 6001:6001 \
	-p 8080:8080 \
	-p 8081:8081 \
    -e KOHA_INSTANCE=my-library \
    -e KOHA_ADMINUSER=admin \
    -e KOHA_ADMINPASS=admin \
    -e SIP_WORKERS=3 \
    -e SIP_AUTOUSER1=sipuser \
    -e SIP_AUTOPASS1=sipuser \
    -t digibib/koha:2021-08-27.hotfix.b1
```
