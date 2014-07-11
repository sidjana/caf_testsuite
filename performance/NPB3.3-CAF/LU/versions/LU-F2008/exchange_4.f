
c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine exchange_4(g,h,ibeg,ifin1,jbeg,jfin1)

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      use coarray_globals, only: dum

c---------------------------------------------------------------------
c   compute the right hand side based on exact solution
c---------------------------------------------------------------------

      implicit none

      include 'mpinpb.h'
      include 'applu.incl'

c---------------------------------------------------------------------
c  input parameters
c---------------------------------------------------------------------
      double precision  g(0:isiz2+1,0:isiz3+1), 
     >        h(0:isiz2+1,0:isiz3+1)
      integer ibeg, ifin1
      integer jbeg, jfin1

c---------------------------------------------------------------------
c  local variables
c---------------------------------------------------------------------
      integer i, j
      integer ny2

      integer msgid1, msgid3
      integer STATUS(MPI_STATUS_SIZE)
      integer IERROR



      ny2 = ny + 2

c---------------------------------------------------------------------
c   communicate in the east and west directions
c---------------------------------------------------------------------

c---------------------------------------------------------------------
c   receive from east
c---------------------------------------------------------------------
      if (jfin1.eq.ny) then

        sync images( east+1 )
        sync images( east+1 )

        do i = 1,nx
          g(i,ny+1) = dum(i)
          h(i,ny+1) = dum(i+nx)
        end do

      end if

c---------------------------------------------------------------------
c   send west
c---------------------------------------------------------------------
      if (jbeg.eq.1) then
        do i = 1,nx
          dum(i) = g(i,1)
          dum(i+nx) = h(i,1)
        end do

        sync images( west+1 )

        dum(1:2*nx)[west] = dum(1:2*nx)

        sync images( west+1 )

      end if

c---------------------------------------------------------------------
c   communicate in the south and north directions
c---------------------------------------------------------------------

c---------------------------------------------------------------------
c   receive from south
c---------------------------------------------------------------------
      if (ifin1.eq.nx) then

        sync images( south+1 )
        sync images( south+1 )

        do j = 0,ny+1
          g(nx+1,j) = dum(j+1)
          h(nx+1,j) = dum(j+ny2+1)
        end do

      end if

c---------------------------------------------------------------------
c   send north
c---------------------------------------------------------------------
      if (ibeg.eq.1) then
        do j = 0,ny+1
          dum(j+1) = g(1,j)
          dum(j+ny2+1) = h(1,j)
        end do

        sync images( north+1 )

        dum(1:2*ny2)[north] = dum(1:2*ny2)

        sync images( north+1 )

      end if

      return
      end     
