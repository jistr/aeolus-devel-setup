#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

systemctl stop iptables.service
systemctl disable iptables.service

