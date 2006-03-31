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
Module psb_tools_mod
  use psb_const_mod

  interface  psb_geall
     ! 2-D double precision version
     subroutine psb_dalloc(m, n, x, desc_a, info, js)
       use psb_descriptor_type
       implicit none
       integer, intent(in)                   :: m,n
       real(kind(1.d0)), pointer             :: x(:,:)
       type(psb_desc_type), intent(in)       :: desc_a
       integer                               :: info
       integer, optional, intent(in)         :: js
     end subroutine psb_dalloc
     ! 1-D double precision version
     subroutine psb_dallocv(m, x, desc_a,info)
       use psb_descriptor_type
       integer, intent(in)            :: m
       real(kind(1.d0)), pointer      :: x(:)
       type(psb_desc_type), intent(in):: desc_a
       integer                        :: info
     end subroutine psb_dallocv
     ! 2-D integer version
     subroutine psb_ialloc(m, n, x, desc_a, info,js)
       use psb_descriptor_type
       integer, intent(in)                   :: m,n
       integer, pointer                      :: x(:,:)
       type(psb_desc_type), intent(inout)    :: desc_a
       integer, intent(out)                  :: info
       integer, optional, intent(in)         :: js
     end subroutine psb_ialloc
     subroutine psb_iallocv(m, x, desc_a,info)
       use psb_descriptor_type
       integer, intent(in)            :: m
       integer, pointer               :: x(:)
       type(psb_desc_type), intent(in):: desc_a
       integer                        :: info
     end subroutine psb_iallocv
     ! 2-D double precision version
     subroutine psb_zalloc(m, n, x, desc_a, info, js)
       use psb_descriptor_type
       implicit none
       integer, intent(in)                   :: m,n
       complex(kind(1.d0)), pointer             :: x(:,:)
       type(psb_desc_type), intent(in)       :: desc_a
       integer                               :: info
       integer, optional, intent(in)         :: js
     end subroutine psb_zalloc
     ! 1-D double precision version
     subroutine psb_zallocv(m, x, desc_a,info)
       use psb_descriptor_type
       integer, intent(in)            :: m
       complex(kind(1.d0)), pointer      :: x(:)
       type(psb_desc_type), intent(in):: desc_a
       integer                        :: info
     end subroutine psb_zallocv
  end interface


  interface psb_geasb
     ! 2-D double precision version
     subroutine psb_dasb(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       real(kind(1.d0)), pointer       ::  x(:,:)
       integer, intent(out)            ::  info
     end subroutine psb_dasb
     ! 1-D double precision version
     subroutine psb_dasbv(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       real(kind(1.d0)), pointer   ::  x(:)
       integer, intent(out)        ::  info
     end subroutine psb_dasbv
     ! 2-D integer version
     subroutine psb_iasb(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       integer, pointer                ::  x(:,:)
       integer, intent(out)            ::  info
     end subroutine psb_iasb
     ! 1-D integer version
     subroutine psb_iasbv(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       integer, pointer   ::  x(:)
       integer, intent(out)        ::  info
     end subroutine psb_iasbv
     ! 2-D double precision version
     subroutine psb_zasb(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       complex(kind(1.d0)), pointer       ::  x(:,:)
       integer, intent(out)            ::  info
     end subroutine psb_zasb
     ! 1-D double precision version
     subroutine psb_zasbv(x, desc_a, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       complex(kind(1.d0)), pointer   ::  x(:)
       integer, intent(out)        ::  info
     end subroutine psb_zasbv
   end interface

  interface psb_sphalo
     Subroutine psb_dsphalo(a,desc_a,blk,info,rwcnv,clcnv,outfmt)
       use psb_descriptor_type
       use psb_spmat_type
       Type(psb_dspmat_type),Intent(in)    :: a
       Type(psb_dspmat_type),Intent(inout) :: blk
       Type(psb_desc_type),Intent(in)      :: desc_a
       integer, intent(out)                :: info
       logical, optional, intent(in)       :: rwcnv,clcnv
       character(len=5), optional          :: outfmt 
     end Subroutine psb_dsphalo
     Subroutine psb_zsphalo(a,desc_a,blk,info,rwcnv,clcnv,outfmt)
       use psb_descriptor_type
       use psb_spmat_type
       Type(psb_zspmat_type),Intent(in)    :: a
       Type(psb_zspmat_type),Intent(inout) :: blk
       Type(psb_desc_type),Intent(in)      :: desc_a
       integer, intent(out)                :: info
       logical, optional, intent(in)       :: rwcnv,clcnv
       character(len=5), optional          :: outfmt 
     end Subroutine psb_zsphalo
  end interface


  interface psb_csrp
     subroutine psb_dcsrp(trans,iperm,a, desc_a, info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_dspmat_type), intent(inout)  ::  a
       type(psb_desc_type), intent(in)       ::  desc_a
       integer, intent(inout)                :: iperm(:), info
       character, intent(in)                 :: trans
     end subroutine psb_dcsrp
  end interface


  interface psb_cdovrbld
     Subroutine psb_dcdovrbld(n_ovr,desc_p,desc_a,a,&
          &       l_tmp_halo,l_tmp_ovr_idx,lworks,lworkr,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_dspmat_type),intent(in)  :: a
       type(psb_desc_type),intent(in)    :: desc_a
       type(psb_desc_type),intent(inout) :: desc_p
       integer,intent(in)                :: n_ovr
       Integer, Intent(in)               :: l_tmp_halo,l_tmp_ovr_idx
       Integer, Intent(inout)            :: lworks, lworkr
       integer, intent(out)              :: info
     end Subroutine psb_dcdovrbld
     Subroutine psb_zcdovrbld(n_ovr,desc_p,desc_a,a,&
          &       l_tmp_halo,l_tmp_ovr_idx,lworks,lworkr,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_zspmat_type),intent(in)  :: a
       type(psb_desc_type),intent(in)    :: desc_a
       type(psb_desc_type),intent(inout) :: desc_p
       integer,intent(in)                :: n_ovr
       Integer, Intent(in)               :: l_tmp_halo,l_tmp_ovr_idx
       Integer, Intent(inout)            :: lworks, lworkr
       integer, intent(out)              :: info
     end Subroutine psb_zcdovrbld
  end interface


  interface psb_cdprt
     subroutine psb_cdprt(iout,desc_p,glob,short)
       use psb_const_mod
       use psb_descriptor_type
       implicit none 
       type(psb_desc_type), intent(in)    :: desc_p
       integer, intent(in)                :: iout
       logical, intent(in), optional      :: glob,short
     end subroutine psb_cdprt
  end interface


  interface psb_gefree
     ! 2-D double precision version
     subroutine psb_dfree(x, desc_a, info)
       use psb_descriptor_type
       real(kind(1.d0)),pointer        :: x(:,:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_dfree
     ! 1-D double precision version
     subroutine psb_dfreev(x, desc_a, info)
       use psb_descriptor_type
       real(kind(1.d0)),pointer        :: x(:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_dfreev
     ! 2-D integer version
     subroutine psb_ifree(x, desc_a, info)
       use psb_descriptor_type
       integer,pointer                 :: x(:,:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_ifree
     ! 1-D integer version
     subroutine psb_ifreev(x, desc_a, info)
       use psb_descriptor_type
       integer, pointer                :: x(:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_ifreev
     ! 2-D double precision version
     subroutine psb_zfree(x, desc_a, info)
       use psb_descriptor_type
       complex(kind(1.d0)),pointer        :: x(:,:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_zfree
     ! 1-D double precision version
     subroutine psb_zfreev(x, desc_a, info)
       use psb_descriptor_type
       complex(kind(1.d0)),pointer        :: x(:)
       type(psb_desc_type), intent(in) :: desc_a
       integer                         :: info
     end subroutine psb_zfreev
  end interface


  interface psb_gelp
     ! 2-D version
     subroutine psb_dgelp(trans,iperm,x,desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)      ::  desc_a
       real(kind(1.d0)), intent(inout)      ::  x(:,:)
       integer, intent(inout)               ::  iperm(:),info
       character, intent(in)                :: trans
     end subroutine psb_dgelp
     ! 1-D version
     subroutine psb_dgelpv(trans,iperm,x,desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       real(kind(1.d0)), intent(inout)    ::  x(:)
       integer, intent(inout)             ::  iperm(:), info
       character, intent(in)              :: trans
     end subroutine psb_dgelpv
     ! 2-D version
     subroutine psb_zgelp(trans,iperm,x,desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)      ::  desc_a
       complex(kind(1.d0)), intent(inout)      ::  x(:,:)
       integer, intent(inout)               ::  iperm(:),info
       character, intent(in)                :: trans
     end subroutine psb_zgelp
     ! 1-D version
     subroutine psb_zgelpv(trans,iperm,x,desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in) ::  desc_a
       complex(kind(1.d0)), intent(inout)    ::  x(:)
       integer, intent(inout)             ::  iperm(:), info
       character, intent(in)              :: trans
     end subroutine psb_zgelpv
  end interface


  interface psb_geins
     ! 2-D double precision version
     subroutine psb_dins(m, n, x, ix, jx, blck, desc_a, info,&
          & iblck, jblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m,n
       type(psb_desc_type), intent(in)    ::  desc_a
       real(kind(1.d0)),pointer           ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       real(kind(1.d0)), intent(in)       ::  blck(:,:)
       integer,intent(out)                ::  info
       integer, optional, intent(in)      ::  iblck,jblck
     end subroutine psb_dins
     ! 2-D double precision square version
     subroutine psb_dinsvm(m, x, ix, jx, blck, desc_a,info,&
          & iblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in) ::  desc_a
       real(kind(1.d0)),pointer           ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       real(kind(1.d0)), intent(in)       ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
     end subroutine psb_dinsvm
     ! 1-D double precision version
     subroutine psb_dinsvv(m, x, ix, blck, desc_a, info,&
          & iblck,insflag)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in)    ::  desc_a
       real(kind(1.d0)),pointer           ::  x(:)
       integer, intent(in)                ::  ix
       real(kind(1.d0)), intent(in)       ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
       integer, optional, intent(in)      ::  insflag
     end subroutine psb_dinsvv
     ! 2-D integer version
     subroutine psb_iins(m, n, x, ix, jx, blck, desc_a, info,&
          & iblck, jblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m,n
       type(psb_desc_type), intent(in)    ::  desc_a
       integer,pointer                    ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       integer, intent(in)                ::  blck(:,:)
       integer,intent(out)                ::  info
       integer, optional, intent(in)      ::  iblck,jblck
     end subroutine psb_iins
     ! 2-D integer square version
     subroutine psb_iinsvm(m, x, ix, jx, blck, desc_a,info,&
          & iblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in)    ::  desc_a
       integer, pointer                   ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       integer, intent(in)                ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
     end subroutine psb_iinsvm
     ! 1-D integer version
     subroutine psb_iinsvv(m, x, ix, blck, desc_a, info,&
          & iblck,insflag)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in)    ::  desc_a
       integer, pointer                   ::  x(:)
       integer, intent(in)                ::  ix
       integer, intent(in)                ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
       integer, optional, intent(in)      ::  insflag
     end subroutine psb_iinsvv
     ! 2-D double precision version
     subroutine psb_zins(m, n, x, ix, jx, blck, desc_a, info,&
          & iblck, jblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m,n
       type(psb_desc_type), intent(in)    ::  desc_a
       complex(kind(1.d0)),pointer        ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       complex(kind(1.d0)), intent(in)    ::  blck(:,:)
       integer,intent(out)                ::  info
       integer, optional, intent(in)      ::  iblck,jblck
     end subroutine psb_zins
     ! 2-D double precision square version
     subroutine psb_zinsvm(m, x, ix, jx, blck, desc_a,info,&
          & iblck)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in)    ::  desc_a
       complex(kind(1.d0)),pointer        ::  x(:,:)
       integer, intent(in)                ::  ix,jx
       complex(kind(1.d0)), intent(in)    ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
     end subroutine psb_zinsvm
     ! 1-D double precision version
     subroutine psb_zinsvv(m, x, ix, blck, desc_a, info,&
          & iblck,insflag)
       use psb_descriptor_type
       integer, intent(in)                ::  m
       type(psb_desc_type), intent(in)    ::  desc_a
       complex(kind(1.d0)),pointer        ::  x(:)
       integer, intent(in)                ::  ix
       complex(kind(1.d0)), intent(in)    ::  blck(:)
       integer, intent(out)               ::  info
       integer, optional, intent(in)      ::  iblck
       integer, optional, intent(in)      ::  insflag
     end subroutine psb_zinsvv
  end interface


  interface psb_cdall
     subroutine psb_cdall(m, n, parts, icontxt, desc_a, info)
       use psb_descriptor_type
       include 'parts.fh'
       Integer, intent(in)                 :: m,n,icontxt
       Type(psb_desc_type), intent(out)    :: desc_a
       integer, intent(out)                :: info
     end subroutine psb_cdall
     subroutine psb_cdalv(m, v, icontxt, desc_a, info, flag)
       use psb_descriptor_type
       Integer, intent(in)               :: m,icontxt, v(:)
       integer, intent(in), optional     :: flag
       integer, intent(out)              :: info
       Type(psb_desc_type), intent(out)  :: desc_a
     end subroutine psb_cdalv
  end interface
  

  interface psb_cdasb
     subroutine psb_cdasb(desc_a,info)
       use psb_descriptor_type
       Type(psb_desc_type), intent(inout) :: desc_a
       integer, intent(out)               :: info
     end subroutine psb_cdasb
  end interface



  interface psb_cdcpy
     subroutine psb_cdcpy(desc_in, desc_out, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)  :: desc_in
       type(psb_desc_type), intent(out) :: desc_out
       integer, intent(out)             :: info
     end subroutine psb_cdcpy
  end interface

  interface psb_cdtransfer
     subroutine psb_cdtransfer(desc_in, desc_out, info)
       use psb_descriptor_type
       type(psb_desc_type), intent(inout) :: desc_in
       type(psb_desc_type), intent(out)   :: desc_out
       integer, intent(out)               :: info
     end subroutine psb_cdtransfer
  end interface
  
 
  interface psb_cdfree
     subroutine psb_cdfree(desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(inout) :: desc_a
       integer, intent(out)               :: info
     end subroutine psb_cdfree
  end interface
  
  interface psb_cdins
     subroutine psb_cdins(nz,ia,ja,desc_a,info,is,js)
       use psb_descriptor_type
       type(psb_desc_type), intent(inout) :: desc_a
       Integer, intent(in)                :: nz,IA(:),JA(:)
       integer, intent(out)               :: info
       integer, intent(in), optional      :: is,js
     end subroutine psb_cdins
  end interface


  interface psb_cdovr
     Subroutine psb_dcdovr(a,desc_a,novr,desc_ov,info)
       use psb_descriptor_type
       Use psb_spmat_type
       integer, intent(in)                :: novr
       Type(psb_dspmat_type), Intent(in)  ::  a
       Type(psb_desc_type), Intent(in)    :: desc_a
       Type(psb_desc_type), Intent(inout) :: desc_ov
       integer, intent(out)               :: info
     end Subroutine psb_dcdovr
     Subroutine psb_zcdovr(a,desc_a,novr,desc_ov,info)
       use psb_descriptor_type
       Use psb_spmat_type
       integer, intent(in)                :: novr
       Type(psb_zspmat_type), Intent(in)  ::  a
       Type(psb_desc_type), Intent(in)    :: desc_a
       Type(psb_desc_type), Intent(inout) :: desc_ov
       integer, intent(out)               :: info
     end Subroutine psb_zcdovr
  end interface
       
       
  interface psb_cdren
     subroutine psb_cdren(trans,iperm,desc_a,info)
       use psb_descriptor_type
       type(psb_desc_type), intent(inout)    ::  desc_a
       integer, intent(inout)                ::  iperm(:)
       character, intent(in)                 :: trans
       integer, intent(out)                  :: info
     end subroutine psb_cdren
  end interface
  
  interface psb_spall
     subroutine psb_dspalloc(a, desc_a, info, nnz)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(inout) :: desc_a
       type(psb_dspmat_type), intent(out) :: a
       integer, intent(out)               :: info
       integer, optional, intent(in)      :: nnz
     end subroutine psb_dspalloc
     subroutine psb_zspalloc(a, desc_a, info, nnz)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(inout) :: desc_a
       type(psb_zspmat_type), intent(out) :: a
       integer, intent(out)               :: info
       integer, optional, intent(in)      :: nnz
     end subroutine psb_zspalloc
  end interface

  interface psb_spasb
     subroutine psb_dspasb(a,desc_a, info, afmt, up, dup)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_dspmat_type), intent (inout)   :: a
       type(psb_desc_type), intent(in)         :: desc_a
       integer, intent(out)                    :: info
       integer,optional, intent(in)            :: dup
       character, optional, intent(in)         :: afmt*5, up
     end subroutine psb_dspasb
     subroutine psb_zspasb(a,desc_a, info, afmt, up, dup)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_zspmat_type), intent (inout)   :: a
       type(psb_desc_type), intent(in)         :: desc_a
       integer, intent(out)                    :: info
       integer,optional, intent(in)            :: dup
       character, optional, intent(in)         :: afmt*5, up
     end subroutine psb_zspasb
  end interface


  interface psb_spcnv
     subroutine psb_dspcnv(a,b,desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_dspmat_type), intent(in)   :: a
       type(psb_dspmat_type), intent(out)  :: b
       type(psb_desc_type), intent(in)     :: desc_a
       integer, intent(out)                :: info
     end subroutine psb_dspcnv
     subroutine psb_zspcnv(a,b,desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_zspmat_type), intent(in)   :: a
       type(psb_zspmat_type), intent(out)  :: b
       type(psb_desc_type), intent(in)     :: desc_a
       integer, intent(out)                :: info
     end subroutine psb_zspcnv
  end interface


  interface psb_spfree
     subroutine psb_dspfree(a, desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(in) :: desc_a
       type(psb_dspmat_type), intent(inout)       ::a
       integer, intent(out)        :: info
     end subroutine psb_dspfree
     subroutine psb_zspfree(a, desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(in) :: desc_a
       type(psb_zspmat_type), intent(inout)       ::a
       integer, intent(out)        :: info
     end subroutine psb_zspfree
  end interface


  interface psb_spins
     subroutine psb_dspins(nz,ia,ja,val,a,desc_a,info,is,js)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(inout)   :: desc_a
       type(psb_dspmat_type), intent(inout) :: a
       integer, intent(in)                  :: nz,ia(:),ja(:)
       real(kind(1.d0)), intent(in)         :: val(:)
       integer, intent(out)                 :: info
       integer, intent(in), optional        :: is,js
     end subroutine psb_dspins
     subroutine psb_zspins(nz,ia,ja,val,a,desc_a,info,is,js)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(inout)   :: desc_a
       type(psb_zspmat_type), intent(inout) :: a
       integer, intent(in)                  :: nz,ia(:),ja(:)
       complex(kind(1.d0)), intent(in)      :: val(:)
       integer, intent(out)                 :: info
       integer, intent(in), optional        :: is,js
     end subroutine psb_zspins
  end interface


  interface psb_sprn
     subroutine psb_dsprn(a, desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(in)      :: desc_a
       type(psb_dspmat_type), intent(inout) :: a
       integer, intent(out)                 :: info
     end subroutine psb_dsprn
     subroutine psb_zsprn(a, desc_a,info)
       use psb_descriptor_type
       use psb_spmat_type
       type(psb_desc_type), intent(in)      :: desc_a
       type(psb_zspmat_type), intent(inout) :: a
       integer, intent(out)                 :: info
     end subroutine psb_zsprn
  end interface


  interface psb_glob_to_loc
     subroutine psb_glob_to_loc2(x,y,desc_a,info,iact)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)    ::  desc_a
       integer,intent(in)                 ::  x(:)  
       integer,intent(out)                ::  y(:)  
       integer, intent(out)               ::  info
       character, intent(in), optional    ::  iact
     end subroutine psb_glob_to_loc2
     subroutine psb_glob_to_loc(x,desc_a,info,iact)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)    ::  desc_a
       integer,intent(inout)              ::  x(:)  
       integer, intent(out)               ::  info
       character, intent(in), optional    ::  iact
     end subroutine psb_glob_to_loc
  end interface

  interface psb_loc_to_glob
     subroutine psb_loc_to_glob2(x,y,desc_a,info,iact)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)    ::  desc_a
       integer,intent(in)                 ::  x(:)  
       integer,intent(out)                ::  y(:)  
       integer, intent(out)               ::  info
       character, intent(in), optional    ::  iact
     end subroutine psb_loc_to_glob2
     subroutine psb_loc_to_glob(x,desc_a,info,iact)
       use psb_descriptor_type
       type(psb_desc_type), intent(in)    ::  desc_a
       integer,intent(inout)              ::  x(:)  
       integer, intent(out)               ::  info
       character, intent(in), optional    ::  iact
     end subroutine psb_loc_to_glob
  end interface


  interface psb_cdrep
     subroutine psb_cdrep(m, icontxt, desc_a,info)
       use psb_descriptor_type
       Integer, intent(in)               :: m,icontxt
       Type(psb_desc_type), intent(out)  :: desc_a
       integer, intent(out)              :: info
     end subroutine psb_cdrep
  end interface

  interface psb_cddec
     subroutine psb_cddec(nloc, icontxt, desc_a,info)
       use psb_descriptor_type
       Integer, intent(in)               :: nloc,icontxt
       Type(psb_desc_type), intent(out)  :: desc_a
       integer, intent(out)              :: info
     end subroutine psb_cddec
  end interface


end module psb_tools_mod
