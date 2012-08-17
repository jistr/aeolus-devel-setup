#!/bin/bash

# Run this as the user you want to develop with, i.e. whatever
# $dev_username was in conductor-dev-root-prep.sh.

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

set -e

# Setup oauth keys
oauth_json="
{
  \"iwhd\": {
    \"consumer_key\":\"$warehouse_key\",
    \"consumer_secret\":\"$warehouse_secret\"
  },
  \"factory\": {
    \"consumer_key\":\"$factory_key\",
    \"consumer_secret\":\"$factory_secret\"
  }
}
"

su $dev_user -c "echo '$oauth_json' > \"$conductor_dir/src/config/oauth.json\""
