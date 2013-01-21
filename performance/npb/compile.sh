#!/bin/bash

## Compile EP
#
#make clean
#make EP NPROCS=1 CLASS=S
#
#sed 's/-coarray-num-images=1 /-coarray-num-images=2 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make EP NPROCS=2 CLASS=S
#
#sed 's/-coarray-num-images=2 /-coarray-num-images=4 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make EP NPROCS=4 CLASS=S
#
#sed 's/-coarray-num-images=4 /-coarray-num-images=8 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make EP NPROCS=8 CLASS=S
#
#sed 's/-coarray-num-images=8 /-coarray-num-images=16 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make EP NPROCS=16 CLASS=S
#
#sed 's/-coarray-num-images=16 /-coarray-num-images=1 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#

# Compile SP

make clean
make SP NPROCS=1 CLASS=S

sed 's/-coarray-num-images=1 /-coarray-num-images=4 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make SP NPROCS=4 CLASS=S

sed 's/-coarray-num-images=4 /-coarray-num-images=9 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make SP NPROCS=9 CLASS=S

sed 's/-coarray-num-images=9 /-coarray-num-images=16 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make SP NPROCS=16 CLASS=S

sed 's/-coarray-num-images=16 /-coarray-num-images=1 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def


# Compile BT 

make clean
make BT NPROCS=1 CLASS=S

sed 's/-coarray-num-images=1 /-coarray-num-images=4 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make BT NPROCS=4 CLASS=S

sed 's/-coarray-num-images=4 /-coarray-num-images=9 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make BT NPROCS=9 CLASS=S

sed 's/-coarray-num-images=9 /-coarray-num-images=16 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def
make clean
make BT NPROCS=16 CLASS=S

sed 's/-coarray-num-images=16 /-coarray-num-images=1 /g' ./config/make.def > ./config/make.def.intel
cp ./config/make.def.intel ./config/make.def



## Compile CG 
#
#make clean
#make CG NPROCS=1 CLASS=S
#
#sed 's/-coarray-num-images=2 /-coarray-num-images=2 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make CG NPROCS=2 CLASS=S
#
#sed 's/-coarray-num-images=2 /-coarray-num-images=4 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make CG NPROCS=4 CLASS=S
#
#sed 's/-coarray-num-images=4 /-coarray-num-images=8 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make CG NPROCS=8 CLASS=S
#
#sed 's/-coarray-num-images=8 /-coarray-num-images=16 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
#make clean
#make CG NPROCS=16 CLASS=S
#
#sed 's/-coarray-num-images=16 /-coarray-num-images=1 /g' ./config/make.def > ./config/make.def.intel
#cp ./config/make.def.intel ./config/make.def
