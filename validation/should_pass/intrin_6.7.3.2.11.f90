! This program verifies whether the DEALLOCATE & ALLOCATE statements
! act as a barriers.


      program deallocate_test

          integer, allocatable :: arr[:]
          integer, save :: temp[*]

          allocate(arr[*])
          do i  = 1 , 10
            temp = i
            deallocate(arr)
            if (temp[2] /= i) then
              print * ,"ERROR"
              call EXIT(1)
            end if
            allocate(arr[*])
          end do

      end program

