#!/bin/bash

# navigate to the config file regardless of current working directory
source "`dirname \"$0\"`/../config.sh"

if ! which rbenv &> /dev/null ; then
  echo "Rbenv not found"
  echo "---------------"
  echo "If you didn't restart the shell after rbenv installation, please do so now (so that rcfiles can set environment variables accordingly)."
  echo "If you don't want to restart the shell, source the set_rbenv_shell_vars.sh script into your current shell."
  exit 1
fi

rbenv install "$ruby_version"

# if [[ "$ruby_version" =~ 1\.8\.7 ]] ; then
#   gcc_dir=/usr/local/gcc45
#   echo "Installing GCC 4.5 into $gcc_dir to be able to build Ruby 1.8.7"
#
#   echo "Installing build deps..."
#   yum install -y gcc mpfr-devel libmpc libmpc-devel glibc-devel
#
#   mkdir -p "$gcc_dir/source"
#   cd "$gcc_dir/source"
#
#   echo "Downloading..."
#   wget http://gcc.fyxm.net/releases/gcc-4.5.4/gcc-4.5.4.tar.bz2
#
#   echo "Extracting..."
#   tar -xjf gcc-4.5.4.tar.bz2
#
#   echo "Compiling..."
#   cd "$gcc_dir/source/gcc-4.5.4"
#   ./configure --prefix="$gcc_dir" --program-suffix=45 --enable-languages=c,c++ &&
#   make &&
#   make install
#
#   CC=/usr/local/gcc45/bin/gcc45 rbenv install "$ruby_version"
# else
#   rbenv install "$ruby_version"
# fi

