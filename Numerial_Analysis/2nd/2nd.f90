program main
    integer N
    real*8, dimension(:,:), allocatable :: A
    real*8 diagonal_sum
    real*8 ans

    write(*,*) 'Matrix Size? : '
    read (*,*) N
    allocate(A(N,N))

    do j = 1, N
        do i = 1, N
            write(*,*) 'Input number : '
            read(*,*) A(i,j)
        end do
    end do

    ans = diagonal_sum(N,A)

    write(*,*) "Answer = ", ans
end program main

real*8 function diagonal_sum(N,A)
    integer N
    real*8 A(N,N)

    diagonal_sum = 0.0

    do i = 1 , N
        diagonal_sum = diagonal_sum + abs(A(i,i))
    end do

    return

end function diagonal_sum