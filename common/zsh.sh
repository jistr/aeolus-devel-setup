#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

yum install -y zsh
