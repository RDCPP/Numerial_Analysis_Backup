!program main
!    implicit real*4(a-h, o-z) ! The pppack is in single precision
!    real tau(201), c(4, 201)
!    f(x) = exp(x) * cos(2*x)
!    fderiv(x) = exp(x) * (cos(2*x) - 2 * sin(2*x))
!    ibcbeg = 2 ! Natural Cubic Spline
!    ibcend = 2
!    a = 0. ! Starting point
!    b = 2.0 ! End point
!    write(*,*) '-- Enter Number of SubIntervals --'
!    read(*,*) N
!    h = (b-a)/N ! h is the length of the subinterval
!    do i = 1, N+1
!        tau(i) = a + (i-1)*h
!        c(1, i) = f(tau(i))
!    enddo
!    c(2,1) = 0. ! Natural Cubic Spline
!    c(2,N+1) = 0. ! Natural Cubic Spline
!    call cubspl(tau, c, N, ibcbeg, ibcend)
!    ! Using the coefficient computed above, we actually
!    ! evaluate function values
!    ! at mid-points and compare with the exact values.
!    k = 4
!    jderiv = 0 ! Compute the 0-th derivative, i.e,
!    ! The function values.
!    do i= 1, N-1
!        x = a + (i+0.5)*h ! At the mid-point of the subintervals.
!        y = f(x) ! The Exact Value
!        y2 = ppvalu(tau, c, N, k, x, jderiv) ! Cubic Spline Value
!        write(*,*)' Value at x = ', x, y, y2
!    enddo
!    write(*,*) ' -- Derivatives --'
!    k = 4
!    jderiv = 1 ! Compute the 1-th derivative, i.e,
!    ! The first-derivative values.
!    do i= 1, N-1
!        x = a + (i+0.5)*h ! At the mid-point of the subintervals.
!        y = fderiv(x) ! The Exact Value
!        y2 = ppvalu(tau, c, N, k, x, jderiv) ! Cubic Spline Value
!        write(*,*)' Value at x = ', x, y, y2
!    enddo
!    stop
!end program main

program main
    !====================================================================
    ! Spline interpolation
    ! Comments: values of function f(x) are calculated in n base points
    ! then: spline coefficients are computed
    !       spline interpolation is computed in 2n-1 points,
    !       a difference sum|f(u)-ispline(u)|
    !====================================================================
    implicit none
    integer, parameter :: n=11      ! base points for interpolation
    integer, parameter :: nint=11   ! compute interpolation in nint points
    double precision xmin, xmax     ! given interval of x()
    double precision, dimension (n) :: xi(n), yi(n), b(n), c(n), d(n)
    double precision x, y, step, ys, error, errav
    integer i
    double precision f, ispline

    ! open files
    !open (unit=1, file='tablex1.dat')
    !open (unit=2, file='tablex2.dat')

    xmin = 0.0
    xmax = 2.0

    ! step 1: generate xi and yi from f(x), xmin, xmax, n
    step = (xmax-xmin)/(n-1)
    do i=1,n
        xi(i) = xmin + step*float(i-1)
        yi(i) = f(xi(i))
        !  write (*,200) xi(i), yi(i)
    end do

    !  step 2: call spline to calculate spline coeficients
    call spline (xi, yi, b, c, d,n)

    !  step 3: interpolation at nint points
    errav = 0.0
    step = (xmax-xmin)/(nint-1)
    write(*,201)
    do i=1, nint
        x = xmin + step*float(i-1)
        y = f(x)
        ys = ispline(x, xi, yi, b, c, d, n)
        error = ys-y
        write (*,200) x, ys, error
        ! step 4: calculate quality of interpolation
        errav = errav + abs(y-ys)/nint
    end do
    write (*,202) errav
    200 format (3f12.5)
    201 format ('        x        spline      error')
    202 format ('           Average error',f12.5)

end program main


!
!  Function f(x)
!
function f(x)
    double precision f, x
    f = exp(x) * cos(2*x)
end function f

