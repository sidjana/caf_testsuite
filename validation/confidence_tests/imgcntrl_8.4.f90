! ERROR STOP statement should stop other images as soon as it is practicable

    PROGRAM errorstop_test
    use cross_test

       IMPLICIT NONE

       integer :: rank, size,i, temp

       rank = this_image()

       sync all

       if (rank == 1) then
         print *, "calling ERROR STOP"
#ifndef CROSS_
         error stop 10
#endif
       else

         ! The following loop is added just to get some computational overhead
         ! and to make is possible for ERROR termination
         do i = 1 , NITER
            call sleep(SLEEP)
            temp = temp + 100
         end do
         call EXIT(7)
       end if

    END PROGRAM
