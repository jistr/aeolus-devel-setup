#!/bin/bash

source ../config.sh

if [ "$dev_user" == "aeolus" ]; then
  # add aeolus user and group if needed (need to cp -r /etc/skel to avoid
  # selinux issue)
  cp -r /etc/skel /usr/share/aeolus-conductor
  /usr/sbin/groupadd -g 180 -r aeolus 2>/dev/null
  /usr/sbin/useradd -u 180 -g aeolus -m -d /usr/share/aeolus-conductor aeolus 2>/dev/null
  chown aeolus:aeolus /usr/share/aeolus-conductor 
else
  useradd $dev_user 2>/dev/null
fi
