! test to verify the correctness of the sync all statement

      program item12_1

        implicit none

        integer :: num[*]
        integer :: i, rank
        rank=this_image()
        num=rank
        sync all

        do i = 1,3
              num = num+1
              sync all
              if (rank /= 1) then
                call sleep(4)
              else
                if((num[2]-1) /=  num) then
                  print *, "ERROR"
                end if
              end if
        end do


      end program

