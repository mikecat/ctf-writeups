import z3

descryption = "9xLmMiI2znmPam'D_A_1:RQ;Il\\*7:%i\".R<"

flag = [z3.Int("f" + str(i)) for i in range(len(descryption) * 4)]

r2 = [158 - f for f in flag]

solver = z3.Solver()

#for a, b in zip(flag, "kqctf{"):
#	solver.add(a == ord(b))

for f in flag:
	solver.add(0x20 <= f, f < 0x7f)

a = 0
build_idx = 0
while build_idx + 1 < len(descryption):
	solver.add(ord(descryption[build_idx]) == ((2*r2[2*a]-r2[2*a+1]+153)%93+33))
	solver.add(ord(descryption[build_idx + 1]) == ((r2[2*a+1]-r2[2*a]+93)%93+33))
	a += 1
	build_idx += 2

res = solver.check()
if res == z3.sat:
	model = solver.model()
	values = [model[f].as_long() if model[f] is not None else None for f in flag]
	print(values)
	values_str = ""
	for v in values:
		if v is not None:
			values_str += chr(v)
	print(values_str)
else:
	print(res)
