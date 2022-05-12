import z3
import sys
import struct

if len(sys.argv) != 3:
	sys.stderr.write("Usage: solve.py input_file output_file\n")
	sys.exit(1)

ct = [ord(c) for c in open(sys.argv[1], "rb").read().decode("UTF-8")]
pt = [z3.BitVec("p" + str(i), 16) for i in range(len(ct))]

enc = []
for i, p in enumerate(pt):
	x = (p + i * 0xf) % 0x80
	x += (enc[i - 1] % 128 if i > 0 else 0xd)
	x ^= 0x555
	x = ~x & 0xff
	x = ~(x ^ 3)
	x = ~(-1 + x)
	enc.append(x)

solver = z3.Solver()
for e, c in zip(enc, ct):
	solver.add(e == c)

for p in pt:
	solver.add((p & 0xff00) == 0)

res = solver.check()
if res == z3.sat:
	m = solver.model()
	with open(sys.argv[2], "wb") as f:
		f.write(b"".join([bytes([m[p].as_long()]) for p in pt]))
else:
	sys.stderr.write(str(res) + "\n")
