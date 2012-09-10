!the cosubscript doesnt indicate which image will access the coarray object
program main
	implicit none
	integer :: a[*], rank, i
	
	rank = this_image()
	
	do i=1,num_images()
		if(i == rank) then
			a[1] = rank
		end if
		sync all
	end do
	
	if(rank == 1) then
		if(a .NE. num_images()) then
			write(UNIT=0,*)"Error the cosubscript doesnt indicate which image will access the coarray object"
		end if
	end if
	
end program main
