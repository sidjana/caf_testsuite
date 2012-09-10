program main
	implicit none
	integer :: img_size, img_rank, i, j, k, tot[*], tot2[*], cosubs(2)
	logical :: error
	real :: z[2,*]
	
	tot = 0
	error = .FALSE.
	img_size = num_images()
	img_rank = this_image()
	if (img_size .NE. 4) then
		if (img_rank .EQ. 1) then
			write(UNIT=0,*) "Wrong num_images()"
		end if
	else
		
		k = 0
		do i=1,2	!column
			do j=1,2	!row
				k = k + 1
				if(img_rank .EQ. k) then
					tot[1] = tot[1] + 1
!					cosubs = this_image(z)
!					if (j .EQ. cosubs(1) .AND. i .EQ. cosubs(2)) then
!						tot2[1] = tot2[1] + 1
!					end if
				end if
				sync all
			end do
		end do
		
		if (img_rank .EQ. 1) then
			if(tot .NE. 4) then
				write(UNIT=0,*) "Wrong this_image()"
			end if
			
!			if(tot2 .NE. 4) then
!				write(UNIT=0,*) "Wrong this_image(z)"
!			end if
		end if
	end if
end program main

