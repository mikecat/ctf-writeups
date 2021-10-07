import hashlib
import sha3


prefix = "https://EVILCODE/"

chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
charnum = len(chars)

def get_str(n):
	res = ""
	while True:
		res += chars[n % charnum]
		n //= charnum
		if n <= 0:
			return res

i = 0
while True:
	str = prefix + get_str(i)
	hash = hashlib.sha3_512(str.encode())
	if hash.digest()[0] == 0x00:
		print(str)
		print(hash.hexdigest())
		break
	i += 1
	if i % 10000 == 0:
		print("searching..." + str(i))
