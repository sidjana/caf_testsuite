#!/bin/sh

## These variables are needed for the output files and for the graphs' naming.
## Please set these variables to their appropiate values.

export BENCH_PATH=$PWD

export BENCH_BINDIR=$BENCH_PATH/bin

export DATA_PATH=$BENCH_PATH/data/output
export CAF_PATH=$DATA_PATH/caf
export INTELCAF_PATH=$DATA_PATH/intelcaf

export DIAGS_PATH=$BENCH_PATH/data/diags
export NITER=100
export CLUSTER=shark #$HRTC_SYSTEM_NAME

# The timer we used for this benchmark supports the following architectures :
#   ARCH_X86
#   ARCH_X86_64
#   ARCH_IA64
#   ARCH_PPC64
#   ARCH_NONE to use gettimeofday instead
export TIMER_ARCH=ARCH_X86_64
