#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
	int t = time(NULL);
	int i;
	for (i = 0; i < 20; i++) {
		srand(t + i);
		printf("%d %d\n", t + i, rand());
	}
	return 0;
}
