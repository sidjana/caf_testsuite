!Specification 15. Transformational functions
!num images()
program main
implicit none
	integer :: coitem[*]
	if(num_images() .ne. 4) then
		write(*,*) "Error runtime item15_d num_images()"
	end if	
end program main