#############################################################
# Install Jenkins
#############################################################
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
apt-get update
apt-get -y install jenkins

#############################################################
# Install dependencies
#############################################################
apt-get -y install apache2
a2enmod proxy
a2enmod proxy_http

#############################################################
# Setup Apache proxy
#############################################################
cp /vagrant/VirtualHost/jenkins.conf /etc/apache2/sites-available
a2ensite jenkins.conf
service apache2 restart



#############################################################
# Install Jenkins plugins
#############################################################
apt-get -y install curl
cd /var/lib/jenkins/plugins

curl -OL http://updates.jenkins-ci.org/latest/analysis-core.hpi
curl -OL http://updates.jenkins-ci.org/latest/ccm.hpi
curl -OL http://updates.jenkins-ci.org/latest/checkstyle.hpi
curl -OL http://updates.jenkins-ci.org/latest/cloverphp.hpi
curl -OL http://updates.jenkins-ci.org/latest/dry.hpi
curl -OL http://updates.jenkins-ci.org/latest/git.hpi
curl -OL http://updates.jenkins-ci.org/latest/git-client.hpi
curl -OL http://updates.jenkins-ci.org/latest/jdepend.hpi
curl -OL http://updates.jenkins-ci.org/latest/jshint-checkstyle.hpi
curl -OL http://updates.jenkins-ci.org/latest/plot.hpi
curl -OL http://updates.jenkins-ci.org/latest/pmd.hpi
curl -OL http://updates.jenkins-ci.org/latest/postbuild-task.hpi
curl -OL http://updates.jenkins-ci.org/latest/violations.hpi
curl -OL http://updates.jenkins-ci.org/latest/xunit.hpi

chown -R jenkins:nogroup *

curl -X POST http://jenkins.local/reload
/etc/init.d/jenkins restart

#########
# Install tools for PHP code
#########

apt-get -y install git
apt-get -y install php5

###
wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit

###
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
chmod +x phpcs.phar
sudo mv phpcs.phar /usr/local/bin/phpcs

###
curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
chmod +x phpcbf.phar
sudo mv phpcbf.phar /usr/local/bin/phpcbf

###
wget https://phar.phpunit.de/phploc.phar
chmod +x phploc.phar
sudo mv phploc.phar /usr/local/bin/phploc

###
wget -c http://static.phpmd.org/php/latest/phpmd.phar
chmod +x phpmd.phar
sudo mv phpmd.phar /usr/local/bin/phpmd

###
wget https://phar.phpunit.de/phpcpd.phar
chmod +x phpcpd.phar
sudo mv phpcpd.phar /usr/local/bin/phpcpd










