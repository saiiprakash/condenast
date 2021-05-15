#!/bin/bash

secgroupname_tags=$1
region=$2

secgroup_ids=""
tmpresult=""
echo $1
echo $2

for secgroup_tag in $(echo $secgroupname_tags | tr "^^" "\n")
do
#  secgroup_id=`aws ec2 describe-security-groups --region $region --filters Name=group_name,Values=$secgroup_tag --output text --query SecurityGroups[*].GroupId`
 secgroup_id=`aws ec2 describe-security-groups --region $region --filters Name=group-name,Values=$secgroup_tag --output text --query SecurityGroups[*].GroupId`

  secgroup_ids="$secgroup_ids , $secgroup_id"
done

secgroup_ids=`echo $secgroup_ids | sed 's/,//'`
echo "secgroup_ids is $secgroup_ids"

echo $secgroup_ids >> listsecgroupids.lst
