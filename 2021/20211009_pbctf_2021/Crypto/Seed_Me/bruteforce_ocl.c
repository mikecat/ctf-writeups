#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <sys/time.h>
#include "CL/cl.h"

#define NUM_BITS_ALL 48
#define NUM_BITS_LOW 24
#define HIGH_TARGET 16444268
#define NUM_DROP 03777
#define DEFAULT_ROUNDS 15

#define STR2(x) #x
#define STR(x) STR2(x)

const char* kernel_source = 
"__kernel void calcNext(__global ulong* answers, __global int* answerCount, int num, int rounds, ulong start) {\n"
"  int id = get_global_id(0);\n"
"  ulong current = start + id;\n"
"  int yes = 1;\n"
"  if (id == 0) {\n"
"    *answerCount = 0;\n"
"  }\n"
"  barrier(CLK_GLOBAL_MEM_FENCE);\n"
"  for (int r = 0; r < rounds; r++) {\n"
"    current = (current * 0xba17a0bd2001lu + 0xe5b38f05c800lu) & ((1lu << 48) - 1);\n"
"    if ((current >> " STR(NUM_BITS_LOW) ") < " STR(HIGH_TARGET) ") yes = 0;\n"
"  }\n"
"  if (yes) {\n"
"    int writeid = atomic_add(answerCount, 1);\n"
"    answers[writeid * 2] = start + id;\n"
"    answers[writeid * 2 + 1] = current;\n"
"  }\n"
"  barrier(CLK_GLOBAL_MEM_FENCE);\n"
"}\n";

static int64_t time_diff(const struct timeval *tv1, const struct timeval* tv2) {
	int64_t res = (int64_t)tv1->tv_sec - (int64_t)tv2->tv_sec;
	return res * 1000000 + ((int64_t)tv1->tv_usec - (int64_t)tv2->tv_usec);
}

static void print_time(FILE* fp, uint64_t t) {
	uint64_t s = t % (60 * UINT64_C(1000000));
	uint64_t m = t / (60 * UINT64_C(1000000));
	uint64_t h = m / 60;
	m %= 60;
	if (h > 0) fprintf(fp, "%2" PRIu64 " h ", h);
	if (h > 0 || m > 0) fprintf(fp, "%2" PRIu64 " m ", m);
	fprintf(fp, "%2" PRIu64 ".%06" PRIu64 " s", s / UINT64_C(1000000), s % UINT64_C(1000000));
}

