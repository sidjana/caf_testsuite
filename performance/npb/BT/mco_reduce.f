      module mco_reduce
      integer, parameter :: mbuf_size = 16
      double precision :: loc_buf(mbuf_size)
      double precision :: shared_buf(mbuf_size)[*]
      integer :: shared_ibuf(mbuf_size)[*]

      contains

      !********* Reduce variables (1=SUM, 2=MIN, 3=MAX)
      subroutine mco_reduce_r8(data_in, data_out, nitems, rtype, team)
      double precision :: data_in(*), data_out(*)
      integer :: nitems, rtype, team(:)

      integer :: myid, nprocs, ip, i

      myid = this_image()
      nprocs = size(team,1)
      i = 1
      do while (i <= nprocs .and. myid /= team(i))
         i = i + 1
      end do
      if (i > nprocs) return

      ! copy local data to shared buffer
      data_out(1:nitems) = data_in(1:nitems)
      if (nprocs < 2) return
      shared_buf(1:nitems) = data_in(1:nitems)

      ! ensure everyone is here
!      sync images(team)
      sync all

      ! reduce data from the shared buffer
      do ip = 1, nprocs
         if (ip == myid) cycle
         loc_buf(1:nitems) = shared_buf(1:nitems)[ip]
         if (rtype == 1) then
            data_out(1:nitems) = data_out(1:nitems) + loc_buf(1:nitems)
         else if (rtype == 2) then
            do i = 1, nitems
               data_out(i) = min(data_out(i), loc_buf(i))
            end do
         else if (rtype == 3) then
            do i = 1, nitems
               data_out(i) = max(data_out(i), loc_buf(i))
            end do
         endif
      end do

      ! ensure no one pass this point before buffer is reused
!      sync images(team)
      sync all
      end subroutine mco_reduce_r8

      subroutine mco_sum_r8(data_in, data_out, nitems, team)
      double precision :: data_in(*), data_out(*)
      integer :: nitems, team(:)
      call mco_reduce_r8(data_in, data_out, nitems, 1, team)
      end subroutine mco_sum_r8

      subroutine mco_minval_r8(data_in, data_out, nitems, team)
      double precision :: data_in(*), data_out(*)
      integer :: nitems, team(:)
      call mco_reduce_r8(data_in, data_out, nitems, 2, team)
      end subroutine mco_minval_r8

      subroutine mco_maxval_r8(data_in, data_out, nitems, team)
      double precision :: data_in(*), data_out(*)
      integer :: nitems, team(:)
      call mco_reduce_r8(data_in, data_out, nitems, 3, team)
      end subroutine mco_maxval_r8

      end module mco_reduce
