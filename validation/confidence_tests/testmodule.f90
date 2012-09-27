

      module cross_test
      IMPLICIT NONE
       contains

       subroutine calc (cross_err)
          integer :: cross_err[*]
          integer :: size, rank, i
          size =  num_images()
          rank = this_image()

            if (rank == 1) then
              do i = 2 , size
                cross_err = max(cross_err,cross_err[i])
                print *, cross_err
              end do
              print *, (cross_err*1.0)/5
              if ((cross_err*1.0)/5 .ge. 0.5) then
                call EXIT (7)
              end if
            end if

       end subroutine calc


      end module cross_test
