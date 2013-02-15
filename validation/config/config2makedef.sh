#! /bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $ROOT
ROOT=$ROOT/..
config_file="CONFIG"
if [ ! -f CONFIG ]; then
config_file="CONFIG.sample"
fi

#for cfg in `ls CONFIG*` ; do
#  postfix="`echo $config_file | sed 's/CONFIG//g'`"
  sed "s/\"//g" $config_file > tmp1
  sed 's/=/:=/' tmp1 > tmp2
  sed 's/{/(/g' tmp2 > tmp1
  sed 's/}/)/g' tmp1 > tmp2
  sed 's/`//g'  tmp2 > tmp1
  sed "s|pwd/..|$ROOT|g" tmp1 > make.def
  #sed "s|pwd/..|$ROOT|g" tmp1 > make.def$postfix
  rm tmp1 tmp2
#done
cd -

