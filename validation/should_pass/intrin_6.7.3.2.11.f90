! this program checks whether the DEALLOCATE & ALLOCATE statements acts as a barriers
! or not. They should !

      program deallocate_test

          integer, allocatable :: arr[:]
          integer, save :: temp[*]

          allocate(arr[*])
          do i  = 1 , 10
            temp = i
            deallocate(arr)
            if (temp[2] /= i) then
              print * ,"ERROR"
            end if
            allocate(arr[*])
          end do

      end program

