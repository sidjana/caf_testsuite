#! /bin/bash

source ../../config/CONFIG
PWD="`pwd`"


for file in `cat test_file`; do
  echo "file is $file"
  $FC $FFLAGS -DNPROCS=4  -o $BIN_PATH/$file.x $ROOT/$file
     if [ "$?" == "0" ]; then
          printf '%s\t\t' "PASS" | tee -a $LOGFILE
          perl ../timedexec.pl $TIMEOUT $LAUNCHER  $BIN_PATH/$file.x  2>$EXEC_OUTPUT/$file.out
          if [ "$?" == "0" ]; then
             printf '%s\n' "PASS" | tee -a $LOGFILE
          else
             printf '%s\n' "FAIL" | tee -a $LOGFILE
          fi
     else
          printf '%s\t\t%s\n' "FAIL" "N/A" | tee -a $LOGFILE
     fi
done



