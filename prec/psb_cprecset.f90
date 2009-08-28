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
subroutine psb_cprecseti(p,what,val,info)

  use psb_base_mod
  use psb_prec_mod, psb_protect_name => psb_cprecseti
  implicit none
  type(psb_cprec_type), intent(inout)    :: p
  integer                                :: what, val 
  integer, intent(out)                   :: info

  info = 0

  select case(what)
  case (psb_f_type_) 
    if (p%iprcparm(psb_p_type_) /= psb_bjac_) then 
      write(0,*) 'WHAT is invalid for current preconditioner ',p%iprcparm(psb_p_type_),&
           & 'ignoring user specification'
      return
    endif
    p%iprcparm(psb_f_type_)     = val

  case (psb_ilu_fill_in_) 
    if ((p%iprcparm(psb_p_type_) /= psb_bjac_).or.(p%iprcparm(psb_f_type_) /= psb_f_ilu_n_)) then 
      write(0,*) 'WHAT is invalid for current preconditioner ',p%iprcparm(psb_p_type_),&
           & 'ignoring user specification'
      return
    endif
    p%iprcparm(psb_ilu_fill_in_) = val
 
  case default
    write(0,*) 'WHAT is invalid, ignoring user specification'

  end select
  return

end subroutine psb_cprecseti


subroutine psb_cprecsets(p,what,val,info)

  use psb_base_mod
  use psb_prec_mod, psb_protect_name => psb_cprecsets
  implicit none
  type(psb_cprec_type), intent(inout)    :: p
  integer                                :: what
  real(psb_spk_)                       :: val 
  integer, intent(out)                   :: info

!
!  This will have to be changed if/when we put together an ILU(eps)
!  factorization.
!
  select case(what)
!!$  case (psb_f_type_) 
!!$    if (p%iprcparm(psb_p_type_) /= psb_bjac_) then 
!!$      write(0,*) 'WHAT is invalid for current preconditioner ',p%iprcparm(psb_p_type_),&
!!$           & 'ignoring user specification'
!!$      return
!!$    endif
!!$    p%iprcparm(psb_f_type_)     = val
!!$
!!$  case (psb_ilu_fill_in_) 
!!$    if ((p%iprcparm(psb_p_type_) /= psb_bjac_).or.(p%iprcparm(psb_f_type_) /= psb_f_ilu_n_)) then 
!!$      write(0,*) 'WHAT is invalid for current preconditioner ',p%iprcparm(psb_p_type_),&
!!$           & 'ignoring user specification'
!!$      return
!!$    endif
!!$    p%iprcparm(psb_ilu_fill_in_) = val
 
  case default
    write(0,*) 'WHAT is invalid, ignoring user specification'

  end select
  return

end subroutine psb_cprecsets