
      module cross_test

      IMPLICIT NONE
      integer :: cross_err[*]

      contains

       subroutine calc_ori(cross_err)
          integer:: cross_err[*]
          if (cross_err .gt. 0) then
            STOP 1
          !else
          !  STOP 0
          end if
       end subroutine

       subroutine calc (cross_err)
          integer :: cross_err[*]
          integer :: size, rank, i
          integer :: percent=0

          size =  num_images()
          rank = this_image()

          if (rank == 1) then
           ! do i = 1 , size
           !   cross_err = max(cross_err,cross_err[i])
           ! end do
            !print *, "we get" , cross_err[1]
            percent=(cross_err[1]*100.0)/NITER
            call exit(percent)
          end if

       end subroutine calc


      end module cross_test
