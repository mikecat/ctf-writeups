undefined8 main(void)

{
  long lVar1;
  long in_FS_OFFSET;
  byte local_238 [32];
  long local_218;
  int local_210;
  short local_20c;
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  lVar1 = 0;
  do {
    if ((&DAT_00102008)[lVar1] != 0) {
      local_238[lVar1] = (&DAT_00102008)[lVar1] ^ 0x5a;
    }
    lVar1 = lVar1 + 1;
  } while (lVar1 != 0x1f);
  local_238[30] = 0;
  puts("What is the best and sp00kiest breakfast cereal?");
  __printf_chk(1,&DAT_001020ad,"Please enter the passphrase: ");
  __isoc99_scanf(&DAT_001020ad,&local_218);
  if (((local_218 == 0x68632d746e753063) && (local_210 == 0x6c756330)) && (local_20c == 0x61)) {
    puts((char *)local_238);
  }
  else {
    puts("notflag{you-guessed-it---this-is-not-the-flag}");
  }
  if (local_10 == *(long *)(in_FS_OFFSET + 0x28)) {
    return 0;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}
