#include <stdio.h>
#include <stdlib.h>

int main(int argc, char* argv[]) {
	int seed;
	int value;
	if (argc < 2) {
		fprintf(stderr, "Usage: %s seed\n", argc > 0 ? argv[0] : "solve");
		return 1;
	}
	seed = atoi(argv[1]);
	srand(seed);
	rand();
	printf("question_two: %d\n", rand());
	srand(seed);
	srand(value = rand());
	printf("question_three: %d\n", value / rand() % 1000);
	return 0;
}
