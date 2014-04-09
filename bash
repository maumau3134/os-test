#!/bin/bash
apt-get update -y
apt-get install gitweb wget -y
wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
dpkg -i puppetlabs-release-precise.deb
apt-get update -y
apt-get install puppet-common -y
puppet module install jfryman/nginx --version 0.0.7
puppet module install Slashbunny/phpfpm
git clone https://github.com/maumau3134/os-test.git
cd os-test/
mv default.conf /etc/nginx/sites-available/monsite
cp site.pp /etc/puppet/manifests/
cp node.pp /etc/puppet/manifests/
puppet apply /etc/puppet/manifests/site.pp
cp -r /etc/nginx /etc/nginx-ori
service nginx configtest
service nginx restart
mkdir /var/www
echo '<?php phpinfo(); ?>' > /var/www/index.php
chown www-data. /var/www/index.php
chmod 700 /var/www/index.php
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf-ori

ln -s /etc/nginx/sites-available/monsite /etc/nginx/sites-enabled/
service nginx restart
