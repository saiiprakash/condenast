#!/bin/bash
yum install unzip -y
yum install wget -y
JENKINS_APP_HOME_PATH="/usr/share/devops/"

rm -rf $JENKINS_APP_HOME_PATH  && mkdir -p $JENKINS_APP_HOME_PATH

cd $JENKINS_APP_HOME_PATH
wget https://s3-us-west-1.amazonaws.com/jenkins-redhat-install-scripts/jenkins-redhat-install-scripts.zip
unzip jenkins-redhat-install-scripts.zip
#cd jenkins-redhat-install-scripts && 
chmod +x jenkin-setup-create.sh && ./jenkin-setup-create.sh
