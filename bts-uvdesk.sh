sudo mysql -u root
CREATE DATABASE `uvdesk` CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER 'uvdesk'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON `uvdesk` . * TO 'uvdesk'@'localhost';
FLUSH PRIVILEGES;
quit
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
echo $HASH
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer
sudo apt-get install php-{mailparse,imap}
composer create-project uvdesk/community-skeleton uvdesk
sudo cp -r uvdesk/ /var/www/uvdesk; sudo chown www-data -R /var/www
sudo nano /etc/apache2/sites-available/uvdesk-ssl.conf; sudo a2ensite uvdesk-ssl; sudo service apache2 restart
sudo certbot --apache -d uvdesk.belfasttechservices.co.uk -d www.uvdesk.belfasttechservices.co.uk --agree-tos --renew-by-default --no-redirect
