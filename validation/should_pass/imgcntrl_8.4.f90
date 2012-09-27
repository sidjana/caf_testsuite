! ERROR STOP statement should stop other images as soon as it is practicable

    PROGRAM item13
       IMPLICIT NONE
       integer :: rank, i, temp

       rank = this_image()
       sync all
       if (rank == 1) then
         print *, "calling ERROR STOP"
         error stop
       else

         do i = 1 , 10
            call sleep(1)
            temp = temp + 100
         end do
         print *, "end of sleep"
         print *, "ERROR - this line should not be executed", rank
       end if

    END PROGRAM item13
