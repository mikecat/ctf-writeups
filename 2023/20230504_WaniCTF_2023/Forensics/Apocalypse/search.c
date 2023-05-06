#include <stdio.h>
#include <inttypes.h>

uint32_t updateCRC(const void* data, size_t size, uint32_t start) {
	const uint32_t magic = UINT32_C(0xEDB88320);
	static uint32_t table[256];
	uint32_t crc = ~start;
	if (table[0] == 0) {
		for (int i = 0; i < 256; i++) {
			uint32_t table_value = i;
			for (int j = 0; j < 8; j++) {
				int b = (table_value & 1);
				table_value >>= 1;
				if (b) table_value ^= magic;
			}
			table[i] = table_value;
		}
	}
	for (size_t i = 0; i < size; i++) {
		crc = table[(crc ^ ((const uint8_t*)data)[i]) & 0xff] ^ (crc >> 8);
	}
	return ~crc;
}

uint8_t data[128 * 1024];

int main(int argc, char* argv[]) {
	const size_t PREFIX_START = 0x4079, PREFIX_END = 0x6000;
	const size_t SUFFIX_START = 0x6004, SUFFIX_END = 0x607D;
	const uint32_t TARGET_CRC = UINT32_C(0xCDA0E401);
	if (argc < 2) return 1;
	FILE* fp = fopen(argv[1], "rb");
	if (fp == NULL) return 2;
	size_t sizeRead = 0;
	for (;;) {
		size_t delta = fread(data + sizeRead, 1, sizeof(data) - sizeRead, fp);
		if (delta == 0) break;
		sizeRead += delta;
	}
	fclose(fp);
	uint32_t crcPrefix = updateCRC(data + PREFIX_START, PREFIX_END - PREFIX_START, 0);
	#pragma omp parallel for
	for (uint32_t search = 0; search < UINT32_C(0x80000000); search++) {
		for (int topbit = 0; topbit < 2; topbit++) {
			uint32_t search2 = search | (topbit ? UINT32_C(0x80000000) : 0);
			uint8_t dataBuf[4] = {
				search2 & 0xff, (search2 >> 8) & 0xff,
				(search2 >> 16) & 0xff, (search2 >> 24) & 0xff
			};
			uint32_t crc = updateCRC(data + SUFFIX_START, SUFFIX_END - SUFFIX_START,
				updateCRC(dataBuf, 4, crcPrefix));
			if (crc == TARGET_CRC) {
				#pragma omp critical
				{
					printf("%02X %02X %02X %02X\n",
						(unsigned int)dataBuf[0], (unsigned int)dataBuf[1],
						(unsigned int)dataBuf[2], (unsigned int)dataBuf[3]);
				}
			}
		}
	}
	return 0;
}
