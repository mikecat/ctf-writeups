void FUN_001014b2(void)

{
  ulong uVar1;
  long lVar2;
  long lVar3;
  long lVar4;
  long lVar5;
  long lVar6;
  long lVar7;
  long lVar8;
  FILE *pFVar9;
  long in_FS_OFFSET;
  int local_120;
  ulong local_110;
  uint local_f8 [4];
  undefined4 local_e8;
  undefined4 local_e4;
  undefined4 local_e0;
  undefined4 local_dc;
  undefined4 local_d8;
  undefined4 local_d4;
  undefined4 local_d0;
  undefined4 local_cc;
  undefined4 local_c8;
  undefined4 local_c4;
  undefined4 local_c0;
  undefined4 local_bc;
  undefined4 local_b8;
  undefined4 local_b4;
  undefined4 local_b0;
  undefined4 local_ac;
  undefined4 local_a8;
  undefined4 local_a4;
  undefined4 local_a0;
  undefined4 local_9c;
  undefined4 local_98;
  undefined4 local_94;
  undefined4 local_90;
  undefined4 local_8c;
  undefined4 local_88;
  undefined4 local_84;
  undefined4 local_80;
  undefined4 local_7c;
  undefined4 local_78;
  undefined4 local_74;
  undefined4 local_70;
  undefined4 local_6c;
  undefined4 local_68;
  undefined4 local_64;
  undefined4 local_60;
  undefined4 local_5c;
  undefined4 local_58;
  undefined8 local_48;
  undefined8 local_40;
  undefined8 local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined8 local_20;
  undefined2 local_18;
  undefined8 local_10;
  
  local_10 = *(undefined8 *)(in_FS_OFFSET + 0x28);
  local_48 = 0;
  local_40 = 0;
  local_38 = 0;
  local_30 = 0;
  local_28 = 0;
  local_20 = 0;
  local_18 = 0;
  lVar2 = FUN_00101269("ls /lib");
  lVar3 = FUN_00101269("env | grep PATH");
  lVar4 = FUN_00101269("env | grep HOME");
  lVar5 = FUN_00101269("uname");
  lVar6 = FUN_00101269("ls /usr/bin");
  lVar7 = FUN_00101269("ldd --version");
  lVar8 = FUN_00101269(&DAT_0010204e);
  uVar1 = lVar6 * lVar5 * lVar4 * lVar3 * lVar2 + lVar7 + lVar8;
  local_f8[0] = 0x72;
  local_f8[1] = 0x38;
  local_f8[2] = 0x65;
  local_f8[3] = 0x54;
  local_e8 = 0x48;
  local_e4 = 0x3c;
  local_e0 = 0x70;
  local_dc = 6;
  local_d8 = 0x40;
  local_d4 = 0x7f;
  local_d0 = 0x1a;
  local_cc = 0x14;
  local_c8 = 0x44;
  local_c4 = 0x6c;
  local_c0 = 0xd;
  local_bc = 0x70;
  local_b8 = 4;
  local_b4 = 0x40;
  local_b0 = 0x40;
  local_ac = 0x1b;
  local_a8 = 0x7b;
  local_a4 = 0x54;
  local_a0 = 0x56;
  local_9c = 0x31;
  local_98 = 0x1f;
  local_94 = 0x42;
  local_90 = 0x71;
  local_8c = 0x40;
  local_88 = 0x1b;
  local_84 = 0x7b;
  local_80 = 0x24;
  local_7c = 0x5b;
  local_78 = 0x20;
  local_74 = 0x1f;
  local_70 = 0x37;
  local_6c = 0x70;
  local_68 = 0x57;
  local_64 = 0x1f;
  local_60 = 0x41;
  local_5c = 0x41;
  local_58 = 0x4e;
  pFVar9 = fopen("/.dockerenv","r");
  if (pFVar9 == (FILE *)0x0) {
    puts("You are not in docker");
                    /* WARNING: Subroutine does not return */
    exit(-1);
  }
  local_110 = uVar1;
  for (local_120 = 0; local_120 < 0x29; local_120 = local_120 + 1) {
    if (local_110 == 0) {
      local_110 = uVar1;
    }
    putchar(local_f8[local_120] ^ (int)local_110 + (int)(local_110 / 0xa5) * -0xa5);
    local_110 = local_110 / 0xa5;
  }
                    /* WARNING: Subroutine does not return */
  exit(0);
}
