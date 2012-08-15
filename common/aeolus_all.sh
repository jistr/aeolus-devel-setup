#!/bin/bash

# Use this script to install everything *system-wide* (as opposed to using
# bundler) to enable development.  For example, ruby, rails, deltacloud,
# imagefactory, postgres, etc.
#
# Note: this works well for Fedora 16 and 17.  For RHEL 6, some of the
# the dependencies may need to be manually downloaded and installed
# (e.g., rubygem-paranoia)

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

yum install -y postgresql-server postgresql postgresql-devel ruby ruby-devel ruby-rdoc rubygems-devel git libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel gcc gcc-c++ make 

yum install -y aeolus-all

# If you need the ldap_fluff rpm, here is one place it exists for now:
# http://repos.fedorapeople.org/repos/katello/katello/6Server/x86_64/
# e.g.:
# yum install http://repos.fedorapeople.org/repos/katello/katello/6Server/x86_64/rubygem-ldap_fluff-0.1.1-1.git.2.80fbc67.el6.noarch.rpm http://repos.fedorapeople.org/repos/katello/katello/6Server/x86_64/rubygem-net-ldap-0.1.1-2.el6.noarch.rpm
