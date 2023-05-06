#include <stdio.h>

#define MOD_BY 1000000007

int add(int a, int b) {
	return a + b - MOD_BY * (a + b >= MOD_BY);
}

#define MAX_NUM_ELEMS 1024
#define MAX_ELEMENT 1000

/* xor may make result more than MAX_ELEMENT */
#define ELEMENT_MEMO_MAX 1024

int f(int a) {
	int alt = MAX_ELEMENT - a;
	return a <= alt ? a : alt;
}

int N = 0;
int a[MAX_NUM_ELEMS];

int min_memo[MAX_NUM_ELEMS][ELEMENT_MEMO_MAX + 1];

int get_min(int pos, int acc) {
	int ans, candidate;
	if (pos >= N) return acc;
	if (min_memo[pos][acc]) return ~min_memo[pos][acc];
	ans = get_min(pos + 1, acc ^ a[pos]);
	candidate = get_min(pos + 1, acc ^ f(a[pos]));
	if (candidate < ans) ans = candidate;
	return ~(min_memo[pos][acc] = ~ans);
}

int min_value;

int count_memo[MAX_NUM_ELEMS][ELEMENT_MEMO_MAX + 1];

int get_count(int pos, int acc) {
	int ans;
	int operated;
	if (pos >= N) return acc == min_value;
	if (count_memo[pos][acc]) return ~count_memo[pos][acc];
	ans = get_count(pos + 1, acc ^ a[pos]);
	operated = f(a[pos]);
	if (a[pos] != operated) {
		ans = add(ans, get_count(pos + 1, acc ^ operated));
	}
	return ~(count_memo[pos][acc] = ~ans);
}

int main(void) {
	while (N < MAX_NUM_ELEMS) {
		int res = scanf("%d", &a[N]);
		if (res < 0) break;
		if (res != 1 || a[N] < 0 || MAX_ELEMENT < a[N]) {
			puts("invalid input");
			return 1;
		}
		N++;
	}
	min_value = get_min(0, 0);
	printf("N = %d\n", N);
	printf("min = %d\n", min_value);
	printf("count = %d\n", get_count(0, 0));
	return 0;
}
