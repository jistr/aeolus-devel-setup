#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

yum install nfs-utils

echo "$dev_home 192.168.122.1(rw,all_squash,anonuid=`id -u $dev_user`,anongid=`id -g $dev_user`)" > /etc/exports

systemctl enable nfs-server.service
systemctl restart  nfs-server.service

exportfs -ra