subroutine spline (x, y, b, c, d, n)
    !======================================================================
    !  Calculate the coefficients b(i), c(i), and d(i), i=1,2,...,n
    !  for cubic spline interpolation
    !  s(x) = y(i) + b(i)*(x-x(i)) + c(i)*(x-x(i))**2 + d(i)*(x-x(i))**3
    !  for  x(i) <= x <= x(i+1)
    !  Alex G: January 2010
    !----------------------------------------------------------------------
    !  input..
    !  x = the arrays of data abscissas (in strictly increasing order)
    !  y = the arrays of data ordinates
    !  n = size of the arrays xi() and yi() (n>=2)
    !  output..
    !  b, c, d  = arrays of spline coefficients
    !  comments ...
    !  spline.f90 program is based on fortran version of program spline.f
    !  the accompanying function fspline can be used for interpolation
    !======================================================================
    implicit none
    integer n
    double precision x(n), y(n), b(n), c(n), d(n)
    integer i, j, gap
    double precision h

    gap = n-1
    ! check input
    if ( n < 2 ) return
    if ( n < 3 ) then
        b(1) = (y(2)-y(1))/(x(2)-x(1))   ! linear interpolation
        c(1) = 0.
        d(1) = 0.
        b(2) = b(1)
        c(2) = 0.
        d(2) = 0.
        return
    end if
    !
    ! step 1: preparation
    !
    d(1) = x(2) - x(1)
    c(2) = (y(2) - y(1))/d(1)
    do i = 2, gap
        d(i) = x(i+1) - x(i)np.array
        b(i) = 2.0*(d(i-1) + d(i))
        c(i+1) = (y(i+1) - y(i))/d(i)
        c(i) = c(i+1) - c(i)
    end donp.array
    !
    ! step 2: end conditions
    !
    b(1) = -d(1)
    b(n) = -d(n-1)
    c(1) = 0.0
    c(n) = 0.0
    if(n /= 3) then
        c(1) = c(3)/(x(4)-x(2)) - c(2)/(x(3)-x(1))
        c(n) = c(n-1)/(x(n)-x(n-2)) - c(n-2)/(x(n-1)-x(n-3))
        c(1) = c(1)*d(1)**2/(x(4)-x(1))
        c(n) = -c(n)*d(n-1)**2/(x(n)-x(n-3))
    end if
    !
    ! step 3: forward elimination
    !
    do i = 2, n
        h = d(i-1)/b(i-1)
        b(i) = b(i) - h*d(i-1)
        c(i) = c(i) - h*c(i-1)
    end do
    !
    ! step 4: back substitution
    !
    c(n) = c(n)/b(n)
    do j = 1, gap
        i = n-j
        c(i) = (c(i) - d(i)*c(i+1))/b(i)
    end do
    !
    ! step 5: compute spline coefficients
    !
    b(n) = (y(n) - y(gap))/d(gap) + d(gap)*(c(gap) + 2.0*c(n))
    do i = 1, gap
        b(i) = (y(i+1) - y(i))/d(i) - d(i)*(c(i+1) + 2.0*c(i))
        d(i) = (c(i+1) - c(i))/d(i)
        c(i) = 3.*c(i)
    end do
    c(n) = 3.0*c(n)
    d(n) = d(n-1)
end subroutine spline

function ispline(u, x, y, b, c, d, n)
    !======================================================================
    ! function ispline evaluates the cubic spline interpolation at point z
    ! ispline = y(i)+b(i)*(u-x(i))+c(i)*(u-x(i))**2+d(i)*(u-x(i))**3
    ! where  x(i) <= u <= x(i+1)
    !----------------------------------------------------------------------
    ! input..
    ! u       = the abscissa at which the spline is to be evaluated
    ! x, y    = the arrays of given data points
    ! b, c, d = arrays of spline coefficients computed by spline
    ! n       = the number of data points
    ! output:
    ! ispline = interpolated value at point u
    !=======================================================================
    implicit none
    double precision ispline
    integer n
    double precision  u, x(n), y(n), b(n), c(n), d(n)
    integer i, j, k
    double precision dx

    ! if u is ouside the x() interval take a boundary value (left or right)
    if(u <= x(1)) then
        ispline = y(1)
        return
    end if
    if(u >= x(n)) then
        ispline = y(n)
        return
    end if

    !*
    !  binary search for for i, such that x(i) <= u <= x(i+1)
    !*
    i = 1
    j = n+1
    do while (j > i+1)
        k = (i+j)/2
        if(u < x(k)) then
            j=k
        else
            i=k
        end if
    end do
    !*
    !  evaluate spline interpolation
    !*
    dx = u - x(i)
    ispline = y(i) + dx*(b(i) + dx*(c(i) + dx*d(i)))
end function ispline