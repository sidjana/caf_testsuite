        program main
            implicit none

            integer, parameter :: N=NPROCS
            integer :: np

            np = num_images()

            if (np /= N) then
              print *, "error"
            end if

        end program main

