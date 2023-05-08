import z3
import binascii

magic = 0xEDB88320

def crcnext(crc, d):
	res = crc ^ 0xffffffff
	for i in range(8):
		res ^= z3.ZeroExt(24, (d >> i) & 1)
		b = -(res & 1)
		res = (res >> 1) & 0x7fffffff
		res ^= magic & b
	return res ^ 0xffffffff

prefix = b'int system(char*);int main(){system("/bin/sh");}//'
startValue = binascii.crc32(prefix)
addData = [z3.BitVec("x%d" % i, 8) for i in range(8)]

s = z3.Solver()

bitValue = z3.BitVec("init", 32)
s.add(bitValue == startValue)
for d in addData:
	bitValue = crcnext(bitValue, d)
	s.add(0x20 <= d, d <= 0x7e)

s.add(bitValue == 0x38DF65F2)
r = s.check()
if r == z3.sat:
	m = s.model()
	print(prefix.decode() + "".join([chr(m[e].as_long()) for e in addData]))
else:
	print(r)
