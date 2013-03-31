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
!
! package: psb_d_mat_mod
!
! This module contains the definition of the psb_d_sparse type which
! is a generic container for a sparse matrix and it is mostly meant to
! provide a mean of switching, at run-time, among different formats,
! potentially unknown at the library compile-time by adding a layer of
! indirection. This type encapsulates the psb_d_base_sparse_mat class
! inside another class which is the one visible to the user. 
! Most methods of the psb_d_mat_mod simply call the methods of the
! encapsulated class.
! The exceptions are mainly cscnv and cp_from/cp_to; these provide
! the functionalities to have the encapsulated class change its
! type dynamically, and to extract/input an inner object.
!
! A sparse matric has a state corresponding to its progression
! through the application life.
! In particular, computational methods can only be invoked when
! the matrix is in the ASSEMBLED state, whereas the other states are
! dedicated to operations on the internal matrix data. 
! A sparse matrix can move between states according to the 
! following state transition table. Associated with these states are
! the possible dynamic types of the inner matrix object.
! Only COO matrices can ever be in the BUILD state, whereas
! the ASSEMBLED and UPDATE state can be entered by any class. 
! 
! In           Out        Method    
!| ----------------------------------
!| Null         Build      csall
!| Build        Build      csput
!| Build        Assembled  cscnv
!| Assembled    Assembled  cscnv
!| Assembled    Update     reinit
!| Update       Update     csput
!| Update       Assembled  cscnv
!| *            unchanged  reall 
!| Assembled    Null       free
! 


