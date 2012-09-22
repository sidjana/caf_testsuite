!A coindexed object is permitted as an actual argument corresponding to a
!non-coarray dummy argument in a procedure invocation


      program  non_coarray_arg

        integer :: arr(5)[*]

        arr(:)  =  this_image()
        sync all
        call foo(arr)

        contains

        subroutine foo(a)
            integer :: a(:)
            integer :: rank
            integer :: upper
            upper = ubound(a,1)
            rank = this_image()

            if ( rank .eq. 2) then
              do i = 1 , upper
              if (a(i) /= rank ) then
                  print *, "ERROR"
              end if
              end do
            end if
        end subroutine
      end program
