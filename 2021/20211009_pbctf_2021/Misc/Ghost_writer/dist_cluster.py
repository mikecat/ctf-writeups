import sys

distFile = sys.argv[1] if len(sys.argv) > 1 else "dists.txt"
dists = [[float(elem) for elem in e.rstrip().split("\t")] for e in open(distFile, "r").readlines()]

threshold = float(sys.argv[2]) if len(sys.argv) > 2 else 2000.0

uf = [-1 for _ in dists]

def uf_root(node):
	if uf[node] < 0:
		return node
	uf[node] = uf_root(uf[node])
	return uf[node]

def uf_size(node):
	return -uf[uf_root(node)]

def uf_merge(a, b):
	ar = uf_root(a)
	br = uf_root(b)
	if ar != br:
		asz = uf_size(ar)
		bsz = uf_size(br)
		if asz >= bsz:
			uf[ar] += uf[br]
			uf[br] = ar
		else:
			uf[br] += uf[ar]
			uf[ar] = br

for i in range(len(dists)):
	for j in range(len(dists[i])):
		if dists[i][j] < threshold:
			uf_merge(i, j)

groupData = {}
groupCount = 0
res = []

for i in range(len(dists)):
	r = uf_root(i)
	if r not in groupData:
		groupData[r] = groupCount
		groupCount += 1
	res.append(groupData[r])

print("count = " + str(groupCount))
print(res)

if groupCount <= 27:
	chars = "abcdefghijklmnopqrstuvwxyz7"
	print("".join([chars[c] for c in res]))
