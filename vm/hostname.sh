#!/bin/bash

source ../config.sh

sed -ri "s/HOSTNAME=.*/HOSTNAME=$vm_hostname/" /etc/sysconfig/network