int calc_main(cl_platform_id platform, cl_device_id device, cl_context context,
int argc, char* argv[]) {
	unsigned long long i, j;
	unsigned long long* results, *alt_results;
	size_t resultSize = sizeof(*results) * (1 << NUM_BITS_LOW) * 2;
	int resultCountBuf[2], *resultCount = resultCountBuf, *alt_resultCount = resultCountBuf + 1;
	int num = NUM_DROP + 1, rounds = DEFAULT_ROUNDS;
	unsigned long long start = HIGH_TARGET, end = (1ull << (NUM_BITS_ALL - NUM_BITS_LOW));
	struct timeval start_time, current_time;
	int start_time_valid, current_time_valid;

	cl_command_queue queue;
	cl_program program;
	cl_kernel kernel;
	cl_int error;
	cl_mem cl_results, cl_resultCount;
	size_t local_size = 1;
	size_t global_size = 1 << NUM_BITS_LOW;

	char* ep;
	if (argc > 0) rounds = atoi(argv[0]);
	if (argc > 1) start = strtoull(argv[1], &ep, 10);
	if (argc > 2) end = strtoull(argv[2], &ep, 10);

	fprintf(stderr, "set to %d rounds\n", rounds);
	fprintf(stderr, "search for [%" PRIu64 ", %" PRIu64 ")\n", start ,end);

#ifdef CL_VERSION_2_0
	queue = clCreateCommandQueueWithProperties(context, device, NULL, &error);
#else
	queue = clCreateCommandQueue(context, device, 0, &error);
#endif
	if (error != CL_SUCCESS) {
		fprintf(stderr, "clCreateCommandQueue failed: %d\n", (int)error);
		return 1;
	}

	program = clCreateProgramWithSource(context, 1, &kernel_source, NULL, &error);
	if (error != CL_SUCCESS) {
		fprintf(stderr, "clCreateProgramWithSource failed: %d\n", (int)error);
		clReleaseCommandQueue(queue);
		return 1;
	}

	if ((error = clBuildProgram(program, 1, &device, "-w", NULL, NULL)) != CL_SUCCESS) {
		fprintf(stderr, "clBuildProgram failed: %d\n", (int)error);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		return 1;
	}

	kernel = clCreateKernel(program, "calcNext", &error);
	if (error != CL_SUCCESS) {
		fprintf(stderr, "clCreateKernel failed: %d\n", (int)error);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		return 1;
	}

	results = malloc(resultSize);
	if (results == NULL) {
		perror("malloc(results)");
		clReleaseKernel(kernel);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		return 1;
	}

	alt_results = malloc(resultSize);
	if (alt_results == NULL) {
		perror("malloc(alt_results)");
		clReleaseKernel(kernel);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		free(results);
		return 1;
	}

	cl_results = clCreateBuffer(context, CL_MEM_WRITE_ONLY, resultSize, NULL, &error);
	if (error != CL_SUCCESS) {
		fprintf(stderr, "clCreateBuffer for cl_results failed: %d\n", (int)error);
		clReleaseKernel(kernel);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		free(results);
		free(alt_results);
		return 1;
	}

	cl_resultCount = clCreateBuffer(context, CL_MEM_WRITE_ONLY, sizeof(int), NULL, &error);
	if (error != CL_SUCCESS) {
		fprintf(stderr, "clCreateBuffer for cl_results failed: %d\n", (int)error);
		clReleaseMemObject(cl_results);
		clReleaseKernel(kernel);
		clReleaseProgram(program);
		clReleaseCommandQueue(queue);
		free(results);
		free(alt_results);
		return 1;
	}

#define CALL_AND_CHECK(name, func) \
	if ((error = func) != CL_SUCCESS) { \
		fprintf(stderr, name " failed: %d\n", (int)error); \
		clReleaseMemObject(cl_results); \
		clReleaseMemObject(cl_resultCount); \
		clReleaseKernel(kernel); \
		clReleaseProgram(program); \
		clReleaseCommandQueue(queue); \
		free(results); \
		free(alt_results); \
		return 1; \
	}

	CALL_AND_CHECK("clSetKernelArg (0)",
		clSetKernelArg(kernel, 0, sizeof(cl_results), &cl_results))
	CALL_AND_CHECK("clSetKernelArg (1)",
		clSetKernelArg(kernel, 1, sizeof(cl_resultCount), &cl_resultCount))
	CALL_AND_CHECK("clSetKernelArg (2)",
		clSetKernelArg(kernel, 2, sizeof(num), &num))
	CALL_AND_CHECK("clSetKernelArg (3)",
		clSetKernelArg(kernel, 3, sizeof(rounds), &rounds))

	start_time_valid = gettimeofday(&start_time, NULL) == 0;
	for (i = start; i <= end; i++) {
		/* if there is some work left, run the work */
		unsigned long long firstNumberInGroup;
		if (i < end) {
			firstNumberInGroup = i << NUM_BITS_LOW;
			CALL_AND_CHECK("clSetKernelArg (4)",
				clSetKernelArg(kernel, 4, sizeof(firstNumberInGroup), &firstNumberInGroup))
			CALL_AND_CHECK("clEnqueueNDRangeKernel",
				clEnqueueNDRangeKernel(queue, kernel, 1, NULL, &global_size, &local_size, 0, NULL, NULL))
			CALL_AND_CHECK("clEnqueueReadBuffer (cl_results)",
				clEnqueueReadBuffer(queue, cl_results, CL_TRUE, 0, resultSize, results, 0, NULL, NULL))
			CALL_AND_CHECK("clEnqueueReadBuffer (cl_resultCount)",
				clEnqueueReadBuffer(queue, cl_resultCount, CL_TRUE, 0, sizeof(int), resultCount, 0, NULL, NULL))
		}
		/* while current work is running, finalize previous work */
		if (i > start) {
			for (j = 0; j < *alt_resultCount; j++) {
				printf("%" PRIu64 "\t%" PRIu64 "\n", (uint64_t)alt_results[j * 2], (uint64_t)alt_results[j * 2 + 1]);
			}
			fflush(stdout);
			if (i % 100 == 0 || i == end) {
				current_time_valid = gettimeofday(&current_time, NULL) == 0;
				if (start_time_valid && current_time_valid) {
					int64_t elapsed = time_diff(&current_time, &start_time);
					int64_t estimated = elapsed * ((1ull << (NUM_BITS_ALL - NUM_BITS_LOW)) - HIGH_TARGET) / (i - HIGH_TARGET);
					fprintf(stderr, "i = %8" PRIu64 " / ", (uint64_t)i);
					fprintf(stderr, "Elapsed time: "); print_time(stderr, elapsed);
					fprintf(stderr, " / Estimated time left: "); print_time(stderr, estimated - elapsed); fputc('\n', stderr);
					fflush(stderr);
				}
			}
		}
		if (i < end) {
			/* wait until current work is done and proceed to the next work */
			unsigned long long* tmp_results;
			int* tmp_resultCount;
			CALL_AND_CHECK("clFinish", clFinish(queue))
			tmp_results = results;
			results = alt_results;
			alt_results = tmp_results;
			tmp_resultCount = resultCount;
			resultCount = alt_resultCount;
			alt_resultCount = tmp_resultCount;
		}
	}

	clReleaseMemObject(cl_results);
	clReleaseMemObject(cl_resultCount);
	clReleaseKernel(kernel);
	clReleaseProgram(program);
	clReleaseCommandQueue(queue);
	free(results);
	free(alt_results);
	return 0;
}
