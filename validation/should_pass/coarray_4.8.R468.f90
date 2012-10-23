!access to coarray without [] is to local object
    program main
        implicit none
        integer :: sca[*]
        integer :: rank,i

        rank = this_image()
        sca[rank] = rank

        do i = 1 , NPROCS
           if (rank == i .and. sca/=i) then
              print *, "reference to local coarray without cosubscripts failed"
              STOP 1
           end if
           if (sca[i] /= i) then
              print *, "reference to remote coarray with cosubscripts failed for image ",rank
              STOP 1
          end if
        end do

    end program main
