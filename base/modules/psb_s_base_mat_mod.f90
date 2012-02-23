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
!
!
module psb_s_base_mat_mod
  
  use psb_base_mat_mod
  use psb_s_base_vect_mod


  !> \namespace  psb_base_mod  \class  psb_s_base_sparse_mat
  !! \extends psb_base_mat_mod::psb_base_sparse_mat
  !! The psb_s_base_sparse_mat type, extending psb_base_sparse_mat,
  !! defines a middle level  real(psb_spk_) sparse matrix object.
  !! This class object itself does not have any additional members
  !! with respect to those of the base class. No methods can be fully
  !! implemented at this level, but we can define the interface for the
  !! computational methods requiring the knowledge of the underlying
  !! field, such as the matrix-vector product; this interface is defined,
  !! but is supposed to be overridden at the leaf level.
  !!
  !! About the method MOLD: this has been defined for those compilers
  !! not yet supporting ALLOCATE( ...,MOLD=...); it's otherwise silly to
  !! duplicate "by hand" what is specified in the language (in this case F2008)
  !!
  type, extends(psb_base_sparse_mat) :: psb_s_base_sparse_mat
  contains
    !
    ! Data management methods: defined here, but (mostly) not implemented.
    !    
    procedure, pass(a) :: csput         => psb_s_base_csput  
    procedure, pass(a) :: s_csgetrow  => psb_s_base_csgetrow
    procedure, pass(a) :: s_csgetblk  => psb_s_base_csgetblk
    procedure, pass(a) :: get_diag      => psb_s_base_get_diag
    generic, public    :: csget         => s_csgetrow, s_csgetblk 
    procedure, pass(a) :: csclip        => psb_s_base_csclip 
    procedure, pass(a) :: mold          => psb_s_base_mold 
    procedure, pass(a) :: cp_to_coo     => psb_s_base_cp_to_coo   
    procedure, pass(a) :: cp_from_coo   => psb_s_base_cp_from_coo 
    procedure, pass(a) :: cp_to_fmt     => psb_s_base_cp_to_fmt   
    procedure, pass(a) :: cp_from_fmt   => psb_s_base_cp_from_fmt 
    procedure, pass(a) :: mv_to_coo     => psb_s_base_mv_to_coo   
    procedure, pass(a) :: mv_from_coo   => psb_s_base_mv_from_coo 
    procedure, pass(a) :: mv_to_fmt     => psb_s_base_mv_to_fmt   
    procedure, pass(a) :: mv_from_fmt   => psb_s_base_mv_from_fmt 
    procedure, pass(a) :: s_base_cp_from
    generic, public    :: cp_from => s_base_cp_from
    procedure, pass(a) :: s_base_mv_from
    generic, public    :: mv_from => s_base_mv_from
    
    !
    ! Transpose methods: defined here but not implemented. 
    !    
    procedure, pass(a) :: transp_1mat => psb_s_base_transp_1mat
    procedure, pass(a) :: transp_2mat => psb_s_base_transp_2mat
    procedure, pass(a) :: transc_1mat => psb_s_base_transc_1mat
    procedure, pass(a) :: transc_2mat => psb_s_base_transc_2mat
    
    !
    ! Computational methods: defined here but not implemented. 
    !    
    procedure, pass(a) :: s_sp_mv      => psb_s_base_vect_mv
    procedure, pass(a) :: s_csmv       => psb_s_base_csmv
    procedure, pass(a) :: s_csmm       => psb_s_base_csmm
    generic, public    :: csmm         => s_csmm, s_csmv, s_sp_mv
    procedure, pass(a) :: s_in_sv      => psb_s_base_inner_vect_sv
    procedure, pass(a) :: s_inner_cssv => psb_s_base_inner_cssv    
    procedure, pass(a) :: s_inner_cssm => psb_s_base_inner_cssm
    generic, public    :: inner_cssm   => s_inner_cssm, s_inner_cssv, s_in_sv
    procedure, pass(a) :: s_vect_cssv  => psb_s_base_vect_cssv
    procedure, pass(a) :: s_cssv       => psb_s_base_cssv
    procedure, pass(a) :: s_cssm       => psb_s_base_cssm
    generic, public    :: cssm         => s_cssm, s_cssv, s_vect_cssv
    procedure, pass(a) :: s_scals      => psb_s_base_scals
    procedure, pass(a) :: s_scal       => psb_s_base_scal
    generic, public    :: scal         => s_scals, s_scal 
    procedure, pass(a) :: maxval       => psb_s_base_maxval
    procedure, pass(a) :: csnmi        => psb_s_base_csnmi
    procedure, pass(a) :: csnm1        => psb_s_base_csnm1
    procedure, pass(a) :: rowsum       => psb_s_base_rowsum
    procedure, pass(a) :: arwsum       => psb_s_base_arwsum
    procedure, pass(a) :: colsum       => psb_s_base_colsum
    procedure, pass(a) :: aclsum       => psb_s_base_aclsum
  end type psb_s_base_sparse_mat
  
  private :: s_base_cp_from, s_base_mv_from
  
  
  !> \namespace  psb_base_mod  \class  psb_s_coo_sparse_mat
  !! \extends psb_s_base_mat_mod::psb_s_base_sparse_mat
  !! 
  !! psb_s_coo_sparse_mat type and the related methods. This is the
  !! reference type for all the format transitions, copies and mv unless
  !! methods are implemented that allow the direct transition from one
  !! format to another. It is defined here since all other classes must
  !! refer to it per the MEDIATOR design pattern.
  !!
  type, extends(psb_s_base_sparse_mat) :: psb_s_coo_sparse_mat
    !> Number of nonzeros.
    integer(psb_ipk_) :: nnz
    !> Row indices.
    integer(psb_ipk_), allocatable :: ia(:)
    !> Column indices.
    integer(psb_ipk_), allocatable :: ja(:)
    !> Coefficient values. 
    real(psb_spk_), allocatable :: val(:)
    
  contains
    !
    ! Data management methods. 
    !    
    procedure, pass(a) :: get_size     => s_coo_get_size
    procedure, pass(a) :: get_nzeros   => s_coo_get_nzeros
    procedure, nopass  :: get_fmt      => s_coo_get_fmt
    procedure, pass(a) :: sizeof       => s_coo_sizeof
    procedure, pass(a) :: reallocate_nz => psb_s_coo_reallocate_nz
    procedure, pass(a) :: allocate_mnnz => psb_s_coo_allocate_mnnz
    procedure, pass(a) :: cp_to_coo    => psb_s_cp_coo_to_coo
    procedure, pass(a) :: cp_from_coo  => psb_s_cp_coo_from_coo
    procedure, pass(a) :: cp_to_fmt    => psb_s_cp_coo_to_fmt
    procedure, pass(a) :: cp_from_fmt  => psb_s_cp_coo_from_fmt
    procedure, pass(a) :: mv_to_coo    => psb_s_mv_coo_to_coo
    procedure, pass(a) :: mv_from_coo  => psb_s_mv_coo_from_coo
    procedure, pass(a) :: mv_to_fmt    => psb_s_mv_coo_to_fmt
    procedure, pass(a) :: mv_from_fmt  => psb_s_mv_coo_from_fmt
    procedure, pass(a) :: csput        => psb_s_coo_csput
    procedure, pass(a) :: get_diag     => psb_s_coo_get_diag
    procedure, pass(a) :: s_csgetrow   => psb_s_coo_csgetrow
    procedure, pass(a) :: csgetptn     => psb_s_coo_csgetptn
    procedure, pass(a) :: reinit       => psb_s_coo_reinit
    procedure, pass(a) :: get_nz_row   => psb_s_coo_get_nz_row
    procedure, pass(a) :: fix          => psb_s_fix_coo
    procedure, pass(a) :: trim         => psb_s_coo_trim
    procedure, pass(a) :: print        => psb_s_coo_print
    procedure, pass(a) :: free         => s_coo_free
    procedure, pass(a) :: mold         => psb_s_coo_mold
    procedure, pass(a) :: psb_s_coo_cp_from
    generic, public    :: cp_from => psb_s_coo_cp_from
    procedure, pass(a) :: psb_s_coo_mv_from
    generic, public    :: mv_from => psb_s_coo_mv_from
    !
    ! This is COO specific
    !
    procedure, pass(a) :: set_nzeros   => s_coo_set_nzeros
    
    !
    ! Transpose methods. These are the base of all
    ! indirection in transpose, together with conversions
    ! they are sufficient for all cases. 
    !
    procedure, pass(a) :: transp_1mat => s_coo_transp_1mat
    procedure, pass(a) :: transc_1mat => s_coo_transc_1mat

    !
    ! Computational methods. 
    !    
    procedure, pass(a) :: s_csmm       => psb_s_coo_csmm
    procedure, pass(a) :: s_csmv       => psb_s_coo_csmv
    procedure, pass(a) :: s_inner_cssm => psb_s_coo_cssm
    procedure, pass(a) :: s_inner_cssv => psb_s_coo_cssv
    procedure, pass(a) :: s_scals      => psb_s_coo_scals
    procedure, pass(a) :: s_scal       => psb_s_coo_scal
    procedure, pass(a) :: maxval       => psb_s_coo_maxval
    procedure, pass(a) :: csnmi        => psb_s_coo_csnmi
    procedure, pass(a) :: csnm1        => psb_s_coo_csnm1
    procedure, pass(a) :: rowsum       => psb_s_coo_rowsum
    procedure, pass(a) :: arwsum       => psb_s_coo_arwsum
    procedure, pass(a) :: colsum       => psb_s_coo_colsum
    procedure, pass(a) :: aclsum       => psb_s_coo_aclsum
    
  end type psb_s_coo_sparse_mat
  
  private :: s_coo_get_nzeros, s_coo_set_nzeros, &
       & s_coo_get_fmt,  s_coo_free, s_coo_sizeof, &
       & s_coo_transp_1mat, s_coo_transc_1mat
  
  
  
  ! == =================
  !
  ! BASE interfaces
  !
  ! == =================

  !> Function  csput:
  !! \brief Insert coefficients. 
  !!
  !!
  !!         Given  a list of NZ triples
  !!           (IA(i),JA(i),VAL(i))
  !!         record a new coefficient in A such that
  !!            A(IA(1:nz),JA(1:nz)) = VAL(1:NZ).
  !!            
  !!         The internal components IA,JA,VAL are reallocated as necessary.
  !!         Constraints:
  !!         - If the matrix A is in the BUILD state, then the method will
  !!           only work for COO matrices, all other format will throw an error.
  !!           In this case coefficients are queued inside A for further processing.
  !!         - If the matrix A is in the UPDATE state, then it can be in any format;
  !!           the update operation will perform either
  !!               A(IA(1:nz),JA(1:nz)) = VAL(1:NZ)
  !!           or
  !!               A(IA(1:nz),JA(1:nz)) =  A(IA(1:nz),JA(1:nz))+VAL(1:NZ)
  !!           according to the value of DUPLICATE.
  !!         - Coefficients with (IA(I),JA(I)) outside the ranges specified by
  !!           IMIN:IMAX,JMIN:JMAX will be ignored. 
  !!           
  !!  \param nz    number of triples in input
  !!  \param ia(:)  the input row indices
  !!  \param ja(:)  the input col indices
  !!  \param val(:)  the input coefficients
  !!  \param imin  minimum row index 
  !!  \param imax  maximum row index 
  !!  \param jmin  minimum col index 
  !!  \param jmax  maximum col index 
  !!  \param info  return code
  !!  \param gtl(:) [none] an array to renumber indices   (iren(ia(:)),iren(ja(:))
  !!
  !
  interface 
    subroutine psb_s_base_csput(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: val(:)
      integer(psb_ipk_), intent(in)             :: nz, ia(:), ja(:), imin,imax,jmin,jmax
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), intent(in), optional   :: gtl(:)
    end subroutine psb_s_base_csput
  end interface
  
  !
  !
  !> Function  csgetrow:
  !! \brief Get a (subset of) row(s)
  !!        
  !!        getrow is the basic method by which the other (getblk, clip) can
  !!        be implemented.
  !!        
  !!        Returns the set
  !!           NZ, IA(1:nz), JA(1:nz), VAL(1:NZ)
  !!         each identifying the position of a nonzero in A
  !!         between row indices IMIN:IMAX; 
  !!         IA,JA are reallocated as necessary.
  !!         
  !!  \param imin  the minimum row index we are interested in 
  !!  \param imax  the minimum row index we are interested in 
  !!  \param nz the number of output coefficients
  !!  \param ia(:)  the output row indices
  !!  \param ja(:)  the output col indices
  !!  \param val(:)  the output coefficients
  !!  \param info  return code
  !!  \param jmin [1] minimum col index 
  !!  \param jmax [a\%get_ncols()] maximum col index 
  !!  \param iren(:) [none] an array to return renumbered indices   (iren(ia(:)),iren(ja(:))
  !!  \param rscale [false] map [min(ia(:)):max(ia(:))] onto [1:max(ia(:))-min(ia(:))+1]
  !!  \param cscale [false] map [min(ja(:)):max(ja(:))] onto [1:max(ja(:))-min(ja(:))+1]
  !!          ( iren cannot be specified with rscale/cscale)
  !!  \param append [false] append to ia,ja 
  !!  \param nzin [none]  if append, then first new entry should go in entry nzin+1
  !!           
  !
  interface 
    subroutine psb_s_base_csgetrow(imin,imax,a,nz,ia,ja,val,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_), intent(out)                 :: nz
      integer(psb_ipk_), allocatable, intent(inout)  :: ia(:), ja(:)
      real(psb_spk_), allocatable,  intent(inout)    :: val(:)
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_s_base_csgetrow
  end interface
  
  !
  !> Function  csgetblk:
  !! \brief Get a (subset of) row(s)
  !!        
  !!        getblk is very similar to getrow, except that the output
  !!        is packaged in a psb_s_coo_sparse_mat object
  !!         
  !!  \param imin  the minimum row index we are interested in 
  !!  \param imax  the minimum row index we are interested in 
  !!  \param b     the output (sub)matrix
  !!  \param info  return code
  !!  \param jmin [1] minimum col index 
  !!  \param jmax [a\%get_ncols()] maximum col index 
  !!  \param iren(:) [none] an array to return renumbered indices   (iren(ia(:)),iren(ja(:))
  !!  \param rscale [false] map [min(ia(:)):max(ia(:))] onto [1:max(ia(:))-min(ia(:))+1]
  !!  \param cscale [false] map [min(ja(:)):max(ja(:))] onto [1:max(ja(:))-min(ja(:))+1]
  !!          ( iren cannot be specified with rscale/cscale)
  !!  \param append [false] append to ia,ja 
  !!  \param nzin [none]  if append, then first new entry should go in entry nzin+1
  !!           
  !
  interface 
    subroutine psb_s_base_csgetblk(imin,imax,a,b,info,&
         & jmin,jmax,iren,append,rscale,cscale)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_s_base_csgetblk
  end interface
  
  !
  !
  !> Function  csclip:
  !! \brief Get a submatrix.
  !!        
  !!        csclip is practically identical to getblk.
  !!        One of them has to go away.....
  !!         
  !!  \param b     the output submatrix
  !!  \param info  return code
  !!  \param imin [1] the minimum row index we are interested in 
  !!  \param imax [a%get_nrows()] the minimum row index we are interested in 
  !!  \param jmin [1] minimum col index 
  !!  \param jmax [a\%get_ncols()] maximum col index 
  !!  \param iren(:) [none] an array to return renumbered indices   (iren(ia(:)),iren(ja(:))
  !!  \param rscale [false] map [min(ia(:)):max(ia(:))] onto [1:max(ia(:))-min(ia(:))+1]
  !!  \param cscale [false] map [min(ja(:)):max(ja(:))] onto [1:max(ja(:))-min(ja(:))+1]
  !!          ( iren cannot be specified with rscale/cscale)
  !!  \param append [false] append to ia,ja 
  !!  \param nzin [none]  if append, then first new entry should go in entry nzin+1
  !!           
  !
  interface 
    subroutine psb_s_base_csclip(a,b,info,&
         & imin,imax,jmin,jmax,rscale,cscale)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_s_coo_sparse_mat), intent(out) :: b
      integer(psb_ipk_),intent(out)                  :: info
      integer(psb_ipk_), intent(in), optional        :: imin,imax,jmin,jmax
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_s_base_csclip
  end interface
  
  !
  !> Function  get_diag:
  !! \brief Extract the diagonal of A. 
  !!        
  !!   D(i) = A(i:i), i=1:min(nrows,ncols)
  !!
  !! \param d(:)  The output diagonal
  !! \param info  return code. 
  ! 
  interface 
    subroutine psb_s_base_get_diag(a,d,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)     :: d(:)
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_get_diag
  end interface
  
  !
  !> Function  mold:
  !! \brief Allocate a class(psb_s_base_sparse_mat) with the
  !!     same dynamic type as the input.
  !!     This is equivalent to allocate(  mold=  ) and is provided
  !!     for those compilers not yet supporting mold.
  !!   \param b The output variable
  !!   \param info return code
  ! 
  interface 
    subroutine psb_s_base_mold(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_long_int_k_
      class(psb_s_base_sparse_mat), intent(in)               :: a
      class(psb_s_base_sparse_mat), intent(out), allocatable :: b
      integer(psb_ipk_), intent(out)                                 :: info
    end subroutine psb_s_base_mold
  end interface
  
  
  !
  !> Function  cp_to_coo:
  !! \brief Copy and convert to psb_s_coo_sparse_mat
  !!        Invoked from the source object.
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_cp_to_coo(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_cp_to_coo
  end interface
  
  !
  !> Function  cp_from_coo:
  !! \brief Copy and convert from psb_s_coo_sparse_mat
  !!        Invoked from the target object.
  !!   \param b The input variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_cp_from_coo(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(in) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_cp_from_coo
  end interface
  
  !
  !> Function  cp_to_fmt:
  !! \brief Copy and convert to a class(psb_s_base_sparse_mat)
  !!        Invoked from the source object. Can be implemented by
  !!        simply invoking a%cp_to_coo(tmp) and then b%cp_from_coo(tmp).
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_cp_to_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_s_base_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_cp_to_fmt
  end interface
  
  !
  !> Function  cp_from_fmt:
  !! \brief Copy and convert from a class(psb_s_base_sparse_mat)
  !!        Invoked from the target object. Can be implemented by
  !!        simply invoking b%cp_to_coo(tmp) and then a%cp_from_coo(tmp).
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_cp_from_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_base_sparse_mat), intent(in) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_cp_from_fmt
  end interface
  
  !
  !> Function  mv_to_coo:
  !! \brief Convert to psb_s_coo_sparse_mat, freeing the source.
  !!        Invoked from the source object.
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_mv_to_coo(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_mv_to_coo
  end interface
  
  !
  !> Function  mv_from_coo:
  !! \brief Convert from psb_s_coo_sparse_mat, freeing the source.
  !!        Invoked from the target object.
  !!   \param b The input variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_mv_from_coo(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_mv_from_coo
  end interface
  
  !
  !> Function  mv_to_fmt:
  !! \brief Convert to a class(psb_s_base_sparse_mat), freeing the source.
  !!        Invoked from the source object. Can be implemented by
  !!        simply invoking a%mv_to_coo(tmp) and then b%mv_from_coo(tmp).
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_mv_to_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_base_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_mv_to_fmt
  end interface
  
  !
  !> Function  mv_from_fmt:
  !! \brief Convert from a class(psb_s_base_sparse_mat), freeing the source.
  !!        Invoked from the target object. Can be implemented by
  !!        simply invoking b%mv_to_coo(tmp) and then a%mv_from_coo(tmp).
  !!   \param b The output variable
  !!   \param info return code
  !  
  interface 
    subroutine psb_s_base_mv_from_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      class(psb_s_base_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_mv_from_fmt
  end interface
  
  !
  !> Function  transp:
  !! \brief Transpose. Can always be implemented by staging through a COO
  !!        temporary for which transpose is very easy. 
  !!        Copyout version
  !!   \param b The output variable
  !  
   interface 
    subroutine psb_s_base_transp_2mat(a,b)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_base_sparse_mat), intent(out)    :: b
    end subroutine psb_s_base_transp_2mat
  end interface
  
  !
  !> Function  transc:
  !! \brief Conjugate Transpose. Can always be implemented by staging through a COO
  !!        temporary for which transpose is very easy. 
  !!        Copyout version.
  !!   \param b The output variable
  !  
  interface  
    subroutine psb_s_base_transc_2mat(a,b)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      class(psb_base_sparse_mat), intent(out)    :: b
    end subroutine psb_s_base_transc_2mat
  end interface
  
  !
  !> Function  transp:
  !! \brief Transpose. Can always be implemented by staging through a COO
  !!        temporary for which transpose is very easy. 
  !!        In-place version.
  !  
  interface 
    subroutine psb_s_base_transp_1mat(a)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
    end subroutine psb_s_base_transp_1mat
  end interface
  
  !
  !> Function  transc:
  !! \brief Conjugate Transpose. Can always be implemented by staging through a COO
  !!        temporary for which transpose is very easy. 
  !!        In-place version.
  !  
  interface 
    subroutine psb_s_base_transc_1mat(a)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
    end subroutine psb_s_base_transc_1mat
  end interface
  
  !
  !> Function  csmm:
  !! \brief Product by a dense rank 2 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:,:) the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:,:) the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !!
  !
  interface 
    subroutine psb_s_base_csmm(alpha,a,x,beta,y,info,trans)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:,:)
      real(psb_spk_), intent(inout) :: y(:,:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_s_base_csmm
  end interface
  
  !> Function  csmv:
  !! \brief Product by a dense rank 1 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:)   the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:)   the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !!
  !
  interface 
    subroutine psb_s_base_csmv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:)
      real(psb_spk_), intent(inout) :: y(:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_s_base_csmv
  end interface
  
  !> Function  vect_mv:
  !! \brief Product by an encapsulated array type(psb_s_vect_type)
  !!
  !!        Compute
  !!           Y = alpha*op(A)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x      the input X
  !! \param beta   Scaling factor for y
  !! \param y      the input/output  Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !!
  !
  interface 
    subroutine psb_s_base_vect_mv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_, psb_s_base_vect_type
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)       :: alpha, beta
      class(psb_s_base_vect_type), intent(inout) :: x
      class(psb_s_base_vect_type), intent(inout) :: y
      integer(psb_ipk_), intent(out)             :: info
      character, optional, intent(in)  :: trans
    end subroutine psb_s_base_vect_mv
  end interface
  
  !
  ! Triangular system solve.
  ! The CSSM/CSSV/VECT_SV outer methods are implemented at the base
  ! level, and they take care of the SCALE and D control arguments.
  ! So the derived classes need to override only the INNER_ methods.
  !
  
  !
  !> Function  cssm:
  !! \brief Triangular system solve by a dense rank 2 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !!        Internal workhorse called by cssm. 
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:,:) the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:,:) the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !!
  !
  interface 
    subroutine psb_s_base_inner_cssm(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:,:)
      real(psb_spk_), intent(inout) :: y(:,:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_s_base_inner_cssm
  end interface
  
  
  !
  !> Function  cssv:
  !! \brief Triangular system solve by a dense rank 1 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !!        Internal workhorse called by cssv. 
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:)   the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:)   the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !! \param scale  [N] Apply a scaling on Right (R) i.e. ADX
  !!               or on the Left (L)  i.e.  DAx
  !! \param D(:)   [none] Diagonal for scaling. 
  !!
  !
  interface 
    subroutine psb_s_base_inner_cssv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:)
      real(psb_spk_), intent(inout) :: y(:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans
    end subroutine psb_s_base_inner_cssv
  end interface
  
  !
  !> Function  inner_vect_cssv:
  !! \brief Triangular system solve by
  !!        an encapsulated array type(psb_s_vect_type)
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !!        Internal workhorse called by vect_cssv. 
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x      the input dense X
  !! \param beta   Scaling factor for y
  !! \param y     the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !
  interface 
    subroutine psb_s_base_inner_vect_sv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_,  psb_s_base_vect_type
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)       :: alpha, beta
      class(psb_s_base_vect_type), intent(inout) :: x, y
      integer(psb_ipk_), intent(out)             :: info
      character, optional, intent(in)  :: trans
    end subroutine psb_s_base_inner_vect_sv
  end interface
  
  !
  !> Function  cssm:
  !! \brief Triangular system solve by a dense rank 2 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:,:) the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:,:) the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !! \param scale  [N] Apply a scaling on Right (R) i.e. ADX
  !!               or on the Left (L)  i.e.  DAx
  !! \param D(:)   [none] Diagonal for scaling. 
  !!
  !
  interface 
    subroutine psb_s_base_cssm(alpha,a,x,beta,y,info,trans,scale,d)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:,:)
      real(psb_spk_), intent(inout) :: y(:,:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans, scale
      real(psb_spk_), intent(in), optional :: d(:)
    end subroutine psb_s_base_cssm
  end interface
  
  !
  !> Function  cssv:
  !! \brief Triangular system solve by a dense rank 1 array.
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x(:)   the input dense X
  !! \param beta   Scaling factor for y
  !! \param y(:)   the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !! \param scale  [N] Apply a scaling on Right (R) i.e. ADX
  !!               or on the Left (L)  i.e.  DAx
  !! \param D(:)   [none] Diagonal for scaling. 
  !!
  !
  interface 
    subroutine psb_s_base_cssv(alpha,a,x,beta,y,info,trans,scale,d)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)    :: alpha, beta, x(:)
      real(psb_spk_), intent(inout) :: y(:)
      integer(psb_ipk_), intent(out)            :: info
      character, optional, intent(in) :: trans, scale
      real(psb_spk_), intent(in), optional :: d(:)
    end subroutine psb_s_base_cssv
  end interface
    
  !
  !> Function  vect_cssv:
  !! \brief Triangular system solve by
  !!        an encapsulated array type(psb_s_vect_type)
  !!
  !!        Compute
  !!           Y = alpha*op(A^-1)*X + beta*Y
  !!
  !! \param alpha  Scaling factor for Ax
  !! \param A      the input sparse matrix
  !! \param x      the input dense X
  !! \param beta   Scaling factor for y
  !! \param y     the input/output dense Y
  !! \param info   return code
  !! \param trans  [N] Whether to use A (N), its transpose (T)
  !!               or its conjugate transpose (C)
  !! \param scale  [N] Apply a scaling on Right (R) i.e. ADX
  !!               or on the Left (L)  i.e.  DAx
  !! \param D      [none] Diagonal for scaling. 
  !!
  !
  interface 
    subroutine psb_s_base_vect_cssv(alpha,a,x,beta,y,info,trans,scale,d)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_,psb_s_base_vect_type
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)       :: alpha, beta
      class(psb_s_base_vect_type), intent(inout) :: x,y
      integer(psb_ipk_), intent(out)             :: info
      character, optional, intent(in)  :: trans, scale
      class(psb_s_base_vect_type), optional, intent(inout)   :: d
    end subroutine psb_s_base_vect_cssv
  end interface
  
  !
  ! Scale a matrix by a scalar or by a vector.
  ! Should we handle scale on the columns?? 
  !
  interface 
    subroutine psb_s_base_scals(d,a,info) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: d
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_base_scals
  end interface
  
  interface 
    subroutine psb_s_base_scal(d,a,info,side) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: d(:)
      integer(psb_ipk_), intent(out)            :: info
      character, intent(in), optional :: side
    end subroutine psb_s_base_scal
  end interface
  
  !
  ! Maximum coefficient absolute value norm
  !
  interface 
    function psb_s_base_maxval(a) result(res)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_base_maxval
  end interface
  
  !
  ! Operator infinity norm
  !
  interface 
    function psb_s_base_csnmi(a) result(res)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_base_csnmi
  end interface

  !
  ! Operator 1-norm
  !
  interface 
    function psb_s_base_csnm1(a) result(res)
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_base_csnm1
  end interface

  !
  ! Compute sums along the rows, either
  ! natural or absolute value
  !
  interface 
    subroutine psb_s_base_rowsum(d,a) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_base_rowsum
  end interface

  interface 
    subroutine psb_s_base_arwsum(d,a) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_base_arwsum
  end interface
  
  !
  ! Compute sums along the columns, either
  ! natural or absolute value
  !
  interface 
    subroutine psb_s_base_colsum(d,a) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_base_colsum
  end interface

  interface 
    subroutine psb_s_base_aclsum(d,a) 
      import :: psb_ipk_, psb_s_base_sparse_mat, psb_spk_
      class(psb_s_base_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_base_aclsum
  end interface

  
  ! == ===============
  !
  ! COO interfaces
  !
  ! == ===============

  !
  !> 
  !! \see psb_base_mat_mod::psb_base_reallocate_nz
  !
  interface
    subroutine  psb_s_coo_reallocate_nz(nz,a) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      integer(psb_ipk_), intent(in) :: nz
      class(psb_s_coo_sparse_mat), intent(inout) :: a
    end subroutine psb_s_coo_reallocate_nz
  end interface
  
  interface 
    subroutine psb_s_coo_reinit(a,clear)
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a   
      logical, intent(in), optional :: clear
    end subroutine psb_s_coo_reinit
  end interface
  
  interface
    subroutine  psb_s_coo_trim(a)
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
    end subroutine psb_s_coo_trim
  end interface
  
  interface
    subroutine  psb_s_coo_allocate_mnnz(m,n,a,nz) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      integer(psb_ipk_), intent(in) :: m,n
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      integer(psb_ipk_), intent(in), optional :: nz
    end subroutine psb_s_coo_allocate_mnnz
  end interface

  interface 
    subroutine psb_s_coo_mold(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_s_base_sparse_mat, psb_long_int_k_
      class(psb_s_coo_sparse_mat), intent(in)               :: a
      class(psb_s_base_sparse_mat), intent(out), allocatable :: b
      integer(psb_ipk_), intent(out)                                 :: info
    end subroutine psb_s_coo_mold
  end interface

  
  interface
    subroutine psb_s_coo_print(iout,a,iv,head,ivr,ivc)
      import :: psb_ipk_, psb_s_coo_sparse_mat
      integer(psb_ipk_), intent(in)               :: iout
      class(psb_s_coo_sparse_mat), intent(in) :: a   
      integer(psb_ipk_), intent(in), optional     :: iv(:)
      character(len=*), optional        :: head
      integer(psb_ipk_), intent(in), optional     :: ivr(:), ivc(:)
    end subroutine psb_s_coo_print
  end interface
  
  
  interface 
    function  psb_s_coo_get_nz_row(idx,a) result(res)
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: idx
      integer(psb_ipk_) :: res
    end function psb_s_coo_get_nz_row
  end interface
  
  
  !
  ! Fix: make sure that
  !   1. The coefficients are sorted
  !   2. Handle duplicates if necessary.
  !   Optional: IDIR: sort by rows or columns.
  !
  interface 
    subroutine psb_s_fix_coo_inner(nzin,dupl,ia,ja,val,nzout,info,idir) 
      import :: psb_ipk_, psb_spk_
      integer(psb_ipk_), intent(in)           :: nzin,dupl
      integer(psb_ipk_), intent(inout)        :: ia(:), ja(:)
      real(psb_spk_), intent(inout) :: val(:)
      integer(psb_ipk_), intent(out)          :: nzout, info
      integer(psb_ipk_), intent(in), optional :: idir
    end subroutine psb_s_fix_coo_inner
  end interface
  
  interface 
    subroutine psb_s_fix_coo(a,info,idir) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      integer(psb_ipk_), intent(out)                :: info
      integer(psb_ipk_), intent(in), optional :: idir
    end subroutine psb_s_fix_coo
  end interface
  
  interface 
    subroutine psb_s_cp_coo_to_coo(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(in) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_cp_coo_to_coo
  end interface
  
  interface 
    subroutine psb_s_cp_coo_from_coo(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(in)    :: b
      integer(psb_ipk_), intent(out)                        :: info
    end subroutine psb_s_cp_coo_from_coo
  end interface
  
  interface 
    subroutine psb_s_cp_coo_to_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_s_base_sparse_mat
      class(psb_s_coo_sparse_mat), intent(in)   :: a
      class(psb_s_base_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)                       :: info
    end subroutine psb_s_cp_coo_to_fmt
  end interface
  
  interface 
    subroutine psb_s_cp_coo_from_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_s_base_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      class(psb_s_base_sparse_mat), intent(in)   :: b
      integer(psb_ipk_), intent(out)                        :: info
    end subroutine psb_s_cp_coo_from_fmt
  end interface
  
  interface 
    subroutine psb_s_mv_coo_to_coo(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(inout)   :: b
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_mv_coo_to_coo
  end interface
  
  interface 
    subroutine psb_s_mv_coo_from_coo(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      class(psb_s_coo_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)                        :: info
    end subroutine psb_s_mv_coo_from_coo
  end interface
  
  interface 
    subroutine psb_s_mv_coo_to_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_s_base_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      class(psb_s_base_sparse_mat), intent(inout)  :: b
      integer(psb_ipk_), intent(out)                        :: info
    end subroutine psb_s_mv_coo_to_fmt
  end interface
  
  interface 
    subroutine psb_s_mv_coo_from_fmt(a,b,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_s_base_sparse_mat
      class(psb_s_coo_sparse_mat), intent(inout)  :: a
      class(psb_s_base_sparse_mat), intent(inout) :: b
      integer(psb_ipk_), intent(out)                         :: info
    end subroutine psb_s_mv_coo_from_fmt
  end interface
  
  interface 
    subroutine psb_s_coo_cp_from(a,b)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      type(psb_s_coo_sparse_mat), intent(in)   :: b
    end subroutine psb_s_coo_cp_from
  end interface
  
  interface 
    subroutine psb_s_coo_mv_from(a,b)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(inout)  :: a
      type(psb_s_coo_sparse_mat), intent(inout) :: b
    end subroutine psb_s_coo_mv_from
  end interface
  
  
  interface 
    subroutine psb_s_coo_csput(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: val(:)
      integer(psb_ipk_), intent(in)             :: nz,ia(:), ja(:),&
           &  imin,imax,jmin,jmax
      integer(psb_ipk_), intent(out)            :: info
      integer(psb_ipk_), intent(in), optional   :: gtl(:)
    end subroutine psb_s_coo_csput
  end interface
  
  interface 
    subroutine psb_s_coo_csgetptn(imin,imax,a,nz,ia,ja,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_), intent(out)                 :: nz
      integer(psb_ipk_), allocatable, intent(inout)  :: ia(:), ja(:)
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_s_coo_csgetptn
  end interface
  
  interface 
    subroutine psb_s_coo_csgetrow(imin,imax,a,nz,ia,ja,val,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      integer(psb_ipk_), intent(in)                  :: imin,imax
      integer(psb_ipk_), intent(out)                 :: nz
      integer(psb_ipk_), allocatable, intent(inout)  :: ia(:), ja(:)
      real(psb_spk_), allocatable,  intent(inout)    :: val(:)
      integer(psb_ipk_),intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer(psb_ipk_), intent(in), optional        :: iren(:)
      integer(psb_ipk_), intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine psb_s_coo_csgetrow
  end interface
  
  interface 
    subroutine psb_s_coo_cssv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)          :: alpha, beta, x(:)
      real(psb_spk_), intent(inout)       :: y(:)
      integer(psb_ipk_), intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine psb_s_coo_cssv
    subroutine psb_s_coo_cssm(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)          :: alpha, beta, x(:,:)
      real(psb_spk_), intent(inout)       :: y(:,:)
      integer(psb_ipk_), intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine psb_s_coo_cssm
  end interface
  
  interface 
    subroutine psb_s_coo_csmv(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)          :: alpha, beta, x(:)
      real(psb_spk_), intent(inout)       :: y(:)
      integer(psb_ipk_), intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine psb_s_coo_csmv
    subroutine psb_s_coo_csmm(alpha,a,x,beta,y,info,trans) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(in)          :: alpha, beta, x(:,:)
      real(psb_spk_), intent(inout)       :: y(:,:)
      integer(psb_ipk_), intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine psb_s_coo_csmm
  end interface
  
    
  interface 
    function psb_s_coo_maxval(a) result(res)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_coo_maxval
  end interface

  interface 
    function psb_s_coo_csnmi(a) result(res)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_coo_csnmi
  end interface
  
  interface 
    function psb_s_coo_csnm1(a) result(res)
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_)         :: res
    end function psb_s_coo_csnm1
  end interface

  interface 
    subroutine psb_s_coo_rowsum(d,a) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_coo_rowsum
  end interface

  interface 
    subroutine psb_s_coo_arwsum(d,a) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_coo_arwsum
  end interface
  
  interface 
    subroutine psb_s_coo_colsum(d,a) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_coo_colsum
  end interface

  interface 
    subroutine psb_s_coo_aclsum(d,a) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)              :: d(:)
    end subroutine psb_s_coo_aclsum
  end interface
  
  interface 
    subroutine psb_s_coo_get_diag(a,d,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(in) :: a
      real(psb_spk_), intent(out)     :: d(:)
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_coo_get_diag
  end interface
  
  interface 
    subroutine psb_s_coo_scal(d,a,info,side) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: d(:)
      integer(psb_ipk_), intent(out)            :: info
      character, intent(in), optional :: side
    end subroutine psb_s_coo_scal
  end interface
  
  interface
    subroutine psb_s_coo_scals(d,a,info) 
      import :: psb_ipk_, psb_s_coo_sparse_mat, psb_spk_
      class(psb_s_coo_sparse_mat), intent(inout) :: a
      real(psb_spk_), intent(in)      :: d
      integer(psb_ipk_), intent(out)            :: info
    end subroutine psb_s_coo_scals
  end interface
  
  
contains 
  
  
  subroutine s_base_mv_from(a,b)
    
    implicit none 
    
    class(psb_s_base_sparse_mat), intent(out)   :: a
    type(psb_s_base_sparse_mat), intent(inout) :: b
    
    
    ! No new things here, very easy
    call a%psb_base_sparse_mat%mv_from(b%psb_base_sparse_mat)
    
    return
    
  end subroutine s_base_mv_from
  
  subroutine s_base_cp_from(a,b)
    implicit none 
    
    class(psb_s_base_sparse_mat), intent(out) :: a
    type(psb_s_base_sparse_mat), intent(in)  :: b
    
    ! No new things here, very easy
    call a%psb_base_sparse_mat%cp_from(b%psb_base_sparse_mat)
    
    return
    
  end subroutine s_base_cp_from
  
 
  
  ! == ==================================
  !
  !
  !
  ! Getters 
  !
  !
  !
  !
  !
  ! == ==================================
  
  
  
  function s_coo_sizeof(a) result(res)
    implicit none 
    class(psb_s_coo_sparse_mat), intent(in) :: a
    integer(psb_long_int_k_) :: res
    res = 8 + 1
    res = res + psb_sizeof_sp  * size(a%val)
    res = res + psb_sizeof_int * size(a%ia)
    res = res + psb_sizeof_int * size(a%ja)
    
  end function s_coo_sizeof
  
  
  function s_coo_get_fmt() result(res)
    implicit none 
    character(len=5) :: res
    res = 'COO'
  end function s_coo_get_fmt
  
  
  function s_coo_get_size(a) result(res)
    implicit none 
    class(psb_s_coo_sparse_mat), intent(in) :: a
    integer(psb_ipk_) :: res
    res = -1
    
    if (allocated(a%ia)) res = size(a%ia)
    if (allocated(a%ja)) then 
      if (res >= 0) then 
        res = min(res,size(a%ja))
      else 
        res = size(a%ja)
      end if
    end if
    if (allocated(a%val)) then 
      if (res >= 0) then 
        res = min(res,size(a%val))
      else 
        res = size(a%val)
      end if
    end if
  end function s_coo_get_size
  
  
  function s_coo_get_nzeros(a) result(res)
    implicit none 
    class(psb_s_coo_sparse_mat), intent(in) :: a
    integer(psb_ipk_) :: res
    res  = a%nnz
  end function s_coo_get_nzeros
  
  
  ! == ==================================
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
  ! == ==================================
  
  subroutine  s_coo_set_nzeros(nz,a)
    implicit none 
    integer(psb_ipk_), intent(in) :: nz
    class(psb_s_coo_sparse_mat), intent(inout) :: a
    
    a%nnz = nz
    
  end subroutine s_coo_set_nzeros
  
  ! == ==================================
  !
  !
  !
  ! Data management
  !
  !
  !
  !
  !
  ! == ==================================
  
  subroutine  s_coo_free(a) 
    implicit none 
    
    class(psb_s_coo_sparse_mat), intent(inout) :: a
    
    if (allocated(a%ia)) deallocate(a%ia)
    if (allocated(a%ja)) deallocate(a%ja)
    if (allocated(a%val)) deallocate(a%val)
    call a%set_null()
    call a%set_nrows(izero)
    call a%set_ncols(izero)
    call a%set_nzeros(izero)
    
    return
    
  end subroutine s_coo_free
  
  
  
  ! == ==================================
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
  ! == ==================================
  subroutine s_coo_transp_1mat(a)
    implicit none 
    
    class(psb_s_coo_sparse_mat), intent(inout) :: a
    
    integer(psb_ipk_), allocatable :: itemp(:) 
    integer(psb_ipk_) :: info
    
    call a%psb_s_base_sparse_mat%psb_base_sparse_mat%transp()
    call move_alloc(a%ia,itemp)
    call move_alloc(a%ja,a%ia)
    call move_alloc(itemp,a%ja)
    
    call a%fix(info)
    
    return
    
  end subroutine s_coo_transp_1mat
  
  subroutine s_coo_transc_1mat(a)
    implicit none 
    
    class(psb_s_coo_sparse_mat), intent(inout) :: a
    
    call a%transp() 
    ! This will morph into conjg() for C and Z
    ! and into a no-op for S and D, so a conditional
    ! on a constant ought to take it out completely. 
    if (psb_s_is_complex_) a%val(:) = (a%val(:))

  end subroutine s_coo_transc_1mat



end module psb_s_base_mat_mod



