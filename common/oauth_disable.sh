#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

sed -ri "s/^OPTIONS=\"--rest --debug\"/OPTIONS=\"--rest --debug --no_oauth\"/" /etc/sysconfig/imagefactory
