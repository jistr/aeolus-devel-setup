#!/bin/bash

if [[ "${BASH_SOURCE[0]}" == "${0}" ]] ; then
  echo "This script is meant to be sourced, not run in a subshell."
  echo "Source it by running 'source set_rbenv_shell_vars.sh'"
  exit 1
fi

export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"
