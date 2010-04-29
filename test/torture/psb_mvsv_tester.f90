module psb_mvsv_tester

contains
subroutine s_usmv_2_n_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=1
  ! 1 1
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*4 :: VA(3)=(/1, 1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/9, 6/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_ap3_bp1_ix1_iy1
! 

subroutine s_usmv_2_t_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=1
  ! 1 0
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/9, 3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_ap3_bp1_ix1_iy1
! 

subroutine s_usmv_2_c_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=1
  ! 1 2
  ! 0 6

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*4 :: VA(3)=(/1, 2, 6/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/6, 27/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_ap3_bp1_ix1_iy1
! 

subroutine s_usmv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 2
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 2/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/9, 0/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_ap3_bm0_ix1_iy1
! 

subroutine s_usmv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 3
  ! 2 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*4 :: VA(3)=(/1, 3, 2/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_ap3_bm0_ix1_iy1
! 

subroutine s_usmv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 0
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/6, 0/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_ap3_bm0_ix1_iy1
! 

subroutine s_usmv_2_n_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=1
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*4 :: VA(1)=(/1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/4, 3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_ap1_bp1_ix1_iy1
! 

subroutine s_usmv_2_t_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=1
  ! 1 0
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/5, 3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_ap1_bp1_ix1_iy1
! 

subroutine s_usmv_2_c_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=1
  ! 1 2
  ! 5 1

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  real*4 :: VA(4)=(/1, 2, 5, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/9, 6/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_ap1_bp1_ix1_iy1
! 

subroutine s_usmv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 1
  ! 2 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*4 :: VA(3)=(/1, 1, 2/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/2, 2/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_ap1_bm0_ix1_iy1
! 

subroutine s_usmv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 3
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  real*4 :: VA(4)=(/1, 3, 1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/2, 4/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_ap1_bm0_ix1_iy1
! 

subroutine s_usmv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 2, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/3, 1/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_ap1_bm0_ix1_iy1
! 

subroutine s_usmv_2_n_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=1
  ! 1 3
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 3/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-1, 3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_am1_bp1_ix1_iy1
! 

subroutine s_usmv_2_t_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=1
  ! 1 1
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/2, 2/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_am1_bp1_ix1_iy1
! 

subroutine s_usmv_2_c_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=1
  ! 1 0
  ! 1 2

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 1, 2/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_am1_bp1_ix1_iy1
! 

subroutine s_usmv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-1, -2/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_am1_bm0_ix1_iy1
! 

subroutine s_usmv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 4
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  real*4 :: VA(4)=(/1, 4, 3, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-4, -5/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_am1_bm0_ix1_iy1
! 

subroutine s_usmv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 1
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*4 :: VA(3)=(/1, 1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-1, -2/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_am1_bm0_ix1_iy1
! 

subroutine s_usmv_2_n_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=1
  ! 1 3
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*4 :: VA(3)=(/1, 3, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-9, 0/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_am3_bp1_ix1_iy1
! 

subroutine s_usmv_2_t_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=1
  ! 1 4
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*4 :: VA(3)=(/1, 4, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-3, -9/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_am3_bp1_ix1_iy1
! 

subroutine s_usmv_2_c_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=1
  ! 1 1
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*4 :: VA(3)=(/1, 1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/0, -3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_am3_bp1_ix1_iy1
! 

subroutine s_usmv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 2 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*4 :: VA(2)=(/1, 2/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-3, -6/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_usmv_2_n_am3_bm0_ix1_iy1
! 

subroutine s_usmv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*4 :: VA(1)=(/1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-3, 0/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_usmv_2_t_am3_bm0_ix1_iy1
! 

subroutine s_usmv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/-3, -3/)! reference cy after 
  real*4 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*4 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_usmv_2_c_am3_bm0_ix1_iy1
! 

subroutine s_ussv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/3, 3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_ussv_2_n_ap3_bm0_ix1_iy1
! 

subroutine s_ussv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/3, 3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_ussv_2_t_ap3_bm0_ix1_iy1
! 

subroutine s_ussv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*4 :: alpha=3
  real*4 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 1, 1/)
  real*4 :: x(2)=(/6, 3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,i,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_ussv_2_c_ap3_bm0_ix1_iy1
! 

subroutine s_ussv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_ussv_2_n_ap1_bm0_ix1_iy1
! 

subroutine s_ussv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_ussv_2_t_ap1_bm0_ix1_iy1
! 

subroutine s_ussv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*4 :: alpha=1
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/1, 1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_ussv_2_c_ap1_bm0_ix1_iy1
! 

subroutine s_ussv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/-1, -1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_ussv_2_n_am1_bm0_ix1_iy1
! 

subroutine s_ussv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 0
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 3, 1/)
  real*4 :: x(2)=(/-4, -1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_ussv_2_t_am1_bm0_ix1_iy1
! 

subroutine s_ussv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*4 :: alpha=-1
  real*4 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*4 :: VA(3)=(/1, 2, 1/)
  real*4 :: x(2)=(/-3, -1/)! reference x 
  real*4 :: cy(2)=(/1, 1/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_ussv_2_c_am1_bm0_ix1_iy1
! 

subroutine s_ussv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/-3, -3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine s_ussv_2_n_am3_bm0_ix1_iy1
! 

subroutine s_ussv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/-3, -3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine s_ussv_2_t_am3_bm0_ix1_iy1
! 

subroutine s_ussv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_s_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*4 :: alpha=-3
  real*4 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*4 :: VA(2)=(/1, 1/)
  real*4 :: x(2)=(/-3, -3/)! reference x 
  real*4 :: cy(2)=(/9, 9/)! reference cy after 
  real*4 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*4 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on s matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine s_ussv_2_c_am3_bm0_ix1_iy1
! 

subroutine d_usmv_2_n_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=1
  ! 1 1
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/9, 3/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_ap3_bp1_ix1_iy1
! 

subroutine d_usmv_2_t_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=1
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/6, 6/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_ap3_bp1_ix1_iy1
! 

subroutine d_usmv_2_c_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=1
  ! 1 0
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/15, 6/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_ap3_bp1_ix1_iy1
! 

subroutine d_usmv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 3
  ! 3 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*8 :: VA(3)=(/1, 3, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/12, 9/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_ap3_bm0_ix1_iy1
! 

subroutine d_usmv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 3
  ! 3 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*8 :: VA(3)=(/1, 3, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/12, 9/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_ap3_bm0_ix1_iy1
! 

subroutine d_usmv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*8 :: VA(1)=(/1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/3, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_ap3_bm0_ix1_iy1
! 

subroutine d_usmv_2_n_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=1
  ! 1 0
  ! 0 2

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 2/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/4, 5/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_ap1_bp1_ix1_iy1
! 

subroutine d_usmv_2_t_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=1
  ! 1 0
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/5, 3/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_ap1_bp1_ix1_iy1
! 

subroutine d_usmv_2_c_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=1
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*8 :: VA(1)=(/1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/4, 3/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_ap1_bp1_ix1_iy1
! 

subroutine d_usmv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 3 4

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 4/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/1, 7/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_ap1_bm0_ix1_iy1
! 

subroutine d_usmv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/2, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_ap1_bm0_ix1_iy1
! 

subroutine d_usmv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 0 3

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/1, 3/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_ap1_bm0_ix1_iy1
! 

subroutine d_usmv_2_n_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=1
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/2, 2/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_am1_bp1_ix1_iy1
! 

subroutine d_usmv_2_t_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=1
  ! 1 3
  ! 1 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*8 :: VA(3)=(/1, 3, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/1, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_am1_bp1_ix1_iy1
! 

subroutine d_usmv_2_c_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=1
  ! 1 0
  ! 0 3

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/2, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_am1_bp1_ix1_iy1
! 

subroutine d_usmv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 3
  ! 0 3

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  real*8 :: VA(3)=(/1, 3, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-4, -3/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_am1_bm0_ix1_iy1
! 

subroutine d_usmv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 0
  ! 3 5

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 5/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-4, -5/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_am1_bm0_ix1_iy1
! 

subroutine d_usmv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 2
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 2/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-1, -2/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_am1_bm0_ix1_iy1
! 

subroutine d_usmv_2_n_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=1
  ! 1 0
  ! 0 6

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 6/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/0, -15/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_am3_bp1_ix1_iy1
! 

subroutine d_usmv_2_t_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=1
  ! 1 2
  ! 1 3

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  real*8 :: VA(4)=(/1, 2, 1, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-3, -12/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_am3_bp1_ix1_iy1
! 

subroutine d_usmv_2_c_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=1
  ! 1 3
  ! 3 0

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  real*8 :: VA(3)=(/1, 3, 3/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-9, -6/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_am3_bp1_ix1_iy1
! 

subroutine d_usmv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*8 :: VA(1)=(/1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-3, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_usmv_2_n_am3_bm0_ix1_iy1
! 

subroutine d_usmv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*8 :: VA(1)=(/1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-3, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_usmv_2_t_am3_bm0_ix1_iy1
! 

subroutine d_usmv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 0 0

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  real*8 :: VA(1)=(/1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/-3, 0/)! reference cy after 
  real*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  real*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_usmv_2_c_am3_bm0_ix1_iy1
! 

subroutine d_ussv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 0
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 1/)
  real*8 :: x(2)=(/3, 12/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_ussv_2_n_ap3_bm0_ix1_iy1
! 

subroutine d_ussv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 2, 1/)
  real*8 :: x(2)=(/9, 3/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_ussv_2_t_ap3_bm0_ix1_iy1
! 

subroutine d_ussv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*8 :: alpha=3
  real*8 :: beta=0
  ! 1 0
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 1/)
  real*8 :: x(2)=(/12, 3/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_ussv_2_c_ap3_bm0_ix1_iy1
! 

subroutine d_ussv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 3 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 3, 1/)
  real*8 :: x(2)=(/1, 4/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_ussv_2_n_ap1_bm0_ix1_iy1
! 

subroutine d_ussv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 1, 1/)
  real*8 :: x(2)=(/2, 1/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_ussv_2_t_ap1_bm0_ix1_iy1
! 

subroutine d_ussv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*8 :: alpha=1
  real*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/1, 1/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_ussv_2_c_ap1_bm0_ix1_iy1
! 

subroutine d_ussv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 1, 1/)
  real*8 :: x(2)=(/-1, -2/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_ussv_2_n_am1_bm0_ix1_iy1
! 

subroutine d_ussv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 0
  ! 6 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 6, 1/)
  real*8 :: x(2)=(/-7, -1/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_ussv_2_t_am1_bm0_ix1_iy1
! 

subroutine d_ussv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*8 :: alpha=-1
  real*8 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 2, 1/)
  real*8 :: x(2)=(/-3, -1/)! reference x 
  real*8 :: cy(2)=(/1, 1/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_ussv_2_c_am1_bm0_ix1_iy1
! 

subroutine d_ussv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  real*8 :: VA(3)=(/1, 1, 1/)
  real*8 :: x(2)=(/-3, -6/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine d_ussv_2_n_am3_bm0_ix1_iy1
! 

subroutine d_ussv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/-3, -3/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine d_ussv_2_t_am3_bm0_ix1_iy1
! 

subroutine d_ussv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_d_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  real*8 :: alpha=-3
  real*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  real*8 :: VA(2)=(/1, 1/)
  real*8 :: x(2)=(/-3, -3/)! reference x 
  real*8 :: cy(2)=(/9, 9/)! reference cy after 
  real*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  real*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on d matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine d_ussv_2_c_am3_bm0_ix1_iy1
! 

subroutine c_usmv_2_n_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 1+1i 2+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,1.e0), (2,2)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(6.e0,3.e0), (12,9)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_ap3_bp1_ix1_iy1
! 

subroutine c_usmv_2_t_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 0+1i 2+6i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (0.e0,1.e0), (2,6)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(6.e0,6.e0), (9,18)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_ap3_bp1_ix1_iy1
! 

subroutine c_usmv_2_c_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=1
  ! 1+1i 3+2i
  ! 0+3i 2+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (3.e0,2.e0), (0.e0,3.e0), (2,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(6.e0,-12.e0), (18,-6)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_ap3_bp1_ix1_iy1
! 

subroutine c_usmv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1+1i 0+0i
  ! 3+3i 6+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (3.e0,3.e0), (6,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(3.e0,3.e0), (27,9)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_ap3_bm0_ix1_iy1
! 

subroutine c_usmv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1+1i 0+0i
  ! 1+2i 2+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,2.e0), (2,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(6.e0,9.e0), (6,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_ap3_bm0_ix1_iy1
! 

subroutine c_usmv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1+1i 1+0i
  ! 0+0i 2+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,0.e0), (2,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(3.e0,-3.e0), (9,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_ap3_bm0_ix1_iy1
! 

subroutine c_usmv_2_n_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 5+1i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (5,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(4.e0,1.e0), (8,1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_ap1_bp1_ix1_iy1
! 

subroutine c_usmv_2_t_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=1
  ! 1+1i 1+0i
  ! 0+1i 0+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (1.e0,0.e0), (0.e0,1.e0), (0,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(4.e0,2.e0), (4,1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_ap1_bp1_ix1_iy1
! 

subroutine c_usmv_2_c_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=1
  ! 1+1i 0+2i
  ! 0+3i 2+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (0.e0,2.e0), (0.e0,3.e0), (2,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(4.e0,-4.e0), (5,-2)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_ap1_bp1_ix1_iy1
! 

subroutine c_usmv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1+1i 1+0i
  ! 0+0i 3+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,0.e0), (3,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(2.e0,1.e0), (3,1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_ap1_bm0_ix1_iy1
! 

subroutine c_usmv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1+1i 0+1i
  ! 0+1i 3+5i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (0.e0,1.e0), (0.e0,1.e0), (3,5)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(1.e0,2.e0), (3,6)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_ap1_bm0_ix1_iy1
! 

subroutine c_usmv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1+1i 0+1i
  ! 0+0i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (0,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(1.e0,-1.e0), (0,-1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_ap1_bm0_ix1_iy1
! 

subroutine c_usmv_2_n_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 0+0i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (1,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(2.e0,-1.e0), (2,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_am1_bp1_ix1_iy1
! 

subroutine c_usmv_2_t_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=1
  ! 1+1i 3+0i
  ! 1+3i 0+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (3.e0,0.e0), (1.e0,3.e0), (0,2)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(1.e0,-4.e0), (0,-2)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_am1_bp1_ix1_iy1
! 

subroutine c_usmv_2_c_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 1+2i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (1,2)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(1.e0,3.e0), (3,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_am1_bp1_ix1_iy1
! 

subroutine c_usmv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1+1i 1+0i
  ! 2+0i 1+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (1.e0,0.e0), (2.e0,0.e0), (1,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-2.e0,-1.e0), (-3,-1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_am1_bm0_ix1_iy1
! 

subroutine c_usmv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1+1i 1+3i
  ! 0+0i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (1,3)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-1.e0,-1.e0), (-1,-3)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_am1_bm0_ix1_iy1
! 

subroutine c_usmv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1+1i 1+0i
  ! 0+1i 5+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (1.e0,0.e0), (0.e0,1.e0), (5,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-1.e0,2.e0), (-6,1)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_am1_bm0_ix1_iy1
! 

subroutine c_usmv_2_n_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=1
  ! 1+1i 0+0i
  ! 3+1i 2+4i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (3.e0,1.e0), (2,4)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(0.e0,-3.e0), (-12,-15)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_am3_bp1_ix1_iy1
! 

subroutine c_usmv_2_t_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=1
  ! 1+1i 0+1i
  ! 0+0i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 1/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/(1.e0,1.e0), (0,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(0.e0,-3.e0), (3,-3)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_am3_bp1_ix1_iy1
! 

subroutine c_usmv_2_c_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=1
  ! 1+1i 1+0i
  ! 1+1i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,0.e0), (1,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-3.e0,6.e0), (0,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_am3_bp1_ix1_iy1
! 

subroutine c_usmv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1+1i 0+0i
  ! 0+2i 0+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (0.e0,2.e0), (0,2)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-3.e0,-3.e0), (0,-12)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_usmv_2_n_am3_bm0_ix1_iy1
! 

subroutine c_usmv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1+1i 0+0i
  ! 1+3i 3+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,1.e0), (1.e0,3.e0), (3,0)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-6.e0,-12.e0), (-9,0)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_usmv_2_t_am3_bm0_ix1_iy1
! 

subroutine c_usmv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1+1i 3+1i
  ! 0+1i 3+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*8 :: VA(4)=(/(1.e0,1.e0), (3.e0,1.e0), (0.e0,1.e0), (3,1)/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/(-3.e0,6.e0), (-18,6)/)! reference cy after 
  complex*8 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*8 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_usmv_2_c_am3_bm0_ix1_iy1
! 

subroutine c_ussv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/1, 1, 1/)
  complex*8 :: x(2)=(/3, 6/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_ussv_2_n_ap3_bm0_ix1_iy1
! 

subroutine c_ussv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 0+2i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (0.e0,2.e0), (1,0)/)
  complex*8 :: x(2)=(/(3.e0,6.e0), (3,0)/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_ussv_2_t_ap3_bm0_ix1_iy1
! 

subroutine c_ussv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*8 :: alpha=3
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 0+4i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (0.e0,4.e0), (1,0)/)
  complex*8 :: x(2)=(/(3.e0,-12.e0), (3,0)/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_ussv_2_c_ap3_bm0_ix1_iy1
! 

subroutine c_ussv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 0+1i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (0.e0,1.e0), (1,0)/)
  complex*8 :: x(2)=(/(1.e0,0.e0), (1,1)/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_ussv_2_n_ap1_bm0_ix1_iy1
! 

subroutine c_ussv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/1, 1/)
  complex*8 :: x(2)=(/1, 1/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_ussv_2_t_ap1_bm0_ix1_iy1
! 

subroutine c_ussv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*8 :: alpha=1
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 3+3i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (3.e0,3.e0), (1,0)/)
  complex*8 :: x(2)=(/(4.e0,-3.e0), (1,0)/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_ussv_2_c_ap1_bm0_ix1_iy1
! 

subroutine c_ussv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1 0
  ! 5 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/1, 5, 1/)
  complex*8 :: x(2)=(/-1, -6/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_ussv_2_n_am1_bm0_ix1_iy1
! 

subroutine c_ussv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 1+2i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (1.e0,2.e0), (1,0)/)
  complex*8 :: x(2)=(/(-2.e0,-2.e0), (-1,0)/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_ussv_2_t_am1_bm0_ix1_iy1
! 

subroutine c_ussv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*8 :: alpha=-1
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 0+4i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (0.e0,4.e0), (1,0)/)
  complex*8 :: x(2)=(/(-1.e0,4.e0), (-1,0)/)! reference x 
  complex*8 :: cy(2)=(/1, 1/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_ussv_2_c_am1_bm0_ix1_iy1
! 

subroutine c_ussv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1+0i 0+0i
  ! 1+1i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*8 :: VA(3)=(/(1.e0,0.e0), (1.e0,1.e0), (1,0)/)
  complex*8 :: x(2)=(/(-3.e0,0.e0), (-6,-3)/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine c_ussv_2_n_am3_bm0_ix1_iy1
! 

subroutine c_ussv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/1, 1/)
  complex*8 :: x(2)=(/-3, -3/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine c_ussv_2_t_am3_bm0_ix1_iy1
! 

subroutine c_ussv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_c_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*8 :: alpha=-3
  complex*8 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*8 :: VA(2)=(/1, 1/)
  complex*8 :: x(2)=(/-3, -3/)! reference x 
  complex*8 :: cy(2)=(/9, 9/)! reference cy after 
  complex*8 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*8 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on c matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine c_ussv_2_c_am3_bm0_ix1_iy1
! 

subroutine z_usmv_2_n_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=1
  ! 1+1i 1+0i
  ! 5+1i 1+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (1.e0,0.e0), (5.e0,1.e0), (1,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(9.e0,3.e0), (21,6)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_ap3_bp1_ix1_iy1
! 

subroutine z_usmv_2_t_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 2+3i 2+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (2.e0,3.e0), (2,2)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(12.e0,12.e0), (9,6)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_ap3_bp1_ix1_iy1
! 

subroutine z_usmv_2_c_ap3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 2+0i 1+3i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (2.e0,0.e0), (1,3)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(12.e0,-3.e0), (6,-9)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_ap3_bp1_ix1_iy1
! 

subroutine z_usmv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 0+0i 0+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*16 :: VA(2)=(/(1.e0,1.e0), (0,2)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(3.e0,3.e0), (0,6)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_ap3_bm0_ix1_iy1
! 

subroutine z_usmv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1+1i 0+1i
  ! 1+0i 3+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (0.e0,1.e0), (1.e0,0.e0), (3,0)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(6.e0,3.e0), (9,3)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_ap3_bm0_ix1_iy1
! 

subroutine z_usmv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 1+3i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  complex*16 :: VA(2)=(/(1.e0,1.e0), (1,3)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(6.e0,-12.e0), (0,0)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_ap3_bm0_ix1_iy1
! 

subroutine z_usmv_2_n_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 0+3i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  complex*16 :: VA(2)=(/(1.e0,1.e0), (0,3)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(4.e0,1.e0), (3,3)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_ap1_bp1_ix1_iy1
! 

subroutine z_usmv_2_t_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 0+1i 1+3i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (0.e0,1.e0), (1,3)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(4.e0,2.e0), (4,3)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_ap1_bp1_ix1_iy1
! 

subroutine z_usmv_2_c_ap1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=1
  ! 1+1i 1+3i
  ! 0+0i 0+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (1.e0,3.e0), (0,2)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(4.e0,-1.e0), (4,-5)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_ap1_bp1_ix1_iy1
! 

subroutine z_usmv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1+1i 3+2i
  ! 0+0i 0+4i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (3.e0,2.e0), (0,4)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(4.e0,3.e0), (0,4)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_ap1_bm0_ix1_iy1
! 

subroutine z_usmv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 0+4i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (0.e0,4.e0), (1,0)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(1.e0,5.e0), (1,0)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_ap1_bm0_ix1_iy1
! 

subroutine z_usmv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 1+3i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 1/)
  complex*16 :: VA(2)=(/(1.e0,1.e0), (1,3)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(2.e0,-4.e0), (0,0)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_ap1_bm0_ix1_iy1
! 

subroutine z_usmv_2_n_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 3+2i 1+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (3.e0,2.e0), (1,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(2.e0,-1.e0), (-1,-3)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_am1_bp1_ix1_iy1
! 

subroutine z_usmv_2_t_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 0+3i 0+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (0.e0,3.e0), (0,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(2.e0,-4.e0), (3,-1)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_am1_bp1_ix1_iy1
! 

subroutine z_usmv_2_c_am1_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 0+4i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (0.e0,4.e0), (1,0)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(2.e0,5.e0), (2,0)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_am1_bp1_ix1_iy1
! 

subroutine z_usmv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 5+3i 2+2i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (5.e0,3.e0), (2,2)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-1.e0,-1.e0), (-7,-5)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_am1_bm0_ix1_iy1
! 

subroutine z_usmv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1+1i 1+0i
  ! 0+3i 3+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (1.e0,0.e0), (0.e0,3.e0), (3,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-1.e0,-4.e0), (-4,-1)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_am1_bm0_ix1_iy1
! 

subroutine z_usmv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1+1i 2+0i
  ! 1+0i 0+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (2.e0,0.e0), (1.e0,0.e0), (0,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-2.e0,1.e0), (-2,1)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_am1_bm0_ix1_iy1
! 

subroutine z_usmv_2_n_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 2+3i 0+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (2.e0,3.e0), (0,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(0.e0,-3.e0), (-3,-12)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_am3_bp1_ix1_iy1
! 

subroutine z_usmv_2_t_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=1
  ! 1+1i 0+0i
  ! 1+4i 2+4i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (1.e0,4.e0), (2,4)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-3.e0,-15.e0), (-3,-12)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_am3_bp1_ix1_iy1
! 

subroutine z_usmv_2_c_am3_bp1_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=1
  ! 1+1i 0+2i
  ! 2+0i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 1, 2/)
  integer :: JA(3)=(/1, 2, 1/)
  complex*16 :: VA(3)=(/(1.e0,1.e0), (0.e0,2.e0), (2,0)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-6.e0,3.e0), (3,6)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 1 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_am3_bp1_ix1_iy1
! 

subroutine z_usmv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1+1i 0+3i
  ! 0+1i 1+1i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (0.e0,3.e0), (0.e0,1.e0), (1,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-3.e0,-12.e0), (-3,-6)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_usmv_2_n_am3_bm0_ix1_iy1
! 

subroutine z_usmv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1+1i 0+1i
  ! 0+3i 1+5i

  ! declaration of VA,IA,JA 
  integer :: nnz=4
  integer :: m=2
  integer :: k=2
  integer :: IA(4)=(/1, 1, 2, 2/)
  integer :: JA(4)=(/1, 2, 1, 2/)
  complex*16 :: VA(4)=(/(1.e0,1.e0), (0.e0,1.e0), (0.e0,3.e0), (1,5)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-3.e0,-12.e0), (-3,-18)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_usmv_2_t_am3_bm0_ix1_iy1
! 

subroutine z_usmv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  integer :: incy=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1+1i 0+0i
  ! 0+0i 0+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=1
  integer :: m=2
  integer :: k=2
  integer :: IA(1)=(/1/)
  integer :: JA(1)=(/1/)
  complex*16 :: VA(1)=(/(1,1)/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/(-3.e0,3.e0), (0,0)/)! reference cy after 
  complex*16 :: bcy(2)=(/3, 3/)! reference bcy before 
  complex*16 :: y(2)=(/3, 3/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spmm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spmm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 usmv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_usmv_2_c_am3_bm0_ix1_iy1
! 

subroutine z_ussv_2_n_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1+0i 0+0i
  ! 0+2i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,0.e0), (0.e0,2.e0), (1,0)/)
  complex*16 :: x(2)=(/(3.e0,0.e0), (3,6)/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_ussv_2_n_ap3_bm0_ix1_iy1
! 

subroutine z_ussv_2_t_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1+0i 0+0i
  ! 0+1i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,0.e0), (0.e0,1.e0), (1,0)/)
  complex*16 :: x(2)=(/(3.e0,3.e0), (3,0)/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_ussv_2_t_ap3_bm0_ix1_iy1
! 

subroutine z_ussv_2_c_ap3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*16 :: alpha=3
  complex*16 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/1, 1, 1/)
  complex*16 :: x(2)=(/6, 3/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_ussv_2_c_ap3_bm0_ix1_iy1
! 

subroutine z_ussv_2_n_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1+0i 0+0i
  ! 1+5i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,0.e0), (1.e0,5.e0), (1,0)/)
  complex*16 :: x(2)=(/(1.e0,0.e0), (2,5)/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_ussv_2_n_ap1_bm0_ix1_iy1
! 

subroutine z_ussv_2_t_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*16 :: VA(2)=(/1, 1/)
  complex*16 :: x(2)=(/1, 1/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_ussv_2_t_ap1_bm0_ix1_iy1
! 

subroutine z_ussv_2_c_ap1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*16 :: alpha=1
  complex*16 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/1, 2, 1/)
  complex*16 :: x(2)=(/3, 1/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha= 1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_ussv_2_c_ap1_bm0_ix1_iy1
! 

subroutine z_ussv_2_n_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/1, 2, 1/)
  complex*16 :: x(2)=(/-1, -3/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_ussv_2_n_am1_bm0_ix1_iy1
! 

subroutine z_ussv_2_t_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1 0
  ! 0 1

  ! declaration of VA,IA,JA 
  integer :: nnz=2
  integer :: m=2
  integer :: k=2
  integer :: IA(2)=(/1, 2/)
  integer :: JA(2)=(/1, 2/)
  complex*16 :: VA(2)=(/1, 1/)
  complex*16 :: x(2)=(/-1, -1/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_ussv_2_t_am1_bm0_ix1_iy1
! 

subroutine z_ussv_2_c_am1_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*16 :: alpha=-1
  complex*16 :: beta=0
  ! 1 0
  ! 2 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/1, 2, 1/)
  complex*16 :: x(2)=(/-3, -1/)! reference x 
  complex*16 :: cy(2)=(/1, 1/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-1 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_ussv_2_c_am1_bm0_ix1_iy1
! 

subroutine z_ussv_2_n_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='n'
  integer :: incx=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1 0
  ! 1 1

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/1, 1, 1/)
  complex*16 :: x(2)=(/-3, -6/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=n is ok"
end subroutine z_ussv_2_n_am3_bm0_ix1_iy1
! 

subroutine z_ussv_2_t_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='t'
  integer :: incx=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1+0i 0+0i
  ! 1+3i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,0.e0), (1.e0,3.e0), (1,0)/)
  complex*16 :: x(2)=(/(-6.e0,-9.e0), (-3,0)/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=t is ok"
end subroutine z_ussv_2_t_am3_bm0_ix1_iy1
! 

subroutine z_ussv_2_c_am3_bm0_ix1_iy1(res,afmt,ictxt)
  use psb_sparse_mod  
  implicit none
  character(len=*) :: afmt
  type(psb_z_sparse_mat) :: a
  type(psb_desc_type)   :: desc_a
  integer            :: ictxt, iam=-1, np=-1
  integer            :: info=-1

  integer::res,istat=0,i
  character::transa='c'
  integer :: incx=1
  complex*16 :: alpha=-3
  complex*16 :: beta=0
  ! 1+0i 0+0i
  ! 2+3i 1+0i

  ! declaration of VA,IA,JA 
  integer :: nnz=3
  integer :: m=2
  integer :: k=2
  integer :: IA(3)=(/1, 2, 2/)
  integer :: JA(3)=(/1, 1, 2/)
  complex*16 :: VA(3)=(/(1.e0,0.e0), (2.e0,3.e0), (1,0)/)
  complex*16 :: x(2)=(/(-9.e0,9.e0), (-3,0)/)! reference x 
  complex*16 :: cy(2)=(/9, 9/)! reference cy after 
  complex*16 :: bcy(2)=(/0, 0/)! reference bcy before 
  complex*16 :: y(2)=(/0, 0/)! y 

  y=bcy
  res=0
  call psb_info(ictxt,iam,np)
  if(iam<0)then
    info=-1
    goto 9999
  endif
  call psb_barrier(ictxt)
  call psb_cdall(ictxt,desc_a,info,nl=m)
  if (info /= psb_success_)goto 9996
  call psb_spall(a,desc_a,info,nnz=nnz)
  if (info /= psb_success_)goto 9996
  call a%set_triangle()
  call a%set_lower()
  call a%set_unit(.false.)

  call psb_barrier(ictxt)
  call psb_spins(nnz,IA,JA,VA,a,desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_cdasb(desc_a,info)
  if (info /= psb_success_)goto 9996
  call psb_spasb(a,desc_a,info,dupl=psb_dupl_err_,afmt=afmt)
  if(info.ne.0)print *,"matrix assembly failed"
  if(info.ne.0)goto 9996

  call psb_spsm(alpha,A,x,beta,y,desc_a,info,transa)
  if(info.ne.0)print *,"psb_spsm failed"
  if(info.ne.0)goto 9996
  do i=1,2
    if(y(i) /= cy(i))print*,"results mismatch:",y,"instead of",cy
    if(y(i) /= cy(i))info=-1
    if(y(i) /= cy(i))goto 9996
  enddo
9996 continue
  if(info /= psb_success_)res=res+1
  call psb_spfree(a,desc_a,info)
  if (info /= psb_success_)goto 9997
9997 continue
  if(info /= psb_success_)res=res+1
  call psb_cdfree(desc_a,info)
  if (info /= psb_success_)goto 9998
9998 continue
  if(info /= psb_success_)res=res+1
9999 continue
  if(info /= psb_success_)res=res+1
  if(res /= 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is not ok"
  if(res == 0)print*,"on z matrix    2 x    2 blocked   1 x   1 ussv alpha=-3 beta= 0 incx=1 incy=1 trans=c is ok"
end subroutine z_ussv_2_c_am3_bm0_ix1_iy1
end module psb_mvsv_tester