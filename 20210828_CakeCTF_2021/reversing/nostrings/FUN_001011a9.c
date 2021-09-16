undefined8 FUN_001011a9(void)

{
  undefined8 uVar1;
  long in_FS_OFFSET;
  int local_60;
  int local_5c;
  char local_58 [72];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  printf("flag: ");
  __isoc99_scanf(&DAT_0010200b,local_58);
  local_60 = 1;
  local_5c = 0;
  do {
    if (0x39 < local_5c) {
      if (local_60 == 0) {
        puts("-_- < flag in the string...");
      }
      else {
        puts(".O. < i+! +o6 noh");
        puts(">v< this is the flag");
      }
      uVar1 = 0;
LAB_001012ae:
      if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
        __stack_chk_fail();
      }
      return uVar1;
    }
    if (local_58[local_5c] == '\x7f') {
      puts("^o^");
      uVar1 = 1;
      goto LAB_001012ae;
    }
    local_60 = (uint)((uint)(byte)s__00104020[(long)(int)local_58[local_5c] * 0x7f + (long)local_5c]
                     == (int)local_58[local_5c]) * local_60;
    local_5c = local_5c + 1;
  } while( true );
}
