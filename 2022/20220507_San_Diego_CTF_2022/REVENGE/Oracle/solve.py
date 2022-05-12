import z3

check = [
	48, 6, 122, -86, -73, -59, 78, 84, 105, -119,
	-36, -118, 70, 17, 101, -85, 55, -38, -91, 32,
	-18, -107, 53, 99, -74, 67, 89, 120, -41, 122,
	-100, -70, 34, -111, 21, -128, 78, 27, 123, -103,
	36, 87
]

flag = [z3.BitVec("f" + str(i), 8) for i in range(42)]
numbers = [f for f in flag]

# firstPass
for b in range(len(numbers)):
	numbers[b] = (numbers[b] ^ 3 * b * b + 5 * b + 101 + b % 2)

# secondPass
arrayOfByte = [
	(numbers[(b + 42 - 1) % 42] << 4 | z3.LShR(numbers[b] & 0xFF, 4)) for b in range(len(numbers))
]
numbers = arrayOfByte

# thirdPass
for b in range(len(numbers)):
	numbers[b] = (numbers[b] + 7 * b * b + 31 * b + 127 + b % 2)

solver = z3.Solver()
for c, b in zip(check, numbers):
	c2 = c if c >= 0 else c + 256
	solver.add(c2 == b)

#for f in flag:
#	solver.add(0x21 <= f, f < 0x7f)

ret = solver.check()
if ret == z3.sat:
	m = solver.model()
	values = [m[f].as_long() for f in flag]
	print(values)
	print("".join([chr(f) for f in values]))
else:
	print(ret)
