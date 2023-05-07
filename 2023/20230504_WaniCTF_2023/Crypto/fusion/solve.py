import sys

data = {}

for line in sys.stdin.readlines():
	key, value = line.rstrip().split(" = ")
	data[key] = int(value)

r_mask = int("55" * 128, 16)
p = data["r"] & r_mask
q = data["r"] & (r_mask << 1)
n = data["n"]

def search(cur_p, cur_q, cur_bit):
	mask = (1 << cur_bit) - 1
	if ((cur_p * cur_q) & mask) != (n & mask):
		return []
	if cur_p * cur_q == n:
		return [(cur_p, cur_q)]
	delta_p = 1 << (cur_bit + 1)
	delta_q = 1 << cur_bit
	result = []
	result += search(cur_p          , cur_q          , cur_bit + 2)
	result += search(cur_p | delta_p, cur_q          , cur_bit + 2)
	result += search(cur_p          , cur_q | delta_q, cur_bit + 2)
	result += search(cur_p | delta_p, cur_q | delta_q, cur_bit + 2)
	return result

findings = search(p, q, 0)
print(findings)
assert len(findings) > 0

phi = (findings[0][0] - 1) * (findings[0][1] - 1)
d = pow(data["e"], -1, phi)
plaintext = pow(data["c"], d, data["n"])
print(plaintext)
plaintext_bytes = b""
while plaintext > 0:
	plaintext_bytes = bytes([plaintext & 0xff]) + plaintext_bytes
	plaintext >>= 8

print(plaintext_bytes)
