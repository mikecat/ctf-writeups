bool main(int param_1,undefined8 *param_2)

{
  undefined8 uVar1;
  FILE *pFVar2;
  FILE *pFVar3;
  size_t __size;
  void *__ptr;
  int *piVar4;
  char *pcVar5;
  uint uVar6;
  uint uVar7;
  size_t sVar8;
  long in_FS_OFFSET;
  bool bVar9;
  undefined local_40 [8];
  long local_38;
  
  local_38 = *(long *)(in_FS_OFFSET + 0x28);
  if (param_1 < 3) {
    bVar9 = false;
    fprintf(stderr,"usage: %s <in file> <out file>\n",*param_2);
  }
  else {
    pFVar3 = fopen((char *)param_2[1],"rb");
    pFVar2 = stderr;
    if (pFVar3 == (FILE *)0x0) {
      uVar1 = param_2[1];
      piVar4 = __errno_location();
      pcVar5 = strerror(*piVar4);
      fprintf(pFVar2,"failed to open input file %s: %s\n",uVar1,pcVar5);
      bVar9 = true;
    }
    else {
      fseek(pFVar3,0,2);
      __size = ftell(pFVar3);
      rewind(pFVar3);
      __ptr = malloc(__size);
      fread(__ptr,1,__size,pFVar3);
      fclose(pFVar3);
      uVar7 = rdseed();
      rdseedIsValid();
      printf("Seed: 0x%08X\n",(ulong)uVar7);
      uVar7 = rngInit(local_40,uVar7);
      if (__size != 0) {
        sVar8 = 0;
        uVar6 = 0;
        do {
          if (uVar6 == 0) {
            uVar7 = rngNext32(local_40);
          }
          uVar6 = uVar6 + 1 & 3;
          *(byte *)((long)__ptr + sVar8) = *(byte *)((long)__ptr + sVar8) ^ (byte)(uVar7 >> 0x18);
          sVar8 = sVar8 + 1;
          uVar7 = uVar7 >> 0x18 | uVar7 << 8;
        } while (__size != sVar8);
      }
      pFVar3 = fopen((char *)param_2[2],"wb");
      pFVar2 = stderr;
      bVar9 = pFVar3 == (FILE *)0x0;
      if (bVar9) {
        uVar1 = param_2[2];
        piVar4 = __errno_location();
        pcVar5 = strerror(*piVar4);
        fprintf(pFVar2,"failed to open ouput file %s: %s\n",uVar1,pcVar5);
      }
      else {
        fwrite(__ptr,1,__size,pFVar3);
        fclose(pFVar3);
      }
      free(__ptr);
    }
  }
  if (*(long *)(in_FS_OFFSET + 0x28) == local_38) {
    return bVar9;
  }
                    /* WARNING: Subroutine does not return */
  __stack_chk_fail();
}
