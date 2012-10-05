! Testing for LOCK - UNLOCK feature

      program lock_unlock
      use cross_test

         USE, INTRINSIC :: ISO_FORTRAN_ENV
         type(LOCK_TYPE) :: lock_var [*]
         integer :: num[*]
         integer :: rank, size

         rank = this_image()
         num = 0
         size = num_images()

        if(size .gt. 1) then
          do i = 1,NITER
              num = 0
              sync all
              if (rank /= 1) then
                 call sleep(SLEEP) ! giving img 1 a head-start
              end if
#ifndef CROSS_
              LOCK (lock_var[1])
#endif
              if (rank /= 1) then
                 num[1] = rank    ! overwriting img 1's var before it is read
              end if
              if (rank == 1) then
                ! if lock does not work , other images will modify 'num[1]' . sleep() gives time to do so.

                 call sleep(SLEEP)
                 if (num /= 0) then
                   cross_err = cross_err + 1
                 end if
              end if
#ifndef CROSS_
         UNLOCK (lock_var[1])
#endif
            sync all
          end do
#ifndef CROSS_
          call calc_ori(cross_err)
#else
          call calc(cross_err)
#endif

        end if

      end program
