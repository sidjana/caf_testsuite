! Testing for LOCK & UNLOCK with STAT=STAT_LOCKED specifier

      program lock_unlock

        USE, INTRINSIC :: ISO_FORTRAN_ENV

        IMPLICIT NONE
        type(LOCK_TYPE) :: lock_var [*]
        type(LOCK_TYPE), allocatable  :: a_lock_var [:]
        integer :: me, stat_var, err_cnt

        ALLOCATE(a_lock_var [*])

        me = this_image()

        if(NPROCS ==  1) then
          print * , "Config Error: NPROCS should be greater than 1"
        end if

	stat_var=STAT_UNLOCKED

        if (me == 1) then
          LOCK(lock_var, STAT=stat_var)
          if (stat_var == STAT_LOCKED) then
	    print *, "stat_var == STAT_LOCKED: ", me
	  else
            print *, "Error:stat_var /= STAT_LOCKED: ", me
            err_cnt = 1
          end if
          UNLOCK(lock_var, STAT=stat_var)
        end if

	stat_var=STAT_UNLOCKED

        ! ALLOCATABLE LOCK_TYPE
        stat_var = 0

        if (me == 1) then
          LOCK(a_lock_var, STAT=stat_var)
          if (stat_var == STAT_LOCKED) then
	    print *, "stat_var == STAT_LOCKED: ", me
	  else
            print *, "Error:stat_var /= STAT_LOCKED: ", me
            err_cnt = 1
          end if
          UNLOCK(a_lock_var, STAT=stat_var)
        end if

        if (err_cnt == 1) then
          call EXIT(1)
        end if

      end program

