!Allocatable arrrays
!length of bound, cobound must be the same on all images
!openuh = success compile and runtime
!g95 = success compile and runtime
program main
implicit none
	integer, allocatable :: x(:)[:,:]
	allocate(x(this_image())[2,*])
	x(num_images())[1,1] = 100
	
	if(this_image() .eq. 1) then
		if(x(num_images()) .eq. 100) then
            print * , "ERROR"
		end if
	end if
end program main
