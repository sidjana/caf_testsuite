#!/bin/bash

PREV=1

for BM in CG 
do
for CLASS in S A B C
do
for NPROCS in 1 2 4 8 16 
do
sed "s/-coarray-num-images=$PREV /-coarray-num-images=$NPROCS /g" ./config/make.def > ./config/make.def.intel
PREV=$NPROCS
cp ./config/make.def.intel ./config/make.def
make clean
make $BM NPROCS=$NPROCS CLASS=$CLASS 
done
done
done

