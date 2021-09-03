void sub_1155(unsigned char* out_table, unsigned char* input_array, int* divisor_ptr) {
	int i;
	int rax, prev_rax = 0;

	/* loc_1160 */
	for (i = 0; i < 0x100; i++) {
		out_table[i] = i;
	}

	/* loc_117A */
	for (i = 0; i < 0x100; i++) {
		unsigned char swap_temp = out_table[i];
		int rdx;
		rax = input_array[i % *divisor_ptr];
		rdx = swap_temp + prev_rax;
		rax += rdx;
		rdx = rax < 0 ? 0xff : 0x00;
		rax = ((rax + rdx) & 0xff) - rdx;
		prev_rax = rax;
		out_table[i] = out_table[rax];
		out_table[rax] = swap_temp;
	}
}
