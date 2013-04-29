!!$ 
!!$              Parallel Sparse BLAS  version 3.1
!!$    (C) Copyright 2006, 2007, 2008, 2009, 2010, 2012, 2013
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
! File: psb_ifree.f90
!
! Subroutine: psb_ifree
!    frees a dense integer matrix structure
! 
! Arguments: 
!    x(:,:)   - integer(psb_ipk_), allocatable                 The dense matrix to be freed.
!    desc_a   - type(psb_desc_type).               The communication descriptor.
!    info     - integer.                             Eventually returns an error code
subroutine psb_ifree(x, desc_a, info)
  use psb_base_mod, psb_protect_name => psb_ifree
  implicit none

  !....parameters...
  integer(psb_ipk_), allocatable, intent(inout) :: x(:,:)
  type(psb_desc_type), intent(in)     :: desc_a
  integer(psb_ipk_), intent(out)                :: info
  
  !...locals....
  integer(psb_ipk_) :: ictxt,np,me, err_act
  character(len=20)   :: name


  if(psb_get_errstatus() /= 0) return 
  info=psb_success_
  call psb_erractionsave(err_act)
  name = 'psb_ifree'
  
  if (.not.psb_is_ok_desc(desc_a)) then
     info=psb_err_forgot_spall_
     call psb_errpush(info,name)
     return
  end if

  ictxt=desc_a%get_context()

  call psb_info(ictxt, me, np)
  !     ....verify blacs grid correctness..
  if (np == -1) then
    info = psb_err_context_error_
    call psb_errpush(info,name)
    goto 9999
  endif

  if (.not.allocated(x)) then
     info=psb_err_forgot_geall_
     call psb_errpush(info,name)
     goto 9999
  end if
  
  !deallocate x
  deallocate(x,stat=info)
  if (info /= psb_success_) then
     info=2045
     call psb_errpush(info,name)
     goto 9999
  endif
  
  call psb_erractionrestore(err_act)
  return

9999 continue
  call psb_erractionrestore(err_act)
  if (err_act == psb_act_abort_) then
     call psb_error(ictxt)
     return
  end if
  return

end subroutine psb_ifree



!!$ 
!!$              Parallel Sparse BLAS  version 3.1
!!$    (C) Copyright 2006, 2007, 2008, 2009, 2010, 2012, 2013
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
! Subroutine: psb_ifreev
!    frees a dense integer matrix structure
! 
! Arguments: 
!    x(:)     - integer(psb_ipk_), allocatable                 The dense matrix to be freed.
!    desc_a   - type(psb_desc_type).               The communication descriptor.
!    info     - integer.                             Eventually returns an error code
subroutine psb_ifreev(x, desc_a,info)
  use psb_base_mod, psb_protect_name => psb_ifreev
  implicit none
  !....parameters...
  integer(psb_ipk_), allocatable, intent(inout) :: x(:)
  type(psb_desc_type), intent(in)     :: desc_a
  integer(psb_ipk_), intent(out)                :: info 
  !...locals....
  integer(psb_ipk_) :: ictxt,np,me, err_act
  character(len=20)   :: name


  if(psb_get_errstatus() /= 0) return 
  info=psb_success_
  call psb_erractionsave(err_act)
  name = 'psb_ifreev'


  if (.not.psb_is_ok_desc(desc_a)) then
    info=psb_err_forgot_spall_
    call psb_errpush(info,name)
    return
  end if
  ictxt=desc_a%get_context()

  call psb_info(ictxt, me, np)
  !     ....verify blacs grid correctness..
  if (np == -1) then
    info = psb_err_context_error_
    call psb_errpush(info,name)
    goto 9999
  endif

  if (.not.allocated(x)) then
    info=psb_err_forgot_geall_
    call psb_errpush(info,name)
    goto 9999
  end if

  !deallocate x
  deallocate(x,stat=info)
  if (info /= psb_no_err_) then
    info=psb_err_alloc_dealloc_
    call psb_errpush(info,name)
  endif

  call psb_erractionrestore(err_act)
  return

9999 continue
  call psb_erractionrestore(err_act)
  if (err_act == psb_act_abort_) then
    call psb_error(ictxt)
    return
  end if
  return

end subroutine psb_ifreev


subroutine psb_ifree_vect(x, desc_a, info)
  use psb_base_mod, psb_protect_name => psb_ifree_vect
  implicit none
  !....parameters...
  type(psb_i_vect_type), intent(inout) :: x
  type(psb_desc_type), intent(in)  :: desc_a
  integer(psb_ipk_), intent(out)             :: info 
  !...locals....
  integer(psb_ipk_) :: ictxt,np,me,err_act
  character(len=20)   :: name


  info=psb_success_
  if (psb_errstatus_fatal()) return 
  call psb_erractionsave(err_act)
  name='psb_ifreev'

  if (.not.desc_a%is_ok()) then
    info = psb_err_invalid_cd_state_
    call psb_errpush(info,name)
    goto 9999
  end if
  ictxt = desc_a%get_context()

  call psb_info(ictxt, me, np)
  if (np == -1) then
    info = psb_err_context_error_
    call psb_errpush(info,name)
    goto 9999
  endif

  if (.not.allocated(x%v)) then 
    info = psb_err_invalid_vect_state_
    call psb_errpush(info,name)
    goto 9999
  endif


  call x%free(info)

  if (info /= psb_no_err_) then
    info=psb_err_alloc_dealloc_
    call psb_errpush(info,name)
  endif

  call psb_erractionrestore(err_act)
  return

9999 continue
  call psb_erractionrestore(err_act)
  if (err_act == psb_act_abort_) then
     call psb_error(ictxt)
     return
  end if
  return

end subroutine psb_ifree_vect

