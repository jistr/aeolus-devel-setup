#!/bin/bash
export dev_user=aedev
export dev_home="/home/$dev_username"

export ruby_version='1.8.7-p370'
# export ruby_version='1.9.3-p194'

export source_install_dir="$dev_home"

export use_bundler=true
if [ $using_bundler ] ; then
  export bundler_prefix='bundle exec'
else
  export bundler_prefix=''
fi


export vm_hostname='f16-aeolus'
