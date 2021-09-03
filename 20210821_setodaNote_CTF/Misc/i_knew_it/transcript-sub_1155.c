#include <inttypes.h>

void sub_1155(uint8_t* rdi, uint8_t* rsi_arg, uint32_t* rdx_arg) {
	uint8_t* r8 =rsi_arg;
	uint32_t* rsi = rdx_arg;
	uint64_t rax = 0;

	/* loc_1160 */
	do {
		rdi[rax] = (uint8_t)rax;
		rax += 1;
	} while (rax != 0x100);

	uint64_t rcx = 0;
	uint64_t r10 = 0;

	/* loc_117A */
	do {
		uint64_t r9 = rdi[rcx];
		rax = rcx & UINT64_C(0xffffffff);
		if (rax & UINT64_C(0x80000000)) rax |= UINT64_C(0xffffffff00000000);
		uint64_t rdx = (int64_t)rax % *rsi;
		rax = (int64_t)rax / *rsi;
		rdx = (rdx & UINT64_C(0xffffffff));
		if (rdx & UINT64_C(0x80000000)) rdx |= UINT64_C(0xffffffff00000000);
		rax = r8[rdx];
		rdx = (uint8_t)r9;
		rdx = (rdx + r10) & UINT64_C(0xffffffff);
		rax = (rax + rdx) & UINT64_C(0xffffffff);
		rdx = rax & UINT64_C(0x80000000) ? UINT64_C(0xffffffff) : UINT64_C(0);
		rax &= UINT64_C(0xffffffff);
		rdx = (rdx & UINT64_C(0xffffffff)) >> 0x18;
		rax = (rax + rdx) & UINT64_C(0xffffffff);
		rax = (uint8_t)rax;
		rax = (rax - rdx) & UINT64_C(0xffffffff);
		r10 = (uint32_t)rax;
		rax &= UINT64_C(0xffffffff);
		if (rax & UINT64_C(0x80000000)) rax |= UINT64_C(0xffffffff00000000);
		rdx = rdi[rax];
		rdi[rcx] = (uint8_t)rdx;
		rdi[rax] = (uint8_t)r9;
		rcx += 1;
	} while (rcx != 0x100);
}
