bts-site
==============

# install

## git instructions

```
sudo rm -rf bts-site /var/www/bts-ssl
```

### git url

```
eval $(ssh-agent -s); ssh-add .ssh/github_rsa
git clone git@github.com:BelfastTechServices/bts-site.git
sudo cp -r bts-site/bts/ /var/www/bts-ssl; sudo chown www-data -R /var/www
```

# Setup - multiple domains/ssl sites

```
nano bts-site/bts-ssl.conf
sudo cp bts-site/bts-ssl.conf /etc/apache2/sites-available/bts-ssl.conf; sudo a2ensite bts-ssl; sudo service apache2 restart
sudo certbot --apache -d belfasttechservices.co.uk -d www.belfasttechservices.co.uk --agree-tos --renew-by-default --no-redirect
nano bts-site/bts-wiki.conf
sudo cp bts-site/bts-wiki.conf /etc/apache2/sites-available/bts-wiki.conf; sudo a2ensite bts-wiki; sudo service apache2 restart
sudo certbot --apache -d wiki.belfasttechservices.co.uk -d www.wiki.belfasttechservices.co.uk --agree-tos --renew-by-default --no-redirect
```

## set up MySQL database

```
sudo mysql -u root
CREATE DATABASE `bts-site` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'bts-site'@'localhost' IDENTIFIED WITH caching_sha2_password BY '';
GRANT ALL PRIVILEGES ON `bts-site` . * TO 'bts-site'@'localhost';
CREATE DATABASE `wiki` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'wikiuser'@'localhost' IDENTIFIED WITH caching_sha2_password BY '';
GRANT ALL PRIVILEGES ON `wiki` . * TO 'wikiuser'@'localhost';
FLUSH PRIVILEGES;
quit
```

## wget instructions

```
sudo rm -rf latest.tar.gz wordpress /var/www/bts-ssl
wget https://wordpress.org/latest.tar.gz; tar -xzvf latest.tar.gz; rm latest.tar.gz
nano wordpress/wp-config-sample.php; cp wordpress/wp-config-sample.php wordpress/wp-config.php
sudo cp -r wordpress/ /var/www/bts-ssl; sudo chown www-data -R /var/www
sudo cp -r bts-site/bts/.well-known/ /var/www/bts-ssl/.well-known; sudo chown www-data -R /var/www
git clone https://github.com/psignoret/aad-sso-wordpress.git
sudo cp -r aad-sso-wordpress/ /var/www/bts-ssl/wp-content/plugins/
sudo rm -rf mediawiki-* /var/www/bts-wiki
wget https://releases.wikimedia.org/mediawiki/1.43/mediawiki-1.43.3.tar.gz; tar -xzvf mediawiki-*.tar.gz
sudo cp -r mediawiki-*/ /var/www/bts-wiki; sudo chown www-data -R /var/www
# browse to site, run install wizard & generate LocalSettings.php, download file, then add to install & recopy dir to web location
nano mediawiki-1.43.3/LocalSettings.php
sudo rm -rf /var/www/bts-wiki; sudo cp -r mediawiki-*/ /var/www/bts-wiki; sudo chown www-data -R /var/www
sudo cp -r bts-site/bts/.well-known/ /var/www/bts-wiki/.well-known; sudo chown www-data -R /var/www
```
