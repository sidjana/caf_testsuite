! Testing for LOCK & UNLOCK with STAT specifier

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

             if (rank == 1) then
               ! testing for lock_var on the same image
               LOCK(lock_var[2])
               LOCK(lock_var[2], STAT=stat_var)
               if (stat_var /= STAT_LOCKED) then
                 print *, "Error: STAT var not set", rank
                 err_cnt = 1
               end if
               UNLOCK(lock_var[2])
             end if
             print *, "passed 1st stage", rank

            sync all

            ! ALLOCATABLE LOCK_TYPE
            stat_var = 0

            if (rank == 1) then
               ! testing for a_lock_var on the same image
               LOCK(a_lock_var[2])
               LOCK(a_lock_var[2], STAT=stat_var)
               if (stat_var /= STAT_LOCKED) then
                 print *, "Error: STAT var not set", rank
                 err_cnt = 1
               end if
               UNLOCK(a_lock_var[2])
             end if
             print *, "passed 1st stage", rank

             sync all
        end do

        if (err_cnt .ge. 1) then
          call EXIT(1)
        end if

      end program

