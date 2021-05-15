#!/bin/bash

subnet_tags=$1
region=$2

subnet_ids=""
tmpresult=""
echo $1
echo $2

for subnet_tag in $(echo $subnet_tags | tr "^^" "\n")
do
 #subnet_id=`aws ec2 describe-security-groups --region $region --filters Name=group-name,Values=$secgroup_tag --output text --query SecurityGroups[*].GroupId`
  subnet_id=`aws ec2 describe-subnets --region $region --filters Name=tag:Name,Values=$subnet_tag --output text --query Subnets[*].SubnetId`

  subnet_ids="$subnet_ids , $subnet_id"
done

subnet_ids=`echo $subnet_ids | sed 's/,//'`
echo "subnet_ids is $subnet_ids"

echo $subnet_ids >> listsubnetid.lst
