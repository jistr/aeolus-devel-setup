#!/bin/bash

source ../config.sh

if ! which rbenv &> /dev/null ; then
  echo "Rbenv not found"
  echo "---------------"
  echo "If you didn't restart the shell after rbenv installation, please do so now (so that rcfiles can set environment variables accordingly)."
  echo "If you don't want to restart the shell, source the set_rbenv_shell_vars.sh script into your current shell."
  exit 1
fi

rbenv install "$ruby_version"
