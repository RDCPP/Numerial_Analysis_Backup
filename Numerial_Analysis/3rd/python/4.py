import numpy as np

def eigenvalue(A, v):
    Av = A.dot(v)
    up = Av.T.dot(v)
    down = v.T.dot(v)
    return up/down

def power_iteration(A):
    n, d = A.shape

    v = np.ones(d)
    ev = eigenvalue(A, v)

    cnt = 0

    while (cnt < 5):
        print(cnt+1)
        Av = A.dot(v)
        v_new = Av / np.max(Av)

        ev_new = eigenvalue(A, v_new)

        v = v_new
        ev = ev_new
        cnt += 1
        print(v,ev)

    return ev_new, v_new

A = np.array([[4,-1,0],[-1,4,-1],[0,-1,4]])

print(power_iteration(A))