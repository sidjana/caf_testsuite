SHELL=/bin/sh
BENCHMARK=ep
BENCHMARKU=EP

include ../config/make.def

OBJS = ep.o ${COMMON}/print_results.o ${COMMON}/${RAND}.o ${COMMON}/timers.o ${COMMON}/wtime.o

include ../sys/make.common

${PROGRAM}: config ${OBJS}
	${FLINK}  ${FLINKFLAGS} -o ${PROGRAM}  ${OBJS}   ${FMPI_LIB}  


ep.o:		ep.f 
	${UHCAF} -c  ${FFLAGS} ep.f  

#${UHCAF} -c  ${FFLAGS} ep.f # npbparams.h # mpinpb.h 

clean:
	- rm -f *.o *~ 
	- rm -f npbparams.h core



