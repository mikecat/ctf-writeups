import sys
import z3
from string import ascii_lowercase, digits
CHARSET = "DUCTF{}_!?'" + ascii_lowercase + digits

ct = "Ujyw5dnFofaou0au3nx3Cn84"

coeffs = [int(e) for e in sys.argv[1:]]

def value(x, lst = coeffs):
	res = 0
	for i in range(len(coeffs)):
		res += lst[i] * (x ** i)
	return res % len(CHARSET)

invtable = {}
for i in range(len(CHARSET)):
	c = value(i)
	if c in invtable:
		print("collision: %d for %d (%c) and %d (%c)" % (c, i, CHARSET[i], invtable[c], CHARSET[invtable[c]]))
	else:
		invtable[c] = i
for i in range(len(CHARSET)):
	if i not in invtable:
		invtable[i] = len(CHARSET)
print("".join([(CHARSET + "#")[invtable[CHARSET.index(c)]] for c in ct]))
