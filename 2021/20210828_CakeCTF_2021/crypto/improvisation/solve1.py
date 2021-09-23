import z3

value = 0x58566f59979e98e5f2f3ecea26cfb0319bc9186e206d6b33e933f3508e39e41bb771e4af053

bvalue = bin(value)[2:]
bvalue = ("0" * (4 - len(bvalue) % 8)) + bvalue

print(bvalue)

r_init = z3.BitVec("r", 64)
r = r_init

def LFSR():
	global r
	res = r & 1
	b = (r & 1) ^\
		((r & 2) >> 1) ^\
		((r & 8) >> 3) ^\
		((r & 16) >> 4)
	r = z3.LShR(r, 1) | (b << 63)
	return res

solver = z3.Solver()

offset = 0
for c in b'CakeCTF{':
	for i in range(8):
		value_bit = int(bvalue[offset + i])
		c_bit = (c >> i) & 1
		solver.add((c_bit ^ LFSR()) == value_bit)
	offset += 8

res = solver.check()
print(res)
if res == z3.sat:
	m = solver.model()
	print(hex(m[r_init].as_long()))
