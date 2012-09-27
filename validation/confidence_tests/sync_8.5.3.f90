! test to verify the correctness of the sync all statement

      program item12_1

        implicit none

        integer :: num[*]
        integer :: i, rank

        rank=this_image()
        num=rank

        sync all

        do i = 1,5
              num = i*rank
              if (rank .eq. 2) then
                call sleep(2) ! delaying img2 to give img1 a head start
              end if
              sync all
              if (rank .eq.1 ) then
                 if(num[2] /=  i*2 ) then
                   print *, "ERROR"
                 end if
              end if
              sync all
        end do

      end program

