#!/bin/bash

# Run this as the user you want to develop with, i.e. whatever
# $dev_username was in conductor-dev-root-prep.sh.

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

git clone git://github.com/aeolusproject/conductor.git
cd "$conductor_dir"
git submodule init
git submodule update


if [ $use_bundler ]; then
  cd "$conductor_dir/src"

  # where the gems bundle pulls down will live:
  mkdir -p "$conductor_dir/src/bundle"

  # only Gemfile (not Gemfile.in) should exist
  if [ -e Gemfile.in ]; then  mv -f Gemfile.in Gemfile; fi

  # pull down the gem dependencies
  bundle install --path "$conductor_dir/src/bundle"

else
  cd "$conductor_dir/src"

  # only Gemfile.in (not Gemfile) should exist
  if [ -e Gemfile ]; then  mv -f Gemfile Gemfile.in; fi

fi

# In this example, we use postgres.
cp "$conductor_dir/src/config/database.pg" \
 "$conductor_dir/src/config/database.yml"

if [[ "$aeolus_postgres_user" != "aeolus" ]] ; then
  perl -p -i -e "s/username: aeolus/username: $dev_user/" \
      $conductor_dir/src/config/database.yml
  # prefix our database names with our username so we don't clash
  # with another user (if another user is also doing development)
  perl -p -i -e "s/database: (conductor.*\$)/database: ${dev_user}_\$1/" \
      $conductor_dir/src/config/database.yml
fi


# keys for imagefactory
$bundler_prefix rake dc:oauth_keys

# create db schema
$bundler_prefix rake db:create:all

# answer yes to command below
echo YES | $bundler_prefix rake dc:setup

# Precompile some needed stylesheets.
$bundler_prefix compass compile

# Start the server
$bundler_prefix rails s
