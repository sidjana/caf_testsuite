      module mco_reduce
      integer, parameter :: mbuf_size = 16
      double precision :: loc_buf(mbuf_size)
      double precision :: shared_buf(mbuf_size)[*]
      integer :: shared_ibuf(mbuf_size)[*]

      contains

      !********* Reduce variables (1=SUM, 2=MIN, 3=MAX)
      subroutine mco_reduce_r8(data_in, data_out, nitems, rtype)
      double precision :: data_in(*), data_out(*)
      integer :: nitems, rtype

      integer :: myid, nprocs, ip, i

      myid = this_image()
      nprocs = num_images()

      ! copy local data to shared buffer
      data_out(1:nitems) = data_in(1:nitems)
      if (nprocs < 2) return
      shared_buf(1:nitems) = data_in(1:nitems)

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
      sync all

      end subroutine mco_reduce_r8

      subroutine mco_sum_r8(data_in, data_out, nitems)
      double precision :: data_in(*), data_out(*)
      integer :: nitems
      call mco_reduce_r8(data_in, data_out, nitems, 1)
      end subroutine mco_sum_r8

      subroutine mco_minval_r8(data_in, data_out, nitems)
      double precision :: data_in(*), data_out(*)
      integer :: nitems
      call mco_reduce_r8(data_in, data_out, nitems, 2)
      end subroutine mco_minval_r8

      subroutine mco_maxval_r8(data_in, data_out, nitems)
      double precision :: data_in(*), data_out(*)
      integer :: nitems
      call mco_reduce_r8(data_in, data_out, nitems, 3)
      end subroutine mco_maxval_r8

      !********* Reduce variables (1=SUM, 2=MIN, 3=MAX)

      subroutine mco_sum_c8(data_in, data_out, nitems)
      double complex :: data_in, data_out
      double complex :: lval
      double complex, save :: sbuf[*]
      integer :: nitems

      integer :: myid, nprocs, ip, i

      myid = this_image()
      nprocs = num_images()

      ! copy local data to shared buffer
      data_out = data_in
      if (nprocs < 2) return
      sbuf = data_in

      ! ensure everyone is here
      sync all

      ! reduce data from the shared buffer
      do ip = 1, nprocs
         if (ip == myid) cycle
         lval = sbuf[ip]
         data_out = data_out + lval
      end do

      ! ensure no one pass this point before buffer is reused
      sync all
      end subroutine mco_sum_c8


      end module mco_reduce
