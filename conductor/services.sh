#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

chkconfig postgresql on ; service postgresql start
chkconfig deltacloud-core on ; service deltacloud-core start
chkconfig mongod on ; service mongod start
chkconfig iwhd on ; service iwhd start
chkconfig imagefactory on ; service imagefactory start
chkconfig conductor-dbomatic on ; service conductor-dbomatic start
