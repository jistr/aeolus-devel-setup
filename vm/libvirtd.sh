#!/bin/bash

# Libvirtd causes troubles when running in a VM (makes the guest
# unreachable from host). Temporarily disable it until a better solution
# is found.

source ../config.sh

chkconfig libvirtd off
