#!/bin/sh

ROOT=`pwd`
TESTS_DIR=$ROOT/
cd $TESTS_DIR

rm  -rf ./regression_op/latest_compile/* ./regression_op/latest_execute/* ./regression_op/history/*  ./log/*  ./bin/*
