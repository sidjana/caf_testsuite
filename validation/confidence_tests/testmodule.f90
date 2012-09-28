
      module cross_test

      IMPLICIT NONE
      integer :: cross_err[*]

      contains

       subroutine calc_ori(cross_err)
          integer:: cross_err[*]
          if (cross_err .gt. 0) then
            call EXIT(5)
          else
            call EXIT(4)
          end if
       end subroutine

       subroutine calc (cross_err)
          integer :: cross_err[*]
          integer :: size, rank, i
          size =  num_images()
          rank = this_image()

            if (rank == 1) then
              do i = 1 , size
                cross_err = max(cross_err,cross_err[i])
              end do
              if ((cross_err*1.0)/5 .ge. 0.5) then
                print *, "high confidence"
                call EXIT(6)
              else
                call EXIT(7)
              end if
            end if

       end subroutine calc


      end module cross_test
