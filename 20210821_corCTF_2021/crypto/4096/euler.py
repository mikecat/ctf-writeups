import sys

data = [int(line.rstrip()) for line in sys.stdin.readlines()]

multed = 1

for d in data:
	multed *= d

euler = 1

for d in data:
	euler *= (d - 1)

print(euler)
