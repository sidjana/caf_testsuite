
include ../../config/make.def

INPUT=

F_TESTS = $(wildcard *.f90)

F_EXES  = $(F_TESTS:.f90=.x)

EXES    = $(F_EXES) $(F_TESTS)

all:    $(EXES)

.SUFFIXES: .x

%.x:    %.f90
	   $(eval COMPILE_STATUS:="UNKNOWN")
	   $(eval EXEC_STATUS:="N/A")
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-20s\t%-80s\t' "$(SPEC_IDX)" "$(DESCRIPTION)"
	   $(eval COMPILE_OUT:=$(shell echo "`$(FC) $(FFLAGS) -o $@ $^ 2>log && echo 2 || echo 3`"))
	   @ cat log
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
		     printf '%-10s\t' "PASS"; \
		 else \
		 	 printf '%-10s\t%s\n' "FAIL" "N/A" ;\
		 fi
	   $(eval EXEC_OUT:=$(shell echo "`perl ../timedexec.pl $(TIMEOUT) $(LAUNCHER)  $@  2>&1 && echo 1 || echo -1`"))
	   @ if [ $(COMPILE_OUT) -eq 2 ]; then \
	   		 if [ "`echo "$(EXEC_OUT)" | grep "\-1"  `"!="" ]; then \
		         printf '%s\n' "PASS" ;\
			 else \
		 		 printf '%s\n' "FAIL" ;\
			 fi   \
	     fi

test:
	@		if [ "$(INPUT)" -eq "1" ];  then echo "Hi"; \
		else  echo "Bye";\
		  fi

foo:
	 $(eval (shell echo "hi" 123 "bye")

clean:
	@rm  -rf *.x

