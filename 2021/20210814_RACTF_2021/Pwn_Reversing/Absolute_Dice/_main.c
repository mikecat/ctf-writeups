void _main(char *param_1)

{
  FILE *pFVar1;
  int iVar2;
  int *piVar3;
  int in_GS_OFFSET;
  char local_b1;
  int local_a8 [4];
  uint local_98;
  char *local_14;
  int local_10;
  
  local_10 = *(int *)(in_GS_OFFSET + 0x14);
  piVar3 = local_a8;
  for (iVar2 = 0x26; iVar2 != 0; iVar2 = iVar2 + -1) {
    *piVar3 = 0;
    piVar3 = piVar3 + 1;
  }
  local_14 = param_1;
  puts(
      "Welcome to the final boss fight of my new indie game, Solid Rook. Your goal - predict the same number as the final boss, Absolute Dice, 30 times in a row; she\'ll pick between 0 and 20.\n"
      );
  while (local_a8[0] < 100) {
    local_a8[0] = local_a8[0] + 1;
    pFVar1 = fopen(local_14,"r");
    fread(local_a8 + 4,4,1,pFVar1);
    srand(local_98);
    printf("Enter your guess> ");
    __isoc99_scanf(&DAT_08048b2f,local_a8 + 3);
    local_a8[1] = rand();
    local_a8[1] = local_a8[1] % 0x15;
    local_a8[local_a8[0] % 0x21 + 5] = local_a8[3];
    if (local_a8[3] == local_a8[1]) {
      iVar2 = local_a8[2] + 1;
      local_a8[2] = iVar2;
      printf("Absolute Dice shrieks as your needle strikes a critical hit. (%d/50)\n",iVar2);
      if (0x1e < local_a8[2]) {
        printf("Absolute Dice shrieks as you take her down with a final hit.",iVar2);
        pFVar1 = fopen("flag.txt","r");
        iVar2 = fgetc(pFVar1);
        local_b1 = (char)iVar2;
        while (local_b1 != -1) {
          putchar((int)local_b1);
          iVar2 = fgetc(pFVar1);
          local_b1 = (char)iVar2;
        }
        fclose(pFVar1);
      }
    }
    else {
      local_a8[2] = 0;
      printf("Absolute Dice scores a hit on you! (She had %d, you said %d)\n",local_a8[1],
             local_a8[3]);
    }
  }
  if (local_10 != *(int *)(in_GS_OFFSET + 0x14)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return;
}
