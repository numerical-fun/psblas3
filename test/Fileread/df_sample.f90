!!$ 
!!$              Parallel Sparse BLAS  v2.0
!!$    (C) Copyright 2006 Salvatore Filippone    University of Rome Tor Vergata
!!$                       Alfredo Buttari        University of Rome Tor Vergata
!!$ 
!!$  Redistribution and use in source and binary forms, with or without
!!$  modification, are permitted provided that the following conditions
!!$  are met:
!!$    1. Redistributions of source code must retain the above copyright
!!$       notice, this list of conditions and the following disclaimer.
!!$    2. Redistributions in binary form must reproduce the above copyright
!!$       notice, this list of conditions, and the following disclaimer in the
!!$       documentation and/or other materials provided with the distribution.
!!$    3. The name of the PSBLAS group or the names of its contributors may
!!$       not be used to endorse or promote products derived from this
!!$       software without specific written permission.
!!$ 
!!$  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
!!$  ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
!!$  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
!!$  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE PSBLAS GROUP OR ITS CONTRIBUTORS
!!$  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
!!$  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
!!$  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
!!$  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!!$  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
!!$  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
!!$  POSSIBILITY OF SUCH DAMAGE.
!!$ 
!!$  
program df_sample
  use psb_sparse_mod
  use mat_dist
  use read_mat
  use partgraph
  use getp
  implicit none

  ! input parameters
  character*40 :: cmethd, mtrx_file, rhs_file
  character*80 :: charbuf

  interface 
    !   .....user passed subroutine.....
    subroutine part_block(global_indx,n,np,pv,nv)
      implicit none
      integer, intent(in)  :: global_indx, n, np
      integer, intent(out) :: nv
      integer, intent(out) :: pv(*) 
    end subroutine part_block
  end interface   ! local variables
  interface 
    !   .....user passed subroutine.....
    subroutine part_blk2(global_indx,n,np,pv,nv)
      implicit none
      integer, intent(in)  :: global_indx, n, np
      integer, intent(out) :: nv
      integer, intent(out) :: pv(*) 
    end subroutine part_blk2
  end interface   ! local variables


  ! sparse matrices
  type(psb_dspmat_type) :: a, aux_a

  ! preconditioner data
  type(psb_dprec_type)  :: pre
  integer               :: igsmth, matop, novr

  ! dense matrices
  real(kind(1.d0)), pointer       ::  aux_b(:,:), d(:)
  real(kind(1.d0)), pointer, save :: b_col(:), x_col(:), r_col(:), &
       & b_col_glob(:), x_col_glob(:), r_col_glob(:)

  ! communications data structure
  type(psb_desc_type):: desc_a

  ! blacs variables
  integer               :: nprow, npcol, ictxt, iam, np, myprow, mypcol
  character, parameter  :: order='r'
  logical               :: amroot

  ! solver paramters
  integer            :: iter, itmax, ierr, itrace, ircode, ipart,&
       & methd, istopc, iprec, ml
  real(kind(1.d0))   :: err, eps

  character(len=5)   :: afmt
  character(len=20)  :: name
  integer   :: iparm(20)

  ! other variables
  integer            :: i,info,j,m_problem, nproc
  integer            :: internal, m,ii,nnzero
  real(kind(1.d0)) :: mpi_wtime, t1, t2, tprec, r_amax, b_amax,&
       &scale,resmx,resmxp
  integer :: nrhs, nrow, n_row, dim, nv, ne
  integer, pointer :: ivg(:), ipv(:), neigh(:)

  external mpi_wtime
  

  ! initialize blacs
  call blacs_pinfo(iam, np)
  call blacs_get(izero, izero, ictxt)

  ! rectangular grid,  np x 1

  call blacs_gridinit(ictxt, order, np, ione)
  call blacs_gridinfo(ictxt, nprow, npcol, myprow, mypcol)
  amroot = (myprow==0).and.(mypcol==0)

  name='df_sample'
  if(psb_get_errstatus().ne.0) goto 9999
  info=0
  call psb_set_errverbosity(2)
  call psb_set_erraction(0)
  !
  !  get parameters
  !
  call get_parms(ictxt,mtrx_file,rhs_file,cmethd,&
       & ipart,afmt,istopc,itmax,itrace,novr,iprec,eps)

  call blacs_barrier(ictxt,'a')
  t1 = mpi_wtime()  
  ! read the input matrix to be processed and (possibly) the rhs 
  nrhs = 1
  nproc = nprow 

  if (amroot) then
    nullify(aux_b)
    call readmat(mtrx_file, aux_a, ictxt)

    m_problem = aux_a%m
    call gebs2d(ictxt,'a',m_problem)

    if(rhs_file /= 'NONE') then
       !  reading an rhs
       call read_rhs(rhs_file,aux_b,ictxt)
    end if

    if (associated(aux_b).and.size(aux_b,1)==m_problem) then
      ! if any rhs were present, broadcast the first one
      write(0,'("Ok, got an rhs ")')
      b_col_glob =>aux_b(:,1)
    else
      write(*,'("Generating an rhs...")')
      write(*,'(" ")')
      allocate(aux_b(m_problem,1), stat=ircode)
      if (ircode /= 0) then
         call psb_errpush(4000,name)
         goto 9999
      endif

      b_col_glob => aux_b(:,1)
      do i=1, m_problem
         b_col_glob(i) = 1.d0
      enddo      
    endif
    call gebs2d(ictxt,'a',b_col_glob(1:m_problem))
  else
    call gebr2d(ictxt,'a',m_problem)
    allocate(aux_b(m_problem,1), stat=ircode)
    if (ircode /= 0) then
       call psb_errpush(4000,name)
       goto 9999
    endif
    b_col_glob =>aux_b(:,1)
    call gebr2d(ictxt,'a',b_col_glob(1:m_problem)) 
  end if

  ! switch over different partition types
  if (ipart.eq.0) then 
     call blacs_barrier(ictxt,'a')
     if (amroot) write(*,'("Partition type: block")')
     allocate(ivg(m_problem),ipv(np))
     do i=1,m_problem
        call part_block(i,m_problem,np,ipv,nv)
        ivg(i) = ipv(1)
     enddo
     call matdist(aux_a, a, ivg, ictxt, &
          & desc_a,b_col_glob,b_col,info,fmt=afmt)
  else  if (ipart.eq.1) then 
    call blacs_barrier(ictxt,'a')
    if (amroot) write(*,'("Partition type: blk2")')
    allocate(ivg(m_problem),ipv(np))
    do i=1,m_problem
       call part_blk2(i,m_problem,np,ipv,nv)
       ivg(i) = ipv(1)
    enddo
    call matdist(aux_a, a, ivg, ictxt, &
         & desc_a,b_col_glob,b_col,info,fmt=afmt)
  else if (ipart.eq.2) then 
    if (amroot) then 
       write(*,'("Partition type: graph")')
       write(*,'(" ")')
