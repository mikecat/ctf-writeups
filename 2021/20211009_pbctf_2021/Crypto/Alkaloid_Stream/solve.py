import sys

challFile = sys.argv[1] if len(sys.argv) > 1 else "data/output.txt"

with open(challFile, "r") as f:
	encoded = f.readline().strip()
	dataStr = f.readline().strip()

data = [[int(e) for e in row.split(", ")] for row in dataStr[2:-2].split("], [")]
keyNumInFake = len(data) // 3

keyIsRight = [None for _ in data]

keyLog = []
currentFake = 0

found = True
while found:
	found = False
	for i in range(len(data)):
		if keyIsRight[i] is None and (data[i][0] == currentFake or data[i][1] == currentFake):
			newKey = data[i][0] ^ data[i][1] ^ currentFake
			keyIsRight[i] = currentFake == data[i][0]
			keyLog.append(newKey)
			currentFake ^= newKey
			if len(keyLog) > keyNumInFake:
				currentFake ^= keyLog[-(keyNumInFake + 1)]
			found = True

keyStream = "".join(["1" if e else "0" for e in keyIsRight])

keyHex = ""
for i in range(0, len(keyStream), 8):
	keyHex += "%02x" % int(keyStream[i:i+8], 2)

print(keyHex)

decoded = ""
for i in range(0, len(keyHex), 2):
	decoded += chr(int(keyHex[i:i+2], 16) ^ int(encoded[i:i+2], 16))

print(decoded)
