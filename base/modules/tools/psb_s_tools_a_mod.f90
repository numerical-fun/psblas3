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
Module psb_s_tools_a_mod
  use psb_desc_mod, only : psb_desc_type, psb_spk_, psb_ipk_, psb_lpk_, psb_mpk_, psb_epk_

  interface  psb_geall
    subroutine psb_salloc(x, desc_a, info, n, lb)
      import
      implicit none
      real(psb_spk_), allocatable, intent(out)    :: x(:,:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), optional, intent(in)   :: n, lb
    end subroutine psb_salloc
    subroutine psb_sallocv(x, desc_a,info,n)
      import
      implicit none
      real(psb_spk_), allocatable, intent(out)    :: x(:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), optional, intent(in)   :: n
    end subroutine psb_sallocv
  end interface


  interface psb_geasb
    subroutine psb_sasb(x, desc_a, info, scratch)
      import
      implicit none
      type(psb_desc_type), intent(in) ::  desc_a
      real(psb_spk_), allocatable, intent(inout)       ::  x(:,:)
      integer(psb_ipk_), intent(out)            ::  info
      logical, intent(in), optional        :: scratch
    end subroutine psb_sasb
    subroutine psb_sasbv(x, desc_a, info, scratch)
      import
      implicit none
      type(psb_desc_type), intent(in) ::  desc_a
      real(psb_spk_), allocatable, intent(inout)   ::  x(:)
      integer(psb_ipk_), intent(out)        ::  info
      logical, intent(in), optional        :: scratch
    end subroutine psb_sasbv
  end interface

  interface psb_gefree
    subroutine psb_sfree(x, desc_a, info)
      import
      implicit none
      real(psb_spk_),allocatable, intent(inout)        :: x(:,:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_sfree
    subroutine psb_sfreev(x, desc_a, info)
      import
      implicit none
      real(psb_spk_),allocatable, intent(inout)        :: x(:)
      type(psb_desc_type), intent(in) :: desc_a
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_sfreev
  end interface


  interface psb_geins
    subroutine psb_sinsi(m,irw,val, x, desc_a,info,dupl,local)
      import
      implicit none
      integer(psb_ipk_), intent(in)              ::  m
      type(psb_desc_type), intent(in)  ::  desc_a
      real(psb_spk_),intent(inout)      ::  x(:,:)
      integer(psb_ipk_), intent(in)              ::  irw(:)
      real(psb_spk_), intent(in)  ::  val(:,:)
      integer(psb_ipk_), intent(out)             ::  info
      integer(psb_ipk_), optional, intent(in)    ::  dupl
      logical, intent(in), optional        :: local
    end subroutine psb_sinsi
    subroutine psb_sinsvi(m, irw,val, x,desc_a,info,dupl,local)
      import
      implicit none
      integer(psb_ipk_), intent(in)              ::  m
      type(psb_desc_type), intent(in)  ::  desc_a
      real(psb_spk_),intent(inout)      ::  x(:)
      integer(psb_ipk_), intent(in)              ::  irw(:)
      real(psb_spk_), intent(in)  ::  val(:)
      integer(psb_ipk_), intent(out)             ::  info
      integer(psb_ipk_), optional, intent(in)    ::  dupl
      logical, intent(in), optional        :: local
    end subroutine psb_sinsvi
  end interface

end module psb_s_tools_a_mod
