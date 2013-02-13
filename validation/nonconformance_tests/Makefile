include ../config/make.def

DATE:=$(shell echo "`date +"%m-%d-%y-%T"`")
EXEC_OUTPUT:=$(NONCONF_EXEC_PATH)
COMPILE_OUTPUT:=$(NONCONF_COMPILE_PATH)

LOG_NAME:=$(DATE).log
LOGFILE:=$(NONCONF_LOG_PATH)/$(LOG_NAME)

F_TESTS = $(wildcard *.f90)
F_EXES  = $(F_TESTS:.f90=.x)
EXES    = $(F_EXES)
total_cnt:=0


all:   clean-output header $(EXES) tail
	   @cp $(LOGFILE) ./HISTORY/
	   @mv $(LOGFILE) latest_results.log


.SUFFIXES: .x


header:
	@cd ../ ; $(MAKE) -s  non-conformance-header | tee -a $(LOGFILE)


tail:
	@ printf '\n%s%d\n\n' "TOTAL TESTS=" "`echo $(total_cnt)`" | tee -a $(LOGFILE)
#	@ if [ "$(EMAIL)" == "yes" ]; then \
#		 mutt -s "$(SUBJ)" -a $(LOGFILE) $(EMAIL_LIST) < $(EMAIL_BODY);\
#	  fi



%.x: %.f90
	   $(eval SPEC_IDX:=$(shell echo "`echo "$^"|sed 's/.f90//'| sed 's/*_//'`"))
	   $(eval DESCRIPTION:=$(shell echo "`cat description | grep "$^" | sed s/"$^"//`"))
	   @ printf '%-20s\t%-80s\t' "$(SPEC_IDX)" "$(DESCRIPTION)" | tee -a $(LOGFILE)
	   @ $(FC) $(FFLAGS)  -o $(BIN_PATH)/$@ $^ 2>$(COMPILE_OUTPUT)/$^.out ;\
	     if [ "$$?" == "1" ]; then \
		     printf '%s\t\t' "PASS" | tee -a $(LOGFILE)  ; \
			 perl ../support/timedexec.pl $(TIMEOUT) $(LAUNCHER)  $(BIN_PATH)/$@  2>$(EXEC_OUTPUT)/$@.out ; \
			 if [ "$$?" == "1" ]; then \
			 	printf '%s\n' "PASS" | tee -a $(LOGFILE) ;\
			 else \
			 	printf '%s\n' "FAIL" | tee -a $(LOGFILE) ;\
			 fi \
		 else \
		 	 	printf '%s\t\t%s\n' "FAIL" "N/A" | tee -a $(LOGFILE) ;\
		 fi
	    $(eval total_cnt=$(shell echo $(total_cnt)\+1 | bc))


clean-output:
	    @rm -rf compile_output/*.out exec_output/*.out


clean-exec:
	    @rm  -rf  $(BIN_PATH)/*.x   ./*.mod


clean-history:
	    @rm -rf ./HISTORY/*.log


clean-all:  clean-output clean-exec clean-history
	    @rm -rf uhcaf.keep ./*.log


clean:
	@ printf '%s\n%s\n' "Usage:" "$ $(MAKE) clean-<output | exec | history | all>"



