module psb_d_base_mat_mod
  
  use psb_base_mat_mod
  
  type, extends(psb_base_sparse_mat) :: psb_d_base_sparse_mat
  contains
    procedure, pass(a) :: d_base_csmv
    procedure, pass(a) :: d_base_csmm
    generic, public    :: csmm => d_base_csmm, d_base_csmv
    procedure, pass(a) :: d_base_cssv
    procedure, pass(a) :: d_base_cssm
    generic, public    :: base_cssm => d_base_cssm, d_base_cssv
    procedure, pass(a) :: d_cssv
    procedure, pass(a) :: d_cssm
    generic, public    :: cssm => d_cssm, d_cssv
    procedure, pass(a) :: d_scals
    procedure, pass(a) :: d_scal
    generic, public    :: scal => d_scals, d_scal 
    procedure, pass(a) :: csnmi
    procedure, pass(a) :: get_diag
    procedure, pass(a) :: csput

    procedure, pass(a) :: d_csgetrow
    procedure, pass(a) :: d_csgetblk
    generic, public    :: csget => d_csgetrow, d_csgetblk 
    procedure, pass(a) :: csclip
    procedure, pass(a) :: cp_to_coo
    procedure, pass(a) :: cp_from_coo
    procedure, pass(a) :: cp_to_fmt
    procedure, pass(a) :: cp_from_fmt
    procedure, pass(a) :: mv_to_coo
    procedure, pass(a) :: mv_from_coo
    procedure, pass(a) :: mv_to_fmt
    procedure, pass(a) :: mv_from_fmt
    procedure, pass(a) :: d_base_cp_from
    generic, public    :: cp_from => d_base_cp_from
    procedure, pass(a) :: d_base_mv_from
    generic, public    :: mv_from => d_base_mv_from
  end type psb_d_base_sparse_mat

  private :: d_base_csmv, d_base_csmm, d_base_cssv, d_base_cssm,&
       & d_scals, d_scal, csnmi, csput, d_csgetrow, d_csgetblk, &
       & cp_to_coo, cp_from_coo, cp_to_fmt, cp_from_fmt, &
       & mv_to_coo, mv_from_coo, mv_to_fmt, mv_from_fmt, &
       & get_diag, csclip, d_cssv, d_cssm, base_cp_from, base_mv_from

  type, extends(psb_d_base_sparse_mat) :: psb_d_coo_sparse_mat
    
    integer              :: nnz
    integer, allocatable :: ia(:), ja(:)
    real(psb_dpk_), allocatable :: val(:)
    
  contains
    
    procedure, pass(a) :: get_size => d_coo_get_size
    procedure, pass(a) :: get_nzeros => d_coo_get_nzeros
    procedure, pass(a) :: set_nzeros => d_coo_set_nzeros
    procedure, pass(a) :: d_base_csmm => d_coo_csmm
    procedure, pass(a) :: d_base_csmv => d_coo_csmv
    procedure, pass(a) :: d_base_cssm => d_coo_cssm
    procedure, pass(a) :: d_base_cssv => d_coo_cssv
    procedure, pass(a) :: d_scals => d_coo_scals
    procedure, pass(a) :: d_scal => d_coo_scal
    procedure, pass(a) :: csnmi => d_coo_csnmi
    procedure, pass(a) :: csput => d_coo_csput
    procedure, pass(a) :: get_diag => d_coo_get_diag
    procedure, pass(a) :: reallocate_nz => d_coo_reallocate_nz
    procedure, pass(a) :: allocate_mnnz => d_coo_allocate_mnnz
    procedure, pass(a) :: cp_to_coo   => d_cp_coo_to_coo
    procedure, pass(a) :: cp_from_coo => d_cp_coo_from_coo
    procedure, pass(a) :: cp_to_fmt   => d_cp_coo_to_fmt
    procedure, pass(a) :: cp_from_fmt => d_cp_coo_from_fmt
    procedure, pass(a) :: mv_to_coo   => d_mv_coo_to_coo
    procedure, pass(a) :: mv_from_coo => d_mv_coo_from_coo
    procedure, pass(a) :: mv_to_fmt   => d_mv_coo_to_fmt
    procedure, pass(a) :: mv_from_fmt => d_mv_coo_from_fmt
    procedure, pass(a) :: fix      => d_fix_coo
    procedure, pass(a) :: free     => d_coo_free
    procedure, pass(a) :: trim     => d_coo_trim
    procedure, pass(a) :: d_csgetrow => d_coo_csgetrow
    procedure, pass(a) :: csgetptn => d_coo_csgetptn
    procedure, pass(a) :: print    => d_coo_print
    procedure, pass(a) :: get_fmt  => d_coo_get_fmt
    procedure, pass(a) :: get_nz_row  => d_coo_get_nz_row
    procedure, pass(a) :: sizeof => d_coo_sizeof
    procedure, pass(a) :: reinit => d_coo_reinit
    procedure, pass(a) :: d_coo_cp_from
    generic, public    :: cp_from => d_coo_cp_from
    procedure, pass(a) :: d_coo_mv_from
    generic, public    :: mv_from => d_coo_mv_from
    
  end type psb_d_coo_sparse_mat

  private :: d_coo_get_nzeros, d_coo_set_nzeros, d_coo_get_diag, &
       & d_coo_csmm, d_coo_csmv, d_coo_cssm, d_coo_cssv, d_coo_csnmi, &
       & d_coo_csput, d_coo_reallocate_nz, d_coo_allocate_mnnz, &
       & d_fix_coo, d_coo_free, d_coo_print, d_coo_get_fmt, &
       & d_cp_coo_to_coo, d_cp_coo_from_coo, &
       & d_cp_coo_to_fmt, d_cp_coo_from_fmt, &
       & d_coo_scals, d_coo_scal, d_coo_csgetrow, d_coo_sizeof, &
       & d_coo_csgetptn, d_coo_get_nz_row, d_coo_reinit,&
       & d_coo_cp_from, d_coo_mv_from

  
  interface 
    subroutine d_fix_coo_inner(nzin,dupl,ia,ja,val,nzout,info,idir) 
      use psb_const_mod
      integer, intent(in)           :: nzin,dupl
      integer, intent(inout)        :: ia(:), ja(:)
      real(psb_dpk_), intent(inout) :: val(:)
      integer, intent(out)          :: nzout, info
      integer, intent(in), optional :: idir
    end subroutine d_fix_coo_inner
  end interface

  interface 
    subroutine d_fix_coo_impl(a,info,idir) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      integer, intent(out)                :: info
      integer, intent(in), optional :: idir
    end subroutine d_fix_coo_impl
  end interface

  interface 
    subroutine d_cp_coo_to_coo_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      class(psb_d_coo_sparse_mat), intent(out) :: b
      integer, intent(out)            :: info
    end subroutine d_cp_coo_to_coo_impl
  end interface
  
  interface 
    subroutine d_cp_coo_from_coo_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(out) :: a
      class(psb_d_coo_sparse_mat), intent(in)    :: b
      integer, intent(out)                        :: info
    end subroutine d_cp_coo_from_coo_impl
  end interface

  interface 
    subroutine d_cp_coo_to_fmt_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat, psb_d_base_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in)   :: a
      class(psb_d_base_sparse_mat), intent(out) :: b
      integer, intent(out)                       :: info
    end subroutine d_cp_coo_to_fmt_impl
  end interface

  interface 
    subroutine d_cp_coo_from_fmt_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat, psb_d_base_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      class(psb_d_base_sparse_mat), intent(in)   :: b
      integer, intent(out)                        :: info
    end subroutine d_cp_coo_from_fmt_impl
  end interface

  interface 
    subroutine d_mv_coo_to_coo_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      class(psb_d_coo_sparse_mat), intent(out)   :: b
      integer, intent(out)            :: info
    end subroutine d_mv_coo_to_coo_impl
  end interface

  interface 
    subroutine d_mv_coo_from_coo_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      class(psb_d_coo_sparse_mat), intent(inout) :: b
      integer, intent(out)                        :: info
    end subroutine d_mv_coo_from_coo_impl
  end interface

  interface 
    subroutine d_mv_coo_to_fmt_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat, psb_d_base_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      class(psb_d_base_sparse_mat), intent(out)  :: b
      integer, intent(out)                        :: info
    end subroutine d_mv_coo_to_fmt_impl
  end interface

  interface 
    subroutine d_mv_coo_from_fmt_impl(a,b,info) 
      use psb_const_mod
      import psb_d_coo_sparse_mat, psb_d_base_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout)  :: a
      class(psb_d_base_sparse_mat), intent(inout) :: b
      integer, intent(out)                         :: info
    end subroutine d_mv_coo_from_fmt_impl
  end interface


  interface 
    subroutine d_coo_csput_impl(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(inout) :: a
      real(psb_dpk_), intent(in)      :: val(:)
      integer, intent(in)             :: nz,ia(:), ja(:),&
           &  imin,imax,jmin,jmax
      integer, intent(out)            :: info
      integer, intent(in), optional   :: gtl(:)
    end subroutine d_coo_csput_impl
  end interface

  interface 
    subroutine d_coo_csgetptn_impl(imin,imax,a,nz,ia,ja,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      use psb_const_mod
      import psb_d_coo_sparse_mat
      implicit none
      class(psb_d_coo_sparse_mat), intent(in) :: a
      integer, intent(in)                  :: imin,imax
      integer, intent(out)                 :: nz
      integer, allocatable, intent(inout)  :: ia(:), ja(:)
      integer,intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer, intent(in), optional        :: iren(:)
      integer, intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine d_coo_csgetptn_impl
  end interface
  
  interface 
    subroutine d_coo_csgetrow_impl(imin,imax,a,nz,ia,ja,val,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)
      use psb_const_mod
      import psb_d_coo_sparse_mat
      implicit none
      
      class(psb_d_coo_sparse_mat), intent(in) :: a
      integer, intent(in)                  :: imin,imax
      integer, intent(out)                 :: nz
      integer, allocatable, intent(inout)  :: ia(:), ja(:)
      real(psb_dpk_), allocatable,  intent(inout)    :: val(:)
      integer,intent(out)                  :: info
      logical, intent(in), optional        :: append
      integer, intent(in), optional        :: iren(:)
      integer, intent(in), optional        :: jmin,jmax, nzin
      logical, intent(in), optional        :: rscale,cscale
    end subroutine d_coo_csgetrow_impl
  end interface
  
  interface d_coo_cssm_impl
    subroutine d_coo_cssv_impl(alpha,a,x,beta,y,info,trans) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      real(psb_dpk_), intent(in)          :: alpha, beta, x(:)
      real(psb_dpk_), intent(inout)       :: y(:)
      integer, intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine d_coo_cssv_impl
    subroutine d_coo_cssm_impl(alpha,a,x,beta,y,info,trans) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      real(psb_dpk_), intent(in)          :: alpha, beta, x(:,:)
      real(psb_dpk_), intent(inout)       :: y(:,:)
      integer, intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine d_coo_cssm_impl
  end interface

  interface d_coo_csmm_impl
    subroutine d_coo_csmv_impl(alpha,a,x,beta,y,info,trans) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      real(psb_dpk_), intent(in)          :: alpha, beta, x(:)
      real(psb_dpk_), intent(inout)       :: y(:)
      integer, intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine d_coo_csmv_impl
    subroutine d_coo_csmm_impl(alpha,a,x,beta,y,info,trans) 
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      real(psb_dpk_), intent(in)          :: alpha, beta, x(:,:)
      real(psb_dpk_), intent(inout)       :: y(:,:)
      integer, intent(out)                :: info
      character, optional, intent(in)     :: trans
    end subroutine d_coo_csmm_impl
  end interface


  interface d_coo_csnmi_impl
    function d_coo_csnmi_impl(a) result(res)
      use psb_const_mod
      import psb_d_coo_sparse_mat
      class(psb_d_coo_sparse_mat), intent(in) :: a
      real(psb_dpk_)         :: res
    end function d_coo_csnmi_impl
  end interface


contains 


  !====================================
  !
  !
  !
  ! Data management
  !
  !
  !
  !
  !
  !====================================

  subroutine cp_to_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    class(psb_d_coo_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine cp_to_coo

  subroutine cp_from_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_coo_sparse_mat), intent(in) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine cp_from_coo


  subroutine cp_to_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    class(psb_d_base_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_fmt'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine cp_to_fmt

  subroutine cp_from_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(in) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_fmt'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine cp_from_fmt


  subroutine mv_to_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_coo_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine mv_to_coo

  subroutine mv_from_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_coo_sparse_mat), intent(inout) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine mv_from_coo


  subroutine mv_to_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_fmt'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine mv_to_fmt

  subroutine mv_from_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(inout) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_fmt'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine mv_from_fmt

  subroutine d_base_mv_from(a,b)
    use psb_error_mod
    implicit none 

    class(psb_d_base_sparse_mat), intent(out)   :: a
    type(psb_d_base_sparse_mat), intent(inout) :: b


    ! No new things here, very easy
    call a%psb_base_sparse_mat%mv_from(b%psb_base_sparse_mat)

    return

  end subroutine d_base_mv_from

  subroutine d_base_cp_from(a,b)
    use psb_error_mod
    implicit none 

    class(psb_d_base_sparse_mat), intent(out) :: a
    type(psb_d_base_sparse_mat), intent(in)  :: b

    ! No new things here, very easy
    call a%psb_base_sparse_mat%cp_from(b%psb_base_sparse_mat)

    return

  end subroutine d_base_cp_from



  subroutine csput(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(inout) :: a
    real(psb_dpk_), intent(in)      :: val(:)
    integer, intent(in)             :: nz, ia(:), ja(:), imin,imax,jmin,jmax
    integer, intent(out)            :: info
    integer, intent(in), optional   :: gtl(:)

    Integer :: err_act
    character(len=20)  :: name='csput'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine csput

  subroutine d_csgetrow(imin,imax,a,nz,ia,ja,val,info,&
       & jmin,jmax,iren,append,nzin,rscale,cscale)
    ! Output is always in  COO format 
    use psb_error_mod
    use psb_const_mod
    implicit none
    
    class(psb_d_base_sparse_mat), intent(in) :: a
    integer, intent(in)                  :: imin,imax
    integer, intent(out)                 :: nz
    integer, allocatable, intent(inout)  :: ia(:), ja(:)
    real(psb_dpk_), allocatable,  intent(inout)    :: val(:)
    integer,intent(out)                  :: info
    logical, intent(in), optional        :: append
    integer, intent(in), optional        :: iren(:)
    integer, intent(in), optional        :: jmin,jmax, nzin
    logical, intent(in), optional        :: rscale,cscale
    Integer :: err_act
    character(len=20)  :: name='csget'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_csgetrow



  subroutine d_csgetblk(imin,imax,a,b,info,&
       & jmin,jmax,iren,append,rscale,cscale)
    ! Output is always in  COO format 
    use psb_error_mod
    use psb_const_mod
    implicit none
    
    class(psb_d_base_sparse_mat), intent(in) :: a
    class(psb_d_coo_sparse_mat), intent(inout) :: b
    integer, intent(in)                  :: imin,imax
    integer,intent(out)                  :: info
    logical, intent(in), optional        :: append
    integer, intent(in), optional        :: iren(:)
    integer, intent(in), optional        :: jmin,jmax
    logical, intent(in), optional        :: rscale,cscale
    Integer :: err_act, nzin, nzout
    character(len=20)  :: name='csget'
    logical :: append_
    logical, parameter :: debug=.false.
    
    call psb_erractionsave(err_act)
    info = 0

    if (present(append)) then 
      append_ = append
    else
      append_ = .false.
    endif
    if (append_) then 
      nzin = a%get_nzeros()
    else
      nzin = 0
    endif

    call a%csget(imin,imax,nzout,b%ia,b%ja,b%val,info,&
         & jmin=jmin, jmax=jmax, iren=iren, append=append_, &
         & nzin=nzin, rscale=rscale, cscale=cscale)

    if (info /= 0) goto 9999

    call b%set_nzeros(nzin+nzout)
    call b%fix(info)
    if (info /= 0) goto 9999
    
    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_csgetblk


  subroutine csclip(a,b,info,&
       & imin,imax,jmin,jmax,rscale,cscale)
    ! Output is always in  COO format 
    use psb_error_mod
    use psb_const_mod
    implicit none
    
    class(psb_d_base_sparse_mat), intent(in) :: a
    class(psb_d_coo_sparse_mat), intent(out) :: b
    integer,intent(out)                  :: info
    integer, intent(in), optional        :: imin,imax,jmin,jmax
    logical, intent(in), optional        :: rscale,cscale

    Integer :: err_act, nzin, nzout, imin_, imax_, jmin_, jmax_, mb,nb
    character(len=20)  :: name='csget'
    logical :: rscale_, cscale_
    logical, parameter :: debug=.false.
    
    call psb_erractionsave(err_act)
    info = 0

    nzin = 0
    if (present(imin)) then 
      imin_ = imin
    else
      imin_ = 1
    end if
    if (present(imax)) then 
      imax_ = imax
    else
      imax_ = a%get_nrows()
    end if
    if (present(jmin)) then 
      jmin_ = jmin
    else
      jmin_ = 1
    end if
    if (present(jmax)) then 
      jmax_ = jmax
    else
      jmax_ = a%get_ncols()
    end if
    if (present(rscale)) then 
      rscale_ = rscale
    else
      rscale_ = .true.
    end if
    if (present(cscale)) then 
      cscale_ = cscale
    else
      cscale_ = .true.
    end if

    if (rscale_) then 
      mb = imax_ - imin_ +1
    else 
      mb = a%get_nrows() ! Should this be imax_ ?? 
    endif
    if (cscale_) then 
      nb = jmax_ - jmin_ +1
    else 
      nb = a%get_ncols()  ! Should this be jmax_ ?? 
    endif
    call b%allocate(mb,nb)

    call a%csget(imin_,imax_,nzout,b%ia,b%ja,b%val,info,&
         & jmin=jmin_, jmax=jmax_, append=.false., &
         & nzin=nzin, rscale=rscale_, cscale=cscale_)

    if (info /= 0) goto 9999

    call b%set_nzeros(nzin+nzout)
    call b%fix(info)

    if (info /= 0) goto 9999
    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine csclip



  !====================================
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
  !====================================

  subroutine d_base_csmm(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)    :: alpha, beta, x(:,:)
    real(psb_dpk_), intent(inout) :: y(:,:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans

    Integer :: err_act
    character(len=20)  :: name='d_base_csmm'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_base_csmm

  subroutine d_base_csmv(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(kind(1.d0)), intent(in)    :: alpha, beta, x(:)
    real(kind(1.d0)), intent(inout) :: y(:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans

    Integer :: err_act
    character(len=20)  :: name='d_base_csmv'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return


  end subroutine d_base_csmv

  subroutine d_base_cssm(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)    :: alpha, beta, x(:,:)
    real(psb_dpk_), intent(inout) :: y(:,:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans

    Integer :: err_act
    character(len=20)  :: name='d_base_cssm'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_base_cssm

  subroutine d_base_cssv(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)    :: alpha, beta, x(:)
    real(psb_dpk_), intent(inout) :: y(:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans

    Integer :: err_act
    character(len=20)  :: name='d_base_cssv'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_base_cssv

  subroutine d_cssm(alpha,a,x,beta,y,info,trans,side,d) 
    use psb_error_mod
    use psb_string_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)    :: alpha, beta, x(:,:)
    real(psb_dpk_), intent(inout) :: y(:,:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans, side
    real(psb_dpk_), intent(in), optional :: d(:)
    
    real(psb_dpk_), allocatable :: tmp(:,:)
    Integer :: err_act, nar,nac,nc, i
    character(len=1) :: side_
    character(len=20)  :: name='d_cssm'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    if (.not.a%is_asb()) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif

    nar = a%get_nrows()
    nac = a%get_ncols()
    nc = min(size(x,2), size(y,2))
    if (size(x,1) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y,1) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    
    if (.not. (a%is_triangle())) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    end if

    if (present(d)) then 
      if (present(side)) then 
        side_ = side
      else
        side_ = 'L'
      end if
        
      if (psb_toupper(side_) == 'R') then 
        if (size(d,1) < nac) then
          info = 36
          call psb_errpush(info,name,i_err=(/9,nac,0,0,0/))
          goto 9999
        end if
        
        allocate(tmp(nac,nc),stat=info) 
        if (info /= 0) info = 4000 
        if (info == 0) then 
          do i=1, nac
            tmp(i,1:nc) = d(i)*x(i,1:nc) 
          end do
        end if
        if (info == 0)&
             & call a%base_cssm(alpha,tmp,beta,y,info,trans)
        
        if (info == 0) then 
          deallocate(tmp,stat=info) 
          if (info /= 0) info = 4000
        end if
      
      else if (psb_toupper(side_) == 'L') then 
        
        if (size(d,1) < nar) then
          info = 36
          call psb_errpush(info,name,i_err=(/9,nar,0,0,0/))
          goto 9999
        end if
        
        allocate(tmp(nar,nc),stat=info) 
        if (info /= 0) info = 4000 
        if (info == 0)&
             & call a%base_cssm(done,x,dzero,tmp,info,trans)
        
        if (info == 0)then 
          do i=1, nar
            tmp(i,1:nc) = d(i)*tmp(i,1:nc) 
          end do
        end if
        if (info == 0)&
             & call daxpby(nar,nc,alpha,tmp,size(tmp,1),beta,y,size(y,1),info)

        if (info == 0) then 
          deallocate(tmp,stat=info) 
          if (info /= 0) info = 4000
        end if
        
      else
        info = 31
        call psb_errpush(info,name,i_err=(/8,0,0,0,0/),a_err=side_)
        goto 9999
      end if
    else 
      ! Side is ignored in this case 
      call a%base_cssm(alpha,x,beta,y,info,trans)
    end if
    
    if (info /= 0) then 
      info = 4010 
      call psb_errpush(info,name, a_err='base_cssm')
      goto 9999
    end if


    return
    call psb_erractionrestore(err_act)
    return


9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return


  end subroutine d_cssm

  subroutine d_cssv(alpha,a,x,beta,y,info,trans,side,d) 
    use psb_error_mod
    use psb_string_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)    :: alpha, beta, x(:)
    real(psb_dpk_), intent(inout) :: y(:)
    integer, intent(out)            :: info
    character, optional, intent(in) :: trans, side
    real(psb_dpk_), intent(in), optional :: d(:)
    
    real(psb_dpk_), allocatable :: tmp(:)
    Integer :: err_act, nar,nac,nc, i
    character(len=1) :: side_
    character(len=20)  :: name='d_cssm'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    if (.not.a%is_asb()) then
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif

    nar = a%get_nrows()
    nac = a%get_ncols()
    nc = 1
    if (size(x,1) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y,1) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    
    if (.not. (a%is_triangle())) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    end if

    if (present(d)) then 
      if (present(side)) then 
        side_ = side
      else
        side_ = 'L'
      end if
        
      if (psb_toupper(side_) == 'R') then 
        if (size(d,1) < nac) then
          info = 36
          call psb_errpush(info,name,i_err=(/9,nac,0,0,0/))
          goto 9999
        end if
        
        allocate(tmp(nac),stat=info) 
        if (info /= 0) info = 4000 
        if (info == 0) tmp(1:nac) = d(1:nac)*x(1:nac) 
        if (info == 0)&
             & call a%base_cssm(alpha,tmp,beta,y,info,trans)
        
        if (info == 0) then 
          deallocate(tmp,stat=info) 
          if (info /= 0) info = 4000
        end if
      
      else if (psb_toupper(side_) == 'L') then 
        if (size(d,1) < nar) then
          info = 36
          call psb_errpush(info,name,i_err=(/9,nar,0,0,0/))
          goto 9999
        end if
        
        allocate(tmp(nar),stat=info) 
        if (info /= 0) info = 4000 
        if (info == 0)&
             & call a%base_cssm(done,x,dzero,tmp,info,trans)

        if (info == 0) tmp(1:nar) = d(1:nar)*tmp(1:nar) 
        if (info == 0)&
             & call daxpby(nar,nc,alpha,tmp,size(tmp,1),beta,y,size(y,1),info)
        
        if (info == 0) then 
          deallocate(tmp,stat=info) 
          if (info /= 0) info = 4000
        end if
        
      else
        info = 31
        call psb_errpush(info,name,i_err=(/8,0,0,0,0/),a_err=side_)
        goto 9999
      end if
    else 
      ! Side is ignored in this case 
      call a%base_cssm(alpha,x,beta,y,info,trans)
    end if

    if (info /= 0) then 
      info = 4010 
      call psb_errpush(info,name, a_err='base_cssm')
      goto 9999
    end if


    return
    call psb_erractionrestore(err_act)
    return


9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return


  end subroutine d_cssv


  subroutine d_scals(d,a,info) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)      :: d
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='d_scals'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return
    
  end subroutine d_scals


  subroutine d_scal(d,a,info) 
    use psb_error_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)      :: d(:)
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='d_scal'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return
    
  end subroutine d_scal


  function csnmi(a) result(res)
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_)         :: res

    Integer :: err_act, info
    character(len=20)  :: name='csnmi'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    res = -done

    return

  end function csnmi

  subroutine get_diag(a,d,info) 
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_base_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(out)     :: d(:)
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='get_diag'
    logical, parameter :: debug=.false.

    call psb_get_erraction(err_act)
    ! This is the base version. If we get here
    ! it means the derived class is incomplete,
    ! so we throw an error.
    info = 700
    call psb_errpush(info,name,a_err=a%get_fmt())

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if

    return

  end subroutine get_diag




  !====================================
  !
  !
  !
  ! Getters 
  !
  !
  !
  !
  !
  !====================================


  
  function d_coo_sizeof(a) result(res)
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer(psb_long_int_k_) :: res
    res = 8 + 1
    res = res + psb_sizeof_dp  * size(a%val)
    res = res + psb_sizeof_int * size(a%ia)
    res = res + psb_sizeof_int * size(a%ja)
      
  end function d_coo_sizeof


  function d_coo_get_fmt(a) result(res)
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    character(len=5) :: res
    res = 'COO'
  end function d_coo_get_fmt


  function d_coo_get_size(a) result(res)
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer :: res
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
  end function d_coo_get_size


  function d_coo_get_nzeros(a) result(res)
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer :: res
    res  = a%nnz
  end function d_coo_get_nzeros


  function  d_coo_get_nz_row(idx,a) result(res)
    use psb_const_mod
    use psb_sort_mod
    implicit none
    
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer, intent(in)                  :: idx
    integer                              :: res
    integer  :: nzin_, nza,ip,jp,i,k
    
    res = 0 
    nza = a%get_nzeros()
    if (a%is_sorted()) then 
      ! In this case we can do a binary search. 
      ip = psb_ibsrch(idx,nza,a%ia)
      if (ip /= -1) return
      jp = ip 
      do 
        if (ip < 2) exit
        if (a%ia(ip-1) == idx) then  
          ip = ip -1 
        else 
          exit
        end if
      end do
      do 
        if (jp == nza) exit
        if (a%ia(jp+1) == idx) then  
          jp = jp + 1
        else 
          exit
        end if
      end do
      
      res = jp - ip +1 
      
    else
      
      res = 0
      
      do i=1, nza
        if (a%ia(i) == idx) then 
          res = res + 1 
        end if
      end do
      
    end if
    
  end function d_coo_get_nz_row

  !====================================
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
  !====================================

  subroutine  d_coo_set_nzeros(nz,a)
    implicit none 
    integer, intent(in) :: nz
    class(psb_d_coo_sparse_mat), intent(inout) :: a

    a%nnz = nz

  end subroutine d_coo_set_nzeros

  !====================================
  !
  !
  !
  ! Data management
  !
  !
  !
  !
  !
  !====================================


  subroutine d_fix_coo(a,info,idir) 
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    integer, intent(out)                :: info
    integer, intent(in), optional :: idir
    Integer :: err_act
    character(len=20)  :: name='fix_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_fix_coo_impl(a,info,idir)

    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return


  end subroutine d_fix_coo


  subroutine d_cp_coo_to_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    class(psb_d_coo_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_cp_coo_to_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_cp_coo_to_coo

  subroutine d_cp_coo_from_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(out) :: a
    class(psb_d_coo_sparse_mat), intent(in) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_cp_coo_from_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_cp_coo_from_coo


  subroutine d_cp_coo_to_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    class(psb_d_base_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_cp_coo_to_fmt_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_cp_coo_to_fmt

  subroutine d_cp_coo_from_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(in) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_cp_coo_from_fmt_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_cp_coo_from_fmt



  subroutine d_mv_coo_to_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    class(psb_d_coo_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_mv_coo_to_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_mv_coo_to_coo

  subroutine d_mv_coo_from_coo(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    class(psb_d_coo_sparse_mat), intent(inout) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_mv_coo_from_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_mv_coo_from_coo



  subroutine d_coo_cp_from(a,b)
    use psb_error_mod
    implicit none 

    class(psb_d_coo_sparse_mat), intent(out) :: a
    type(psb_d_coo_sparse_mat), intent(in)   :: b


    Integer :: err_act, info
    character(len=20)  :: name='cp_from'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_cp_coo_from_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_coo_cp_from

  subroutine d_coo_mv_from(a,b)
    use psb_error_mod
    implicit none 

    class(psb_d_coo_sparse_mat), intent(out)  :: a
    type(psb_d_coo_sparse_mat), intent(inout) :: b


    Integer :: err_act, info
    character(len=20)  :: name='mv_from'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_mv_coo_from_coo_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_coo_mv_from


  subroutine d_mv_coo_to_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(out) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='to_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_mv_coo_to_fmt_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_mv_coo_to_fmt

  subroutine d_mv_coo_from_fmt(a,b,info) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    class(psb_d_base_sparse_mat), intent(inout) :: b
    integer, intent(out)            :: info

    Integer :: err_act
    character(len=20)  :: name='from_coo'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    call d_mv_coo_from_fmt_impl(a,b,info)
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    call psb_errpush(info,name)

    if (err_act /= psb_act_ret_) then
      call psb_error()
    end if
    return

  end subroutine d_mv_coo_from_fmt



  subroutine  d_coo_reallocate_nz(nz,a) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    integer, intent(in) :: nz
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    Integer :: err_act, info
    character(len=20)  :: name='d_coo_reallocate_nz'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    call psb_realloc(nz,a%ia,a%ja,a%val,info)

    if (info /= 0) then 
      call psb_errpush(4000,name)
      goto 9999
    end if

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_reallocate_nz


  subroutine d_coo_csput(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    real(psb_dpk_), intent(in)      :: val(:)
    integer, intent(in)             :: nz, ia(:), ja(:), imin,imax,jmin,jmax
    integer, intent(out)            :: info
    integer, intent(in), optional   :: gtl(:)


    Integer            :: err_act
    character(len=20)  :: name='d_coo_csput'
    logical, parameter :: debug=.false.
    integer            :: nza, i,j,k, nzl, isza, int_err(5)

    call psb_erractionsave(err_act)
    info = 0

    if (nz <= 0) then 
      info = 10
      int_err(1)=1
      call psb_errpush(info,name,i_err=int_err)
      goto 9999
    end if
    if (size(ia) < nz) then 
      info = 35
      int_err(1)=2
      call psb_errpush(info,name,i_err=int_err)
      goto 9999
    end if

    if (size(ja) < nz) then 
      info = 35
      int_err(1)=3
      call psb_errpush(info,name,i_err=int_err)
      goto 9999
    end if
    if (size(val) < nz) then 
      info = 35
      int_err(1)=4
      call psb_errpush(info,name,i_err=int_err)
      goto 9999
    end if

    if (nz == 0) return
    nza = a%get_nzeros()
    call d_coo_csput_impl(nz,ia,ja,val,a,imin,imax,jmin,jmax,info,gtl) 
    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_csput


  subroutine d_coo_csgetrow(imin,imax,a,nz,ia,ja,val,info,&
       & jmin,jmax,iren,append,nzin,rscale,cscale)
    ! Output is always in  COO format 
    use psb_error_mod
    use psb_const_mod
    implicit none
    
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer, intent(in)                  :: imin,imax
    integer, intent(out)                 :: nz
    integer, allocatable, intent(inout)  :: ia(:), ja(:)
    real(psb_dpk_), allocatable,  intent(inout)    :: val(:)
    integer,intent(out)                  :: info
    logical, intent(in), optional        :: append
    integer, intent(in), optional        :: iren(:)
    integer, intent(in), optional        :: jmin,jmax, nzin
    logical, intent(in), optional        :: rscale,cscale
    Integer :: err_act
    character(len=20)  :: name='csget'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0

    call d_coo_csgetrow_impl(imin,imax,a,nz,ia,ja,val,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)

    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_csgetrow


  subroutine d_coo_csgetptn(imin,imax,a,nz,ia,ja,info,&
       & jmin,jmax,iren,append,nzin,rscale,cscale)
    ! Output is always in  COO format 
    use psb_error_mod
    use psb_const_mod
    implicit none
    
    class(psb_d_coo_sparse_mat), intent(in) :: a
    integer, intent(in)                  :: imin,imax
    integer, intent(out)                 :: nz
    integer, allocatable, intent(inout)  :: ia(:), ja(:)
    integer,intent(out)                  :: info
    logical, intent(in), optional        :: append
    integer, intent(in), optional        :: iren(:)
    integer, intent(in), optional        :: jmin,jmax, nzin
    logical, intent(in), optional        :: rscale,cscale
    Integer :: err_act
    character(len=20)  :: name='csget'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0

    call d_coo_csgetptn_impl(imin,imax,a,nz,ia,ja,info,&
         & jmin,jmax,iren,append,nzin,rscale,cscale)

    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_csgetptn


  subroutine  d_coo_free(a) 
    implicit none 

    class(psb_d_coo_sparse_mat), intent(inout) :: a

    if (allocated(a%ia)) deallocate(a%ia)
    if (allocated(a%ja)) deallocate(a%ja)
    if (allocated(a%val)) deallocate(a%val)
    call a%set_null()
    call a%set_nrows(0)
    call a%set_ncols(0)

    return

  end subroutine d_coo_free

  subroutine d_coo_reinit(a,clear)
    use psb_error_mod
    implicit none 

    class(psb_d_coo_sparse_mat), intent(inout) :: a   
    logical, intent(in), optional :: clear

    Integer :: err_act, info
    character(len=20)  :: name='reinit'
    logical  :: clear_
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0


    if (present(clear)) then 
      clear_ = clear
    else
      clear_ = .true.
    end if

    if (a%is_bld() .or. a%is_upd()) then 
      ! do nothing
      return
    else if (a%is_asb()) then 
      if (clear_) a%val(:) = dzero
      call a%set_upd()
    else
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    end if

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_reinit


  subroutine  d_coo_trim(a)
    use psb_realloc_mod
    use psb_error_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    Integer :: err_act, info, nz
    character(len=20)  :: name='trim'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    nz  = a%get_nzeros()
    if (info == 0) call psb_realloc(nz,a%ia,info)
    if (info == 0) call psb_realloc(nz,a%ja,info)
    if (info == 0) call psb_realloc(nz,a%val,info)

    if (info /= 0) goto 9999 
    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_trim

  subroutine  d_coo_allocate_mnnz(m,n,a,nz) 
    use psb_error_mod
    use psb_realloc_mod
    implicit none 
    integer, intent(in) :: m,n
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    integer, intent(in), optional :: nz
    Integer :: err_act, info, nz_
    character(len=20)  :: name='allocate_mnz'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)
    info = 0
    if (m < 0) then 
      info = 10
      call psb_errpush(info,name,i_err=(/1,0,0,0,0/))
      goto 9999
    endif
    if (n < 0) then 
      info = 10
      call psb_errpush(info,name,i_err=(/2,0,0,0,0/))
      goto 9999
    endif
    if (present(nz)) then 
      nz_ = nz
    else
      nz_ = max(7*m,7*n,1)
    end if
    if (nz_ < 0) then 
      info = 10
      call psb_errpush(info,name,i_err=(/3,0,0,0,0/))
      goto 9999
    endif
    if (info == 0) call psb_realloc(nz_,a%ia,info)
    if (info == 0) call psb_realloc(nz_,a%ja,info)
    if (info == 0) call psb_realloc(nz_,a%val,info)
    if (info == 0) then 
      call a%set_nrows(m)
      call a%set_ncols(n)
      call a%set_nzeros(0)
      call a%set_bld()
      call a%set_triangle(.false.)
      call a%set_unit(.false.)
      call a%set_dupl(psb_dupl_def_)
    end if
    if (info /= 0) goto 9999 
    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_allocate_mnnz


  subroutine d_coo_print(iout,a,iv,eirs,eics,head,ivr,ivc)
    use psb_string_mod
    implicit none 

    integer, intent(in)               :: iout
    class(psb_d_coo_sparse_mat), intent(in) :: a   
    integer, intent(in), optional     :: iv(:)
    integer, intent(in), optional     :: eirs,eics
    character(len=*), optional        :: head
    integer, intent(in), optional     :: ivr(:), ivc(:)

    Integer :: err_act
    character(len=20)  :: name='d_coo_print'
    logical, parameter :: debug=.false.

    character(len=80)                 :: frmtv 
    integer  :: irs,ics,i,j, nmx, ni, nr, nc, nz

    if (present(eirs)) then 
      irs = eirs
    else
      irs = 0
    endif
    if (present(eics)) then 
      ics = eics
    else
      ics = 0
    endif

    if (present(head)) then 
      write(iout,'(a)') '%%MatrixMarket matrix coordinate real general'
      write(iout,'(a,a)') '% ',head 
      write(iout,'(a)') '%'    
      write(iout,'(a,a)') '% COO'
    endif

    nr = a%get_nrows()
    nc = a%get_ncols()
    nz = a%get_nzeros()
    nmx = max(nr,nc,1)
    ni  = floor(log10(1.0*nmx)) + 1

    write(frmtv,'(a,i3.3,a,i3.3,a)') '(2(i',ni,',1x),es26.18,1x,2(i',ni,',1x))'
    write(iout,*) nr, nc, nz 
    if(present(iv)) then 
      do j=1,a%get_nzeros()
        write(iout,frmtv) iv(a%ia(j)),iv(a%ja(j)),a%val(j)
      enddo
    else      
      if (present(ivr).and..not.present(ivc)) then 
        do j=1,a%get_nzeros()
          write(iout,frmtv) ivr(a%ia(j)),a%ja(j),a%val(j)
        enddo
      else if (present(ivr).and.present(ivc)) then 
        do j=1,a%get_nzeros()
          write(iout,frmtv) ivr(a%ia(j)),ivc(a%ja(j)),a%val(j)
        enddo
      else if (.not.present(ivr).and.present(ivc)) then 
        do j=1,a%get_nzeros()
          write(iout,frmtv) a%ia(j),ivc(a%ja(j)),a%val(j)
        enddo
      else if (.not.present(ivr).and..not.present(ivc)) then 
        do j=1,a%get_nzeros()
          write(iout,frmtv) a%ia(j),a%ja(j),a%val(j)
        enddo
      endif
    endif

  end subroutine d_coo_print




  !====================================
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
  !====================================

  subroutine d_coo_csmv(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)          :: alpha, beta, x(:)
    real(psb_dpk_), intent(inout)       :: y(:)
    integer, intent(out)                :: info
    character, optional, intent(in)     :: trans

    character :: trans_
    integer   :: i,j,k,m,n, nnz, ir, jc, nac, nar
    real(psb_dpk_) :: acc
    logical   :: tra
    Integer :: err_act
    character(len=20)  :: name='d_coo_csmv'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    if (.not.a%is_asb()) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif
    nar = a%get_nrows()
    nac = a%get_ncols()
    if (size(x) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    

    call d_coo_csmm_impl(alpha,a,x,beta,y,info,trans) 

    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_csmv

  subroutine d_coo_csmm(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)          :: alpha, beta, x(:,:)
    real(psb_dpk_), intent(inout)       :: y(:,:)
    integer, intent(out)                :: info
    character, optional, intent(in)     :: trans

    character :: trans_
    integer   :: i,j,k,m,n, nnz, ir, jc, nc, nar, nac
    real(psb_dpk_), allocatable  :: acc(:)
    logical   :: tra
    Integer :: err_act
    character(len=20)  :: name='d_coo_csmm'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)


    if (.not.a%is_asb()) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif
    nar = a%get_nrows()
    nac = a%get_ncols()
    if (size(x,1) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y,1) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    
    call d_coo_csmm_impl(alpha,a,x,beta,y,info,trans) 

    if (info /= 0) goto 9999

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_csmm


  subroutine d_coo_cssv(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)          :: alpha, beta, x(:)
    real(psb_dpk_), intent(inout)       :: y(:)
    integer, intent(out)                :: info
    character, optional, intent(in)     :: trans

    character :: trans_
    integer   :: i,j,k,m,n, nnz, ir, jc, nar, nac
    real(psb_dpk_) :: acc
    real(psb_dpk_), allocatable :: tmp(:)
    logical   :: tra
    Integer :: err_act
    character(len=20)  :: name='d_coo_cssv'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    if (.not.a%is_asb()) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif

    nar = a%get_nrows()
    nac = a%get_ncols()
    if (size(x,1) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y,1) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    

    if (.not. (a%is_triangle())) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    end if

    call d_coo_cssm_impl(alpha,a,x,beta,y,info,trans) 

    call psb_erractionrestore(err_act)
    return


9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return


  end subroutine d_coo_cssv



  subroutine d_coo_cssm(alpha,a,x,beta,y,info,trans) 
    use psb_error_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(in)          :: alpha, beta, x(:,:)
    real(psb_dpk_), intent(inout)       :: y(:,:)
    integer, intent(out)                :: info
    character, optional, intent(in)     :: trans

    character :: trans_
    integer   :: i,j,k,m,n, nnz, ir, jc, nc, nar, nac
    real(psb_dpk_) :: acc
    real(psb_dpk_), allocatable :: tmp(:,:)
    logical   :: tra
    Integer :: err_act
    character(len=20)  :: name='d_coo_csmm'
    logical, parameter :: debug=.false.

    call psb_erractionsave(err_act)

    if (.not.a%is_asb()) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    endif

    nar = a%get_nrows()
    nac = a%get_ncols()
    if (size(x,1) < nac) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nac,0,0,0/))
      goto 9999
    end if
    if (size(y,1) < nar) then
      info = 36
      call psb_errpush(info,name,i_err=(/3,nar,0,0,0/))
      goto 9999
    end if
    

    if (.not. (a%is_triangle())) then 
      info = 1121
      call psb_errpush(info,name)
      goto 9999
    end if

    call d_coo_cssm_impl(alpha,a,x,beta,y,info,trans) 
    call psb_erractionrestore(err_act)
    return


9999 continue
    call psb_erractionrestore(err_act)

    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_cssm

  function d_coo_csnmi(a) result(res)
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_)         :: res

    Integer :: err_act
    character(len=20)  :: name='csnmi'
    logical, parameter :: debug=.false.


    res = d_coo_csnmi_impl(a)

    return

  end function d_coo_csnmi

  subroutine d_coo_get_diag(a,d,info) 
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(in) :: a
    real(psb_dpk_), intent(out)     :: d(:)
    integer, intent(out)            :: info

    Integer :: err_act,mnm, i, j
    character(len=20)  :: name='get_diag'
    logical, parameter :: debug=.false.

    info  = 0
    call psb_erractionsave(err_act)

    mnm = min(a%get_nrows(),a%get_ncols())
    if (size(d) < mnm) then 
      info=35
      call psb_errpush(info,name,i_err=(/2,size(d),0,0,0/))
      goto 9999
    end if
    d(:) = dzero

    do i=1,a%get_nzeros()
      j=a%ia(i)
      if ((j==a%ja(i)) .and.(j <= mnm ) .and.(j>0)) then 
        d(j) = a%val(i)
      endif
    enddo

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)
    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_get_diag

  subroutine d_coo_scal(d,a,info) 
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    real(psb_dpk_), intent(in)      :: d(:)
    integer, intent(out)            :: info

    Integer :: err_act,mnm, i, j, m
    character(len=20)  :: name='scal'
    logical, parameter :: debug=.false.

    info  = 0
    call psb_erractionsave(err_act)

    m = a%get_nrows()
    if (size(d) < m) then 
      info=35
      call psb_errpush(info,name,i_err=(/2,size(d),0,0,0/))
      goto 9999
    end if

    do i=1,a%get_nzeros()
      j        = a%ia(i)
      a%val(i) = a%val(i) * d(j)
    enddo

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)
    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_scal

  subroutine d_coo_scals(d,a,info) 
    use psb_error_mod
    use psb_const_mod
    implicit none 
    class(psb_d_coo_sparse_mat), intent(inout) :: a
    real(psb_dpk_), intent(in)      :: d
    integer, intent(out)            :: info

    Integer :: err_act,mnm, i, j, m
    character(len=20)  :: name='scal'
    logical, parameter :: debug=.false.

    info  = 0
    call psb_erractionsave(err_act)


    do i=1,a%get_nzeros()
      a%val(i) = a%val(i) * d
    enddo

    call psb_erractionrestore(err_act)
    return

9999 continue
    call psb_erractionrestore(err_act)
    if (err_act == psb_act_abort_) then
      call psb_error()
      return
    end if
    return

  end subroutine d_coo_scals


end module psb_d_base_mat_mod



