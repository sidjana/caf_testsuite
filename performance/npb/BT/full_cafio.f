
c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine setup_btio

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      use npbcaf
      include 'header.h'
c      include 'mpinpb.h'

      integer c, m
      


      record_length = 5*8
      root = 1

	
      if (node .eq. root) then
	call caf_file_delete(filenm)
      endif

      sync all

      call  caf_file_open(99, filenm, MPI_MODE_RDWR + MPI_MODE_CREATE, 
     >         4 , (/PROBLEM_SIZE, PROBLEM_SIZE, PROBLEM_SIZE/),
     >         record_length, 1)


      do m = 1, 5
         xce_sub(m) = 0.d0
      end do

      idump_sub = 0


      return
      end

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine output_timestep

c---------------------------------------------------------------------
c---------------------------------------------------------------------
	
      use npbcaf
      include 'header.h'
c      include 'mpinpb.h'

	integer :: c
      do  c = 1, ncells
       call caf_file_write_str(99, (/cell_low(1:3,c)+1,idump_sub+1/), 
     >        (/cell_low(1:3,c)+1+cell_size(1:3,c)-1,idump_sub+1/), 
     >        (/1,1,1,1/),
     >         u(1:5,
     >		 0:cell_size(1, c)-1, 
     >           0:cell_size(2, c)-1, 
     >           0:cell_size(3, c)-1,
     >	         c), 
     >         cell_size(1,c)*cell_size(2,c)*cell_size(3,c)*5*8)
            print *,"bytes written =", 
     >      cell_size(1,c)*cell_size(2,c)*cell_size(3,c)*5*8

       end do

      idump_sub = idump_sub + 1
      if (rd_interval .gt. 0) then
         if (idump_sub .ge. rd_interval) then

            call acc_sub_norms(idump+1)

            idump_sub = 0
         endif
      endif

      return
      end

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine acc_sub_norms(idump_cur)

      use npbcaf
      include 'header.h'
c      include 'mpinpb.h'

      integer idump_cur
      integer ii, c,m, ichunk
      double precision xce_single(5)

      ichunk = idump_cur - idump_sub + 1

      do ii=0, idump_sub-1
      do  c = 1, ncells

           call caf_file_read_str(99, (/cell_low(1:3,c)+1,ii+1/), 
     >        (/cell_low(1:3,c)+1+cell_size(1:3,c)-1,ii+1/),
     >        (/1,1,1,1/),
     >         u(1:5,
     >		 0:cell_size(1, c)-1, 
     >           0:cell_size(2, c)-1, 
     >           0:cell_size(3, c)-1,
     >	         c), 
     >         cell_size(1,c)*cell_size(2,c)*cell_size(3,c)*5*8)
     


        if (node .eq. root) print *, 'Reading data set ', ii+ichunk

        call error_norm(xce_single)
        do m = 1, 5
           xce_sub(m) = xce_sub(m) + xce_single(m)
        end do
      enddo
      enddo

      return
      end

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      subroutine btio_cleanup

c---------------------------------------------------------------------
c---------------------------------------------------------------------
      use npbcaf
      include 'header.h'
c      include 'mpinpb.h'

      call caf_file_close(99)

      return
      end

c---------------------------------------------------------------------
c---------------------------------------------------------------------


      subroutine accumulate_norms(xce_acc)

c---------------------------------------------------------------------
c---------------------------------------------------------------------

      use npbcaf
      include 'header.h'
c      include 'mpinpb.h'

      double precision xce_acc(5)
      integer m, ierr

      if (rd_interval .gt. 0) goto 20

      call  caf_file_open(99, filenm, MPI_MODE_RDONLY, 
     >         4 , (/PROBLEM_SIZE, PROBLEM_SIZE, PROBLEM_SIZE/),
     >         record_length, 1)

c     clear the last time step

      call clear_timestep

c     read back the time steps and accumulate norms

      call acc_sub_norms(idump)

      call caf_file_close(99)

 20   continue
      do m = 1, 5
         xce_acc(m) = xce_sub(m) / dble(idump)
      end do

      return
      end

