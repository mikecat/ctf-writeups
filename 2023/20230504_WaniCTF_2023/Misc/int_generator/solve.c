#include <stdio.h>
#include <inttypes.h>

struct pair {
	int64_t a, b;
};

static const int k = 36;
static const int maxlength = 16;

static int64_t mulmod(int64_t a, int64_t b, int64_t m) {
	__asm__ __volatile__(
		"imul %1\n\t"
		"idiv %2\n\t"
		"movq %%rdx, %%rax\n\t"
	: "+a"(a)
	: "S"(b), "c"(m)
	: "%rdx");
	if (a < 0) a += m;
	return a;
}

static int64_t muldiv(int64_t a, int64_t b, int64_t d) {
	int64_t r;
	__asm__ __volatile__(
		"imul %2\n\t"
		"idiv %3\n\t"
	: "+a"(a), "=d"(r)
	: "S"(b), "c"(d)
	: );
	if (r < 0) a--;
	return a;
}

static int64_t mod(int64_t a, int64_t b) {
	__asm__ __volatile__(
		"cqo\n\t"
		"idiv %1\n\t"
		"movq %%rdx, %%rax\n\t"
	: "+a"(a)
	: "S"(b)
	: "%rdx");
	if (a < 0) a += b;
	return a;
}

static int64_t div(int64_t a, int64_t b) {
	int64_t r;
	__asm__ __volatile__(
		"cqo\n\t"
		"idiv %2\n\t"
	: "+a"(a), "=d"(r)
	: "S"(b)
	: );
	if (r < 0) a--;
	return a;
}

static int64_t pou(int64_t a, int64_t b, int64_t m) {
	int64_t r = 1;
	while (b > 0) {
		if (b & 1) r = mulmod(r, a, m);
		a = mulmod(a, a, m);
		b >>= 1;
	}
	return r;
}

static struct pair f(int64_t x, int64_t cnt) {
	cnt += 1;
	int64_t r = INT64_C(1) << k;
	if (x == 0 || x == r) {
		return (struct pair){-x, cnt};
	}
	if (mulmod(x, x, r) != 0) {
		return (struct pair){-x, cnt};
	} else {
		return (struct pair){muldiv(-x, x - r, r), cnt};
	}
}

static struct pair g(int64_t x) {
	int64_t ret = x * 2 + div(x, 3) * 10 - div(x, 5) * 10 + div(x, 7) * 10;
	ret = ret - mod(ret, 2) + 1;
	return (struct pair){ret, mod(div(x, 100), 100)};
}

static int64_t digit(int64_t x) {
	int64_t cnt = 0;
	while (x > 0) {
		cnt += 1;
		x /= 10; /* don't need to use div() because x > 0 */
	}
	return cnt;
}

static int64_t pad(int64_t x, int64_t cnt) {
	int minus = 0;
	if (x < 0) {
		minus = 1;
		struct pair p = g(-x);
		x = p.a;
		cnt = p.b;
	}
	int64_t sub = maxlength - digit(x);
	int64_t ret = x;
	int64_t end = sub - digit(cnt);
	for (int64_t i = 0; i < end; i++) {
		ret *= 10;
		if (minus) {
			ret += pou(mod(x, 10), mod(x, 10) * i, 10);
		} else {
			ret += pou(i % 10 - i % 2, i % 10 - i % 2 + 1, 10); /* i >= 0 */
		}
	}
	ret += cnt * pou(10, maxlength - digit(cnt), INT64_MAX);
	return ret;
}

int64_t int_generator(int64_t x) {
	int64_t ret = -x;
	struct pair p = f(x, 0);
	int64_t x_ = p.a, cnt = p.b;
	while (x_ > 0) {
		ret = x_;
		p = f(x_, cnt);
		x_ = p.a;
		cnt = p.b;
	}
	return pad(ret, cnt);
}

#ifdef TEST_MODE
int main(int argc, char* argv[]) {
	for (int i = 1; i < argc; i++) {
		int64_t num;
		if (sscanf(argv[i], "%" SCNd64, &num) == 1) {
			printf("int_generator(%" PRId64 ") = %" PRId64 "\n", num, int_generator(num));
		}
	}
	return 0;
}
#else
int main(int argc, char* argv[]) {
	int64_t targets[] = {
		INT64_C(3438959214151555), /* int_generator(818143497) */
		INT64_C(1008844668800884),
		INT64_C(2264663430088446),
		INT64_C(6772814078400884)
	};
	int end = 35;
	if (argc > 1) sscanf(argv[1], "%d", &end);
	if (end < 0 || 64 <= end) {
		fprintf(stderr, "invalid value of end: %d\n", end);
		return 1;
	}
	int64_t max = INT64_C(1) << end;
	#pragma omp parallel for schedule(dynamic)
	for (int64_t i = 0; i <= max; i++) {
		int64_t ret = int_generator(i);
		for (int j = 0; j < (int)(sizeof(targets) / sizeof(*targets)); j++) {
			if (ret == targets[j]) {
				#pragma omp critical
				{
					printf("int_generator(%" PRId64 ") = %" PRId64 "\n", i, ret);
				}
			}
		}
	}
	return 0;
}
#endif
