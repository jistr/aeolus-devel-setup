#!/bin/bash

# This script is for syncing oauth keys in:
#   /etc/iwhd/users.js
#   /etc/imagefactory/imagefactory.conf
#
# Keys in conductor/src/config/oauth.json have to be synced after Conductor
# installation.

set -e

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

# imagefactory/imagefactory.conf
cp /etc/imagefactory/imagefactory.conf /etc/imagefactory/imagefactory.conf.backup
sed -ri "s/\"warehouse_key\": *\"[^\"]*\"/\"warehouse_key\": \"$warehouse_key\"/" /etc/imagefactory/imagefactory.conf
sed -ri "s/\"warehouse_secret\": *\"[^\"]*\"/\"warehouse_secret\": \"$warehouse_secret\"/" /etc/imagefactory/imagefactory.conf
# SED POWER TROLOLO
sed -nri "1h; 1!H; \${ g; s/\"clients\":\s*\{\s*\"[^\"]*\": \"[^\"]*\"/\"clients\": {\n    \"$factory_key\": \"$factory_secret\"/ p }" /etc/imagefactory/imagefactory.conf


# iwhd/users.js

sed -ri "s/\"name\": *\"[^\"]*\"/\"name\": \"$warehouse_key\"/" /etc/iwhd/users.js
sed -ri "s/\"secret\": *\"[^\"]*\"/\"secret\": \"$warehouse_secret\"/" /etc/iwhd/users.js

