!!===----------------------------------------------------------------------===//
!!
!!     KernelGen -- A prototype of LLVM-based auto-parallelizing Fortran/C
!!        compiler for NVIDIA GPUs, targeting numerical modeling code.
!!
!! This file is distributed under the University of Illinois Open Source
!! License. See LICENSE.TXT for details.
!!
!!===----------------------------------------------------------------------===//

subroutine matmul(nx, ny, ns, A, B, C)
  implicit none

  integer, intent(in) :: nx, ny, ns
  real, dimension(nx, ny), intent(in) :: A
  real, dimension(ny, ns), intent(in) :: B
  real, dimension(nx, ns), intent(inout) :: C

  integer :: i, j, k

#if defined(_OPENACC)
  !$acc kernels loop gang(65535)
#endif
#if defined(_OPENMP) || defined(_MIC)
  !$omp parallel for
#endif
  do j = 1, ns
#if defined(_OPENACC)
    !$acc loop vector(512)
#endif
    do i = 1, nx
#if defined(_OPENACC)
      !$acc loop seq 
#endif
      do k = 1, ny
        C(i, j) = C(i, j) + A(i, k) * B(k, j)
      enddo
    enddo
  enddo

end subroutine matmul

