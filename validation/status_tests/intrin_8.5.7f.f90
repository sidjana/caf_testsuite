! Testing for LOCK & UNLOCK with STAT=STAT_UNLOCKED specifier

      program lock_unlock

         USE, INTRINSIC :: ISO_FORTRAN_ENV

         IMPLICIT NONE
         type(LOCK_TYPE) :: lock_var [*]
         type(LOCK_TYPE), allocatable  :: a_lock_var [:]
         integer :: me, stat_var, err_cnt, i

        ALLOCATE(a_lock_var [*])

        me = this_image()

        if(NPROCS ==  1) then
          print * , "Config Error: NPROCS should be greater than 1"
        end if

        stat_var = STAT_LOCKED
	LOCK(lock_var[1])
        UNLOCK(lock_var[1], STAT=stat_var)
        if (stat_var == STAT_UNLOCKED) then
	  print *, "stat_var == STAT_UNLOCKED: ", me
	else
          print *, "Error:stat_var /= STAT_UNLOCKED: ", me
          err_cnt = 1 + err_cnt
        end if
        sync all

        ! ALLOCATABLE LOCK_TYPE
        stat_var = STAT_LOCKED
	LOCK(a_lock_var[1])
        UNLOCK(a_lock_var[1], STAT=stat_var)
        if (stat_var == STAT_UNLOCKED) then
	  print *, "stat_var == STAT_UNLOCKED: ", me
	else
          print *, "Error:stat_var /= STAT_UNLOCKED: ", me
          err_cnt = 1 + err_cnt
        end if

        if (err_cnt .ge. 1) then
          call EXIT(1)
        end if

      end program
