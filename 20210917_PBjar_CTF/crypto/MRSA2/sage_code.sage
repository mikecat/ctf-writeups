import sys
import time

start_time = time.time()

add_bits = 0
start = None
end = None

if len(sys.argv) > 1: add_bits = int(sys.argv[1])
if len(sys.argv) > 2: start = int(sys.argv[2])
if len(sys.argv) > 3: end = int(sys.argv[3])

def partial_p(p0, kbits, n):
    PR.<x> = PolynomialRing(Zmod(n))
    nbits = n.nbits()

    f = 2^kbits*x + p0
    f = f.monic()
    roots = f.small_roots(X=2^(nbits//2-kbits+1), beta=0.3)  # find root < 2^(nbits//2-kbits+1) with factor >= n^0.3
    if roots:
        x0 = roots[0]
        p = gcd(2^kbits*x0 + p0, n)
        return ZZ(p)

def find_p(d0, kbits, e, n, block_cur, block_all):
    X = var('X')

    global start_time
    for k in range(1, e+1):
        results = solve_mod([e*d0*X - k*X*(n-X+1) + k*n == X], 2^kbits)
        for x in results:
            p0 = ZZ(x[0])
            p = partial_p(p0, kbits, n)
            if p:
                return p
        if k % 1 == 0:
            cur_time = time.time()
            elapsed = (cur_time - start_time) / 60
            cur = e * block_cur + k
            all = e * block_all
            print("k = %d (%d/%d) elapsed: %d min. estimated left: %d min." % (k, cur, all, int(elapsed), int(elapsed * (all - cur) / cur)))


if __name__ == '__main__':
    n = 9772226531969686207819247374114719303803618863134142326085221682005263468005580908315437419891898127379693763792876584687800394851062094511331012685480583
    e = 257
    d0 = 685280199936613714337854250650544307231289

    if start is None: start = 0
    if end is None: end = 1 << add_bits

    nbits = n.nbits()
    kbits = 139
    print("lower %d bits (of %d bits) is given" % (kbits, nbits))

    for add_bit in range(start, end):
        p = find_p(d0 | (add_bit << kbits), kbits + add_bits, e, n, add_bit - start, end - start)
        if p is not None:
            print("found p: %d" % p)
            q = n//p
            print("q = %d" % q)
            print("d = %d" % inverse_mod(e, (p-1)*(q-1)))
            sys.exit(0)
    print("not found")
