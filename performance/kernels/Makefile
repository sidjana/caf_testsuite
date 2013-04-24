COMPILER ?= uhcaf


help default: ./test_kernels.sh
	@echo "Usage: make [ compile|execute|complete|cleanall [COMPILER=uhcaf(default)|ifort|g95] ] "
	@echo -e "Please ensure:\n The test_suite specific parameters are set in ../support/CONFIG \n The compiler specific parameters in ../support/CONFIG-compiler.<compiler> \n"

compile: ./test_kernels.sh
	@./test_kernels.sh compile $(COMPILER)

run: ./test_kernels.sh
	@./test_kernels.sh execute $(COMPILER)

complete all: ./test_kernels.sh
	@./test_kernels.sh  complete $(COMPILER)


cleanall: ./test_kernels.sh
	@./test_kernels.sh cleanall
