import sys

def get():
	return int(sys.stdin.readline().rstrip())

p = get()
q = get()
e = get()
ct = get()

phi = (p - 1) * (q - 1)
d = pow(e, -1, phi)
res = pow(ct, d, p * q)

print(res)

res2 = ""
while res > 0:
	res2 = chr(res & 0xff) + res2
	res >>= 8

print(res2)
