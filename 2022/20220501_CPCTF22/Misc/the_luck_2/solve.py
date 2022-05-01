import z3
import sys
import socket

def getBV(name):
	return z3.BitVec(name, 32)

N = 624
M = 397
MATRIX_A = 0x9908b0df
UPPER_MASK = 0x80000000
LOWER_MASK = 0x7fffffff

mt_vars = [getBV("mt" + str(i)) for i in range(N)]
mt = [v for v in mt_vars]
mti = N

def genrand_int32():
	global mti
	if mti >= N:
		for kk in range(N - M):
			y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK)
			mt[kk] = mt[kk + M] ^ z3.LShR(y, 1) ^ (MATRIX_A * (y & 0x1))
		for kk in range(N - M, N - 1):
			y = (mt[kk] & UPPER_MASK) | (mt[kk + 1] & LOWER_MASK)
			mt[kk] = mt[kk + (M-N)] ^ z3.LShR(y, 1) ^ (MATRIX_A * (y & 0x1))
		y = (mt[N - 1] & UPPER_MASK) | (mt[0] & LOWER_MASK)
		mt[N - 1] = mt[M - 1] ^ z3.LShR(y, 1) ^ (MATRIX_A * (y & 0x1))
		mti = 0
	y = mt[mti]
	mti = mti + 1
	y = y ^ z3.LShR(y, 11)
	y = y ^ ((y << 7) & 0x9d2c5680)
	y = y ^ ((y << 15) & 0xefc60000)
	y = y ^ z3.LShR(y, 18)
	return y

solver = z3.Solver()

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((sys.argv[1], int(sys.argv[2])))

def read_line():
	data = b''
	while True:
		c = sock.recv(1)
		if c[0] == 10:
			return data.decode("UTF-8")
		data += c

for i in range(624):
	sock.send(b"0\ny\n")
	print(read_line()) # Please predict the result: You are wrong!
	res = read_line()  # The result is xxxxxxxxxx!
	print(res)
	print(read_line()) # Do you wanna try again?
	solver.add(genrand_int32() == int(res[14:-1]))
	if i % 50 == 0:
		sys.stderr.write("correcting data... " + str(i + 1) + " / 624\n")

sys.stderr.write("solving...\n")

ans = z3.BitVec("ans", 32)
solver.add(genrand_int32() == ans)

res = solver.check()

if res == z3.sat:
	sys.stderr.write("solved!\n")
	m = solver.model()
	ansValue = m[ans].as_long()
	sock.send((str(ansValue) + "\n").encode("UTF-8"))
	while True:
		print(read_line())
else:
	print(res)
