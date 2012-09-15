! this program checks whether the DEALLOCATE statement acts as a barrier
! or not. It should.

      program deallocate

      integer, allocatable :: arr(:)[:,:]
      integer, save :: temp[*]
      integer :: rank, size

      allocate (arr(5)[2,*])
      rank = this_image()
      size = num_images()
      arr(5) = rank

      if (rank .eq. 2) then
        call sleep(10)
      end if
      temp = rank

      deallocate(arr)
      if (size .gt. 1) then
         if (rank .eq. 1) then
           if(temp[2] .eq. 1) then
              print *, "ERROR"
           end if
         end if
      end if


      end program
