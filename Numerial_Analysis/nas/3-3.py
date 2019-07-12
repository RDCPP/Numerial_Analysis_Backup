import numpy as np

from scipy.linalg import hilbert,lu

n = 10

H = hilbert(10)

#------------------------Q1-----------------------------
L = np.array([[0. for i in range(n)] for i in range(n)])
for i in range(0,n):
	L[i][i] = 1.

U = np.array([[0. for i in range(0,n)] for i in range(n)])
for i in range(0,n):
	for j in range(0,n):
		U[i][j] = H[i][j]

for i in range(n):
    for j in range(i+1,n):
        e = np.divide(U[j][i],U[i][i])
        L[j][i] = e
        to = np.array(U[i])
        to = e * to
        for k in range(n):
            U[j][k] -= to[k]

print("L")
print(L)

print("\nU")
print(U)


#------------------------Q2-----------------------------
b = np.array([1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0])

y = np.array([0. for i in range(n)])
x = np.array([0. for i in range(n)])

for i in range(n):
    t = b[i]
    for j in range(i):
        t -= y[j] * L[i][j]
    y[i] = t / L[i][i]

for i in range(n-1,-1,-1):
    t = y[i]
    for j in range(n-1,i-1,-1):
        t -= x[j] * U[i][j]
    x[i] = t / U[i][i]
print()
for i in range(n):
    print("x%2d = %.10f" % (i+1,x[i]))
#------------------------Q3------------------------------
#Determinant of Upper-Triangular is the product of the diagonal components.
#And, Determinant of Orignal Matrix and Matrix U is same.
#So, we can obtain determinant by using the Matrix U.

det = 1.

for i in range(n):
    det = np.multiply(det,U[i][i])

print("\nDet of H =",det)

#------------------------Q4------------------------------
#[Hx1,Hx2, ... , Hxn] = [e1,e2, ... ,en]
inv = [[],[],[],[],[],[],[],[],[],[]]

for p in range(n):
    b_inv = np.array([0. for j in range(n)])
    y_inv = np.array([0. for j in range(n)])
    x_inv = np.array([0. for j in range(n)])
    b_inv[p] = 1.
    for i in range(n):
        t = b_inv[i]
        for j in range(i):
            t -= y_inv[j] * L[i][j]
        y_inv[i] = t / L[i][i]

    for i in range(n-1,-1,-1):
        t = y_inv[i]
        for j in range(n-1,i-1,-1):
            t -= x_inv[j] * U[i][j]
        x_inv[i] = t / U[i][i]

    for i in range(n):
        inv[i].append(x_inv[i])

inv = np.array(inv)

print("\nH^-1")
print(inv)