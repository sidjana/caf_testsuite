
c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine exchange_5(g,ibeg,ifin1)

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      use coarray_globals, only : dum

c---------------------------------------------------------------------
c   compute the right hand side based on exact solution
c---------------------------------------------------------------------

      implicit none

      include 'cafnpb.h'
      include 'applu.incl'

c---------------------------------------------------------------------
c  input parameters
c---------------------------------------------------------------------
      double precision  g(0:isiz2+1,0:isiz3+1)
      integer ibeg, ifin1

c---------------------------------------------------------------------
c  local variables
c---------------------------------------------------------------------
      integer k



c---------------------------------------------------------------------
c   communicate in the south and north directions
c---------------------------------------------------------------------

c---------------------------------------------------------------------
c   receive from south
c---------------------------------------------------------------------
      if (ifin1.eq.nx) then

        sync images( south+1 )
        sync images( south+1 )

        do k = 1,nz
          g(nx+1,k) = dum(k)
        end do

      end if

c---------------------------------------------------------------------
c   send north
c---------------------------------------------------------------------
      if (ibeg.eq.1) then
        do k = 1,nz
          dum(k) = g(1,k)
        end do

      sync images( north+1 )
      dum(1:nz)[north] = dum(1:nz)
      sync images( north+1 )

      end if

      return
      end     
