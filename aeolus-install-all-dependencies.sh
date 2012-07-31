#!/bin/sh

# Use this script to install everything *system-wide* (as opposed to using
# bundler) to enable development.  For example, ruby, rails, deltacloud,
# imagefactory, postgres, etc.
#
# Note: this works well for Fedora 16 and 17.  For RHEL 6, some of the
# the dependencies may need to be manually downloaded and installed
# (e.g., rubygem-paranoia)

yum install -y postgresql-server postgresql postgresql-devel ruby ruby-devel ruby-rdoc rubygems-devel git libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel gcc gcc-c++ make 

# The following list created from 
# grep Requires aeolus-conductor.spec | grep -v aeolus | grep -v 'Requires(' | grep -v '%' | perl -p -e 's/^(Build)?Requires\: (.*)$/$2/' | perl -p -e "s/^(.*)\$/\'\$1\' \\\\/" | sort
for i in 'curl' \
'deltacloud-core' \
'deltacloud-core-ec2' \
'deltacloud-core-rhevm' \
'deltacloud-core-vsphere' \
'httpd >= 2.0' \
'imagefactory' \
'imagefactory-jeosconf-ec2-fedora' \
'imagefactory-jeosconf-ec2-rhel' \
'iwhd' \
'mod_ssl' \
'mongodb-server' \
'ntp' \
'postgresql' \
'postgresql-server' \
'rsyslog-relp' \
'rubygem(builder)' \
'rubygem(capybara) >= 1.0.0' \
'rubygem(compass) >= 0.11.5' \
'rubygem(compass) >= 0.11.5' \
'rubygem(compass-960-plugin) >= 0.10.4' \
'rubygem(compass-960-plugin) >= 0.10.4' \
'rubygem(cucumber)' \
'rubygem(cucumber-rails)' \
'rubygem(database_cleaner) >= 0.5.0' \
'rubygem(delayed_job) >= 2.1.4' \
'rubygem(deltacloud-client) >= 0.4.0' \
'rubygem(factory_girl)' \
'rubygem(factory_girl_rails)' \
'rubygem(fastercsv)' \
'rubygem(haml) >= 3.1' \
'rubygem(json)' \
'rubygem(launchy)' \
'rubygem(minitest)' \
'rubygem(mustache) >= 0.99.4' \
'rubygem(net-ldap)' \
'rubygem(nokogiri) >= 1.4.0' \
'rubygem(oauth)' \
'rubygem(paranoia)' \
'rubygem(pg)' \
'rubygem(rack-restful_submit)' \
'rubygem(rails) >= 3.0.7' \
'rubygem(rails_warden)' \
'rubygem(rake)' \
'rubygem(rest-client) >= 1.6.1' \
'rubygem(rspec-rails) >= 2.6.1' \
'rubygem(ruby-net-ldap)' \
'rubygem(ruby-net-ldap)' \
'rubygem(sass)' \
'rubygem(simple-navigation)' \
'rubygem(thin) >= 1.2.5' \
'rubygem(timecop)' \
'rubygem(uuidtools)' \
'rubygem(vcr)' \
'rubygem(webmock)' \
'rubygem(will_paginate) >= 3.0' \
'systemd-units' \
'system-logos'; do
 yum -y install "$i"
done
