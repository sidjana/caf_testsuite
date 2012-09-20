
    PROGRAM item13
       IMPLICIT NONE
       integer :: rank
       rank = this_image()
       sync all
       if (rank == 1) then
         print *, "calling ERROR STOP"
         error stop
       else
         call sleep(20)
         print *, "end of sleep"
         print *, "ERROR - this line should not be executed", rank
       end if



!
!       if (a2[this_image()] .eq. 0) then
!       write(*,*) this_image(),'ERROR'
!       stop
!       else
!       write(*,*) this_image(),' result = ',a1[this_image()]/a2[this_image()]
!       endif
!
!       write(*,*) this_image(),'End of program '
!
    END PROGRAM item13
