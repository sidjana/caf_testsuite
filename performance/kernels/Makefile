COMPILER ?= uhcaf

help default: ./test_kernels.sh
	@echo "Usage: make [compile|execute|complete|clean] [COMPILER=uhcaf|ifort|g95]"

compile: ./test_kernels.sh
	@./test_kernels.sh compile $(COMPILER)

run: ./test_kernels.sh
	@./test_kernels.sh execute $(COMPILER)

complete all: ./test_kernels.sh
	@./test_kernels.sh  complete $(COMPILER)

.PHONY: clean
clean:
	@rm -rf log regression_op bin