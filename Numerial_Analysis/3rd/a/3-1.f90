implicit real*4(a-h, o-z) ! The pppack is in single precision

real tau(201), c(4, 201)
f(x) = exp(x)*sin(x)
fderiv(x) = exp(x) * (sin(x) + cos(x))
ibcbeg = 2 ! Natural Cubic Spline
ibcend = 2
a = 0.0 ! Starting point
b = 2.0 ! End point

write(*,*) '-- Enter Number of SubIntervals --' ! ’ -- Enter Number of SubIntervals --’

read(*,*) N
h = (b-a)/N ! h is the length of the subinterval

do i = 1, N+1
    tau(i) = a + (i-1)*h
    c(1, i) = f(tau(i))
enddo

c(2,1) = 0.0 ! Natural Cubic Spline
c(2,N+1) = 0.0 ! Natural Cubic Spline
call cubspl(tau, c, N, ibcbeg, ibcend)

! Using the coefficient computed above, we actually
! evaluate function values
! at mid-points and compare with the exact values.
k = 4
jderiv = 0 ! Compute the 0-th derivative, i.e,
! The function values.

do i= 1, N-1
    x = a + (i+0.5)*h ! At the mid-point of the subintervals.
    y = f(x) ! The Exact Value
    y2 = ppvalu(tau, c, N, k, x, jderiv) ! Cubic Spline Value
    d = ABS(y2 - y)
    write(*,*) ' Value at x = ', x, y, y2 , d !’ Value at x = ’, x, y, y2
enddo

write(*,*) '-- Derivatives --' ! ’ -- Derivatives --’

k = 4
jderiv = 1 ! Compute the 1-th derivative, i.e,
! The first-derivative values.
do i= 1, N-1
    x = a + (i+0.5)*h ! At the mid-point of the subintervals.
    y = fderiv(x) ! The Exact Value
    y2 = ppvalu(tau, c, N, k, x, jderiv) ! Cubic Spline Value
    d = ABS(y2 - y)
    write(*,*) ' Value at x = ', x, y, y2 ,d !
enddo


read(*,*)

stop
end