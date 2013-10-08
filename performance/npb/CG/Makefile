SHELL=/bin/sh
BENCHMARK=cg
BENCHMARKU=CG

include ../config/make.def

OBJS = cg.o cg_coarrays.o ${COMMON}/caf_print_results.o  \
       ${COMMON}/${RAND}.o ${COMMON}/timers.o ${COMMON}/wtime.o

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${CAFLINK} ${CAFLINKFLAGS} -o ${PROGRAM} ${OBJS}

cg.o: cg_coarrays.o cg.f
	${CAFCOMPILE} cg.f

cg_coarrays.o:	cg_coarrays.f
	${CAFCOMPILE} cg_coarrays.f

clean:
	- rm -f *.o *~  *.mod *.B *.I *.s
	- rm -f npbparams.h core

