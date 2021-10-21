b = 0x5DEECE66D
c = 0xB

rounds = 0o3777 + 1

sum = 0
for i in range(rounds):
	sum += b ** i

print("sum of the sequence = " + hex((sum * c) & ((1 << 48) - 1)))
print("b^n = " + hex(pow(b, rounds, 1 << 48)))
