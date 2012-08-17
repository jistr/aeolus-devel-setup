#!/bin/bash

# Run this as the user you want to develop with, i.e. whatever
# $dev_username was in conductor-dev-root-prep.sh.

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

set -e

# Mkdir and cd to prevent permission errors like "cannot cd back to /root/..."
sudo -u $dev_user mkdir -p "$conductor_dir"
cd "$conductor_dir"


# Clone repo
sudo -u $dev_user git clone git://github.com/aeolusproject/conductor.git "$conductor_dir"
cd "$conductor_dir"
sudo -u $dev_user git submodule init
sudo -u $dev_user git submodule update


# Bundle gems
if [ $use_bundler ]; then
  cd "$conductor_dir/src"

  # where the gems bundle pulls down will live:
  sudo -u $dev_user mkdir -p "$conductor_dir/src/bundle"

  # only Gemfile (not Gemfile.in) should exist
  if [ -e Gemfile.in ]; then sudo -u $dev_user  mv -f Gemfile.in Gemfile; fi

  # pull down the gem dependencies
  sudo -u $dev_user bundle install --path "$conductor_dir/src/bundle"

else
  cd "$conductor_dir/src"

  # only Gemfile.in (not Gemfile) should exist
  if [ -e Gemfile ]; then sudo -u $dev_user  mv -f Gemfile Gemfile.in; fi

fi

# Set up database connection
sudo -u $dev_user cp "$conductor_dir/src/config/database.pg" \
 "$conductor_dir/src/config/database.yml"

if [[ "$conductor_postgres_user" != "aeolus" ]] ; then
  sudo -u $dev_user perl -p -i -e "s/username: aeolus/username: $conductor_postgres_user/" \
      $conductor_dir/src/config/database.yml
  # prefix our database names with our username so we don't clash
  # with another user (if another user is also doing development)
  sudo -u $dev_user perl -p -i -e "s/database: (conductor.*\$)/database: ${conductor_postgres_user}_\$1/" \
      $conductor_dir/src/config/database.yml
fi


cd "$conductor_dir/src"

# Create db schema
sudo -u $dev_user $bundler_prefix rake db:create:all

# Setup the db
echo YES | sudo -u $dev_user $bundler_prefix rake dc:setup

# Precompile some needed stylesheets
sudo -u $dev_user $bundler_prefix compass compile

