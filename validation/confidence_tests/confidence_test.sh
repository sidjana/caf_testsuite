#!/bin/bash

source ../config/CONFIG
EXEC_OUTPUT=$FEATURE_EXEC_PATH
COMPILE_OUTPUT=$FEATURE_COMPILE_PATH
#export total_cnt=0


$FC $FFLAGS -o $BIN_PATH/$1 testmodule.o $2 2>$COMPILE_OUTPUT/$2.log

if [ "$?" == "0" ]; then
   # feature test passed compilation
   printf '%-15s\t' "PASS"  | tee -a $LOGFILE

   #run the feature test
   perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>$EXEC_OUTPUT/$1.log

  # check if the feature test passed execution
   if [ "$?" == "4" ]; then
       # feature test passed execution
       printf '%-15s\t' "PASS"  | tee -a $LOGFILE

       # compile the cross test
       $FC $FFLAGS_CROSS  -o  $BIN_PATH/$1 testmodule.o $2  2>/dev/null

       # run the cross test
       perl ../timedexec.pl $TIMEOUT "$LAUNCHER $BIN_PATH/$1" 2>/dev/null

       # check if the cross test passes
       if [ "$?" == "6"  ]; then
         # feature test passed with high confidence
         printf '%-10s\n' "PASS_HIGH"  | tee -a $LOGFILE

       else
         # feature test passed with low confidence
         printf '%-10s\n' "PASS_LOW"  | tee -a $LOGFILE

       fi

   else
       # feature test failed execution
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $LOGFILE

   fi

else
   # feature test failed compilation
   printf '%-15s\t%15-s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $LOGFILE

fi

