!!$ 
!!$              Parallel Sparse BLAS  version 2.2
!!$    (C) Copyright 2006/2007/2008
!!$                       Salvatore Filippone    University of Rome Tor Vergata
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
subroutine psb_cgprec_aply(alpha,prec,x,beta,y,desc_data,trans,work,info)
  !
  !  Compute   Y <-  beta*Y + alpha*K^-1 X 
  !  where K is a a basic preconditioner stored in prec
  ! 

  use psb_base_mod
  use psb_prec_mod, psb_protect_name => psb_cgprec_aply
  implicit none 

  type(psb_desc_type),intent(in)    :: desc_data
  type(psb_cprec_type), intent(in)  :: prec
  complex(psb_spk_),intent(in)    :: x(:)
  complex(psb_spk_),intent(inout) :: y(:)
  complex(psb_spk_),intent(in)    :: alpha,beta
  character(len=1)                  :: trans
  complex(psb_spk_),target        :: work(:)
  integer, intent(out)              :: info

  ! Local variables
  integer :: n_row,int_err(5)
  complex(psb_spk_), pointer :: ww(:)
  character     :: trans_
  integer :: ictxt,np,me, err_act
  character(len=20)   :: name, ch_err


  name='psb_cgprec_aply'
  info = 0
  call psb_erractionsave(err_act)

  ictxt=desc_data%matrix_data(psb_ctxt_)
  call psb_info(ictxt, me, np)

  trans_ = psb_toupper(trans)

  select case(trans_)
  case('N')
  case('T','C')
  case default
     info=40
     int_err(1)=6
     ch_err(2:2)=trans
     goto 9999
  end select

  select case(prec%iprcparm(psb_p_type_))

  case(psb_noprec_)

    call psb_geaxpby(alpha,x,beta,y,desc_data,info)

  case(psb_diag_)
    
    if (size(work) >= size(x)) then 
      ww => work
    else
      allocate(ww(size(x)),stat=info)
      if (info /= 0) then 
        call psb_errpush(4010,name,a_err='Allocate')
        goto 9999      
      end if
    end if

    n_row=desc_data%matrix_data(psb_n_row_)
    if (trans_=='C') then 
      ww(1:n_row) = x(1:n_row)*conjg(prec%d(1:n_row))
    else
      ww(1:n_row) = x(1:n_row)*prec%d(1:n_row)
    endif
    call psb_geaxpby(alpha,ww,beta,y,desc_data,info)

    if (size(work) < size(x)) then 
      deallocate(ww,stat=info)
      if (info /= 0) then 
        call psb_errpush(4010,name,a_err='Deallocate')
        goto 9999      
      end if
    end if

  case(psb_bjac_)

    call psb_bjac_aply(alpha,prec,x,beta,y,desc_data,trans_,work,info)
    if(info /= 0) then
       info=4010
       ch_err='psb_bjac_aply'
       goto 9999
    end if

  case default
    info = 4001
    call psb_errpush(info,name,a_err='Invalid prectype')
    goto 9999
  end select

  call psb_erractionrestore(err_act)
  return

9999 continue
  call psb_errpush(info,name,i_err=int_err,a_err=ch_err)
  call psb_erractionrestore(err_act)
  if (err_act == psb_act_abort_) then
    call psb_error()
    return
  end if
  return

end subroutine psb_cgprec_aply
