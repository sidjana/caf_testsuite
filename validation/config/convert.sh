#! /bin/bash


for cfg in `ls CONFIG*` ; do
  postfix="`echo $cfg | sed 's/CONFIG//g'`"
  sed "s/\"//g" $cfg > tmp1
  sed 's/=/:=/' tmp1 > tmp2
  sed 's/{/(/g' tmp2 > tmp1
  sed 's/}/)/g' tmp1 > make.def$postfix 
  rm tmp1 tmp2
done
