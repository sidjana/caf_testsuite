! checking for correctness of num_images()

      program main
            implicit none

            integer, parameter :: N=NPROCS
            integer :: np

            np = num_images()

            if (np /= N) then
              print *, "ERROR"
            end if

        end program main

