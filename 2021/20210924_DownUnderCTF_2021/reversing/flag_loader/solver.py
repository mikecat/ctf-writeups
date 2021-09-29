import z3
import sys

solver = z3.Solver()

# check1

data = [z3.BitVec("d" + str(i), 8) for i in range(5)]
arr = [0x44, 0x55, 0x43, 0x54, 0x46]

c1_c3vs1 = 0
c1_c3vs2 = 1
for i in range(5):
	c1_c3vs1 += data[i] ^ arr[i]
	c1_c3vs2 *= data[i] * (i + 1)

if len(sys.argv) < 2:
	for d in data:
		solver.add(0x21 <= d, d < 0x7f)

	solver.add(c1_c3vs1 == 0)
	solver.add(c1_c3vs2 != 0)

else:
	for d, c in zip(data, sys.argv[1]):
		solver.add(d == ord(c))

# check 2

c2a = z3.BitVec("c2a", 32)
c2b = z3.BitVec("c2b", 32)
value2 = (c2a * c2b) & 0xffff

if len(sys.argv) < 4:
	target2 = 0 if len(sys.argv) < 3 else int(sys.argv[2])
	solver.add(c2a != 0, c2b != 0)
	solver.add(z3.BV2Int(c2a) > target2, z3.BV2Int(c2b) > target2)
	solver.add(c2a + c2b == target2)
	solver.add(value2 >= 0x3c)
else:
	solver.add(c2a == int(sys.argv[2]))
	solver.add(c2b == int(sys.argv[3]))

# check 3

target3 = 0 if len(sys.argv) < 5 else int(sys.argv[4])
c3vs = [z3.BitVec("c3v" + str(i), 32) for i in range(5)]
value3 = ((c3vs[4] - c3vs[3]) * (c3vs[2] - c3vs[1])) & 0xffff

for v in c3vs:
	solver.add(v != 0)

for i in range(4):
	solver.add(z3.BV2Int(c3vs[i + 1]) > z3.BV2Int(c3vs[i]))
solver.add(c3vs[0] + c3vs[1] + c3vs[2] + c3vs[3] + c3vs[4] == target3)
solver.add(value3 >= 0x3c)

solver.add(z3.BV2Int(z3.ZeroExt(24, c1_c3vs2) * value2 * value3) < 10)

res = solver.check()
print(res)
if res == z3.sat:
	m = solver.model()
	print("".join([chr(m[d].as_long()) for d in data]))
	print("%d %d" % (m[c2a].as_long(), m[c2b].as_long()))
	print(" ".join([str(m[v].as_long()) for v in c3vs]))
