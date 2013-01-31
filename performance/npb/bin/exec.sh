#!/bin/bash

## execute EP
#echo "EP"
#for CLASS in S A B C
#do
#for NPROCS in 32 16 8 4 2 1  
#do
#echo -n "CLASS=$CLASS NPROCS=$NPROCS "
## cafrun -n $NPROCS ./ep.$CLASS.$NPROCS 2>&1 | grep -i seconds
#./ep.$CLASS.$NPROCS --g95 images=$NPROCS 2>&1 | grep -i seconds
#done
#done

## execute SP
#echo "SP"
#for CLASS in  S A B C
#do
#for NPROCS in 9 4 1 
#do
#echo -n "CLASS=$CLASS NPROCS=$NPROCS "
## cafrun -n $NPROCS ./sp.$CLASS.$NPROCS 2>&1 | grep -i seconds
#./sp.$CLASS.$NPROCS --g95 images=$NPROCS 2>&1 | grep -i seconds
#done 
#done

# execute CG
echo "CG"
for CLASS in S A B C
do
for NPROCS in 1 2 4 8 16 
do
echo -n "CLASS=$CLASS NPROCS=$NPROCS "
#cafrun -n $NPROCS ./bt.$CLASS.$NPROCS 2>&1 | grep -i seconds
#./bt.$CLASS.$NPROCS --g95 images=$NPROCS 2>&1 | grep -i seconds
./cg.$CLASS.$NPROCS 2>&1 | grep -i seconds
done 
done
