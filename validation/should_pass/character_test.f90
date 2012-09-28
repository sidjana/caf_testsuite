! support for character coarrays

    program char_test
      character*2 ::  x(5,5)[*]

      x(:,:)='xx'

      sync all

      if(this_image() .eq. 1) then
        x(2:4,2:4) = 'ab'
        x(2:4,2:4)[2] = 'ab'   !remote write ARRSECTION
        do i = 1 ,5
          do j = 1 , 5
            if (x(i,j)/=x(i,j)) then    !remote read into all locations
              print *, "ERROR"
            end if
          end do
        end do
      end if

      sync all

   end program

