p = 3
q = 5
n = p * q
e = 65535

for m in range(n):
	c = pow(m, e, n)
	if c == 10:
		print(m)
