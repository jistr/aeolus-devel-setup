#!/bin/bash
#
# Install required libraries, prepare postgres, set up a user for
# aeolus development.  This script should be run as root.

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

os=unsupported
if `grep -qs 'Red Hat Enterprise Linux Server release 6' /etc/redhat-release`; then
  os=rhel6
fi

if `grep -qs -P 'Fedora release 1[67]' /etc/fedora-release`; then
  os=fc
fi

if [ "$os" == "unsupported" ]; then
    echo This script has not been tested outside of RHEL6, FC16 and FC17.
    echo You will need to install development libraries and set up
    echo postgres manually.
    exit 1
fi

# install needed dependencies
yum install -y postgresql-server postgresql postgresql-devel

# set up postgres

# hint: if previous postgres db exists, rm -rf /var/lib/pgsql/data
if [ "$os" == "rhel6" ]; then
  service postgresql initdb
else
  postgresql-setup initdb
fi

echo 'local all all trust' > /var/lib/pgsql/data/pg_hba.conf
echo 'host all all 127.0.0.1/32 trust' >> /var/lib/pgsql/data/pg_hba.conf
echo 'host all all ::1/128 trust' >> /var/lib/pgsql/data/pg_hba.conf

chown postgres.postgres /var/lib/pgsql/data/pg_hba.conf
chmod go-rw /var/lib/pgsql/data/pg_hba.conf

if [ "$os" == "rhel6" ]; then
  service postgresql start
else
  systemctl start postgresql.service
fi

su - postgres -c "psql -c \"CREATE USER $dev_user WITH PASSWORD 'v23zj59an';\""
su - postgres -c "psql -c \"alter user $dev_user CREATEDB;\""

