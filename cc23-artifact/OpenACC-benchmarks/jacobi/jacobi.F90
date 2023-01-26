!!===----------------------------------------------------------------------===//
!!
!!     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
!!        compiler for NVIDIA GPUs, targeting numerical modeling code.
!!
!! This file is distributed under the University of Illinois Open Source
!! License. See LICENSE.TXT for details.
!!
!!===----------------------------------------------------------------------===//

!dir$attributes offload:<MIC> :: jacobi_
subroutine jacobi(nx, ny, c0, c1, c2, w0, w1)

  implicit none

  integer, intent(in) :: nx, ny ! matrix dimensions

  real, intent(in) :: c0, c1, c2
  real, intent(inout), dimension(nx, ny) :: w0, w1

  integer :: i, j

#if defined(_OPENACC)
  !$acc kernels loop independent gang(65535), present(w0(1:nx,1:ny), w1(1:nx,1:ny))
#endif
#if defined(_OPENMP) || defined(_MIC)
  !$omp parallel do
#endif
  do j = 2, ny-1
#if defined(_OPENACC)
    !$acc loop independent vector(512)
#endif
    do i = 2, nx-1
      w1(i, j) = c0 *  w0(i,   j  ) + &
                 c1 * (w0(i-1, j  ) + w0(i  , j-1) + w0(i+1, j  ) + w0(i  , j+1)) + &
                 c2 * (w0(i-1, j-1) + w0(i-1, j+1) + w0(i+1, j-1) + w0(i+1, j+1))
    enddo
  enddo
  
end subroutine jacobi

