import sys

data = {}
for l in sys.stdin.readlines():
	if l[1:3] == ": ":
		name, value = l.rstrip().split(": ")
		data[name] = int(value)

c = data["c"]
p = data["p"]
q = data["q"]
e = data["e"]

phi = (p - 1) * (q - 1)
d = pow(e, -1, phi)
res = pow(c, d, p * q)

res_str = hex(res)[2:]
if len(res_str) % 2 != 0:
	res_str = "0" + res_str

print(res_str)
