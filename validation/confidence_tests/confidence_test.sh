#!/bin/bash

source ../config/CONFIG
EXEC_OUTPUT="${CONF_EXEC_PATH}"
COMPILE_OUTPUT="${CONF_COMPILE_PATH}"

$FC $FFLAGS -o $1 testmodule.o $2 &>$COMPILE_OUTPUT/$2.out
ANS="$?"
if [ "$ANS" == "0" ]; then
   # feature test passed compilation
   printf '%-15s\t' "PASS"  | tee -a $3

   #run the feature test
   perl ../timedexec.pl $TIMEOUT $LAUNCHER $1 $EXEC_OPTIONS &>$EXEC_OUTPUT/$2.out
  # check if the feature test passed execution
   if [ "$?" == "0" ]; then
       # feature test passed execution
       printf '%-15s\t' "PASS"  | tee -a $3

       # compile the cross test
       $FC $FFLAGS_CROSS  -o  $1 testmodule.o $2 &>/dev/null

       # run the cross test
       perl ../timedexec.pl $TIMEOUT $LAUNCHER $1 $EXEC_OPTIONS &>/dev/null

       echo "$?%"
    #   if [ "$?" == "6"  ]; then
    #     # feature test passed with high confidence
    #     printf '%-10s\n' "PASS_HIGH"  | tee -a $3

    #   else
    #     # feature test passed with low confidence
    #     printf '%-10s\n' "PASS_LOW"  | tee -a $3

    #   fi

  elif [ "$ANS" == "4" ]; then
       # feature test timed out
       printf '%-15s\t%-10s\n' "TIMEOUT" "--"  | tee -a $3
  else
       # feature test failed execution
       printf '%-15s\t%-10s\n' "FAIL" "--"  | tee -a $3
  fi

else
   # feature test failed compilation
   printf '%-15s\t%-15s\t%-10s\n' "FAIL" "N/A" "--"  | tee -a $3

fi

