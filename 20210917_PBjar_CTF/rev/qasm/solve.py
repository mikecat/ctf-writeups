data = [6,34,82,81,107,65,66,47,66,0,54,53,120,70,81,6,40,82,14,22,65,1,10,18,45,85,28,53,47,32,39,32,102,71,57,27,120,65,70,98,23,125,32,74,2,101,104,62,60,55,4,14,89,63,117,100,125]
mod_by = 127

res = ""

sum = 0
for i in range(1, len(data) + 1):
	value = (data[-i] - sum) % mod_by
	c = value * pow(i, -1, mod_by) % mod_by
	res = chr(c) + res
	sum = (sum + value) % mod_by

print(res)
