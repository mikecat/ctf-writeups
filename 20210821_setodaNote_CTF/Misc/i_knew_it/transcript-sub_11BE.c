#include <inttypes.h>

void sub_11BE(uint8_t* rdi, uint8_t* rsi, int32_t* rdx_arg, uint8_t* rcx_arg) {
	if (*rdx_arg <= 0) return;
	int32_t* r8 = rdx_arg;
	uint8_t* r9 = rcx_arg;
	int32_t ecx = 0, r11d = 0, r10d = 0;

	/* loc_11E1 */
	do {
		int32_t edx = r10d + 1;
		int32_t eax = edx;
		eax >>= 0x1f;
		eax = (eax & INT32_C(0x7fffffff)) >> 0x18;
		edx += eax;
		edx &= 0xff;
		edx -= eax;
		r10d = edx;
		uint32_t ebx = rdi[edx];
		eax = ebx;
		eax += r11d;
		r11d = eax;
		r11d >>= 0x1f;
		r11d = (r11d & INT32_C(0x7fffffff)) >> 0x18;
		eax += r11d;
		eax &= 0xff;
		eax -= r11d;
		r11d = eax;
		uint32_t r14d = rdi[eax];
		rdi[edx] = r14d;
		rdi[eax] = ebx;
		ebx = (ebx + rdi[edx]) & 0xff;
		eax = rdi[ebx];
		eax ^= rsi[ecx];
		r9[ecx] = eax;
		ecx += 1;
	} while (*r8 > ecx);
}
