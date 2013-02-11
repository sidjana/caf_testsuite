c---------------------------------------------------------------------
c---------------------------------------------------------------------
        module cg_global_coarrays
c---------------------------------------------------------------------
          implicit none


          logical timeron[0:*]
!
!            contains
!  
!           subroutine co_sum(source, result)
!             real (kind=8) :: source(:)[*], result(:)
!             integer :: i
!  
!             sync all
!             result=0
!             do i=1,num_images()
!               result = result + source(:)[i]
!             end do
!             sync all
!           end subroutine co_sum
!  
!           subroutine co_minval(source, result)
!             real (kind=8) :: source(:)[*], result(:)
!             integer :: i
!  
!             sync all
!             result=huge(result)
!             do i=1,num_images()
!               result = min(result,1*source(:)[i])
!             end do
!             sync all
!           end subroutine co_minval
!  
!           subroutine co_maxval(source, result)
!             real (kind=8) :: source(:)[*], result(:)
!             integer :: i
!  
!             sync all
!             result=-1*huge(result)-1
!             do i=1,num_images()
!               result = max(result,1*source(:)[i])
!             end do
!             sync all
!           end subroutine co_maxval
!  
!           subroutine co_maxval0(source, result)
!             real (kind=8) :: source[*], result
!             integer :: i
!  
!             sync all
!             result=-1*huge(result)-1
!             do i=1,num_images()
!               result = max(result,1*source[i])
!             end do
!             sync all
!           end subroutine co_maxval0

      end module
