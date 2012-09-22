C ***********************************************************
C Fortran file translated from WHIRL Fri Sep 14 15:09:08 2012
C ***********************************************************

	PROGRAM MAIN
	IMPLICIT NONE
C
C	**** Variables and functions ****
C
	TYPE  flds
	  INTEGER(8) el_len
	  INTEGER(4) assoc
	  INTEGER(4) is_coarray
	  INTEGER(4) num_codims
	  INTEGER(4) num_dims
	  INTEGER(8) type_code
	  INTEGER(8) orig_base
	  INTEGER(8) orig_size
	END TYPE
	TYPE  dope_bnd
	  INTEGER(8) lb
	  INTEGER(8) ext
	  INTEGER(8) str_m
	END TYPE
	TYPE  dope
	  INTEGER(8) base
	  TYPE (flds) flds
	  TYPE (dope_bnd) dims(3_8)
	END TYPE
	TYPE (dope) C
	TYPE  dope
	  INTEGER(8) base
	  TYPE (flds) flds
	  TYPE (dope_bnd) dims(3_8)
	END TYPE
	TYPE (dope) D
	INTEGER(8) t$8(2_8)
	INTEGER(8) t$9(2_8)
	TYPE  dope
	  INTEGER(8) base
	  TYPE (flds) flds
	  TYPE (dope_bnd) dims(3_8)
	END TYPE
	TYPE (dope) t$10
	INTEGER(8) alloc0(3_8)
	INTEGER(8) alloc1(3_8)
	
	EXTERNAL DEALLOC
	EXTERNAL ALLOCATE
	EXTERNAL caf_init
	REAL(4) deref___SAVE_COARRAY_MAIN___A_12(3_8, 1_8)
	POINTER(SAVE_COARRAY_MAIN___A_12, deref___SAVE_COARRAY_MAIN___A_12)
	REAL(4) deref___SAVE_COARRAY_MAIN___B_36(3_8, 3_8, 1_8)
	POINTER(SAVE_COARRAY_MAIN___B_36, deref___SAVE_COARRAY_MAIN___B_36)
	EXTERNAL caf_finalize
C
C	**** statements ****
C
	CALL caf_init()
	C%base = 0_8
	C%flds%el_len = 32_8
	C%flds%assoc = 24
	C%flds%is_coarray = 1174405120
	C%flds%type_code = 562962838323200_8
	C%flds%orig_base = 0_8
	C%flds%orig_size = 0_8
	D%base = 0_8
	D%flds%el_len = 32_8
	D%flds%assoc = 24
	D%flds%is_coarray = 704643072
	D%flds%type_code = 562962838323200_8
	D%flds%orig_base = 0_8
	D%flds%orig_size = 0_8
	C%flds%assoc = IOR(IAND(C%flds%assoc, 4294967279), 16)
	C%dims(1)%lb = 1_8
	C%dims(1)%ext = 3_8
	C%dims(1)%str_m = 1_8
	C%dims(2)%lb = 1_8
	C%dims(2)%ext = 3_8
	C%dims(2)%str_m = 3_8
	C%dims(3)%lb = 1_8
	C%dims(3)%ext = 1_8
	C%dims(3)%str_m = 1_8
	t$8(1) = 422212465065985_8
	t$8(2) = %loc(C)
	CALL ALLOCATE(t$8, %val(0))
	D%flds%assoc = IOR(IAND(D%flds%assoc, 4294967279), 16)
	D%dims(1)%lb = 1_8
	D%dims(1)%ext = 3_8
	D%dims(1)%str_m = 1_8
	D%dims(2)%lb = 1_8
	D%dims(2)%ext = 3_8
	D%dims(2)%str_m = 1_8
	D%dims(3)%lb = 1_8
	D%dims(3)%ext = 1_8
	D%dims(3)%str_m = 3_8
	t$9(1) = 422212465065985_8
	t$9(2) = %loc(D)
	CALL ALLOCATE(t$9, %val(0))
	t$10 = C
	CALL SUBR.in.DUMMY(5, deref___SAVE_COARRAY_MAIN___A_12, deref___SAVE_COARRAY_MAIN___B_36, t$10, D)
	alloc0(1) = 422212465065985_8
	alloc0(2) = %loc(D)
	CALL DEALLOC(alloc0, D)
	alloc1(1) = 422212465065985_8
	alloc1(2) = %loc(C)
	CALL DEALLOC(alloc1, C)
	CALL caf_finalize()
	
	CONTAINS

	  SUBROUTINE SUBR.in.DUMMY(N, W, X, Y, Z)
	  IMPLICIT NONE
	  INTEGER(4) N
	  REAL(4) W(t$2, t$2, 1_8)
	  REAL(4) X(1_8, t$2, 1_8)
	  TYPE  flds
	    INTEGER(8) el_len
	    INTEGER(4) assoc
	    INTEGER(4) is_coarray
	    INTEGER(4) num_codims
	    INTEGER(4) num_dims
	    INTEGER(8) type_code
	    INTEGER(8) orig_base
	    INTEGER(8) orig_size
	  END TYPE
	  TYPE  dope_bnd
	    INTEGER(8) lb
	    INTEGER(8) ext
	    INTEGER(8) str_m
	  END TYPE
	  TYPE  dope
	    INTEGER(8) base
	    TYPE (flds) flds
	    TYPE (dope_bnd) dims(3_8)
	  END TYPE
	  TYPE (dope) Y
	  TYPE  dope
	    INTEGER(8) base
	    TYPE (flds) flds
	    TYPE (dope_bnd) dims(3_8)
	  END TYPE
	  TYPE (dope) Z
C
C	  **** Variables and functions ****
C
	  INTEGER(8) t$2
	  INTEGER(8) t$3
	  INTEGER(4) t$4
	  INTEGER(8) t$5
	  INTEGER(8) t$6
	  INTEGER(8) t$7
C
C	  **** statements ****
C
	  t$2 = N
	  t$3 = MAX(t$2, 0_8)
	  t$4 = INT4(MAX(t$2, 0_8))
	  t$5 = t$4
	  t$6 = t$3
	  t$7 = t$3
	  Y%dims(1)%lb = 1_8
	  Y%dims(2)%lb = 1_8
	  Y%flds%is_coarray = IOR(IAND(Y%flds%is_coarray, 3825205247), 67108864)
	  Y%dims(3)%lb = 1_8
	  Y%dims(3)%ext = 1_8
	  Y%dims(3)%str_m = 1_8
	  RETURN
	  END SUBROUTINE
	END

	BLOCK DATA
	IMPLICIT NONE
C
C	**** Variables ****
C
	INTEGER(1) pathscale_compiler(38_8)
	  INTEGER(8) tmp0
C
C	**** statements ****
C
	DATA(pathscale_compiler(tmp0), tmp0 = 1, 37, 1) / 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 /
	END
