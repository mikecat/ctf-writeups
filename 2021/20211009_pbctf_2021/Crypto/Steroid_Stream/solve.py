import sys

challFile = sys.argv[1] if len(sys.argv) > 1 else "data/output.txt"

with open(challFile, "r") as f:
	encoded = f.readline().strip()
	dataStr = f.readline().strip()

data = [[int(e) for e in row.split(", ")] for row in dataStr[2:-2].split("], [")]
dataLen = len(data)

keyIsRight = [None for _ in data]

keyData = []
bitPos = []

for i in range(dataLen):
	if data[i][0] == 0:
		keyIsRight[i] = True
		keyData.append(data[i][1])
	elif data[i][1] == 0:
		keyIsRight[i] = False
		keyData.append(data[i][0])

bitUsed = [1 << i for i in range(len(keyData))]

for i in range(len(keyData)):
	p = None
	maxBit = -1
	for j in range(i, len(keyData)):
		if keyData[j] > 0:
			thisBit = len(bin(keyData[j])) - 2 - 1
			if thisBit > maxBit:
				p = j
				maxBit = thisBit
	if p != i:
		keyData[i], keyData[p] = keyData[p], keyData[i]
		bitUsed[i], bitUsed[p] = bitUsed[p], bitUsed[i]
	for j in range(len(keyData)):
		if i != j and (keyData[j] & (1 << maxBit)):
			keyData[j] ^= keyData[i]
			bitUsed[j] ^= bitUsed[i]
	bitPos.append(maxBit)

def bitCount(n):
	cnt = 0
	while n > 0:
		if n & 1:
			cnt += 1
		n >>= 1
	return cnt

#for k in keyData:
#	print(("%" + str(dataLen + 2) + "s") % bin(k))

found = True
while found:
	found = False
	for i in range(len(data)):
		if keyIsRight[i] is None:
			bits = [0, 0]
			current = [data[i][0], data[i][1]]
			for j in range(len(keyData)):
				mask = 1 << bitPos[j]
				if current[0] & mask:
					current[0] ^= keyData[j]
					bits[0] ^= bitUsed[j]
				if current[1] & mask:
					current[1] ^= keyData[j]
					bits[1] ^= bitUsed[j]
			newKey = None
			newBits = None
			if current[0] == 0 and bitCount(bits[0]) == dataLen // 3:
				keyIsRight[i] = True
				newKey = current[1]
				newBits = (1 << len(keyData)) ^ bits[1]
			elif current[1] == 0 and bitCount(bits[1]) == dataLen // 3:
				keyIsRight[i] = False
				newKey = current[0]
				newBits = (1 << len(keyData)) ^ bits[0]
			if newKey is not None:
				#print(("%" + str(dataLen + 2) + "s") % bin(newKey))
				keyData.append(newKey)
				bitPos.append(len(bin(newKey)) - 2 - 1)
				bitUsed.append(newBits)
				found = True

#print(bitPos)
#print(keyIsRight)

keyStream = "".join(["1" if e else "0" for e in keyIsRight])

keyHex = ""
for i in range(0, len(keyStream), 8):
	keyHex += "%02x" % int(keyStream[i:i+8], 2)

print(keyHex)

decoded = ""
for i in range(0, len(keyHex), 2):
	decoded += chr(int(keyHex[i:i+2], 16) ^ int(encoded[i:i+2], 16))

print(decoded)