module psb_d_mat_mod

  use psb_d_base_mat_mod
  use psb_d_csr_mat_mod, only : psb_d_csr_sparse_mat
  use psb_d_csc_mat_mod, only : psb_d_csc_sparse_mat

  type :: psb_dspmat_type

    class(psb_d_base_sparse_mat), allocatable  :: a 

  contains
    ! Getters
    procedure, pass(a) :: get_nrows   => psb_d_get_nrows
    procedure, pass(a) :: get_ncols   => psb_d_get_ncols
    procedure, pass(a) :: get_nzeros  => psb_d_get_nzeros
    procedure, pass(a) :: get_nz_row  => psb_d_get_nz_row
    procedure, pass(a) :: get_size    => psb_d_get_size
    procedure, pass(a) :: get_dupl    => psb_d_get_dupl
    procedure, pass(a) :: is_null     => psb_d_is_null
    procedure, pass(a) :: is_bld      => psb_d_is_bld
    procedure, pass(a) :: is_upd      => psb_d_is_upd
    procedure, pass(a) :: is_asb      => psb_d_is_asb
    procedure, pass(a) :: is_sorted   => psb_d_is_sorted
    procedure, pass(a) :: is_upper    => psb_d_is_upper
    procedure, pass(a) :: is_lower    => psb_d_is_lower
    procedure, pass(a) :: is_triangle => psb_d_is_triangle
    procedure, pass(a) :: is_unit     => psb_d_is_unit
    procedure, pass(a) :: get_fmt     => psb_d_get_fmt
    procedure, pass(a) :: sizeof      => psb_d_sizeof

    ! Setters
    procedure, pass(a) :: set_nrows    => psb_d_set_nrows
    procedure, pass(a) :: set_ncols    => psb_d_set_ncols
    procedure, pass(a) :: set_dupl     => psb_d_set_dupl
    procedure, pass(a) :: set_null     => psb_d_set_null
    procedure, pass(a) :: set_bld      => psb_d_set_bld
    procedure, pass(a) :: set_upd      => psb_d_set_upd
    procedure, pass(a) :: set_asb      => psb_d_set_asb
    procedure, pass(a) :: set_sorted   => psb_d_set_sorted
    procedure, pass(a) :: set_upper    => psb_d_set_upper
    procedure, pass(a) :: set_lower    => psb_d_set_lower
    procedure, pass(a) :: set_triangle => psb_d_set_triangle
    procedure, pass(a) :: set_unit     => psb_d_set_unit

    ! Memory/data management 
    procedure, pass(a) :: csall       => psb_d_csall
    procedure, pass(a) :: free        => psb_d_free
    procedure, pass(a) :: trim        => psb_d_trim
    procedure, pass(a) :: csput       => psb_d_csput 
    procedure, pass(a) :: csgetptn    => psb_d_csgetptn
    procedure, pass(a) :: csgetrow    => psb_d_csgetrow
    procedure, pass(a) :: csgetblk    => psb_d_csgetblk
    generic, public    :: csget       => csgetptn, csgetrow, csgetblk 
    procedure, pass(a) :: m_csclip    => psb_d_csclip
    procedure, pass(a) :: b_csclip    => psb_d_b_csclip
    generic, public    :: csclip      => b_csclip, m_csclip
    procedure, pass(a) :: reall       => psb_d_reallocate_nz
    procedure, pass(a) :: get_neigh   => psb_d_get_neigh
    procedure, pass(a) :: reinit      => psb_d_reinit
    procedure, pass(a) :: print_i     => psb_d_sparse_print
    procedure, pass(a) :: print_n     => psb_d_n_sparse_print
    generic, public    :: print       => print_i, print_n
    procedure, pass(a) :: mold        => psb_d_mold
    procedure, pass(a) :: transp_1mat => psb_d_transp_1mat
    procedure, pass(a) :: transp_2mat => psb_d_transp_2mat
    generic, public    :: transp      => transp_1mat, transp_2mat
    procedure, pass(a) :: transc_1mat => psb_d_transc_1mat
    procedure, pass(a) :: transc_2mat => psb_d_transc_2mat
    generic, public    :: transc      => transc_1mat, transc_2mat
    ! These are specific to this level of encapsulation.
    procedure, pass(a) :: mv_from_b   => psb_d_mv_from
    generic, public    :: mv_from     => mv_from_b
    procedure, pass(a) :: mv_to_b     => psb_d_mv_to
    generic, public    :: mv_to       => mv_to_b
    procedure, pass(a) :: cp_from_b   => psb_d_cp_from
    generic, public    :: cp_from     => cp_from_b
    procedure, pass(a) :: cp_to_b     => psb_d_cp_to
    generic, public    :: cp_to       => cp_to_b
    procedure, pass(a) :: clip_d_ip   => psb_d_clip_d_ip
    procedure, pass(a) :: clip_d      => psb_d_clip_d
    generic, public    :: clip_diag   => clip_d_ip, clip_d
    procedure, pass(a) :: cscnv_np    => psb_d_cscnv
    procedure, pass(a) :: cscnv_ip    => psb_d_cscnv_ip
    procedure, pass(a) :: cscnv_base  => psb_d_cscnv_base
    generic, public    :: cscnv       => cscnv_np, cscnv_ip, cscnv_base
    procedure, pass(a) :: clone       => psb_dspmat_clone

    ! Computational routines 
    procedure, pass(a) :: get_diag => psb_d_get_diag
    procedure, pass(a) :: maxval   => psb_d_maxval
    procedure, pass(a) :: spnmi    => psb_d_csnmi
    procedure, pass(a) :: spnm1    => psb_d_csnm1
    procedure, pass(a) :: rowsum   => psb_d_rowsum
    procedure, pass(a) :: arwsum   => psb_d_arwsum
    procedure, pass(a) :: colsum   => psb_d_colsum
    procedure, pass(a) :: aclsum   => psb_d_aclsum
    procedure, pass(a) :: csmv_v   => psb_d_csmv_vect
    procedure, pass(a) :: csmv     => psb_d_csmv
    procedure, pass(a) :: csmm     => psb_d_csmm
    generic, public    :: spmm     => csmm, csmv, csmv_v
    procedure, pass(a) :: scals    => psb_d_scals
    procedure, pass(a) :: scalv    => psb_d_scal
    generic, public    :: scal     => scals, scalv
    procedure, pass(a) :: cssv_v   => psb_d_cssv_vect
    procedure, pass(a) :: cssv     => psb_d_cssv
    procedure, pass(a) :: cssm     => psb_d_cssm
    generic, public    :: spsm     => cssm, cssv, cssv_v

  end type psb_dspmat_type

  private :: psb_d_get_nrows, psb_d_get_ncols, psb_d_get_nzeros, psb_d_get_size, &
       & psb_d_get_dupl, psb_d_is_null, psb_d_is_bld, &
       & psb_d_is_upd, psb_d_is_asb, psb_d_is_sorted, psb_d_is_upper, &
       & psb_d_is_lower, psb_d_is_triangle, psb_d_get_nz_row

  interface psb_sizeof
    module procedure psb_d_sizeof
  end interface


  ! == ===================================
  !
  !
  !
  ! Setters 
  !
  !
  !
  !
  !
  !
  ! == ===================================


  interface 
    subroutine  psb_d_set_nrows(m,a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      integer(psb_ipk_), intent(in) :: m
    end subroutine psb_d_set_nrows
  end interface
  
  interface 
    subroutine psb_d_set_ncols(n,a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      integer(psb_ipk_), intent(in) :: n
    end subroutine psb_d_set_ncols
  end interface
  
  interface 
    subroutine  psb_d_set_dupl(n,a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      integer(psb_ipk_), intent(in) :: n
    end subroutine psb_d_set_dupl
  end interface
  
  interface 
    subroutine psb_d_set_null(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_set_null
  end interface
  
  interface 
    subroutine psb_d_set_bld(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_set_bld
  end interface
  
  interface 
    subroutine psb_d_set_upd(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_set_upd
  end interface
  
  interface 
    subroutine psb_d_set_asb(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_set_asb
  end interface
  
  interface 
    subroutine psb_d_set_sorted(a,val) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      logical, intent(in), optional :: val
    end subroutine psb_d_set_sorted
  end interface
  
  interface 
    subroutine psb_d_set_triangle(a,val) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      logical, intent(in), optional :: val
    end subroutine psb_d_set_triangle
  end interface
  
  interface 
    subroutine psb_d_set_unit(a,val) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      logical, intent(in), optional :: val
    end subroutine psb_d_set_unit
  end interface
  
  interface 
    subroutine psb_d_set_lower(a,val) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      logical, intent(in), optional :: val
    end subroutine psb_d_set_lower
  end interface
  
  interface 
    subroutine psb_d_set_upper(a,val) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      logical, intent(in), optional :: val
    end subroutine psb_d_set_upper
  end interface
  
  interface 
    subroutine psb_d_sparse_print(iout,a,iv,head,ivr,ivc)
      import :: psb_ipk_, psb_dspmat_type
      integer(psb_ipk_), intent(in)               :: iout
      class(psb_dspmat_type), intent(in) :: a   
      integer(psb_ipk_), intent(in), optional     :: iv(:)
      character(len=*), optional        :: head
      integer(psb_ipk_), intent(in), optional     :: ivr(:), ivc(:)
    end subroutine psb_d_sparse_print
  end interface

  interface 
    subroutine psb_d_n_sparse_print(fname,a,iv,head,ivr,ivc)
      import :: psb_ipk_, psb_dspmat_type
      character(len=*), intent(in)      :: fname
      class(psb_dspmat_type), intent(in) :: a   
      integer(psb_ipk_), intent(in), optional     :: iv(:)
      character(len=*), optional        :: head
      integer(psb_ipk_), intent(in), optional     :: ivr(:), ivc(:)
    end subroutine psb_d_n_sparse_print
  end interface
  
  interface 
    subroutine psb_d_get_neigh(a,idx,neigh,n,info,lev)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(in) :: a   
      integer(psb_ipk_), intent(in)                :: idx 
      integer(psb_ipk_), intent(out)               :: n   
      integer(psb_ipk_), allocatable, intent(out)  :: neigh(:)
      integer(psb_ipk_), intent(out)               :: info
      integer(psb_ipk_), optional, intent(in)      :: lev 
    end subroutine psb_d_get_neigh
  end interface
  
  interface 
    subroutine psb_d_csall(nr,nc,a,info,nz) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(out) :: a
      integer(psb_ipk_), intent(in)             :: nr,nc
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), intent(in), optional   :: nz
    end subroutine psb_d_csall
  end interface
  
  interface 
    subroutine psb_d_reallocate_nz(nz,a) 
      import :: psb_ipk_, psb_dspmat_type
      integer(psb_ipk_), intent(in) :: nz
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_reallocate_nz
  end interface
  
  interface 
    subroutine psb_d_free(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_free
  end interface
  
  interface 
    subroutine psb_d_trim(a) 
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_trim
  end interface
  
  interface 
    subroutine psb_d_csput(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(inout) :: a
      real(psb_dpk_), intent(in)      :: val(:)
      integer(psb_ipk_), intent(in)             :: nz, ia(:), ja(:), imin,imax,jmin,jmax
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), intent(in), optional   :: gtl(:)
    end subroutine psb_d_csput
  end interface
  
  interface 
    subroutine psb_d_csgetptn(imin,imax,a,nz,ia,ja,info,&
       & jmin,jmax,iren,append,nzin,rscale,cscale)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_), intent(out)                 :: nz
      integer(psb_ipk_), allocatable, intent(inout)  :: ia(:), ja(:)
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_d_csgetptn
  end interface
  
  interface 
    subroutine psb_d_csgetrow(imin,imax,a,nz,ia,ja,val,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_), intent(out)                 :: nz
      integer(psb_ipk_), allocatable, intent(inout)  :: ia(:), ja(:)
      real(psb_dpk_), allocatable,  intent(inout)    :: val(:)
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_d_csgetrow
  end interface
  
  interface 
    subroutine psb_d_csgetblk(imin,imax,a,b,info,&
       & jmin,jmax,iren,append,rscale,cscale)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      class(psb_dspmat_type), intent(out) :: b
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_d_csgetblk
  end interface
  
  interface 
    subroutine psb_d_csclip(a,b,info,&
       & imin,imax,jmin,jmax,rscale,cscale)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      class(psb_dspmat_type), intent(out) :: b
      integer(psb_ipk_),intent(out)                  :: info
      integer(psb_ipk_), intent(in), optional        :: imin,imax,jmin,jmax
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_d_csclip
  end interface
  
  interface 
    subroutine psb_d_b_csclip(a,b,info,&
       & imin,imax,jmin,jmax,rscale,cscale)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_coo_sparse_mat
      class(psb_dspmat_type), intent(in) :: a
      type(psb_d_coo_sparse_mat), intent(out) :: b
      integer(psb_ipk_),intent(out)                  :: info
      integer(psb_ipk_), intent(in), optional        :: imin,imax,jmin,jmax
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_d_b_csclip
  end interface
  
  interface 
    subroutine psb_d_mold(a,b)
      import :: psb_ipk_, psb_dspmat_type, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(inout)     :: a
      class(psb_d_base_sparse_mat), allocatable, intent(out) :: b
    end subroutine psb_d_mold
  end interface
  
  interface 
    subroutine psb_d_transp_1mat(a)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_transp_1mat
  end interface
  
  interface 
    subroutine psb_d_transp_2mat(a,b)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(in)  :: a
      class(psb_dspmat_type), intent(out) :: b
    end subroutine psb_d_transp_2mat
  end interface
  
  interface 
    subroutine psb_d_transc_1mat(a)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
    end subroutine psb_d_transc_1mat
  end interface
  
  interface 
    subroutine psb_d_transc_2mat(a,b)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(in)  :: a
      class(psb_dspmat_type), intent(out) :: b
    end subroutine psb_d_transc_2mat
  end interface
  
  interface 
    subroutine psb_d_reinit(a,clear)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a   
      logical, intent(in), optional :: clear
    end subroutine psb_d_reinit
    
  end interface


  !
  ! These methods are specific to the outer SPMAT_TYPE level, since
  ! they tamper with the inner BASE_SPARSE_MAT object.
  !
  !

  !
  ! CSCNV: switches to a different internal derived type.
  !   3 versions: copying to target
  !               copying to a base_sparse_mat object.
  !               in place
  !                 
  !
  interface 
    subroutine psb_d_cscnv(a,b,info,type,mold,upd,dupl)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(in)    :: a
      class(psb_dspmat_type), intent(out)   :: b
      integer(psb_ipk_), intent(out)                   :: info
      integer(psb_ipk_),optional, intent(in)           :: dupl, upd
      character(len=*), optional, intent(in) :: type
      class(psb_d_base_sparse_mat), intent(in), optional :: mold
    end subroutine psb_d_cscnv
  end interface
  

  interface 
    subroutine psb_d_cscnv_ip(a,iinfo,type,mold,dupl)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(inout) :: a
      integer(psb_ipk_), intent(out)                   :: iinfo
      integer(psb_ipk_),optional, intent(in)           :: dupl
      character(len=*), optional, intent(in) :: type
      class(psb_d_base_sparse_mat), intent(in), optional :: mold
    end subroutine psb_d_cscnv_ip
  end interface
  

  interface 
    subroutine psb_d_cscnv_base(a,b,info,dupl)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(in)       :: a
      class(psb_d_base_sparse_mat), intent(out) :: b
      integer(psb_ipk_), intent(out)                   :: info
      integer(psb_ipk_),optional, intent(in)           :: dupl
    end subroutine psb_d_cscnv_base
  end interface
  
  !
  ! Produce a version of the matrix with diagonal cut
  ! out; passes through a COO buffer. 
  !
  interface 
    subroutine psb_d_clip_d(a,b,info)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(in) :: a
      class(psb_dspmat_type), intent(out) :: b
      integer(psb_ipk_),intent(out)                  :: info
    end subroutine psb_d_clip_d
  end interface
  
  interface 
    subroutine psb_d_clip_d_ip(a,info)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      integer(psb_ipk_),intent(out)                  :: info
    end subroutine psb_d_clip_d_ip
  end interface
  
  !
  ! These four interfaces cut through the
  ! encapsulation between spmat_type and base_sparse_mat.
  !
  interface 
    subroutine psb_d_mv_from(a,b)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(out) :: a
      class(psb_d_base_sparse_mat), intent(inout) :: b
    end subroutine psb_d_mv_from
  end interface
  
  interface 
    subroutine psb_d_cp_from(a,b)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(out) :: a
      class(psb_d_base_sparse_mat), intent(in) :: b
    end subroutine psb_d_cp_from
  end interface
  
  interface 
    subroutine psb_d_mv_to(a,b)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat
      class(psb_dspmat_type), intent(inout) :: a
      class(psb_d_base_sparse_mat), intent(out) :: b
    end subroutine psb_d_mv_to
  end interface
  
  interface 
    subroutine psb_d_cp_to(a,b)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_, psb_d_base_sparse_mat    
      class(psb_dspmat_type), intent(in) :: a
      class(psb_d_base_sparse_mat), intent(out) :: b
    end subroutine psb_d_cp_to
  end interface
  
  !
  ! Transfer the internal allocation to the target.
  !  
  interface psb_move_alloc 
    subroutine psb_dspmat_type_move(a,b,info)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      class(psb_dspmat_type), intent(out)   :: b
      integer(psb_ipk_), intent(out)                   :: info
    end subroutine psb_dspmat_type_move
  end interface
  
  interface 
    subroutine psb_dspmat_clone(a,b,info)
      import :: psb_ipk_, psb_dspmat_type
      class(psb_dspmat_type), intent(inout) :: a
      class(psb_dspmat_type), intent(out)   :: b
      integer(psb_ipk_), intent(out)        :: info
    end subroutine psb_dspmat_clone
  end interface




  ! == ===================================
  !
  !
  !
  ! Computational routines
  !
  !
  !
  !
  !
  !
  ! == ===================================

  interface psb_csmm
    subroutine psb_d_csmm(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(in)    :: alpha, beta, x(:,:)
      real(psb_dpk_), intent(inout) :: y(:,:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_d_csmm
    subroutine psb_d_csmv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(in)    :: alpha, beta, x(:)
      real(psb_dpk_), intent(inout) :: y(:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_d_csmv
    subroutine psb_d_csmv_vect(alpha,a,x,beta,y,info,trans) 
      use psb_d_vect_mod, only : psb_d_vect_type
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in)   :: a
      real(psb_dpk_), intent(in)        :: alpha, beta
      type(psb_d_vect_type), intent(inout) :: x
      type(psb_d_vect_type), intent(inout) :: y
      integer(psb_ipk_), intent(out)                 :: info
      character, optional, intent(in)      :: trans
    end subroutine psb_d_csmv_vect
  end interface
  
  interface psb_cssm
    subroutine psb_d_cssm(alpha,a,x,beta,y,info,trans,scale,d) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(in)    :: alpha, beta, x(:,:)
      real(psb_dpk_), intent(inout) :: y(:,:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans, scale
      real(psb_dpk_), intent(in), optional :: d(:)
    end subroutine psb_d_cssm
    subroutine psb_d_cssv(alpha,a,x,beta,y,info,trans,scale,d) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(in)    :: alpha, beta, x(:)
      real(psb_dpk_), intent(inout) :: y(:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans, scale
      real(psb_dpk_), intent(in), optional :: d(:)
    end subroutine psb_d_cssv
    subroutine psb_d_cssv_vect(alpha,a,x,beta,y,info,trans,scale,d) 
      use psb_d_vect_mod, only : psb_d_vect_type
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in)   :: a
      real(psb_dpk_), intent(in)        :: alpha, beta
      type(psb_d_vect_type), intent(inout) :: x
      type(psb_d_vect_type), intent(inout) :: y
      integer(psb_ipk_), intent(out)                 :: info
      character, optional, intent(in)      :: trans, scale
      type(psb_d_vect_type), optional, intent(inout)   :: d
    end subroutine psb_d_cssv_vect
  end interface
  
  interface 
    function psb_d_maxval(a) result(res)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_)         :: res
    end function psb_d_maxval
  end interface
  
  interface 
    function psb_d_csnmi(a) result(res)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_)         :: res
    end function psb_d_csnmi
  end interface
  
  interface 
    function psb_d_csnm1(a) result(res)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_)         :: res
    end function psb_d_csnm1
  end interface

  interface 
    subroutine psb_d_rowsum(d,a,info) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(out)     :: d(:)
      integer(psb_ipk_), intent(out)               :: info
    end subroutine psb_d_rowsum
  end interface

  interface 
    subroutine psb_d_arwsum(d,a,info) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(out)        :: d(:)
      integer(psb_ipk_), intent(out)               :: info
    end subroutine psb_d_arwsum
  end interface
  
  interface 
    subroutine psb_d_colsum(d,a,info) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(out)     :: d(:)
      integer(psb_ipk_), intent(out)               :: info
    end subroutine psb_d_colsum
  end interface

  interface 
    subroutine psb_d_aclsum(d,a,info) 
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(out)        :: d(:)
      integer(psb_ipk_), intent(out)              :: info
    end subroutine psb_d_aclsum
  end interface

  
  interface 
    subroutine psb_d_get_diag(a,d,info)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(in) :: a
      real(psb_dpk_), intent(out)         :: d(:)
      integer(psb_ipk_), intent(out)                 :: info
    end subroutine psb_d_get_diag
  end interface
  
  interface psb_scal
    subroutine psb_d_scal(d,a,info,side)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(inout) :: a
      real(psb_dpk_), intent(in)             :: d(:)
      integer(psb_ipk_), intent(out)                    :: info
      character, intent(in), optional :: side
    end subroutine psb_d_scal
    subroutine psb_d_scals(d,a,info)
      import :: psb_ipk_, psb_dspmat_type, psb_dpk_
      class(psb_dspmat_type), intent(inout) :: a
      real(psb_dpk_), intent(in)             :: d
      integer(psb_ipk_), intent(out)                    :: info
    end subroutine psb_d_scals
  end interface


contains 


  ! == ===================================
  !
  !
  !
  ! Getters 
  !
  !
  !
  !
  !
  ! == ===================================

  
  function psb_d_sizeof(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_long_int_k_) :: res
    
    res = 0
    if (allocated(a%a)) then 
      res = a%a%sizeof()
    end if
    
  end function psb_d_sizeof


  function psb_d_get_fmt(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    character(len=5) :: res

    if (allocated(a%a)) then 
      res = a%a%get_fmt()
    else
      res = 'NULL'
    end if

  end function psb_d_get_fmt


  function psb_d_get_dupl(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res

    if (allocated(a%a)) then 
      res = a%a%get_dupl()
    else
      res = psb_invalid_
    end if
  end function psb_d_get_dupl

  function psb_d_get_nrows(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res

    if (allocated(a%a)) then 
      res = a%a%get_nrows()
    else
      res = 0
    end if

  end function psb_d_get_nrows

  function psb_d_get_ncols(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res

    if (allocated(a%a)) then 
      res = a%a%get_ncols()
    else
      res = 0
    end if

  end function psb_d_get_ncols

  function psb_d_is_triangle(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_triangle()
    else
      res = .false.
    end if

  end function psb_d_is_triangle

  function psb_d_is_unit(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_unit()
    else
      res = .false.
    end if

  end function psb_d_is_unit

  function psb_d_is_upper(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_upper()
    else
      res = .false.
    end if

  end function psb_d_is_upper

  function psb_d_is_lower(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = .not. a%a%is_upper()
    else
      res = .false.
    end if

  end function psb_d_is_lower

  function psb_d_is_null(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_null() 
    else
      res = .true.
    end if

  end function psb_d_is_null

  function psb_d_is_bld(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_bld()
    else
      res = .false.
    end if

  end function psb_d_is_bld

  function psb_d_is_upd(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_upd()
    else
      res = .false.
    end if

  end function psb_d_is_upd

  function psb_d_is_asb(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_asb()
    else
      res = .false.
    end if

  end function psb_d_is_asb

  function psb_d_is_sorted(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    logical :: res

    if (allocated(a%a)) then 
      res = a%a%is_sorted()
    else
      res = .false.
    end if

  end function psb_d_is_sorted



  function psb_d_get_nzeros(a) result(res)
    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res

    res = 0
    if (allocated(a%a)) then 
      res = a%a%get_nzeros()
    end if

  end function psb_d_get_nzeros

  function psb_d_get_size(a) result(res)

    implicit none 
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res


    res = 0
    if (allocated(a%a)) then 
      res = a%a%get_size()
    end if

  end function psb_d_get_size


  function psb_d_get_nz_row(idx,a) result(res)
    implicit none 
    integer(psb_ipk_), intent(in)               :: idx
    class(psb_dspmat_type), intent(in) :: a
    integer(psb_ipk_) :: res

    res = 0
    
    if (allocated(a%a)) res = a%a%get_nz_row(idx)

  end function psb_d_get_nz_row


end module psb_d_mat_mod
