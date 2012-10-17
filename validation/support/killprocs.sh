#!/bin/bash

function killprocs {

usrid="`whoami`"
colnum="\$1"
file="`sed 's/.f90//'| sed 's/.x//'`"
echo "ps -u $usrid | awk '/$file/ {print \$1}'"
for proc in  `ps -u $usrid | awk  "/$file/ {print $colnum}"`
do
    echo $proc is dying
    kill $proc
   done

}
