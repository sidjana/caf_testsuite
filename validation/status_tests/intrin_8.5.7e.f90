! Testing for LOCK & UNLOCK with STAT=STAT_LOCKED_OTHER_IMAGE specifier

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

	stat_var=STAT_UNLOCKED 

        ! testing for lock_var on different image
        if (me == 1) then
          LOCK(lock_var[1])
          call sleep(SLEEP*5)
        else
          call sleep(SLEEP)
          LOCK(lock_var[1], STAT=stat_var)
	  if (stat_var == STAT_LOCKED_OTHER_IMAGE) then
	      print *, "stat_var == STAT_LOCKED_OTHER_IMAGE: ", me
	  else
              print *, "Error:stat_var /= STAT_LOCKED_OTHER_IMAGE: ", me
              err_cnt = 1 + err_cnt
          end if
        end if
        UNLOCK(lock_var[1], STAT=stat_var)
	sync all

        ! ALLOCATABLE LOCK_TYPE
	stat_var=STAT_UNLOCKED 

        ! testing for a_lock_var on different image
        if (me == 1 ) then
          LOCK(a_lock_var[1])
          call sleep(SLEEP*5)
        else
          call sleep(SLEEP)
          LOCK(a_lock_var[1], STAT=stat_var)
	  if (stat_var == STAT_LOCKED_OTHER_IMAGE) then
	      print *, "stat_var == STAT_LOCKED_OTHER_IMAGE: ", me
	  else
              print *, "Error:stat_var /= STAT_LOCKED_OTHER_IMAGE: ", me
              err_cnt = 1 + err_cnt
          end if
        end if
        UNLOCK(a_lock_var[1], STAT=stat_var)

        if (err_cnt .ge. 1) then
          call EXIT(1)
        end if

      end program

