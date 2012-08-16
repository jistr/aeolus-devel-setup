#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

sed -ri "s/HOSTNAME=.*/HOSTNAME=$vm_hostname/" /etc/sysconfig/network
