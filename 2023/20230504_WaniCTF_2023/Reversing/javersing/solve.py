data = "Fcn_yDlvaGpj_Logi}eias{iaeAm_s"
res = ["***UNKNOWN***" for _ in data]

for i, c in enumerate(data):
	res[i * 7 % 30] = c

print("".join(res))
