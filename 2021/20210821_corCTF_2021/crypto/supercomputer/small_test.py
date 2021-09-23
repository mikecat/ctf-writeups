import random

def v(p, k):
	ans = 0
	while k % p == 0:
		k //= p
		ans += 1
	return ans

p, q, r = 5, 7, 11
print(p, q, r)
n = pow(p, q) * r

a1 = random.randint(0, n)
a2 = n - a1
assert a1 % p != 0 and a2 % p != 0

print(n, a1, a2)
t = pow(a1, n) + pow(a2, n)
print(v(p, t))
