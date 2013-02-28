!!$ 
!!$              Parallel Sparse BLAS  version 3.0
!!$    (C) Copyright 2006, 2007, 2008, 2009, 2010, 2012
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
subroutine psb_dprecbld(a,desc_a,p,info,upd,amold,afmt,vmold)

  use psb_base_mod
  use psb_d_prec_type
  Implicit None

  type(psb_dspmat_type), intent(in), target  :: a
  type(psb_desc_type), intent(in), target      :: desc_a
  type(psb_dprec_type),intent(inout)         :: p
  integer(psb_ipk_), intent(out)               :: info
  character, intent(in), optional              :: upd
  character(len=*), intent(in), optional       :: afmt
  class(psb_d_base_sparse_mat), intent(in), optional :: amold
  class(psb_d_base_vect_type), intent(in), optional  :: vmold

  ! Local scalars
  integer(psb_ipk_) :: ictxt, me,np
  integer(psb_ipk_) :: err, n_row, n_col,mglob, err_act
  integer(psb_ipk_) :: int_err(5)
  character    :: upd_

  integer(psb_ipk_),parameter  :: iroot=psb_root_,iout=60,ilout=40
  character(len=20)   :: name, ch_err

  if(psb_get_errstatus() /= 0) return 
  info=psb_success_
  err=0
  call psb_erractionsave(err_act)
  name = 'psb_precbld'

  info = psb_success_
  int_err(1) = 0
  ictxt = desc_a%get_context()

  call psb_info(ictxt, me, np)

  n_row   = desc_a%get_local_rows()
  n_col   = desc_a%get_local_cols()
  mglob   = desc_a%get_global_rows()
  !
  ! Should add check to ensure all procs have the same... 
  !
  ! ALso should define symbolic names for the preconditioners. 
  !

  if (.not.allocated(p%prec)) then
    info = 1124
    call psb_errpush(info,name,a_err="preconditioner")
    goto 9999
  end if

  call p%prec%precbld(a,desc_a,info,upd=upd,&
       & afmt=afmt,amold=amold,vmold=vmold)

  if (info /= psb_success_) goto 9999

  call psb_erractionrestore(err_act)
  return

9999 continue
  call psb_erractionrestore(err_act)
  if (err_act == psb_act_abort_) then
    call psb_error()
    return
  end if
  return


end subroutine psb_dprecbld

