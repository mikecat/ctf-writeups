void sub_11BE(unsigned char* array_to_swap, unsigned char* xor_input_array, int* size_ptr, unsigned char* xor_result_array) {
	int i;
	int prev_idx2 = 0, idx = 0;
	if (*size_ptr <= 0) return;

	/* loc_11E1 */
	for (i = 0; i < *size_ptr; i++) {
		int next_idx = idx + 1;
		int calc_temp = next_idx < 0 ? 0xff : 0x00;
		int swap_temp, idx2;
		idx = ((next_idx + calc_temp) & 0xff) - calc_temp;
		swap_temp = array_to_swap[idx];

		idx2 = swap_temp + prev_idx2;
		calc_temp = eax < 0 ? 0xff : 0x00;
		idx2 = ((eax + calc_temp) & 0xff) - calc_temp;
		prev_idx2 = idx2;

		array_to_swap[idx] = array_to_swap[idx2];
		array_to_swap[idx2] = swap_temp;

		swap_temp = (swap_temp + array_to_swap[idx]) & 0xff;
		xor_result_array[i] = array_to_swap[swap_temp] ^ xor_input_array[i];
	}
}
