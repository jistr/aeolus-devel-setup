#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

yum install -y git readline-devel ncurses-devel zlib-devel openssl-devel libffi libffi-devel libxml2 libxml2-devel libxslt libxslt-devel gcc gcc-c++

cd /usr/local
git clone git://github.com/sstephenson/rbenv.git rbenv
mkdir /usr/local/rbenv/plugins
cd /usr/local/rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git ruby-build

zsh_initialization=<<'EOS'
export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
EOS

bashrc='/etc/bashrc'
if [ -f "$bashrc" ] ; then
  echo "$zsh_initialization" >> "$bashrc"
fi

zshenv='/etc/zshenv'
if [ -f "$zshenv" ] ; then
  echo "$zsh_initialization" >> "$zshenv"
fi

