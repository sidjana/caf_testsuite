#!/bin/bash


## execute with diff CAF implementations
# UHCAF --  cafrun -n $NPROCS ./sp.$CLASS.$NPROCS 2>&1 | grep -i seconds
# G95 -- ./sp.$CLASS.$NPROCS --g95 images=$NPROCS 2>&1 | grep -i seconds
# Intel -- ./cg.$CLASS.$NPROCS 2>&1 | grep -i seconds


# execute EP
for BM in  ep 
do
for CLASS in  S A B C
do
for NPROCS in 1 2 4 8 16 
do
echo -n "BM=$BM CLASS=$CLASS NPROCS=$NPROCS "
cafrun -n $NPROCS --image-heap=1G ./$BM.$CLASS.$NPROCS 2>&1 | grep -i seconds
done 
done 
done


# execute SP BT
for CLASS in  S A B C
do
for BM in  sp bt 
do
for NPROCS in 1 4 9 16 
do
echo -n "BM=$BM CLASS=$CLASS NPROCS=$NPROCS "
cafrun -n $NPROCS --image-heap=1G ./$BM.$CLASS.$NPROCS 2>&1 | grep -i seconds
done 
done
done
