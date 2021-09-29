char check1(void)

{
  long in_FS_OFFSET;
  char local_1e;
  char local_1d;
  int local_1c;
  byte local_16 [6];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_1e = '\0';
  local_1d = '\x01';
  printf("Give me five letters: ");
  read(0,local_16,5);
  for (local_1c = 0; local_1c < 5; local_1c = local_1c + 1) {
    local_1e = local_1e + (local_16[local_1c] ^ *(byte *)((long)&X + (long)local_1c));
    local_1d = local_1d * local_16[local_1c] * ((char)local_1c + '\x01');
  }
  if ((local_1e != '\0') || (local_1d == '\0')) {
    die();
  }
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return local_1d;
}

uint check2(void)

{
  long in_FS_OFFSET;
  uint local_1c;
  uint local_18;
  uint local_14;
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_14 = rand();
  local_14 = local_14 & 0xffff;
  printf("Solve this: x + y = %d\n",(ulong)local_14);
  __isoc99_scanf("%u %u",&local_1c,&local_18);
  if ((((local_1c == 0) || (local_18 == 0)) || (local_1c <= local_14)) || (local_18 <= local_14)) {
    die();
  }
  if ((local_1c + local_18 != local_14) || ((local_18 * local_1c & 0xffff) < 0x3c)) {
    die();
  }
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return local_18 * local_1c & 0xffff;
}

uint check3(void)

{
  long in_FS_OFFSET;
  uint local_28;
  uint local_24;
  uint local_20;
  uint local_1c;
  uint local_18;
  uint local_14;
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_14 = rand();
  local_14 = local_14 & 0xffff;
  printf("Now solve this: x1 + x2 + x3 + x4 + x5 = %d\n",(ulong)local_14);
  __isoc99_scanf("%u %u %u %u %u",&local_28,&local_24,&local_20,&local_1c,&local_18);
  if ((((local_28 == 0) || (local_24 == 0)) || (local_20 == 0)) ||
     ((local_1c == 0 || (local_18 == 0)))) {
    die();
  }
  if (((local_24 <= local_28) || (local_20 <= local_24)) ||
     ((local_1c <= local_20 || (local_18 <= local_1c)))) {
    die();
  }
  if ((local_28 + local_24 + local_20 + local_1c + local_18 != local_14) ||
     (((local_18 - local_1c) * (local_20 - local_24) & 0xffff) < 0x3c)) {
    die();
  }
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return (local_18 - local_1c) * (local_20 - local_24) & 0xffff;
}
