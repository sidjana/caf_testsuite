#! /bin/bash

source ../../config/CONFIG
PWD="`pwd`"


for f_tmp in `cat test_file`; do
  echo "f_tmp is $f_tmp"
  file="$ROOT/$f_tmp"
  if [ -f $file ]; then
     $FC $FLAGS -o $file.x $file 2>$LOG_FILE
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
   elif
     printf '%s\n' "$file not found in the specified directory"
   fi

done



