!if dummy argument is an allocatable coarray, the actual argument must be an allocatable coarray of same rank and corank
!openuh compilation successful
!execution is also successful
program main
implicit none
	real, allocatable :: a(:)[:]
    integer :: i , rank
    rank = this_image()
    allocate(a(2)[*])
	call subr(a)

	sync all
    do i = 1,2
      if (a(i) /= rank ) then
          print *, "ERROR"
      end if
    end do

	contains
    subroutine subr(x)
    	real, allocatable :: x(:)[:]
    	x(:) = this_image()
    end subroutine subr
end program main
