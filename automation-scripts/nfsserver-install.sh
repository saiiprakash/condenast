#!/bin/bash
yum install unzip -y
yum install wget -y
NFSSERVER_APP_HOME_PATH="/usr/share/devops/"
ANSIBLE_MASTER_VM_FILE="/usr/share/devops/masterVM.yml"

rm -rf $NFSSERVER_APP_HOME_PATH  && mkdir -p $NFSSERVER_APP_HOME_PATH
cd $NFSSERVER_APP_HOME_PATH

#enable redhat EPEL
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
rpm -ivh epel-release-7-5.noarch.rpm

#install aws cli
curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
sleep 120
unzip awscli-bundle.zip
./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

#install Ansible
yum install ansible -y

#ansible script to disable host key checking
#sudo ansible-playbook -i "localhost," -c local $ANSIBLE_MASTER_VM_FILE
sed  's/^#host_key_checking*/host_key_checking/' -i /etc/ansible/ansible.cfg

#install git
yum install git -y

#install nfs server related packages
yum install nfs-utils nfs-utils-lib rpcbind -y

#create directory which will be shared from nfs server
mkdir -p /opt/nfs

#giving access to all nfs client
echo "/opt/nfs *(rw,async,no_root_squash)" > /etc/exports
exportfs -a

#start the nfs server related services
service rpcbind restart
service nfs restart
service nfs status
