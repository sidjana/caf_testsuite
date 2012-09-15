!a subroutine with non-allocatable coarray may not be called simultaneously
!each image independently associate the coarray dummy argument with actual coarray, defines the corank and cobound afresh
program main
implicit none
	integer :: x[*],i

	x = this_image()

	if(this_image() .eq. 1) then	!only image 1 call subr
		call subr(x,4)
	end if

    sync all

	if(this_image() .eq. 2) then
		!do i=1,num_images()
		!	write(*,*)"x[",i,"]:",x[i]
		!end do
		if(x[3] .ne. 12) then
		print *, "ERROR"	
		end if
	end if

contains
subroutine subr(n,idx)
	integer :: n[2:*],idx !new cobound from 2 to *
	n[idx] = 12
end subroutine subr
end program main
