!---------------------------------------------------------------------
!
!  This program is Round-Trip benchmark with CAF put and get
!  statements.
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
!  Debjyoti Majumder   July 2011       Minor change
!
!---------------------------------------------------------------------

program bidirectional

  implicit none

  integer,parameter :: nt=1024*1024
  integer,parameter :: iterations=NITER

  integer,allocatable::msg1(:)[:],msg2(:)[:]
  integer           :: me
  integer           :: msg_size
  integer           :: i,j,k,it
  integer           :: ierr

  real(kind=8)      :: r_msgsize,r_iterations

  integer(kind=8)   :: srtc,ertc,res
  real(kind=8)      :: rtc,rtmp

  character(len=512):: output
  character(len=256) :: suffix,path
  character(len=64) :: layer,cluster,ncore,nproc

  allocate(msg1(nt)[*],msg2(nt)[*])

  me=this_image()
  if (num_images() ==  1) then
     print *, "number of images can not be 1"
     call exit(0)
  end if

  call getarg(1,path)
  call getarg(2,layer)
  call getarg(3,cluster)
  call getarg(4,ncore)
  call getarg(5,nproc)

  !suffix=trim(layer)//"_"//trim(cluster)//&
  !     "_NC"//trim(ncore)//"_NP"//trim(nproc)//".dat"

  !output=trim(path)//"/bidirectional_CAF_"//suffix

  if (me == 1) then
     !open(unit=10,file=trim(output),form='formatted', &
     !     status='replace',access='sequential',       &
     !     action='write',iostat=ierr                  )
     !write(10,'(A1,A10,A21,A20)') "#","[Bytes]","[Microsec]","[KB/sec]"
     write(* ,'(A1,A10,A21,A20)') "#","[Bytes]","[Microsec]","[KB/sec]"
  endif

  i=1
  msg1(:)=0; msg2(:)=0
  msg_size=1

  do while (msg_size < nt)

    if (me == 1) then
        write(*,'(I2)') i
    end if

    sync all

    call get_rtc(srtc)

    do it=1,iterations
        if (me==1) then
           msg1(1:msg_size)[2]=msg1(1:msg_size)
        else if (me==2) then
           msg2(1:msg_size)[1]=msg2(1:msg_size)
        endif
    enddo

    sync all

    if (me==1) then
        call get_rtc(ertc)
        call get_rtc_res(res)
        rtmp=res

        rtc=(ertc-srtc)/rtmp

        r_msgsize=msg_size*2
        r_iterations=iterations

        !write(10,'(I10,A1,E20.8,A1,E20.8)') 4*msg_size,";",rtc*1000000.0/r_iterations,";",4.0*r_msgsize*r_iterations/rtc/1024.0
        write(*,'(I10,A1,E20.8,A1,E20.8)') 4*msg_size,";",rtc*1000000.0/r_iterations,";",4.0*r_msgsize*r_iterations/rtc/1024.0

        i=i+1

     endif

     msg_size=2*msg_size

  enddo

  deallocate (msg1, msg2)

  !if (me == 1) then
  !   close(unit=10,iostat=ierr)
  !endif

end program bidirectional
