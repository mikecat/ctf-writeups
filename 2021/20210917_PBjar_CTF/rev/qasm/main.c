undefined8 main(int param_1,undefined8 *param_2)

{
  int iVar1;
  int iVar2;
  undefined8 uVar3;
  FILE *__stream;
  long lVar4;
  int local_1c;
  int local_18;
  
  if (param_1 == 2) {
    __stream = fopen((char *)param_2[1],"rb");
    if (__stream == (FILE *)0x0) {
      printf("Unable to find file: %s\n",param_2[1]);
      uVar3 = 1;
    }
    else {
      fseek(__stream,0,2);
      prog_len = ftell(__stream);
      fseek(__stream,0,0);
      prog = malloc(prog_len + 1);
      fread(prog,1,prog_len,__stream);
      fclose(__stream);
      for (local_1c = 0; local_1c < 0x40000; local_1c = local_1c + 1) {
        *(undefined4 *)(qv + (long)local_1c * 4) = 0;
        *(undefined4 *)(ql + (long)local_1c * 4) = 0xffffffff;
        *(undefined4 *)(qr + (long)local_1c * 4) = 0xffffffff;
      }
      *(int *)(qr + (long)pl * 4) = pr;
      *(int *)(ql + (long)pr * 4) = pl;
      while ((long)pc < (long)prog_len) {
        iVar1 = pc + 1;
        iVar2 = (int)*(char *)((long)pc + (long)prog);
        pc = iVar1;
        if (iVar2 < 0x72) {
          for (local_18 = 0; local_18 < *(int *)(argn + (long)iVar2 * 4); local_18 = local_18 + 1) {
            lVar4 = (long)pc;
            pc = pc + 1;
            *(int *)((long)&v + (long)local_18 * 4) = (int)*(char *)(lVar4 + (long)prog);
          }
          (**(code **)(f_lookup + (long)iVar2 * 8))();
        }
      }
      free(prog);
      uVar3 = 0;
    }
  }
  else {
    printf("USAGE: %s <file>\n",*param_2);
    uVar3 = 1;
  }
  return uVar3;
}
