#!/bin/bash

for BM in EP 
do
for CLASS in S A B C
do
for NPROCS in 1 2 4 8 16 32 
do
make clean
make $BM NPROCS=$NPROCS CLASS=$CLASS 
done
done
done

#compile SP, BT
for BM in SP BT 
do
for CLASS in S A B C
do
for NPROCS in 1 4 9 16 
do
make clean
make $BM NPROCS=$NPROCS CLASS=$CLASS 
done
done
done
