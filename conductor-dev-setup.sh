#!/bin/sh

# Run this as the user you want to develop with, i.e. whatever
# $dev_username was in conductor-dev-root-prep.sh.

export here=`pwd`
export WORKDIR="$here/w1"
mkdir -p $WORKDIR
cd $WORKDIR
git clone git://github.com/aeolusproject/conductor.git
cd $WORKDIR/conductor
git submodule init
git submodule update

# where the gems bundle pulls down will live:
mkdir -p $WORKDIR/bundler

# pull down the gem dependencies
cd $WORKDIR/conductor/src
export USE_BUNDLER=yes
bundle install --path $WORKDIR/bundler

# In this example, we use postgres.
cp $WORKDIR/conductor/src/config/database.pg \
 $WORKDIR/conductor/src/config/database.yml

# create db schema
bundle exec rake -v db:create:all
# answer yes to command below
echo YES | bundle exec rake -v dc:setup

# Precompile some needed stylesheets.
bundle exec compass compile

# Start the server
bundle exec rails s
