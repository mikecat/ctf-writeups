undefined8 main(int param_1,undefined8 *param_2)

{
  int iVar1;
  size_t sVar2;
  long lVar3;
  undefined8 *puVar4;
  undefined8 *puVar5;
  long in_FS_OFFSET;
  int local_3bc;
  undefined local_3b8 [4];
  int local_3b4;
  int local_3b0;
  int local_3ac;
  undefined8 local_3a8;
  undefined8 local_208;
  undefined local_62;
  undefined local_61;
  undefined local_60;
  undefined local_5f;
  char local_5e [11];
  char local_53 [11];
  byte local_48 [16];
  byte local_38 [40];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  puVar4 = &DAT_001020a0;
  puVar5 = &local_3a8;
  for (lVar3 = 0x32; lVar3 != 0; lVar3 = lVar3 + -1) {
    *puVar5 = *puVar4;
    puVar4 = puVar4 + 1;
    puVar5 = puVar5 + 1;
  }
  *(undefined4 *)puVar5 = *(undefined4 *)puVar4;
  *(undefined2 *)((long)puVar5 + 4) = *(undefined2 *)((long)puVar4 + 4);
  *(undefined *)((long)puVar5 + 6) = *(undefined *)((long)puVar4 + 6);
  puVar4 = &DAT_00102240;
  puVar5 = &local_208;
  for (lVar3 = 0x32; lVar3 != 0; lVar3 = lVar3 + -1) {
    *puVar5 = *puVar4;
    puVar4 = puVar4 + 1;
    puVar5 = puVar5 + 1;
  }
  *(undefined4 *)puVar5 = *(undefined4 *)puVar4;
  *(undefined2 *)((long)puVar5 + 4) = *(undefined2 *)((long)puVar4 + 4);
  *(undefined *)((long)puVar5 + 6) = *(undefined *)((long)puVar4 + 6);
  if (param_1 < 2) {
    printf("Usage: %s <flag>\n",*param_2,(long)puVar4 + 7);
  }
  else {
    sVar2 = strlen((char *)param_2[1]);
    local_3ac = (int)(sVar2 >> 1);
    if (local_3ac == 0x25) {
      for (local_3b4 = 0; local_3b4 < local_3ac; local_3b4 = local_3b4 + 1) {
        f(local_3b4,local_3ac,&local_3bc,local_3b8);
        if (local_3bc < 0) {
          local_3bc = local_3ac + local_3bc;
        }
        local_62 = *(undefined *)((long)(local_3b4 * 2) + param_2[1]);
        local_61 = 0;
        local_60 = *(undefined *)(param_2[1] + (long)(local_3b4 * 2) + 1);
        local_5f = 0;
        md5(&local_62,local_48);
        sha256(&local_60,local_38);
        for (local_3b0 = 0; local_3b0 < 5; local_3b0 = local_3b0 + 1) {
          sprintf(local_5e + local_3b0 * 2,"%02x",(ulong)local_48[local_3b0]);
          sprintf(local_53 + local_3b0 * 2,"%02x",(ulong)local_38[local_3b0]);
        }
        iVar1 = strcmp((char *)((long)&local_3a8 + (long)local_3b4 * 0xb),local_5e);
        if (iVar1 != 0) {
          puts("Too spicy :(");
          goto LAB_00101768;
        }
        iVar1 = strcmp((char *)((long)&local_208 + (long)local_3bc * 0xb),local_53);
        if (iVar1 != 0) {
          puts("Too spicy :(");
          goto LAB_00101768;
        }
      }
      puts("Yum! Yum! Yummy!!!! :)\nThe flag is one of the best ingredients.");
    }
    else {
      puts("Too sweet :(");
    }
  }
LAB_00101768:
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
