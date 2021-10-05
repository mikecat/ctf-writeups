import z3
from string import ascii_lowercase, digits
CHARSET = "DUCTF{}_!?'" + ascii_lowercase + digits

ct = "Ujyw5dnFofaou0au3nx3Cn84"

coeffs = [z3.Int("c" + str(i)) for i in range(6 + 1)]

solver = z3.Solver()

for c in coeffs:
	solver.add(0 <= c, c < len(CHARSET))

def value(x, lst = coeffs):
	res = 0
	for i in range(len(coeffs)):
		res += lst[i] * (x ** i)
	return res % len(CHARSET)

key1 = "DUCTF{"
key2 = "}"

for i in range(len(key1)):
	solver.add(value(CHARSET.index(key1[i])) == CHARSET.index(ct[i]))

for i in range(1, len(key2) + 1):
	solver.add(value(CHARSET.index(key2[-i])) == CHARSET.index(ct[-i]))

res = solver.check()
print(res)
if res == z3.sat:
	m = solver.model()
	coeffs_c = [m[c].as_long() for c in coeffs]
	print(coeffs_c)
	invtable = {}
	for i in range(len(CHARSET)):
		c = value(i, coeffs_c)
		if c in invtable:
			print("collision: %d for %d and %d" % (c, i, invtable[c]))
		else:
			invtable[c] = i
	for i in range(len(CHARSET)):
		if i not in invtable:
			invtable[i] = len(CHARSET)
	print("".join([(CHARSET + "#")[invtable[CHARSET.index(c)]] for c in ct]))
