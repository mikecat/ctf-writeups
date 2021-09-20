#include <stdio.h>
#include <inttypes.h>

uint64_t mul(uint64_t a, uint64_t b, uint64_t m) {
	uint64_t res = 0;
	if (b == 0) return 0;
	if (a <= UINT64_MAX / b) return a * b % m;
	while (b > 0) {
		if (b & 1) res = res + a - m * (res + a >= m);
		a = a + a - m * (a + a >= m);
		b >>= 1;
	}
	return res;
}

int main(int argc, char* argv[]) {
	uint64_t target;
	uint64_t i;
	if (argc != 2 || sscanf(argv[1], "%" SCNu64, &target) != 1) {
		fprintf(stderr, "Usage: %s target\n", argc > 0 ? argv[0] : "attack");
		return 1;
	}
	#ifdef _OPENMP
	#pragma omp parallel for
	#endif
	for (i = 2; i < target; i++) {
		if (mul(mul(i, i, target), i, target) == 1) {
			#ifdef _OPENMP
			#pragma omp critical
			#endif
			{
				printf("%" PRIu64 "\n", i);
			}
		}
	}
	return 0;
}
