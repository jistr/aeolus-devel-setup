#!/bin/bash

# Run this as the user you want to develop with, i.e. whatever
# $dev_username was in conductor-dev-root-prep.sh.

here=`pwd`
WORKDIR="$here/w1"
this_user=`whoami`
using_bundler=yes
if [ "$using_bundler" == "yes" ]; then
  rake_prefix='bundle exec'
else 
  rake_prefix=''
fi

mkdir -p $WORKDIR
cd $WORKDIR
git clone git://github.com/aeolusproject/conductor.git
cd $WORKDIR/conductor
git submodule init
git submodule update


cd $WORKDIR/conductor/src

if [ "$using_bundler" == "yes" ]; then

  # where the gems bundle pulls down will live:
  mkdir -p $WORKDIR/bundler
  
  # only Gemfile (not Gemfile.in) should exist
  if [ -e Gemfile.in ]; then  mv -f Gemfile.in Gemfile; fi

  # pull down the gem dependencies
  bundle install --path $WORKDIR/bundler

else

  # only Gemfile.in (not Gemfile) should exist
  if [ -e Gemfile ]; then  mv -f Gemfile Gemfile.in; fi

fi

# In this example, we use postgres.
cp $WORKDIR/conductor/src/config/database.pg \
 $WORKDIR/conductor/src/config/database.yml
perl -p -i -e "s/username: aeolus/username: $this_user/" \
    $WORKDIR/conductor/src/config/database.yml
# prefix our database names with our username so we don't clash
# with another user (if another user is also doing development)
perl -p -i -e "s/database: (conductor.*\$)/database: ${this_user}_\$1/" \
    $WORKDIR/conductor/src/config/database.yml


# keys for imagefactory
$rake_prefix rake dc:oauth_keys

# create db schema
$rake_prefix rake db:create:all

# answer yes to command below
echo YES | $rake_prefix rake dc:setup

# Precompile some needed stylesheets.
$rake_prefix compass compile

# Start the server
$rake_prefix rails s