!      write(0,'("Build type: graph")')
      call build_grppart(aux_a%m,aux_a%fida,aux_a%ia1,aux_a%ia2,np)
    endif
    call blacs_barrier(ictxt,'a')
    call distr_grppart(0,0,ictxt)
    call getv_grppart(ivg)
    call matdist(aux_a, a, ivg, ictxt, &
         & desc_a,b_col_glob,b_col,info,fmt=afmt)
  else 
    if (amroot) write(*,'("Partition type: block")')
    call matdist(aux_a, a, part_block, ictxt, &
         & desc_a,b_col_glob,b_col,info,fmt=afmt)
  end if
  
  call psb_geall(m_problem,x_col,desc_a,info)
  x_col(:) =0.0
  call psb_geasb(x_col,desc_a,info)
  call psb_geall(m_problem,r_col,desc_a,info)
  r_col(:) =0.0
  call psb_geasb(r_col,desc_a,info)
  t2 = mpi_wtime() - t1
  
  
  call gamx2d(ictxt, 'a', t2)
  
  if (amroot) then
     write(*,'(" ")')
     write(*,'("Time to read and partition matrix : ",es10.4)')t2
     write(*,'(" ")')
  end if

  !
  !  prepare the preconditioning matrix. note the availability
  !  of optional parameters
  !

  ! zero initial guess.
  matop=1
  igsmth=-1
  select case(iprec)
  case(noprec_)
    call psb_precset(pre,'noprec')
  case(diagsc_)             
    call psb_precset(pre,'diagsc')
  case(bja_)             
    call psb_precset(pre,'ilu')
  case(asm_)             
    call psb_precset(pre,'asm',iv=(/novr,halo_,sum_/))
  case(ash_)             
    call psb_precset(pre,'asm',iv=(/novr,nohalo_,sum_/))
  case(ras_)             
    call psb_precset(pre,'asm',iv=(/novr,halo_,none_/))
  case(rash_)             
    call psb_precset(pre,'asm',iv=(/novr,nohalo_,none_/))
  case default
    call psb_precset(pre,'ilu')
  end select

  ! building the preconditioner
  t1 = mpi_wtime()
  call psb_precbld(a,desc_a,pre,info)
  tprec = mpi_wtime()-t1
  if (info /= 0) then
     call psb_errpush(4010,name,a_err='psb_precbld')
     goto 9999
  end if
  
  
  call gamx2d(ictxt,'a',tprec)
  
  if(amroot) then
     write(*,'("Preconditioner time: ",es10.4)')tprec
     write(*,'(" ")')
  end if

  iparm = 0
  call blacs_barrier(ictxt,'all')
  t1 = mpi_wtime()
  if (cmethd.eq.'BICGSTAB') then
    call  psb_bicgstab(a,pre,b_col,x_col,eps,desc_a,info,& 
       & itmax,iter,err,itrace,istop=istopc)     
  else if (cmethd.eq.'BICG') then
    call  psb_bicg(a,pre,b_col,x_col,eps,desc_a,info,& 
       & itmax,iter,err,itrace)     
  else if (cmethd.eq.'CGS') then
    call  psb_cgs(a,pre,b_col,x_col,eps,desc_a,info,& 
       & itmax,iter,err,itrace)     
  else if (cmethd.eq.'CG') then
    call  psb_cg(a,pre,b_col,x_col,eps,desc_a,info,& 
       & itmax,iter,err,itrace)     
  else if (cmethd.eq.'BICGSTABL') then
    call  psb_bicgstabl(a,pre,b_col,x_col,eps,desc_a,info,& 
       & itmax,iter,err,ierr,itrace,ml)     
  endif
  call blacs_barrier(ictxt,'all')
  t2 = mpi_wtime() - t1
  call gamx2d(ictxt,'a',t2)
  call psb_geaxpby(1.d0,b_col,0.d0,r_col,desc_a,info)
  call psb_spmm(-1.d0,a,x_col,1.d0,r_col,desc_a,info)
  call psb_genrm2s(resmx,r_col,desc_a,info)
  call psb_geamaxs(resmxp,r_col,desc_a,info)

  if (amroot) then 
    call psb_prec_descr(6,pre)
    write(*,'("Matrix: ",a)')mtrx_file
    write(*,'("Computed solution on ",i4," processors")')nprow
    write(*,'("Iterations to convergence: ",i6)')iter
    write(*,'("Error indicator on exit: ",f7.2)')err
    write(*,'("Time to buil prec.   : ",es10.4)')tprec
    write(*,'("Time to solve matrix : ",es10.4)')t2
    write(*,'("Time per iteration   : ",es10.4)')t2/(iter)
    write(*,'("Total time           : ",es10.4)')t2+tprec
    write(*,'("Residual norm 2   = ",es10.4)')resmx
    write(*,'("Residual norm inf = ",es10.4)')resmxp
  end if

  allocate(x_col_glob(m_problem),r_col_glob(m_problem),stat=ierr)
  if (ierr.ne.0) then 
    write(0,*) 'allocation error: no data collection'
  else
    call psb_gather(x_col_glob,x_col,desc_a,info,iroot=0)
    call psb_gather(r_col_glob,r_col,desc_a,info,iroot=0)
    if (amroot) then
      write(0,'(" ")')
      write(0,'("Saving x on file")')
      write(20,*) 'matrix: ',mtrx_file
      write(20,*) 'computed solution on ',nprow,' processors.'
      write(20,*) 'iterations to convergence: ',iter
      write(20,*) 'error indicator (infinity norm) on exit:', &
           & ' ||r||/(||a||||x||+||b||) = ',err
      write(20,*) 'max residual = ',resmx, resmxp
      do i=1,m_problem
        write(20,998) i,x_col_glob(i),r_col_glob(i),b_col_glob(i)
      enddo
    end if
  end if
998 format(i8,4(2x,g20.14))
993 format(i6,4(1x,e12.6))

  
  call psb_gefree(b_col, desc_a,info)
  call psb_gefree(x_col, desc_a,info)
  call psb_spfree(a, desc_a,info)
  call psb_precfree(pre,info)
  call psb_cdfree(desc_a,info)

9999 continue
  if(info /= 0) then
     call psb_error(ictxt)
     call blacs_gridexit(ictxt)
     call blacs_exit(0)
  else
     call blacs_gridexit(ictxt)
     call blacs_exit(0)
  end if

  stop
  
end program df_sample
  




