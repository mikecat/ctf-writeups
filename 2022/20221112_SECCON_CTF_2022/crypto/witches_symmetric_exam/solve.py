import sys
import socket
import datetime

password = "give me key"

if len(sys.argv) != 3:
	sys.stderr.write("Usage: solve.py host port\n")
	sys.exit(1)

def showProgress(message):
	print(datetime.datetime.now().strftime("[%Y-%m-%d %H:%M:%S] ") + message)

showProgress("program start")

sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.connect((sys.argv[1], int(sys.argv[2])))
showProgress("connected")

sockbuf = b""
def getLineFromServer():
	global sockbuf
	while True:
		idx = sockbuf.find(b"\n")
		if idx >= 0:
			res = sockbuf[0:idx]
			sockbuf = sockbuf[idx + 1:]
			return res.decode()
		received = sock.recv(4096)
		if received == b"":
			showProgress("receive error")
			sys.exit(1)
		sockbuf += received

def sendLineToServer(line):
	sock.send((line + "\n").encode())

firstCipherTextKey = "ciphertext: "
firstCipherTextLine = getLineFromServer()
assert firstCipherTextLine[0:len(firstCipherTextKey)] == firstCipherTextKey
firstCipherText = firstCipherTextLine[len(firstCipherTextKey):]
showProgress("retrieved firstCipherText")

ofb_iv = firstCipherText[0:32]
secretSpellOfbEncrypted = firstCipherText[32:]
assert len(secretSpellOfbEncrypted) % 32 == 0

def arrayToHex(arr):
	return "".join(["%02x" % e for e in arr])

def xorHex(a, b):
	return (b"".join([bytes((x ^ y,)) for x, y in zip(bytes.fromhex(a), bytes.fromhex(b))])).hex()

encryptCache = {}
def encryptBlock(block):
	if block in encryptCache:
		return encryptCache[block]
	queryPrefix = block
	queryArray = [0 for _ in range(16)]
	resultArray = [0 for _ in range(16)]
	# determine last byte (not that both of ....01 and ..0202 are valid)
	lastByteCandidates = []
	for i in range(256):
		queryArray[15] = i
		sendLineToServer(queryPrefix + arrayToHex(queryArray))
		res = getLineFromServer()
		if "ofb" not in res:
			lastByteCandidates.append(i)
	queryArray[14] = 1
	lastByte = None
	for b in lastByteCandidates:
		queryArray[15] = b
		sendLineToServer(queryPrefix + arrayToHex(queryArray))
		res = getLineFromServer()
		if "ofb" not in res:
			lastByte = b
			break
	assert lastByte is not None
	resultArray[15] = lastByte ^ 1
	# determine remaining bytes
	for i in range(1, 16):
		for j in range(16 - i, 16):
			queryArray[j] = (i + 1) ^ resultArray[j]
		resultByte = None
		for j in range(256):
			queryArray[15 - i] = j
			sendLineToServer(queryPrefix + arrayToHex(queryArray))
			res = getLineFromServer()
			if "ofb" not in res:
				resultByte = j
				break
		assert resultByte is not None
		resultArray[15 - i] = resultByte ^ (i + 1)
	result = arrayToHex(resultArray)
	encryptCache[block] = result
	return result

showProgress("decrypting OFB for secret spell")
currentBlock = ofb_iv
ofbKeyStream = ""
secretSpellNumBlocks = len(secretSpellOfbEncrypted) // 32
secretSpellGcmEncrypted = ""
for i in range(secretSpellNumBlocks):
	currentBlock = encryptBlock(currentBlock)
	ofbKeyStream += currentBlock
	secretSpellGcmEncrypted += xorHex(currentBlock, secretSpellOfbEncrypted[32*i:32*(i+1)])
	showProgress("decrypting OFB for secret spell: %d/%d" % (i + 1, secretSpellNumBlocks))

secretSpellGcmTag = secretSpellGcmEncrypted[0:32]
gcmNonce = secretSpellGcmEncrypted[32:64]
secretSpellGcmCipherText = secretSpellGcmEncrypted[64:]

showProgress("calculating H for GCM")
H = encryptBlock("0" * 32)
Hint = int(H, 16)
showProgress("calculated H for GCM")

nakaguroMagic = 0xe1 << 120
def nakaguro(a, b):
	res = 0
	for i in range(127, -1, -1):
		if ((b >> i) & 1) != 0:
			res ^= a
		delta = nakaguroMagic if (a & 1) != 0 else 0
		a = (a >> 1) ^ delta
	return res

def GHASH(hexString):
	y = 0
	for i in range(0, len(hexString), 32):
		x = int(hexString[i:i+32], 16)
		y = nakaguro(y ^ x, Hint)
	return "%032x" % y

if len(gcmNonce) == 24:
	J0 = gcmNonce + "00000001"
else:
	s = 32 * ((len(gcmNonce) + 31) // 32) - len(gcmNonce)
	J0 = GHASH(gcmNonce + ("0" * (s + 16)) + ("%016x" % (4 * len(gcmNonce))))

def inc32(block):
	return block[0:24] + ("%08x" % ((int(block[24:], 16) + 1) & 0xffffffff))

def GCTR(ICB, X):
	CB = ICB
	res = ""
	for i in range(0, len(X), 32):
		pt = X[i:i+32]
		res += xorHex(encryptBlock(CB), pt)
		CB = inc32(CB)
		showProgress("performing GCTR %d/%d" % (i // 32 + 1, (len(X) + 31) // 32))
	return res

def gcmEncrypt(A, P):
	C = GCTR(inc32(J0), P)
	u = 32 * ((len(C) + 31) // 32) - len(C)
	v = 32 * ((len(A) + 31) // 32) - len(A)
	S = GHASH(A + ("0" * v) + C + ("0" * u) + ("%016x%016x" % (4 * len(A), 4 * len(C))))
	T = GCTR(J0, S)
	return (C, T)

padLength = 2 * int(secretSpellGcmCipherText[-2:], 16)
gcmKeyStream, _ = gcmEncrypt("", "0" * (len(secretSpellGcmCipherText) - padLength))
secretSpell = xorHex(secretSpellGcmCipherText, gcmKeyStream)
showProgress("found the secret spell! : " + str(bytes.fromhex(secretSpell)))
secretSpellString = bytes.fromhex(secretSpell).decode()

passwordEncrypted, passwordTag = gcmEncrypt("", password.encode().hex())

passwordOfbPlainText = passwordTag + gcmNonce + passwordEncrypted
passwordPadLength = 16 - (len(passwordOfbPlainText) // 2) % 16
passwordOfbPlainText += ("%02x" % passwordPadLength) * passwordPadLength

while len(ofbKeyStream) < len(passwordOfbPlainText):
	showProgress("extending ofbKeyStream: %d/%d" % (len(ofbKeyStream) < len(passwordOfbPlainText)))
	ofbKeyStream += encryptBlock(ofbKeyStream[-32:])

passwordOfbCipherText = ofb_iv + xorHex(passwordOfbPlainText, ofbKeyStream)

showProgress("sending encrypted password and the secret spell")
sendLineToServer(passwordOfbCipherText)
sendLineToServer(secretSpellString)
showProgress("response from the server: " + getLineFromServer())

showProgress("program end")
