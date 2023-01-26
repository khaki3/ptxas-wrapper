!!===----------------------------------------------------------------------===//
!!
!!     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
!!        compiler for NVIDIA GPUs, targeting numerical modeling code.
!!
!! This file is distributed under the University of Illinois Open Source
!! License. See LICENSE.TXT for details.
!!
!!===----------------------------------------------------------------------===//

subroutine sincos(nx, ny, ns, x, y, xy)

  implicit none

  integer, intent(in) :: nx, ny, ns
  real, intent(in), dimension(nx, ny, ns) :: x, y
  real, intent(out), dimension(nx, ny, ns) :: xy

  integer :: i, j, k

#if defined(_OPENACC)
  !$acc kernels loop independent gang(65535), present(x(1:nx,1:ny,1:ns), y(1:nx,1:ny,1:ns), xy(1:nx,1:ny,1:ns))
#endif
#if defined(_OPENMP) || defined(_MIC)
  !$omp parallel for
#endif
  do k = 1, ns
#if defined(_OPENACC)
    !$acc loop independent
#endif
    do j = 1, ny
#if defined(_OPENACC)
      !$acc loop independent vector(512)
#endif
      do i = 1, nx
        xy(i,j,k) = sin(x(i,j,k)) + cos(y(i,j,k))
      enddo
    enddo
  enddo

end subroutine sincos	

