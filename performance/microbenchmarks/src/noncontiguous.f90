
!---------------------------------------------------------------------
!
!  This program is a Latency benchmark with CAF put statement used 
!  for partial data.
!
!  For the output files you need to specify : 
!      the path, 
!      the compiler's update,
!      the communication layer,
!      the cluster name,
!      cores number and processes number respectively.
!
!
!
!  Name                Date            Notes
!  --------------      ----------      --------------------
!  Asma Farjallah      July 2010       Init
!
!---------------------------------------------------------------------

program partial_data

  implicit none

  integer,parameter :: nt=4096*256 ! 1 MB
  integer,parameter :: iterations=NITER

  integer,allocatable:: msg(:,:)[:]
  integer           :: me
  integer           :: msg_size,size
  integer           :: i,j,it
  integer           :: ierr

  real(kind=8)      :: r_msgsize,r_iterations

  integer(kind=8)   :: srtc,ertc,res
  real(kind=8)      :: rtc,rtmp

  character(len=512):: output
  character(len=256) :: suffix,path,update
  character(len=64) :: layer,cluster,ncore,nproc

  allocate(msg(16,nt)[*])

  me=this_image()

  call getarg(1,path)
  call getarg(2,layer)
  call getarg(3,cluster)
  call getarg(4,ncore)
  call getarg(5,nproc)

  suffix=trim(layer)//"_"//trim(cluster)//&
       "_NC"//trim(ncore)//"_NP"//trim(nproc)//".dat"

  output=trim(path)//"/noncontiguous_CAF_"//suffix

  if (me == 1) then
     open(unit=10,file=trim(output),form='formatted', &
          status='replace',access='sequential',       &
          action='write',iostat=ierr                  )
     write(10,'(A1,A10,A21,A20)') "#","[Bytes]","[Microsec]","[KB/sec]"
  endif

  i=1
  msg(:,:)=me
  msg_size=1

  do while (msg_size <= nt)

    sync all

     if (me == 1) then

        write(*,'(I2, I10)') i, msg_size

        call get_rtc(srtc)

        do it=1,iterations
          msg(1,1:msg_size)[2]=msg(1,1:msg_size)
        enddo

        call get_rtc(ertc)
        call get_rtc_res(res)
        rtmp=res
        rtc=(ertc-srtc)/rtmp

        write(10,'(I10,A1,E20.8,A1,E20.8)') 4*msg_size,";",rtc*1000000.0/iterations,";",4.0*msg_size*iterations/rtc/1024.0

        i=i+1

       do j=1,msg_size
          if (msg(1,j)[2] /= me) then
             write(*,*) "Data is missing."
             stop
          endif
       enddo

     endif

     sync all

     msg_size=2*msg_size

  enddo

  deallocate(msg)

  if (me == 1) then
     close(unit=10,iostat=ierr)
  endif

end program partial_data