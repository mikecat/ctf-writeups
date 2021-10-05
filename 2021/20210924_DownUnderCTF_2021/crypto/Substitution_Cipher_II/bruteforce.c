#include <stdio.h>
#include <string.h>

#ifndef CHARSET_SIZE
#define CHARSET_SIZE 47
#endif
#ifndef TEXT_SIZE
#define TEXT_SIZE 7
#endif
#ifndef CHECK_SIZE
#define CHECK_SIZE TEXT_SIZE
#endif

const char* CHARSET = "DUCTF{}_!?'abcdefghijklmnopqrstuvwxyz0123456789";
const char* pt = "DUCTF{}";
const char* ct = "Ujyw5d4";

int pos(char c) {
	return strchr(CHARSET, c) - CHARSET;
}

int coeffs[TEXT_SIZE][TEXT_SIZE];
int targets[TEXT_SIZE];

void search(int* arr, int pos) {
	int i;
	if (pos >= TEXT_SIZE) {
		int j;
		for(i = 0; i < CHECK_SIZE; i++) {
			int sum = 0;
			for (j = 0; j < TEXT_SIZE; j++) {
				sum += coeffs[i][j] * arr[j];
			}
			if(sum % CHARSET_SIZE != targets[i]) return;
		}
		#ifdef _OPENMP
		#pragma omp critical
		#endif
		{
			printf("[%d", arr[0]);
			for (i = 1; i < TEXT_SIZE; i++) {
				printf(", %d", arr[i]);
			}
			puts("]");
			fflush(stdout);
		}
	} else {
		for (i = 0; i < CHARSET_SIZE; i++) {
			arr[pos] = i;
			search(arr, pos + 1);
		}
	}
}

int main(void) {
	int i, j, k;
	for (i = 0; i < TEXT_SIZE; i++) {
		int p = pos(pt[i]);
		coeffs[i][0] = 1;
		for (j = 1; j < TEXT_SIZE; j++) {
			coeffs[i][j] = (coeffs[i][j - 1] * p) % CHARSET_SIZE;
		}
		targets[i] = pos(ct[i]);
	}

	#ifdef _OPENMP
	#pragma omp parallel for collapse(3)
	#endif
	for (i = 0; i < CHARSET_SIZE; i++) {
		for (j = 0; j < CHARSET_SIZE; j++) {
			for (k = 0; k < CHARSET_SIZE; k++) {
				int ans[TEXT_SIZE];
				ans[0] = i;
				ans[1] = j;
				ans[2] = k;
				search(ans, 3);
			}
		}
	}

	return 0;
}
