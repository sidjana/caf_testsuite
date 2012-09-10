!Specification 15. Intrinsic procedures
!image_index()
program main
implicit none
	integer :: x[2,*]
	integer :: idx
	
	idx = image_index(x,[2,2])
	if(idx .ne. 4) then
		write(0,*) "Error runtime item15_a"
	end if
end program main