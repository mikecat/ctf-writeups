import sys

nums = [int(x.rstrip(), 0) for x in sys.stdin.readlines()]

def gcd(a, b):
	while b > 0:
		a, b = b, a % b
	return a

for i in range(len(nums)):
	for j in range(i + 1, len(nums)):
		g = gcd(nums[i], nums[j])
		if g > 1:
			print("%d\t%d\t%d" % (i, j, g))
