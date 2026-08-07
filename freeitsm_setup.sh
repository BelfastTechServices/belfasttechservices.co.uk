# freeitsm-site

sudo mkdir /etc/encryption_keys; sudo chown root:www-data -R /etc/encryption_keys; sudo chmod 750 /etc/encryption_keys
php -r "echo bin2hex(random_bytes(32));" > freeitsm.key; sudo mv freeitsm.key /etc/encryption_keys/freeitsm.key
sudo chmod 640 /etc/encryption_keys/freeitsm.key; sudo chown root:www-data /etc/encryption_keys/freeitsm.key
nano bts-site/freeitsm-ssl.conf
sudo cp bts-site/freeitsm-ssl.conf /etc/apache2/sites-available/freeitsm-ssl.conf; sudo a2ensite freeitsm-ssl; sudo service apache2 restart
sudo certbot --apache -d servicedesk.belfasttechservices.co.uk -d www.servicedesk.belfasttechservices.co.uk --agree-tos --no-redirect

sudo mysql -u root
CREATE DATABASE `freeitsm` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'freeitsm'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON `freeitsm` . * TO 'freeitsm'@'localhost';
FLUSH PRIVILEGES;
quit

sudo rm -rf freeitsm /var/www/freeitsm
git clone https://github.com/edmozley/freeitsm.git
sudo cp -r freeitsm /var/www/freeitsm; sudo chown chris:www-data -R /var/www/freeitsm
sudo find /var/www/freeitsm -type d -exec chmod 2750 {} \;
sudo find /var/www/freeitsm -type f -exec chmod 640 {} \;
sudo cp /var/www/freeitsm/db_config.sample.php /etc/freeitsm_db_config.php
sudo chown root:www-data /etc/freeitsm_db_config.php; sudo chmod 640 /etc/freeitsm_db_config.php
sudo nano /etc/freeitsm_db_config.php
sudo nano /var/www/freeitsm/config.php
sudo rm -rf /var/www/freeitsm/setup
