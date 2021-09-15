import sys

r = int(sys.argv[1], 0) if len(sys.argv) > 1 else 0

def LFSR():
	global r
	res = r & 1
	b = (r & 1) ^\
		((r & 2) >> 1) ^\
		((r & 8) >> 3) ^\
		((r & 16) >> 4)
	r = (r >> 1) | (b << 63)
	return res

value = 0x58566f59979e98e5f2f3ecea26cfb0319bc9186e206d6b33e933f3508e39e41bb771e4af053

bvalue = bin(value)[2:]
bvalue = ("0" * (4 - len(bvalue) % 8)) + bvalue + "0"

res = ""

cur = 0
for i in range(len(bvalue)):
	cur = cur | ((int(bvalue[i]) ^ LFSR()) << (i % 8))
	if i % 8 == 7:
		res += hex(cur)[2:]
		cur = 0

print(res)
