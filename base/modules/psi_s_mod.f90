!   
!                Parallel Sparse BLAS  version 3.5
!      (C) Copyright 2006-2018
!        Salvatore Filippone    
!        Alfredo Buttari      
!   
!    Redistribution and use in source and binary forms, with or without
!    modification, are permitted provided that the following conditions
!    are met:
!      1. Redistributions of source code must retain the above copyright
!         notice, this list of conditions and the following disclaimer.
!      2. Redistributions in binary form must reproduce the above copyright
!         notice, this list of conditions, and the following disclaimer in the
!         documentation and/or other materials provided with the distribution.
!      3. The name of the PSBLAS group or the names of its contributors may
!         not be used to endorse or promote products derived from this
!         software without specific written permission.
!   
!    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
!    ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
!    TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
!    PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE PSBLAS GROUP OR ITS CONTRIBUTORS
!    BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
!    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
!    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
!    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
!    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
!    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
!    POSSIBILITY OF SUCH DAMAGE.
!   
!    
module psi_s_mod
  use psb_desc_mod, only : psb_desc_type, psb_ipk_, psb_spk_, psb_i_base_vect_type
  use psb_s_base_vect_mod, only : psb_s_base_vect_type 
  use psb_s_base_multivect_mod, only : psb_s_base_multivect_type 


  interface psi_swapdata
    subroutine psi_sswapdatam(flag,n,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag, n
      integer(psb_ipk_), intent(out)        :: info
      real(psb_spk_)           :: y(:,:), beta
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswapdatam
    subroutine psi_sswapdatav(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      real(psb_spk_)           :: y(:), beta 
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswapdatav
    subroutine psi_sswapdata_vect(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      class(psb_s_base_vect_type) :: y
      real(psb_spk_)           :: beta 
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswapdata_vect
    subroutine psi_sswapdata_multivect(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      class(psb_s_base_multivect_type)    :: y
      real(psb_spk_)           :: beta 
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswapdata_multivect
    subroutine psi_sswapidxm(ictxt,icomm,flag,n,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)      :: ictxt,icomm,flag, n
      integer(psb_ipk_), intent(out)     :: info
      real(psb_spk_)        :: y(:,:), beta
      real(psb_spk_),target :: work(:)
      integer(psb_ipk_), intent(in)      :: idx(:),totxch,totsnd,totrcv
    end subroutine psi_sswapidxm
    subroutine psi_sswapidxv(ictxt,icomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)      :: ictxt,icomm,flag
      integer(psb_ipk_), intent(out)     :: info
      real(psb_spk_)        :: y(:), beta
      real(psb_spk_),target :: work(:)
      integer(psb_ipk_), intent(in)      :: idx(:),totxch,totsnd,totrcv
    end subroutine psi_sswapidxv
    subroutine psi_sswap_vidx_vect(iictxt,iicomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)           :: iictxt,iicomm,flag
      integer(psb_ipk_), intent(out)          :: info
      class(psb_s_base_vect_type)             :: y
      real(psb_spk_)                       :: beta
      real(psb_spk_), target               :: work(:)
      class(psb_i_base_vect_type), intent(inout) :: idx
      integer(psb_ipk_), intent(in)           :: totxch,totsnd, totrcv
    end subroutine psi_sswap_vidx_vect
    subroutine psi_sswap_vidx_multivect(iictxt,iicomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)           :: iictxt,iicomm,flag
      integer(psb_ipk_), intent(out)          :: info
      class(psb_s_base_multivect_type)      :: y
      real(psb_spk_)                       :: beta
      real(psb_spk_), target               :: work(:)
      class(psb_i_base_vect_type), intent(inout) :: idx
      integer(psb_ipk_), intent(in)           :: totxch,totsnd, totrcv
    end subroutine psi_sswap_vidx_multivect
  end interface psi_swapdata


  interface psi_swaptran
    subroutine psi_sswaptranm(flag,n,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag, n
      integer(psb_ipk_), intent(out)        :: info
      real(psb_spk_)           :: y(:,:), beta
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswaptranm
    subroutine psi_sswaptranv(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      real(psb_spk_)           :: y(:), beta
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswaptranv
    subroutine psi_sswaptran_vect(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      class(psb_s_base_vect_type) :: y
      real(psb_spk_)           :: beta
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswaptran_vect
    subroutine psi_sswaptran_multivect(flag,beta,y,desc_a,work,info,data)
      import 
      integer(psb_ipk_), intent(in)         :: flag
      integer(psb_ipk_), intent(out)        :: info
      class(psb_s_base_multivect_type) :: y
      real(psb_spk_)           :: beta
      real(psb_spk_),target    :: work(:)
      type(psb_desc_type), target :: desc_a
      integer(psb_ipk_), optional           :: data
    end subroutine psi_sswaptran_multivect
    subroutine psi_stranidxm(ictxt,icomm,flag,n,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)      :: ictxt,icomm,flag, n
      integer(psb_ipk_), intent(out)     :: info
      real(psb_spk_)        :: y(:,:), beta
      real(psb_spk_),target :: work(:)
      integer(psb_ipk_), intent(in)       :: idx(:),totxch,totsnd,totrcv
    end subroutine psi_stranidxm
    subroutine psi_stranidxv(ictxt,icomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)      :: ictxt,icomm,flag
      integer(psb_ipk_), intent(out)     :: info
      real(psb_spk_)        :: y(:), beta
      real(psb_spk_),target :: work(:)
      integer(psb_ipk_), intent(in)      :: idx(:),totxch,totsnd,totrcv
    end subroutine psi_stranidxv
    subroutine psi_stran_vidx_vect(iictxt,iicomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)           :: iictxt,iicomm,flag
      integer(psb_ipk_), intent(out)          :: info
      class(psb_s_base_vect_type)             :: y
      real(psb_spk_)                       :: beta
      real(psb_spk_), target               :: work(:)
      class(psb_i_base_vect_type), intent(inout) :: idx
      integer(psb_ipk_), intent(in)           :: totxch,totsnd, totrcv
    end subroutine psi_stran_vidx_vect
    subroutine psi_stran_vidx_multivect(iictxt,iicomm,flag,beta,y,idx,&
         & totxch,totsnd,totrcv,work,info)
      import 
      integer(psb_ipk_), intent(in)           :: iictxt,iicomm,flag
      integer(psb_ipk_), intent(out)          :: info
      class(psb_s_base_multivect_type)      :: y
      real(psb_spk_)                       :: beta
      real(psb_spk_), target               :: work(:)
      class(psb_i_base_vect_type), intent(inout) :: idx
      integer(psb_ipk_), intent(in)           :: totxch,totsnd, totrcv
    end subroutine psi_stran_vidx_multivect
  end interface psi_swaptran

  interface psi_ovrl_upd
    subroutine  psi_sovrl_updr1(x,desc_a,update,info)
      import 
      real(psb_spk_), intent(inout), target :: x(:)
      type(psb_desc_type), intent(in)          :: desc_a
      integer(psb_ipk_), intent(in)                      :: update
      integer(psb_ipk_), intent(out)                     :: info
    end subroutine psi_sovrl_updr1
    subroutine  psi_sovrl_updr2(x,desc_a,update,info)
      import 
      real(psb_spk_), intent(inout), target :: x(:,:)
      type(psb_desc_type), intent(in)          :: desc_a
      integer(psb_ipk_), intent(in)                      :: update
      integer(psb_ipk_), intent(out)                     :: info
    end subroutine psi_sovrl_updr2
    subroutine  psi_sovrl_upd_vect(x,desc_a,update,info)
      import 
      class(psb_s_base_vect_type)       :: x
      type(psb_desc_type), intent(in)   :: desc_a
      integer(psb_ipk_), intent(in)               :: update
      integer(psb_ipk_), intent(out)              :: info
    end subroutine psi_sovrl_upd_vect
    subroutine  psi_sovrl_upd_multivect(x,desc_a,update,info)
      import 
      class(psb_s_base_multivect_type)   :: x
      type(psb_desc_type), intent(in)      :: desc_a
      integer(psb_ipk_), intent(in)        :: update
      integer(psb_ipk_), intent(out)       :: info
    end subroutine psi_sovrl_upd_multivect
  end interface psi_ovrl_upd

  interface psi_ovrl_save
    subroutine  psi_sovrl_saver1(x,xs,desc_a,info)
      import 
      real(psb_spk_), intent(inout) :: x(:)
      real(psb_spk_), allocatable   :: xs(:)
      type(psb_desc_type), intent(in)  :: desc_a
      integer(psb_ipk_), intent(out)             :: info
    end subroutine psi_sovrl_saver1
    subroutine  psi_sovrl_saver2(x,xs,desc_a,info)
      import 
      real(psb_spk_), intent(inout) :: x(:,:)
      real(psb_spk_), allocatable   :: xs(:,:)
      type(psb_desc_type), intent(in)  :: desc_a
      integer(psb_ipk_), intent(out)             :: info
    end subroutine psi_sovrl_saver2
    subroutine  psi_sovrl_save_vect(x,xs,desc_a,info)
      import 
      class(psb_s_base_vect_type)     :: x
      real(psb_spk_), allocatable  :: xs(:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psi_sovrl_save_vect
    subroutine  psi_sovrl_save_multivect(x,xs,desc_a,info)
      import 
      class(psb_s_base_multivect_type)     :: x
      real(psb_spk_), allocatable  :: xs(:,:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psi_sovrl_save_multivect
  end interface psi_ovrl_save

  interface psi_ovrl_restore
    subroutine  psi_sovrl_restrr1(x,xs,desc_a,info)
      import 
      real(psb_spk_), intent(inout)  :: x(:)
      real(psb_spk_)                 :: xs(:)
      type(psb_desc_type), intent(in)  :: desc_a
      integer(psb_ipk_), intent(out)             :: info
    end subroutine psi_sovrl_restrr1
    subroutine  psi_sovrl_restrr2(x,xs,desc_a,info)
      import 
      real(psb_spk_), intent(inout) :: x(:,:)
      real(psb_spk_)                :: xs(:,:)
      type(psb_desc_type), intent(in)  :: desc_a
      integer(psb_ipk_), intent(out)             :: info
    end subroutine psi_sovrl_restrr2
    subroutine  psi_sovrl_restr_vect(x,xs,desc_a,info)
      import 
      class(psb_s_base_vect_type)     :: x
      real(psb_spk_)               :: xs(:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psi_sovrl_restr_vect
    subroutine  psi_sovrl_restr_multivect(x,xs,desc_a,info)
      import 
      class(psb_s_base_multivect_type)     :: x
      real(psb_spk_)               :: xs(:,:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psi_sovrl_restr_multivect
  end interface psi_ovrl_restore

end module psi_s_mod

