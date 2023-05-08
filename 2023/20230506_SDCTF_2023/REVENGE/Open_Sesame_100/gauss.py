MOD = 131
FLAG_LEN = 36
DOOR_SHAPE = [94, 68, 98, 110, 45, 81, 6, 76, 119, 53, 16, 19, 122, 91, 51, 44,
	13, 35, 2, 124, 83, 101, 75, 122, 75, 124, 37, 8, 127, 0, 22, 130,
	11, 42, 114, 19]

def gencave(flaglen):
	cave = []
	ps = []
	i = 1
	while len(cave) <= flaglen:
		i += 1
		skip = False
		for p in ps:
			if i % p == 0:
				skip = True
		if skip:
			pass
		else:
			ps.append(i)
			if not cave or len(cave[-1]) >= flaglen:
				cave.append([])
			cave[-1].append(i % MOD)
	cave = cave[:-1]
	return cave

mat = gencave(FLAG_LEN)
vec = [e for e in DOOR_SHAPE]

for i in range(FLAG_LEN):
	m = pow(mat[i][i], -1, MOD)
	for j in range(FLAG_LEN):
		mat[i][j] = mat[i][j] * m % MOD
	vec[i] = vec[i] * m % MOD
	for j in range(i + 1, FLAG_LEN):
		m2 = mat[j][i]
		for k in range(FLAG_LEN):
			mat[j][k] = (mat[j][k] - m2 * mat[i][k]) % MOD
		vec[j] = (vec[j] - m2 * vec[i]) % MOD

for i in range(FLAG_LEN - 1, -1, -1):
	for j in range(i):
		m = mat[j][i]
		for k in range(FLAG_LEN):
			mat[j][k] = (mat[j][k] - m * mat[i][k]) % MOD
		vec[j] = (vec[j] - m * vec[i]) % MOD

# print(mat)
print(vec)
print(bytes(vec))
