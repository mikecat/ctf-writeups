import sys

# return (x, y) where a*x + b*y = gcd(a, b)
def kago(a, b):
	if b == 0:
		return (1, 0)
	s, t = kago(b, a % b)
	return (t, s - (a // b) * t)

# return x where x === b1 (mod m1), x === b2 (mod m2)
def chuzyo(b1, m1, b2, m2):
	p, q = kago(m1, m2)
	return (b2 * m1 * p + b1 * m2 * q) % (m1 * m2)

# l = [(b1, m1), (b2, m2), ...]
def chuzyo2(l):
	b = 0
	m = 1
	for bb, mm in l:
		b = chuzyo(b, m, bb, mm)
		m *= mm
	return b

def is_prime(n):
	if n < 2:
		return False
	i = 2
	while i * i <= n:
		if n % i == 0:
			return False
		i += 1
	return True

g_str = sys.stdin.readline().rstrip()
assert g_str[0:3] == "g: "
g = int(g_str[3:])
p_str = sys.stdin.readline().rstrip()
assert p_str[0:3] == "p: "
p = int(p_str[3:])
ef_str = sys.stdin.readline().rstrip()
ef_prefix = "encrypted flag: "
assert ef_str[0:len(ef_prefix)] == ef_prefix
ef = int(ef_str[len(ef_prefix):])

data = []
divisor = 100 if len(sys.argv) < 2 else int(sys.argv[1])
prefix = "give me a number> "
while True:
	line = sys.stdin.readline().rstrip()
	if line[0:len(prefix)] != prefix:
		break
	while not is_prime(divisor):
		divisor += 1
	b = 0
	value = pow(int(line[len(prefix):]), divisor, p)
	while value != ef:
		b += 1
		value = (value * g) % p
	data.append((b, divisor))
	divisor += 1

num = chuzyo2(data)
print(hex(num))

result = ""
while num > 0:
	result = chr(num & 0xff) + result
	num >>= 8

print(result)
