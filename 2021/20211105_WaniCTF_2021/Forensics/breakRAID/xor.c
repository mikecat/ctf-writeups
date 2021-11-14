#include <stdio.h>

#define BLOCK_SIZE 4096

int main(int argc, char* argv[]) {
	FILE *in1, *in2, *out;
	if (argc < 4) {
		fprintf(stderr, "Usage: %s in1 in2 out\n", argc > 0 ? argv[0] : "xor");
		return 1;
	}
	in1 = fopen(argv[1], "rb");
	if (in1 == NULL) {
		fprintf(stderr, "failed to open %s\n", argv[1]);
		return 1;
	}
	in2 = fopen(argv[2], "rb");
	if (in2 == NULL) {
		fclose(in1);
		fprintf(stderr, "failed to open %s\n", argv[2]);
		return 1;
	}
	out = fopen(argv[3], "wb");
	if (out == NULL) {
		fclose(in1);
		fclose(in2);
		fprintf(stderr, "failed to open %s\n", argv[3]);
		return 1;
	}
	for (;;) {
		char a[BLOCK_SIZE], b[BLOCK_SIZE], c[BLOCK_SIZE];
		size_t as, bs, cs, i;
		as = fread(a, 1, BLOCK_SIZE, in1);
		bs = fread(b, 1, BLOCK_SIZE, in2);
		cs = as < bs ? as : bs;
		if (cs == 0) break;
		for (i = 0; i < cs; i++) c[i] = a[i] ^ b[i];
		fwrite(c, 1, cs, out);
	}
	fclose(in1);
	fclose(in2);
	fclose(out);
	return 0;
}
