!if dummy argument is an allocatable coarray, the actual argument must be an allocatable coarray of same rank and corank
!openuh compilation successful
!execution is also successful
program main
implicit none
	real, allocatable :: a(:)[:]
	call subr(a)

	sync all
	write(*,*) "Rank -",this_image()," =>",a(1)
contains 
subroutine subr(x)
	real, allocatable :: x(:,:)[:]
	
	allocate(x(2,2)[*])
	x(1,1)[this_image()] = this_image()
	
end subroutine subr	
end program main
