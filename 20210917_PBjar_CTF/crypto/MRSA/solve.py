n = 37883362285621717817648802184202062652809417688523484794085024858731349219741059316667101586086544432111047890789263
e = 65537
ct = 24130613897339537577140515623841231907980081287828362098646642619142127457370021858488470641518167561758047989368704

p = 115410823874954063063510612045946093140915066546157134514387762753920740312601

q = n // p
phi = (p - 1) * (q - 1)

d = pow(e, -1, phi)
res = pow(ct, d, n)

print(res)

res2 = ""
while res > 0:
	res2 = chr(res & 0xff) + res2
	res >>= 8

print(res2)