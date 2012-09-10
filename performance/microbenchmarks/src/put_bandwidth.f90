
!---------------------------------------------------------------------
!
!  This program is Latency and Bandwidth benchmarks with CAF put 
!  statement.
!
!  For the output files you need to specify : 
!      the path, 
!      the communication layer,
!      the cluster name,
!      cores number and processes number respectively.
!
!
!
!  Name                Date            Notes
!  --------------      ----------      --------------------
!  Asma Farjallah      July 2010       Init
!  Debjyoti Majumder   July 2011       Minor modifications
!
!---------------------------------------------------------------------

program latency_bandwidth

  implicit none

  integer,parameter :: nt=1024*1024
  integer,parameter :: iterations=NITER

  integer,allocatable:: msg(:)[:]
  integer           :: me
  integer           :: msg_size
  integer           :: i,k,it
  integer           :: ierr

  real(kind=8)      :: r_msgsize,r_iterations

  integer(kind=8)   :: srtc,ertc,res
  real(kind=8)      :: rtc,rtmp

  character(len=512):: output_bwd
  character(len=256) :: suffix,path
  character(len=64) :: layer,cluster,ncore,nproc

  allocate(msg(nt)[*])

  me=this_image()

  call getarg(1,path)
  call getarg(2,layer)
  call getarg(3,cluster)
  call getarg(4,ncore)
  call getarg(5,nproc)

  suffix=trim(layer)//"_"//trim(cluster)//&
       "_NC"//trim(ncore)//"_NP"//trim(nproc)//".dat"

  output_bwd=trim(path)//"/put-bandwidth_CAF_"//suffix

  if (me == 1) then
     open(unit=11,file=trim(output_bwd),form='formatted',&
          status='replace',access='sequential',          &
          action='write',iostat=ierr                     )
     write(11,'(A1,A10,A21,A20)') "#","[Bytes]","[Microsec]","[KB/sec]"
  endif

  i=1
  msg(:)=me
  msg_size=1

  do while (msg_size <= nt)

     sync all

     if (me == 1) then

        write(*,'(I2)') i

        call get_rtc(srtc)

        do it=1,iterations
           msg(1:msg_size)[2]=msg(1:msg_size)
        enddo

        call get_rtc(ertc)
        call get_rtc_res(res)
        rtmp=res
        rtc=(ertc-srtc)/rtmp

        r_msgsize=msg_size
        r_iterations=iterations

        !write(11,'(I10,A1,E20.8)') 4*msg_size,";",4.0*r_msgsize*r_iterations/rtc/1024.0 !!KB/sec
        write(11,'(I10,A1,E20.8,A1,E20.8)') 4*msg_size,";",rtc*1000000.0/r_iterations,";",4.0*r_msgsize*r_iterations/rtc/1024.0

        i=i+1

     endif
 
     sync all

     if (me == 2) then

        do k=1,msg_size

           if (msg(k) /= 1) then
              write(*,*) "Data received is incomplete."
              stop
           endif

        enddo

     endif

     msg_size=2*msg_size

  enddo

  deallocate(msg)

  if (me == 1) then
     close(unit=11,iostat=ierr)
  endif

end program latency_bandwidth