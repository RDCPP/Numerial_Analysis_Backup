import numpy as np

x = np.linspace(0.,2.,11)
a = np.array([1,1.125,1.039,0.6663,-0.0650,-1.131,-2.448,-3.821,-4.944,-5.425,-4.83])
b = np.array([0. for i in range(11)])
c = np.array([0. for i in range(11)])
d = np.array([0. for i in range(11)])
h = np.array([0. for i in range(10)])
alpha = np.array([0. for i in range(10)])
l = np.array([1. for i in range(11)])
mu = np.array([0. for i in range(10)])
zeta = np.array([0. for i in range(11)])

for i in range(10):
    h[i] = x[i+1] - x[i]

for i in range(1,10):
    alpha[i] = 3*(a[i+1] - a[i])/h[i] - 3*(a[i] - a[i-1])/h[i-1]

for i in range(1,10):
    l[i] = 2*(x[i+1] - x[i-1]) - h[i-1]*mu[i-1]
    mu[i] = h[i]/l[i]
    zeta[i] = (alpha[i] - h[i-1]*zeta[i-1])/l[i]

for j in range(9,-1,-1):
    c[j] = zeta[j] - mu[j]*c[j+1]
    b[j] = (a[j+1] - a[j])/h[j] - h[j]*(c[j+1] + 2*c[j])/3
    d[j] = (c[j+1] - c[j])/(3*h[j])

eval_front_1 = np.subtract(0.5, x[2])
eval_front_2 = np.multiply(eval_front_1, eval_front_1)
eval_front_3 = np.multiply(eval_front_2, eval_front_1)

eval_front_S = np.add(a[2], np.multiply(b[2], eval_front_1))
eval_front_S = np.add(eval_front_S, np.multiply(c[2], eval_front_2))
eval_front_S = np.add(eval_front_S, np.multiply(d[2], eval_front_3))

eval_back_1 = np.subtract(0.5, x[3])
eval_back_2 = np.multiply(eval_back_1, eval_back_1)
eval_back_3 = np.multiply(eval_back_2, eval_back_1)

eval_back_S = np.add(a[3], np.multiply(b[3], eval_back_1))
eval_back_S = np.add(eval_back_S, np.multiply(c[3], eval_back_2))
eval_back_S = np.add(eval_back_S, np.multiply(d[3], eval_back_3))

eval_exact = np.exp(0.5) * np.cos(1.0)

front_diff = np.abs(np.subtract(eval_exact,eval_front_S))
back_diff = np.abs(np.subtract(eval_exact,eval_back_S))

print("\nFunction Value")
print("x = 0.5 : ",end="")

if(front_diff > back_diff):
    print(back_diff)
else:
    print(front_diff)

eval_front_1 = np.subtract(1.5, x[7])
eval_front_2 = np.multiply(eval_front_1, eval_front_1)
eval_front_3 = np.multiply(eval_front_2, eval_front_1)

eval_front_S = np.add(a[7], np.multiply(b[7], eval_front_1))
eval_front_S = np.add(eval_front_S, np.multiply(c[7], eval_front_2))
eval_front_S = np.add(eval_front_S, np.multiply(d[7], eval_front_3))

eval_back_1 = np.subtract(1.5, x[8])
eval_back_2 = np.multiply(eval_back_1, eval_back_1)
eval_back_3 = np.multiply(eval_back_2, eval_back_1)

eval_back_S = np.add(a[8], np.multiply(b[8], eval_back_1))
eval_back_S = np.add(eval_back_S, np.multiply(c[8], eval_back_2))
eval_back_S = np.add(eval_back_S, np.multiply(d[8], eval_back_3))

eval_exact = np.exp(1.5) * np.cos(3.0)

front_diff = np.abs(np.subtract(eval_exact,eval_front_S))
back_diff = np.abs(np.subtract(eval_exact,eval_back_S))

print("x = 1.5 : ",end="")

if(front_diff > back_diff):
    print(back_diff)
else:
    print(front_diff)

eval_front_1 = np.multiply(2,np.subtract(0.5, x[2]))
eval_front_2 = np.multiply(3,np.multiply(eval_front_1, eval_front_1))

eval_front_S = np.add(b[2], np.multiply(c[2], eval_front_1))
eval_front_S = np.add(eval_front_S, np.multiply(d[2], eval_front_2))

eval_back_1 = np.multiply(2,np.subtract(0.5, x[3]))
eval_back_2 = np.multiply(3,np.multiply(eval_back_1, eval_back_1))

eval_back_S = np.add(b[3], np.multiply(c[3], eval_back_1))
eval_back_S = np.add(eval_back_S, np.multiply(d[3], eval_back_2))

eval_exact = np.exp(0.5) * (np.cos(1.0) - 2 * np.sin(1.0))

front_diff = np.abs(np.subtract(eval_exact,eval_front_S))
back_diff = np.abs(np.subtract(eval_exact,eval_back_S))

print("\nDerivation Value")
print("x = 0.5 : ",end="")

if(front_diff > back_diff):
    print(back_diff)
else:
    print(front_diff)

eval_front_1 = np.multiply(2,np.subtract(1.5, x[7]))
eval_front_2 = np.multiply(3,np.multiply(eval_front_1, eval_front_1))

eval_front_S = np.add(b[7], np.multiply(c[7], eval_front_1))
eval_front_S = np.add(eval_front_S, np.multiply(d[7], eval_front_2))

eval_back_1 = np.multiply(2,np.subtract(1.5, x[8]))
eval_back_2 = np.multiply(3,np.multiply(eval_back_1, eval_back_1))

eval_back_S = np.add(b[8], np.multiply(c[8], eval_back_1))
eval_back_S = np.add(eval_back_S, np.multiply(d[8], eval_back_2))

eval_exact = np.exp(1.5) * (np.cos(3.0) - 2 * np.sin(3.0))

front_diff = np.abs(np.subtract(eval_exact,eval_front_S))
back_diff = np.abs(np.subtract(eval_exact,eval_back_S))

print("x = 1.5 : ",end="")

if(front_diff > back_diff):
    print(back_diff)
else:
    print(front_diff)