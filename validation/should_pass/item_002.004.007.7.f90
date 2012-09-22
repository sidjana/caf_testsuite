!the cosubscript indicates the remote image to which the coarray belongs to
    
            program image
        	implicit none
        	integer :: a[*], rank, i
        
        	rank = this_image()
        
        	do i=1,num_images()
        		if(i == rank) then
        			a[1] = rank
        		end if
        		sync all
              	if(rank == 1) then
              		if(a .NE. i) then
                      write *, "ERROR"
                    end if
              	end if
                sync all
        	end do
    
            end program 
