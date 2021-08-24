#include <stdio.h>
#include <stdlib.h>

unsigned long long seed;

int rand_target(void) {
	seed = seed * 0x5851f42d4c957f2dLLU + 1;
	return (int)(seed >> 0x21);
}

int main(int argc, char* argv[]) {
	char keyfile[] = "mikenekomofumofu";
	unsigned long long seed_start;
	int i, j;
	char* end;
	if (argc < 2) return 1;
	seed_start = strtoull(argv[1], &end, 0);
	for (i = 0; i < 1000000; i++) {
		seed = (unsigned int)(seed_start * 1000000 + i) - 1;
		for (j = 0; j < 16; j++) {
			printf("%02x", (rand_target() & 0xff) ^ keyfile[j]);
		}
		putchar(' ');
		for (j = 0; j < 16; j++) {
			printf("%02x", rand_target() & 0xff);
		}
		putchar('\n');
	}
	return 0;
}
