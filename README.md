bts-site
==============

# install

## git instructions

```
sudo rm -rf /var/www/bts-ssl
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
```
