bts-site
==============

# install

## git instructions

```
sudo rm -rf bts-site /var/www/bts-ssl
```

### git url

```
eval $(ssh-agent -s); ssh-add .ssh/github_ed25519
git clone git@github.com:BelfastTechServices/bts-site.git
sudo cp -r bts-site/bts/ /var/www/bts-ssl; sudo chown chris:www-data -R /var/www/bts-ssl
```

# Setup - multiple domains/ssl sites

```
nano bts-site/bts-ssl.conf
sudo cp bts-site/bts-ssl.conf /etc/apache2/sites-available/bts-ssl.conf; sudo a2ensite bts-ssl; sudo service apache2 restart
sudo certbot --apache -d belfasttechservices.co.uk -d www.belfasttechservices.co.uk --agree-tos --no-redirect
```

## set up MySQL database

```
sudo mysql -u root
CREATE DATABASE `bts-site` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'bts-site'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON `bts-site` . * TO 'bts-site'@'localhost';
FLUSH PRIVILEGES;
quit
```

## wget instructions

```
sudo rm -rf latest.tar.gz wordpress /var/www/bts-ssl
wget https://wordpress.org/latest.tar.gz; tar -xzvf latest.tar.gz; rm latest.tar.gz
nano wordpress/wp-config-sample.php; cp wordpress/wp-config-sample.php wordpress/wp-config.php
sudo cp -r wordpress/ /var/www/bts-ssl; sudo chown www-data:www-data -R /var/www/bts-ssl
git clone https://github.com/psignoret/aad-sso-wordpress.git
sudo cp -r aad-sso-wordpress/ /var/www/bts-ssl/wp-content/plugins/
sudo cp -r bts-site/bts/atlassian-domain-verification-4b0j94cc-a885-101k-653k-c9adc33a230a.html /var/www/bts-ssl/atlassian-domain-verification-4b0j94cc-a885-101k-653k-c9adc33a230a.html
sudo cp -r bts-site/bts/.well-known/ /var/www/bts-ssl/.well-known
sudo chown www-data:www-data -R /var/www/bts-ssl
sudo find /var/www/bts-ssl -type d -exec chmod 2770 {} \;
sudo find /var/www/bts-ssl -type f -exec chmod 660 {} \;
# re-tighten wp-config.php: updater never writes it, and it holds DB creds
sudo chown chris:www-data /var/www/bts-ssl/wp-config.php; sudo chmod 640 /var/www/bts-ssl/wp-config.php
```
