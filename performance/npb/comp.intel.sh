#!/bin/bash

PREV=1

for BM in SP BT 
do
for CLASS in C
do
for NPROCS in 1 4 9 16 
do
sed "s/-coarray-num-images=$PREV /-coarray-num-images=$NPROCS /g" ./config/make.def > ./config/make.def.intel
PREV=$NPROCS
cp ./config/make.def.intel ./config/make.def
make clean
make $BM NPROCS=$NPROCS CLASS=$CLASS 
done
done
done

