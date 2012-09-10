!coindexed object can be used in intrinsic operations, intrinsic assignment, input output list
program main
	implicit none
	integer :: a(5)[*], rank, i, myarray(5)
	
	data myarray /1,2,3,4,5/
	
	rank = this_image()
	!write(*,*)"Hello",rank
	if(rank == 1) then
		a(:)[2] = myarray
	end if
	
	sync all
	
	if(rank == 3) then
	!write(*,*) "Max",maxval(a(:)[2])
		if(maxval(a(:)[2]) .NE. 5) then
			write(*,*) "Error using coindexed object in intrinsic operations"
		end if
	end if
	
end program main
