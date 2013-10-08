      program matrixmul
        implicit none
        integer,parameter :: N = 100
        real,allocatable,dimension(:,:),codimension[:,:] :: a,b,c
        integer :: P
        integer :: i,j,k,l,q,iAm, np
        integer :: myP, myQ

        np = num_images()
        iAm = this_image()

        P = INT(sqrt(REAL(np)))
        if (P*P /= np)  then
          if (iAm == 1)   &
            write(*,"('num_images must be square: p = ',i5)") np
          stop
        end if

        allocate(a(N,N)[P,*], b(N,N)[P,*], c(N,N)[P,*])

        myP = this_image(a,1)
        myQ = this_image(a,2)

        a = 1.0
        b = 1.0
        c = 0.0

        sync all

          do i=1,N
            do j=1,N
              do l=1,P
                c(i,j) = c(i,j) + sum(a(i,:)[myP,l]*b(:,j)[l,myQ])
              end do
            end do
          end do

          if (any(c /= N*P)) write(*,"('error on image: ',2i5,e20.10)") &
                 myP,myQ,c(1,1)
          write(*,"('check sum[',i5',',i5,']',e20.10)") &
                  myP,myQ, sum(c) - P*N**3

      end program matrixmul
