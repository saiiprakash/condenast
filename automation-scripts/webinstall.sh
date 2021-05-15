#!/bin/bash
apt-get update

apt-get install openjdk-7-jdk -y
apt-get install tomcat7 -y
apt-get install unzip -y
apt-get install apache2 -y
apt-get install libapache2-mod-jk -y

APP_HOME_PATH="/usr/share/devops/"

sudo rm -rf $APP_HOME_PATH  && mkdir -p $APP_HOME_PATH

cd $APP_HOME_PATH
wget https://s3-us-west-1.amazonaws.com/s3-grasscrm/s3-grass.zip
unzip s3-grass.zip

chmod +x autoscalingScalrAppInstall.sh
./autoscalingScalrAppInstall.sh

mv /var/lib/tomcat7/conf/server.xml /var/lib/tomcat7/conf/server-original.xml
cp server.xml /var/lib/tomcat7/conf/
sudo chown tomcat7:tomcat7 /var/lib/tomcat7/conf/server.xml

cp grass.war /var/lib/tomcat7/webapps/

#cp workers.properties /etc/apache2/

mv /etc/libapache2-mod-jk/workers.properties /etc/libapache2-mod-jk/workers.properties-original
cp workers.properties /etc/libapache2-mod-jk/

rm /etc/apache2/sites-enabled/000-default.conf
mv 000-default.conf /etc/apache2/sites-enabled/

sudo service tomcat7 restart
sudo service apache2 restart

#nfs client installation
sudo apt-get update
sudo apt-get install nfs-common -y

#now create nfs directory mount point
sudo mkdir -p /mnt/nfs/home
sudo mkdir -p /mnt/nfs/var/nfsshare

mount -t nfs {{nfs_server_ip}}:/home /mnt/nfs/home/
mount -t nfs {{nfs_server_ip}}:/home /mnt/nfs/var/nfsshare/
mount -t nfs
