! Testing for LOCK - UNLOCK feature

      program lock_unlock

         USE, INTRINSIC :: ISO_FORTRAN_ENV
         type(LOCK_TYPE) :: lock_var [*]
         integer :: num[*]
         integer :: rank, size

         rank = this_image()
         num = rank
         size = num_images()

        if(size .gt. 1) then
         if (rank .eq. 2) then
              call sleep(5)  ! ensuring the img 2 enters the LOCK seg late
         end if
         LOCK (lock_var[1])
              if (rank .eq. 2) then
                 num[1] = 2    ! overwriting img 1's var before it is read
              end if
              if (rank == 1) then 
                 ! if lock does not work , img 2 will modify 'num[1]' This gives time for img 2 to do so.
                 call sleep(5) 
                 if (num /= rank) then
                  print *, "ERROR"
                 end if
              end if
              
         UNLOCK (lock_var[1])

        end if


      end program

