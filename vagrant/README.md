#Vagrant Ubuntu Jenkins build

Build Jenkins server on Ubuntu 12.04 using Vagrant.

Install Vagrant and VirtualBox.

Add the following line to your host's hosts file:

	127.0.0.1	jenkins.local

Then, once built, access the Jenkins server using

	http://jenkins.local:8082

To build

	vagrant up

