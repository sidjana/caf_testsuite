KERNELS_PATH=./kernels
MICROBENCH_PATH=./microbenchmarks
NPB_PATH=./npb
COMPILER?=uhcaf

help default:
	@printf '%10s\n' " For CAF-performance test suite:"
	@printf '\n%10s\n' " Usage: $(MAKE) [OPTIONS] [COMPILER=uhcaf|ifort|g95]"
	@printf '%10s\n' " OPTIONS include:"
	@printf '%-20s%-90s\n' " |_ compile_<suite>:" "compiles and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ run_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ complete_<suite>:" "executes and generates logs for the codes"
	@printf '%-20s%-90s\n' " |_ clean_<suite>:" "cleans up the logs, executables and all previous history of the regression runs"
	@printf '%-20s%-90s\n' " |_ <suite>:" "[kernels | microbenchmarks | npb | all]"
	@printf '%-20s%-90s\n\n' " |_ help:" " displays this message"
	@printf '%-20s\n' " COMPILER set to uhcaf by default"


compile_performance: compile_performance run_performance

compile_performance: compile_kernels  compile_microbenchmarks compile_npb

compile_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh compile $(COMPILER);

compile_microbenchmarks:
	@cd $(MICROBENCH_PATH) ; source ./test_microbenchmarks.sh compile;

compile_npb:
	@cd $(NPB_PATH); source ./test_npb.sh compile $(COMPILER);

run_performance: run_kernels  run_microbenchmarks run_npb

run_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh execute $(COMPILER);

run_microbenchmarks:
	@cd $(MICROBENCH_PATH) ; source ./test_microbenchmarks.sh execute;

run_npb:
	@cd $(NPB_PATH) ; source ./test_npb.sh execute $(COMPILER);

complete_performance all: complete_kernels  complete_microbenchmarks complete_npb

complete_kernels:
	@cd $(KERNELS_PATH) ; ./test_kernels.sh complete $(COMPILER);

complete_microbenchmarks:
	@cd $(MICROBENCH_PATH) ; source ./test_microbenchmarks.sh complete;

complete_npb:
	@cd $(NPB_PATH) ; source test_npb.sh complete $(COMPILER);



# CLEAN-UP 

.PHONY: clean clean_kernels clean_microbenchmarks clean_npb 

clean:
	@echo "USAGE: $(MAKE) clean_<type>" 
	@echo "where type = <performance/all | kernels | microbenchmarks | npb>"

clean_performance clean_all: clean_kernels clean_microbenchmarks clean_npb

clean_kernels:
	@cd $(KERNELS_PATH) ;   $(MAKE) veryclean

clean_microbenchmarks:
	@cd $(MICROBENCH_PATH) ;  $(MAKE) veryclean 

clean_npb:
	@cd $(NPB_PATH) ;  $(MAKE) veryclean

