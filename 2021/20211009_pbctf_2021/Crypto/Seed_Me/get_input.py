mvalue = 0xba17a0bd2001
avalue = 0xe5b38f05c800
xor_value = 0x5DEECE66D

seed = 275901075310942

mvalue_inv = pow(mvalue, -1, 1 << 48)
seed_initial = (seed - avalue) * mvalue_inv % (1 << 48)

print(seed_initial ^ xor_value)
