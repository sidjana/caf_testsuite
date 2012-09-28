#!/bin/bash

source ../../config/CONFIG

#compile feature  test
COMPILE_OUT=`$FC $FFLAGS -o $1 testmodule.f90 $2 2>./compile_output/$2.log`

if [ "$?" == "0" ]; then
   # feature test passed compilation
   printf '%-10s\t' "PASS"

   #run the feature test
   EXEC_OUT=`perl ../timedexec.pl $TIMEOUT "$LAUNCHER $1" 2>./exec_output/$1.log`

   # check if the feature test passed execution
   if [ "$?" == "4" ]; then
       # feature test failed execution

       # compile the cross test
       COMPILE_CROSS_OUT=`$FC $FFLAGS -DCROSS_ -o $1 testmodule.f90 $2  2>/dev/null`

       # run the cross test
       EXEC_CROSS_OUT=`perl ../timedexec.pl $TIMEOUT "$LAUNCHER $1" 2>/dev/null`

       # check if the cross test passes
       if [ "$?" == "6"  ]; then
         # feature test passed with high confidence
         printf '%s\n' "PASS"

       else
         # feature test passed with low confidence
         printf '%s\n' "PASS_LOW"

       fi

   else
       # feature test failed execution
       printf '%s\n' "FAIL"
       echo $EXEC_OUT
   fi

else
   # feature test failed compilation
   printf '%-10s\t%s\n' "FAIL" "N/A"

fi

