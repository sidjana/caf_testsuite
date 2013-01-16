! Testing for LOCK & UNLOCK without STAT specifier

      program lock_unlock

         USE, INTRINSIC :: ISO_FORTRAN_ENV

         IMPLICIT NONE
         type(LOCK_TYPE) :: lock_var [*]
         type(LOCK_TYPE), allocatable  :: a_lock_var [:]
         integer :: rank, stat_var, err_cnt, i

        ALLOCATE(a_lock_var [*])

        rank = this_image()

        if(NPROCS ==  1) then
          print * , "Config Error: NPROCS should be greater than 1"
        end if


        do i = 1,NITER

            sync all
            stat_var = 0

             ! testing for lock_var on different image
             if (rank == 1 ) then
               LOCK(lock_var[2])
             else
               call sleep(SLEEP)
               LOCK(lock_var[2], STAT=stat_var)
               if (stat_var /= STAT_LOCKED_OTHER_IMAGE) then
                   print *, "Error: STAT var not set", rank
                   err_cnt = 1 + err_cnt
                   UNLOCK(lock_var[2])
               end if
             end if
             if (rank == 1) then
                 call sleep(SLEEP*5)
                 print *, "timer ended"
                 UNLOCK(lock_var[2])
             end if
             sync all

             ! ALLOCATABLE LOCK_TYPE
             stat_var = 0

             ! testing for a_lock_var on different image
             if (rank == 1 ) then
               LOCK(a_lock_var[2])
             else
               call sleep(SLEEP)
               LOCK(a_lock_var[2], STAT=stat_var)
               if (stat_var /= STAT_LOCKED_OTHER_IMAGE) then
                   print *, "Error: STAT var not set", rank
                   err_cnt = 1 + err_cnt
                   UNLOCK(a_lock_var[2])
               end if
             end if
             if (rank == 1) then
                 call sleep(SLEEP*5)
                 print *, "timer ended"
                 UNLOCK(a_lock_var[2])
             end if

        end do

        if (err_cnt .ge. 1) then
          call EXIT(1)
        end if

      end program

