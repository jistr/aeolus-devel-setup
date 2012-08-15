#!/bin/bash

# == USER ==
export dev_user=aedev
export dev_home="/home/$dev_user"


# == RUBY ==
# export ruby_version='1.8.7-p370'
export ruby_version='1.9.3-p194'
export ruby_gems='bundler rake pry'

export use_bundler=true
if [ $using_bundler ] ; then
  export bundler_prefix='bundle exec'
else
  export bundler_prefix=''
fi

export vm_hostname='f16-aeolus'

# == OAUTH ==
export warehouse_key='warehouse_key'
export warehouse_secret='warehouse_secret'
export factory_key='factory_key'
export factory_secret='factory_secret'


# == CONDUCTOR ==
export conductor_postgres_user=aeolus
export conductor_dir="$dev_home/conductor"

# DO NOT CHANGE THE REST OF THE FILE

export RBENV_VERSION="$ruby_version"
