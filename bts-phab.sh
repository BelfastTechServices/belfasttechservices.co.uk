#Server set up

nano bts-site/bts-phab.conf
sudo cp bts-site/bts-phab.conf /etc/apache2/sites-available/bts-phab.conf; sudo a2ensite bts-phab; sudo service apache2 restart
sudo certbot --apache -d phab.belfasttechservices.co.uk -d www.phab.belfasttechservices.co.uk --agree-tos --renew-by-default --no-redirect

git clone https://we.phorge.it/source/arcanist.git
git clone https://we.phorge.it/source/phorge.git
sudo git config --system --add safe.directory arcanist
sudo git config --system --add safe.directory phorge
sudo cp -r phorge/ /var/www/phorge/; sudo chown www-data -R /var/www
sudo mysql -u root
CREATE USER 'phab'@'localhost' IDENTIFIED WITH caching_sha2_password BY '';
FLUSH PRIVILEGES;
quit
sudo /var/www/phorge/bin/config set mysql.host localhost
sudo /var/www/phorge/bin/config set mysql.user phab
sudo /var/www/phorge/bin/config set mysql.pass ''
sudo /var/www/phorge/bin/storage upgrade
