#!/bin/bash

EXEC_OUTPUT=exec_output
COMPILE_OUTPUT=compile_output

TEST=$1
SOURCE=$2
LOGFILE=$3
COMPILER=$4

config_file="../config/CONFIG-validation"
source $config_file
config_file="../config/CONFIG-compiler.${COMPILER}"
source $config_file

$FC $FFLAGS $FFLAGS_VALIDATION_DEFS -o  ../bin/$TEST testmodule.o $SOURCE &> $COMPILE_OUTPUT/$SOURCE.out
ANS="$?"
if [ "$ANS" == "0" ]; then
   # feature test passed compilation
   printf '%-15s\t' "PASS"  | tee -a $LOGFILE

   #run the feature test
   perl ../../support/timedexec.pl $TIMEOUT $LAUNCHER ../bin/$TEST $EXEC_OPTIONS &>$EXEC_OUTPUT/$TEST.out
   ../../support/kill_orphan_procs.sh $TEST
  # check if the feature test passed execution
   if [ "$?" == "0" ]; then
       # feature test passed execution
       printf '%-15s\t' "PASS"  | tee -a $LOGFILE

       # compile the cross test
       $FC $FFLAGS $FFLAGS_CROSSVALIDATION_DEFS  -o  ../bin/$TEST.cross testmodule.o $2 &>/dev/null

       #rm -rf ./tmp ./conf.temp
       # run the cross test
       perl ../../support/timedexec.pl $TIMEOUT $LAUNCHER ../bin//$TEST.cross $EXEC_OPTIONS &>./tmp
       ../../support/kill_orphan_procs.sh $TEST.cross
       RETURN="$?"
       touch ./tmp ./conf.temp

       if [ "$FC" == "g95" ]; then
		echo "`sed -n 's/.*(//;s/).*//p' ./tmp`"%
       else
       		echo `cat conf.temp`
       fi
       #rm -rf ./tmp ./conf.temp

  elif [ "$ANS" == "4" ]; then
       # feature test timed out
       printf '%-15s\t%-10s\n' "TIMEOUT" "--"  | tee -a $LOGFILE
  else
       # feature test failed execution
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $LOGFILE
  fi

else
   # feature test failed compilation
   printf '%-15s\t%-15s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $LOGFILE

fi

rm -rf ./tmp ./conf.temp
