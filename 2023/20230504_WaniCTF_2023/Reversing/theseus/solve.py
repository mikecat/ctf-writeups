data = "FLAGmlEAfh.i`,f_N)r?W^c$kx"

def put(idx, char):
	global data
	data = data[:idx] + char + data[idx+1:]

for i in range(0x1a):
	offset = i * 0xb % 0xf if i > 3 else 0
	put(i, chr(ord(data[i]) + offset))

print(data)
