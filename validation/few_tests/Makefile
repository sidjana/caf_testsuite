
include ../config/make.def

FLAGS=$(FFLAGS)
INPUT=
DATE:="$(shell echo "`date +"%m-%d-%y-%T"`")"
ROOT:="$(shell echo "`pwd`")"
LOGFILE:="$(ROOT)/$(shell echo $(DATE) ).log"

header:
	   @ printf '\n%s\n%s\n' "---------------HPC Tools CAF validation testsuite---------------" \
	   				"Evaluating $(COMPILER) @ $(DATE)" | tee -a $(LOGFILE)
	   @ printf '%-20s\t%-80s\t%s\t%s\n\n' "SPEC_IDX" "DESCRIPTION" "COMPILATION" "EXECUTION"  | tee -a $(LOGFILE)

all: test_file
	   @ source ./test_few.sh


clean-log:
	    @rm -rf compile_output/*.log exec_output/*.log

clean-exec:
	    @rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod

clean-history:
	    @rm -rf ./HISTORY/*.log

clean clean-all:  clean-log clean-exec clean-history

