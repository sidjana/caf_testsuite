SHELL=/bin/sh
BENCHMARK=ep
BENCHMARKU=EP

include ../config/make.def

OBJS = coreduce.o ep.o ${COMMON}/print_results.o ${COMMON}/${RAND}.o ${COMMON}/timers.o

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${FLINK} ${FLINKFLAGS} -o ${PROGRAM} ${OBJS} ${FMPI_LIB}


ep.o:		ep.f  mpinpb.h npbparams.h
	${FCOMPILE} ep.f

coreduce.o:		coreduce.f90
	${FCOMPILE} coreduce.f90

clean:
	- rm -f *.o *.mod *~ 
	- rm -f npbparams.h core



