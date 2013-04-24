COMPILER ?= uhcaf


help default: ./test_microbenchmarks.sh
	@echo -e "\nUsage: make [ compile|execute|complete|clean|cleanall [COMPILER=uhcaf(default)|ifort|g95] ]"
	@echo " Note: make cleanall : cleans all compilation, execution, and testsuite logs "
	@echo -e "Please ensure:\n The test_suite specific parameters are set in ../support/CONFIG \n The compiler specific parameters in ../support/CONFIG-compiler.<compiler> \n"
	@echo -e "The results of all the microbenchmarks are stored in plottable format in the configured output directory \n"

compile: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh compile $(COMPILER)

run: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh execute $(COMPILER)

complete all: ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh  complete $(COMPILER)


cleanall:  ./test_microbenchmarks.sh
	@./test_microbenchmarks.sh  cleanall
