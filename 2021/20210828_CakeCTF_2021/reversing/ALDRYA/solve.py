import z3

target_file = "sample_mod.elf"
target_offset = 0x1000
target_value = 0xffa0f33e

initial_value = 0x20210828
chunk_size = 0x100

with open(target_file, "rb") as file:
	target_data = file.read()[target_offset:target_offset+chunk_size]

modify_data = [z3.BitVec("m" + str(i), 8) for i in range(32)]

value = initial_value
for c in target_data[:-len(modify_data)]:
	value = ((value ^ c) >> 1) | (((value ^ c) & 1) << 0x1f)

for m in modify_data:
	value = z3.LShR(value ^ z3.ZeroExt(24, m), 1) | (((value ^ z3.ZeroExt(24, m)) & 1) << 0x1f)

s = z3.Solver()
s.add(value == target_value)
chk = s.check()
print(chk)
if chk == z3.sat:
	m = s.model()
	for b in modify_data:
		print(hex(m[b].as_long()))
