#!/bin/bash

# Libvirtd causes troubles when running in a VM (makes the guest
# unreachable from host). Temporarily disable it until a better solution
# is found.

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

# install libvirt (in case this script is being run before installing Aeolus)
yum install -y libvirt

chkconfig libvirtd off
