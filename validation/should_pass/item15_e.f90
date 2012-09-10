!Specification 15. Transformational functions
!this_image(coarray, [dim])
program main
implicit none
	integer :: coitem[2,*], x(2), y, z
	
	x = this_image(coitem)
	y = this_image(coitem,1)
	z = this_image(coitem,2)
	
	if(this_image() .eq. 1) then
		
		if(x(1) .ne. 1 .or. x(2) .ne. 1) then
			write(*,*) "Error runtime item15_e this_image(coitem)"
		end if	
		if(y .ne. 1) then
			write(*,*) "Error runtime item15_e this_image(coitem,1)"
		end if	
		if(z .ne. 1) then
			write(*,*) "Error runtime item15_e this_image(coitem,2)"
		end if	

	else if(this_image() .eq. 4) then

		if(x(1) .ne. 2 .or. x(2) .ne. 2) then
			write(*,*) "Error runtime item15_e this_image(coitem)"
		end if
		if(y .ne. 2) then
			write(*,*) "Error runtime item15_e this_image(coitem,1)"
		end if
		if(z .ne. 2) then
			write(*,*) "Error runtime item15_e this_image(coitem,2)"
		end if
	end if
	
	end program main