!Allocatable arrrays
!deallocate after allocate

program main
implicit none
	integer, allocatable :: x(:)[:,:]
	allocate(x(10)[2,*])
	deallocate(x)	
end program main