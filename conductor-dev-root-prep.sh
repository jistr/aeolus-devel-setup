#!/bin/bash
#
# Install required libraries, prepare postgres, set up a user for
# aeolus development.  This script should be run as root.

# change this to the system user you are going to use for development
dev_username=test

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
yum install -y postgresql-server postgresql postgresql-devel ruby ruby-devel ruby-rdoc git libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel gcc gcc-c++ 

# install gem and bundler if we need to
which gem >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Downloading and installing gem and bundler"

  mkdir -p /tmp/gem-install
  cd /tmp/gem-install
  wget http://production.cf.rubygems.org/rubygems/rubygems-1.8.24.tgz
  tar -xzf rubygems-1.8.24.tgz
  cd rubygems*
  ruby setup.rb
  
fi
which bundle >/dev/null 2>&1
if [ $? -ne 0 ]; then
  # install bundler
  gem install bundler
fi

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

su - postgres -c "psql -c \"CREATE USER $dev_username WITH PASSWORD 'v23zj59an';\""
su - postgres -c "psql -c \"alter user $dev_username CREATEDB;\""

if [ "$dev_username" == "aeolus" ]; then
  # add aeolus user and group if needed (need to cp -r /etc/skel to avoid
  # selinux issue)
  cp -r /etc/skel /usr/share/aeolus-conductor
  /usr/sbin/groupadd -g 180 -r aeolus 2>/dev/null
  /usr/sbin/useradd -u 180 -g aeolus -m -d /usr/share/aeolus-conductor aeolus 2>/dev/null
  chown aeolus:aeolus /usr/share/aeolus-conductor 
else
  useradd $dev_username 2>/dev/null
fi
