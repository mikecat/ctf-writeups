undefined8 main(void)

{
  int iVar1;
  FILE *pFVar2;
  size_t sVar3;
  byte *dest;
  long lVar4;
  long lVar5;
  ulong uVar6;
  byte *pbVar7;
  byte *pbVar8;
  ulong uVar9;
  long in_FS_OFFSET;
  byte bVar10;
  int local_180;
  int local_178;
  undefined local_170 [192];
  byte local_b0 [16];
  byte local_a0 [16];
  undefined local_90 [16];
  byte local_80 [64];
  long local_40;
  
  bVar10 = 0;
  local_40 = *(long *)(in_FS_OFFSET + 0x28);
  pFVar2 = fopen("flag.txt","r");
  fgets((char *)local_80,0x40,pFVar2);
  fclose(pFVar2);
  pFVar2 = fopen("keyfile","r");
  fread(local_b0,0x10,1,pFVar2);
  fclose(pFVar2);
  sVar3 = strlen((char *)local_80);
  dest = (byte *)default_malloc(0x100000);
  uVar9 = (sVar3 - 1 | 0xf) + 1;
  if (dest != (byte *)0x0) {
    strcpy((char *)dest,(char *)local_80);
    gettimeofday((timeval *)&local_180,(void *)0x0);
    srand(local_180 * 1000000 + local_178);
    lVar5 = 0;
    do {
      iVar1 = rand();
      lVar4 = lVar5 + 1;
      local_a0[lVar5] = (byte)(iVar1 % 0x100) ^ local_b0[lVar5];
      lVar5 = lVar4;
    } while (lVar4 != 0x10);
    lVar5 = 0;
    do {
      iVar1 = rand();
      local_90[lVar5] = (char)(iVar1 % 0x100);
      lVar5 = lVar5 + 1;
    } while (lVar5 != 0x10);
    sVar3 = strlen((char *)local_80);
    lVar5 = uVar9 - sVar3;
    if (uVar9 < sVar3) {
      lVar5 = 0;
    }
    pbVar7 = dest + sVar3;
    for (; lVar5 != 0; lVar5 = lVar5 + -1) {
      *pbVar7 = 0;
      pbVar7 = pbVar7 + (ulong)bVar10 * -2 + 1;
    }
    AES_init_ctx_iv(local_170,local_a0,local_90);
    AES_CBC_encrypt_buffer(local_170,dest,uVar9);
    if ((((local_80 < dest) && (dest < local_80 + uVar9)) ||
        ((dest < local_80 && (local_80 < dest + uVar9)))) ||
       (uVar6 = uVar9, pbVar7 = dest, pbVar8 = local_80, 0x40 < uVar9)) {
      do {
        invalidInstructionException();
      } while( true );
    }
    for (; uVar6 != 0; uVar6 = uVar6 - 1) {
      *pbVar8 = *pbVar7;
      pbVar7 = pbVar7 + (ulong)bVar10 * -2 + 1;
      pbVar8 = pbVar8 + (ulong)bVar10 * -2 + 1;
    }
  }
  free(dest);
  for (uVar6 = 0; uVar6 < uVar9; uVar6 = uVar6 + 1) {
    printf("%02x",(ulong)local_80[uVar6]);
  }
  putchar(10);
  if (local_40 == *(long *)(in_FS_OFFSET + 0x28)) {
    return 0;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}
