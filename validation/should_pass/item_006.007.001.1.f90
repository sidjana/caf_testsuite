!Allocatable arrrays
!cobounds must be included in the allocate statement and upper bound for final codimension must be *
!openuh caf : success compile & runt
!g95 : success compile & run
program main
    implicit none
	integer, allocatable :: x(:)[:,:]
	allocate(x(10)[2,*])
end program main
