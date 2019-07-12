program main
    call q1()
    call q2a()
    call q2b()
    call q2c()
end program main

subroutine q1()
    real matrix(10,10)
    real length(10)
    do j = 1, 10
        do i =1, 10
            matrix(i,j) = cos(i * 0.7 + j + 2)/(i+j-1)
        end do
    end do
    do j = 1, 10
        length(j) = 0
        do i = 1, 10
            length(j) = length(j) + matrix(i, j)
        end do
    end do
    result = Maxval(length)
    write(*,*) "result = ", result
end subroutine q1

subroutine q2a()
    integer prime(300)
    integer cnt
    integer index
    cnt = 0
    index = 1
    do i = 2, 300
        do j = 1 , i - 1
            if (j .GE. 2 .AND. mod(i,j) .EQ. 0) then
                cnt = cnt + 1
                exit
            end if
        end do
        if(cnt .EQ. 0) then
            prime(index) = i
            index = index + 1
        end if
        cnt = 0
    end do
    do i = 1 , index-1
        write(*,*) prime(i)
    end do
end subroutine q2a

subroutine q2b()
    integer prime(300)
    integer cnt
    integer index
    integer i
    cnt = 0
    index = 1
    i = 2
    do while (index < 301)
        do j = 1 , i - 1
            if (j .GE. 2 .AND. mod(i,j) .EQ. 0) then
                cnt = cnt + 1
                exit
            end if
        end do
        if(cnt .EQ. 0) then
            prime(index) = i
            index = index + 1
        end if
        cnt = 0
        i = i + 1
    end do
    write(*,*) "300-th prime number =" ,prime(300)
end subroutine q2b

subroutine q2c()
    integer total
    integer cnt
    cnt = 0
    total = 0
    do i = 2, 10000
        do j = 1, i - 1
            if (j .GE. 2 .AND. mod(i,j) .EQ. 0) then
                cnt = cnt + 1
                exit
            end if
        end do
        if(cnt .EQ. 0) then
            total = total + 1
        end if
        cnt = 0
    end do
    write(*,*) "numbers of primes = ", total
end subroutine q2c