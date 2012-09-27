! CRITICAL sections

PROGRAM item12

    IMPLICIT NONE
    integer :: num[*], rank, size

    rank = this_image()
    size = num_images()
    num = 0

    sync all

    critical

       if (rank == 1) then
         call sleep(10)
         num = rank
       else
         if (num[1] == 0) then
           print *, "ERROR"
         end if
       end if
    end critical

END PROGRAM item12
