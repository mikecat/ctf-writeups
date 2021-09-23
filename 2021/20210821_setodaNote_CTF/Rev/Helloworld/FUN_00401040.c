undefined4 __cdecl FUN_00401040(int param_1,int param_2)

{
  byte bVar1;
  byte *pbVar2;
  uint uVar3;
  byte *pbVar4;
  byte *pbVar5;
  bool bVar6;
  undefined1 in_stack_ffffffd4;
  undefined4 uStack40;
  undefined4 uStack36;
  undefined4 uStack32;
  undefined4 local_1c;
  undefined4 uStack24;
  undefined4 uStack20;
  undefined4 uStack16;
  undefined4 local_c;
  undefined2 local_8;
  
  if (param_1 < 2) {
    FUN_00401010("Nice try, please set some word when you run me.",in_stack_ffffffd4);
    return 0;
  }
  pbVar5 = &DAT_00402130;
  pbVar4 = *(byte **)(param_2 + 4);
  pbVar2 = pbVar4;
  do {
    bVar1 = *pbVar2;
    bVar6 = bVar1 < *pbVar5;
    if (bVar1 != *pbVar5) {
LAB_00401090:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_00401095;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar2[1];
    bVar6 = bVar1 < pbVar5[1];
    if (bVar1 != pbVar5[1]) goto LAB_00401090;
    pbVar2 = pbVar2 + 2;
    pbVar5 = pbVar5 + 2;
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_00401095:
  if (uVar3 != 0) {
    FUN_00401010("Good job, but please set \'flag\' when you run me.",in_stack_ffffffd4);
    return 0;
  }
  pbVar2 = &DAT_0040216c;
  do {
    bVar1 = *pbVar4;
    bVar6 = bVar1 < *pbVar2;
    if (bVar1 != *pbVar2) {
LAB_004010d2:
      uVar3 = -(uint)bVar6 | 1;
      goto LAB_004010d7;
    }
    if (bVar1 == 0) break;
    bVar1 = pbVar4[1];
    bVar6 = bVar1 < pbVar2[1];
    if (bVar1 != pbVar2[1]) goto LAB_004010d2;
    pbVar4 = pbVar4 + 2;
    pbVar2 = pbVar2 + 2;
  } while (bVar1 != 0);
  uVar3 = 0;
LAB_004010d7:
  if (uVar3 == 0) {
    FUN_00401010("Nice try ;)",in_stack_ffffffd4);
    return 0;
  }
  local_c = 0x2b2d2f3e;
  uStack40 = 0x2b3c2835;
  uStack36 = 0x2f28112b;
  uStack32 = 0x2f113c27;
  local_8 = 0x33;
  uVar3 = 0;
  local_1c = 0x3d112a20;
  uStack24 = 0x3c3b2d2b;
  uStack20 = 0x372d112b;
  uStack16 = 0x3d3c2b2c;
  do {
    FUN_00401010(&DAT_004021a8,(&stack0xffffffd4)[uVar3] ^ 0x4e);
    uVar3 = uVar3 + 1;
  } while (uVar3 < 0x25);
  return 0;
}
