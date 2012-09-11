!compilation should fail
!cosubscript should be integer
program main
	implicit none
	integer :: a[*]
	
	a[1.0] = this_image()
	
end program main
