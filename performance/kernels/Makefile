#SHELL := /bin/sh

COMPILER ?= uhcaf
TEMP_1:=$(shell cd ../support; ./config2makedef.sh; cd -)  # generate make.def from CONFIG
include ../support/make.def-compiler.$(COMPILER)   # auto-generated


help default: 
	@echo "Usage: make [ compile[_KERNEL]|execute[_KERNEL]|complete[_KERNEL]|cleanall [COMPILER=uhcaf(default)|ifort|g95] ] "
	@echo "Where, KERNEL is one of: buffon_laplace, cg_2d, image_smoothing, insertion_sort, insertion_sort_dt, jacobi, _mm"
	@echo -e "Please ensure:\n The test_suite specific parameters are set in ../support/CONFIG \n The compiler specific parameters in ../support/CONFIG-compiler.<compiler> \n"


complete default: compile execute

compile: compile_buffon_laplace  compile_cg_2d compile_image_smoothing  compile_insertion_sort compile_insertion_sort_dtype compile_jacobi compile_mm

execute: execute_buffon_laplace  execute_cg_2d execute_image_smoothing  execute_insertion_sort execute_insertion_sort_dtype execute_jacobi execute_mm

##################### COMPILATION+EXECUTION ###################
complete_buffon_laplace: compile_buffon_laplace execute_buffon_laplace 

complete_cg_2d: compile_cg_2d execute_cg_2d

complete_image_smoothing: compile_image_smoothing execute_image_smoothing

complete_insertion_sort: compile_insertion_sort execute_insertion_sort

complete_insertion_sort_dtype: compile_insertion_sort_dtype execute_insertion_sort_dtype

complete_jacobi: compile_jacobi execute_jacobi

complete_mm: compile_mm execute_mm


##################### COMPILATION ###################
compile_buffon_laplace:
	@cd src/buffon_laplace; make -s compile COMPILER=$(COMPILER);

compile_cg_2d:
	@cd src/cg_2d; make -s compile COMPILER=$(COMPILER);

compile_image_smoothing:
	@cd src/image_smoothing; make -s compile COMPILER=$(COMPILER)

compile_insertion_sort:
	@cd src/insertion_sort; make -s compile COMPILER=$(COMPILER)

compile_insertion_sort_dtype:
	@cd src/insertion_sort_dtype; make -s compile COMPILER=$(COMPILER)

compile_jacobi: 
	@cd src/jacobi; make -s compile COMPILER=$(COMPILER)

compile_mm:
	@cd src/mm; make -s compile COMPILER=$(COMPILER)

##################### EXECUTION ###################
execute_buffon_laplace: 
	@cd src/buffon_laplace; make -s execute COMPILER=$(COMPILER)

execute_cg_2d: 
	@cd src/cg_2d; make -s execute COMPILER=$(COMPILER)

execute_image_smoothing: 
	@cd src/image_smoothing; make -s execute COMPILER=$(COMPILER)

execute_insertion_sort: 
	@cd src/insertion_sort; make -s execute COMPILER=$(COMPILER)

execute_insertion_sort_dtype: 
	@cd src/insertion_sort_dtype; make -s execute COMPILER=$(COMPILER)

execute_jacobi: 
	@cd src/jacobi; make -s execute COMPILER=$(COMPILER)

execute_mm: 
	@cd src/mm; make -s execute COMPILER=$(COMPILER)

cleanall: 
	@cd src/buffon_laplace; make -s clean
	@cd src/cg_2d; make -s clean
	@cd src/image_smoothing; make -s clean
	@cd src/insertion_sort; make -s clean
	@cd src/insertion_sort_dtype; make -s clean
	@cd src/jacobi; make -s clean
	@cd src/mm; make -s clean
	
