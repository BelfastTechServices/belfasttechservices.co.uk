# bts-wiki

nano bts-site/bts-wiki.conf
sudo cp bts-site/bts-wiki.conf /etc/apache2/sites-available/bts-wiki.conf; sudo a2ensite bts-wiki; sudo service apache2 restart
sudo certbot --apache -d wiki.belfasttechservices.co.uk -d www.wiki.belfasttechservices.co.uk --agree-tos --no-redirect

sudo mysql -u root
CREATE DATABASE `wiki` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'wikiuser'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON `wiki` . * TO 'wikiuser'@'localhost';
FLUSH PRIVILEGES;
quit

sudo rm -rf mediawiki-* /var/www/bts-wiki
wget https://releases.wikimedia.org/mediawiki/1.43/mediawiki-1.43.9.tar.gz; tar -xzvf mediawiki-*.tar.gz
sudo cp -r mediawiki-*/ /var/www/bts-wiki; sudo chown chris:www-data -R /var/www/bts-wiki
# browse to site, run install wizard & generate LocalSettings.php, download file, then add to install & recopy dir to web location
nano mediawiki-1.43.9/LocalSettings.php
sudo rm -rf /var/www/bts-wiki; sudo cp -r mediawiki-*/ /var/www/bts-wiki; sudo chown chris:www-data -R /var/www/bts-wiki
sudo cp -r bts-site/bts/.well-known/ /var/www/bts-wiki/.well-known; sudo chown chris:www-data -R /var/www/bts-wiki
sudo find /var/www/bts-wiki -type d -exec chmod 2750 {} \;
sudo find /var/www/bts-wiki -type f -exec chmod 640 {} \;
sudo chown -R www-data:www-data /var/www/bts-wiki/images
sudo find /var/www/bts-wiki/images -type d -exec chmod 2770 {} \;
