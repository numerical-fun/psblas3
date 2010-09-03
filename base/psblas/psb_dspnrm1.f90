!!$ 
!!$              Parallel Sparse BLAS  version 3.0
!!$    (C) Copyright 2006, 2007, 2008, 2009, 2010
!!$                       Salvatore Filippone    University of Rome Tor Vergata
!!$                       Alfredo Buttari        CNRS-IRIT, Toulouse
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
! File: psb_dnrmi.f90
!
! Function: psb_dnrmi
!    Forms the approximated norm of a sparse matrix,       
!
!    norm1 := max(sum(abs(A(:,j))))                                                 
!
! Arguments:
!    a      -  type(psb_dspmat_type).   The sparse matrix containing A.
!    desc_a -  type(psb_desc_type).     The communication descriptor.
!    info   -  integer.                   Return code
!
function psb_dspnrm1(a,desc_a,info)  
!!$  use psb_descriptor_type
!!$  use psb_serial_mod
!!$  use psb_check_mod
!!$  use psb_error_mod
!!$  use psb_penv_mod
!!$  use psb_mat_mod
!!$  use psb_tools_mod
  use psb_sparse_mod, psb_protect_name => psb_dspnrm1
  implicit none

  type(psb_d_sparse_mat), intent(in) :: a
  integer, intent(out)               :: info
  type(psb_desc_type), intent(in)    :: desc_a
  real(psb_dpk_)                     :: psb_dspnrm1

  ! locals
  integer                  :: ictxt, np, me, nr,nc,&
       & err_act, n, iia, jja, ia, ja, mdim, ndim, m
  real(psb_dpk_)         :: nrm1
  character(len=20)      :: name, ch_err
  real(psb_dpk_), allocatable :: v(:)

  name='psb_dnrm1'
  if(psb_get_errstatus() /= 0) return 
  info=psb_success_
  call psb_erractionsave(err_act)

  ictxt=psb_cd_get_context(desc_a)

  call psb_info(ictxt, me, np)
  if (np == -1) then
    info = psb_err_context_error_
    call psb_errpush(info,name)
    goto 9999
  endif

  ia = 1
  ja = 1
  m = psb_cd_get_global_rows(desc_a)
  n = psb_cd_get_global_cols(desc_a)
  nr = psb_cd_get_local_rows(desc_a)
  nc = psb_cd_get_local_cols(desc_a)

  call psb_chkmat(m,n,ia,ja,desc_a,info,iia,jja)
  if(info /= psb_success_) then
    info=psb_err_from_subroutine_
    ch_err='psb_chkmat'
    call psb_errpush(info,name,a_err=ch_err)
    goto 9999
  end if

  if ((iia /= 1).or.(jja /= 1)) then
    info=psb_err_ix_n1_iy_n1_unsupported_
    call psb_errpush(info,name)
    goto 9999
  end if

  call psb_geall(v,desc_a,info)
  if(info == psb_success_) then 
    v = dzero
    call psb_geasb(v,desc_a,info)
  end if
  if(info /= psb_success_) then
    info=psb_err_from_subroutine_
    ch_err='geall/asb'
    call psb_errpush(info,name,a_err=ch_err)
    goto 9999
  end if
  
  if ((m /= 0).and.(n /= 0)) then
    call a%aclsum(v)
    call psb_halo(v,desc_a,info,tran='T')
    if(info /= psb_success_) then
      info=psb_err_from_subroutine_
      ch_err='psb_halo'
      call psb_errpush(info,name,a_err=ch_err)
      goto 9999
    end if
    nrm1 = maxval(v(1:nr))
  else
    nrm1 = 0.d0
  end if
  ! compute global max
  call psb_amx(ictxt, nrm1)

  psb_dspnrm1 = nrm1

  call psb_erractionrestore(err_act)
  return  

9999 continue
  call psb_erractionrestore(err_act)

  if (err_act == psb_act_abort_) then
    call psb_error(ictxt)
    return
  end if
  return
end function psb_dspnrm1