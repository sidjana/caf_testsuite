
include ../../config/make.def

BIN_PATH:="../bin"
FLAGS="$(FFLAGS)"
TIMEOUT="60"


F_TESTS = $(wildcard *.f90)

F_EXES  = $(F_TESTS:.f90=.x)

EXES    = $(F_EXES)

all:    clean $(EXES)

.SUFFIXES: .x

%.x:    %.f90
	   $(eval COMPILE_STATUS:="UNKNOWN")
	   $(eval EXEC_STATUS:="N/A")
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-20s\t%-80s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   $(eval COMPILE_OUT:=$(shell echo "`$(FC) $(FLAGS) -o $@ testmodule.f90 $^ 2>log && echo 2 || echo 3`"))
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
		     printf '%-10s\t' "PASS"; \
		 else \
		 	 printf '%-10s\t%s\n' "FAIL" "N/A" ;\
		 fi
	   $(eval EXEC_OUT:=$(shell echo "`perl ../timedexec.pl $(TIMEOUT) cafrun -n 4  $@  2>&1 && echo $? || echo 9`"))
	   echo $(EXEC_OUT)
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
	   		 if [ "`echo "$(EXEC_OUT)" | grep "9"  `" == "" ]; then \
		         printf '%s\n' "PASS" ;\
				 mv $@ $(BIN_PATH)/  ; \
			 else \
		 		 printf '%s\n' "FAIL" ;\
			 fi   \
	     fi

clean:
	@rm  -rf  $(BIN_PATH)/*.x   ./*.x  ./*.mod

clean-log:
	@rm -rf compile_output/*.log exec_output/*.log

clean_all: clean clean_log

