      program matrixmul
        implicit none
        integer,parameter :: N = 500
        integer :: P
        double precision,allocatable,dimension(:,:),codimension[:,:] :: a,b,c
        integer :: i,j,k,l,q,iAm, np
        integer :: myP, myQ
        integer :: ticks, start_time, end_time, rate

        np = num_images()
        iAm = this_image()

        ! check that np is a square
        P = INT(sqrt(REAL(np)))
        if ( P*P /= np ) then
          if (iAm == 1)   &
            write(*,"('num_images must be square: p=',i5)") np
          stop
        end if


        if (P*P /= np)  then
        end if

        allocate(a(N,N)[P,*], b(N,N)[P,*], c(N,N)[P,*])

        myP = this_image(a,1)
        myQ = this_image(a,2)

        a = 1.0
        b = 1.0
        c = 0.0

        sync all

        call system_clock(start_time, rate)

          do i=1,N
            do j=1,N
              do l=1,P
                c(i,j) = c(i,j) + sum(a(i,:)[myP,l]*b(:,j)[l,myQ])
              end do
            end do
          end do

          sync all
          call system_clock(end_time)


          if (any(c /= N*P)) write(*,"('error on image: ',2i5,2i5)") &
                 myP,myQ
          write(*,"('check sum[',i5',',i5,']',f10.3)") &
            myP,myQ, abs(sum(c) - P*N**3)/(P*N**3)

    if (iAm == 1) then
        ticks = end_time - start_time
        write(*, '(//A20,I8,A)')   "clock rate = ", rate, " ticks/s"
        write(*, '(A20,I8)')           "ticks  = ", ticks
        write(*, '(A20,F8.2,A)') "elapsed time = ", ticks/(1.0*rate), " seconds"
    end if

      end program matrixmul
