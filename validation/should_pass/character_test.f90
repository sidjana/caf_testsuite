! support for character coarrays

    program char_test
      character*6, x(5,5)[*]

      !intialization
      x(:,:)='x'

      if(this_image()==1) then
        x(2:4,2:4)[2] = "abcdef"   !remote write ARRSECTION
        x(2:4,2:4) = x(2:4,2:4)[2]    !remote read into all locations
      end if

      sync all

      print *,this_image()," x = ", x(:,:)
      do i = 1 , 5
        do j = 1 , 5
        end do 
      end do 


   end program

