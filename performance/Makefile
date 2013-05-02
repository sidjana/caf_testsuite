KERNELS_PATH=./kernels
MICROBENCH_PATH=./microbenchmarks
NPB_PATH=./npb
COMPILER?=uhcaf

help default:
	@printf '\n%10s\n' "If test suite is run from within performance directory, then USAGE: $(MAKE) [OPTIONS [COMPILER=uhcaf(default)|ifort|g95] ]"
	@printf '%10s\n' "OPTIONS include:"
	@printf '%-25s\n' "| ( Note: <suite>: [kernels | microbenchmarks | npb | all] )"
	@printf '%-25s%-90s\n' "| "
	@printf '%-25s%-90s\n' "|_ compile_<suite>:" "compiles and generates logs for the codes"
	@printf '%-25s%-90s\n' "|_ run_<suite>:" "executes and generates logs for the codes"
	@printf '%-25s%-90s\n' "|_ complete_<suite>:" "executes and generates logs for the codes"
	@printf '%-25s%-90s\n\n' "|_ clean<suite>:" "cleans up the logs, executables and all previous history of the regression runs"
	@echo -e "Before running the Performance tests, please ensure:\n The test_suite specific parameters are set in ${BENCH_PATH}/../support/CONFIG \n The compiler specific parameters in ${BENCH_PATH}/../support/CONFIG-compiler.<compiler> \n"


compile_performance: compile_performance run_performance

compile_performance compile_all: compile_kernels  compile_microbenchmarks compile_npb

compile_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh compile $(COMPILER);

compile_microbenchmarks:
	@cd $(MICROBENCH_PATH) ; ./test_microbenchmarks.sh compile  $(COMPILER);

compile_npb:
	@cd $(NPB_PATH); ./test_npb.sh compile $(COMPILER);

run_performance run_all: run_kernels  run_microbenchmarks run_npb

run_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh execute $(COMPILER);

run_microbenchmarks:< _performance/all | _kernels | _microbenchmarks | _npb >
	@cd $(MICROBENCH_PATH) ; ./test_microbenchmarks.sh execute  $(COMPILER);

run_npb:
	@cd $(NPB_PATH) ; ./test_npb.sh execute $(COMPILER);

complete_performance complete_all: complete_kernels  complete_microbenchmarks complete_npb

complete_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh complete $(COMPILER);

complete_microbenchmarks:
	@cd $(MICROBENCH_PATH) ; ./test_microbenchmarks.sh complete  $(COMPILER);

complete_npb:
	@cd $(NPB_PATH) ; ./test_npb.sh complete $(COMPILER);



# CLEAN-UP

.PHONY: clean clean_kernels clean_microbenchmarks clean_npb


cleanperformance cleanall: cleankernels cleanmicrobenchmarks cleannpb

cleankernels:
	@cd $(KERNELS_PATH) ;   $(MAKE) -s cleanall

cleanmicrobenchmarks:
	@cd $(MICROBENCH_PATH) ;  $(MAKE) -s cleanall

cleannpb:
	@cd $(NPB_PATH) ;  $(MAKE) -s cleanall
