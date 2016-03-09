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

apt-get -y install git


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

