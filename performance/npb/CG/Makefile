SHELL=/bin/sh
BENCHMARK=cg
BENCHMARKU=CG

include ../config/make.def

 OBJS = cg.o ${COMMON}/print_results.o  \
       ${COMMON}/${RAND}.o ${COMMON}/timers.o
 
include ../sys/make.common

${PROGRAM}: config ${OBJS} 
	${FLINK}  ${OBJS}   ${FLINKFLAGS} -o ${PROGRAM}  

cg.o:	cg.f  mpinpb.h npbparams.h
	${UHCAF} --layer=armci cg.f mpinpb.h npbparams.h -c  ${FFLAGS}

clean:
	- rm -f *.o *~ 
	- rm -f npbparams.h core



