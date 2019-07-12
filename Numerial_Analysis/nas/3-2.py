import numpy as np

def rk4(f, x0, y0, x1, n):
    lx = [0] * (n + 1)
    ly = [0] * (n + 1)
    h = (x1 - x0) / float(n)
    lx[0] = x = x0
    ly[0] = y = y0
    for i in range(1, n + 1):
        k1 = h * f(x, y)
        k2 = h * f(x + 0.5 * h, y + 0.5 * k1)
        k3 = h * f(x + 0.5 * h, y + 0.5 * k2)
        k4 = h * f(x + h, y + k3)
        lx[i] = x = x0 + i * h
        ly[i] = y = y + (k1 + 2*k2 + 2*k3 + k4) / 6
    return lx, ly
 
def f(x, y):
    return x + y

# h = 0.05
lx1, ly1 = rk4(f, 0., 2., 2., 40)

# h = 0.1
lx2, ly2 = rk4(f, 0., 2., 2., 20)

# h = 0.2
lx3, ly3 = rk4(f, 0., 2., 2., 10)

exact = 3 * np.exp(2) - 2 - 1

print("When h = 0.05 , Difference = %.16f" % np.abs(np.subtract(exact,ly1[40])))
print("When h = 0.1  , Difference = %.16f" % np.abs(np.subtract(exact,ly2[20])))
print("When h = 0.2  , Difference = %.16f" % np.abs(np.subtract(exact,ly3[10])))