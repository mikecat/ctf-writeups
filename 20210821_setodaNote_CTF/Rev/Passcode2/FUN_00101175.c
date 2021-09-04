undefined8 FUN_00101175(void)

{
  int iVar1;
  undefined8 uVar2;
  size_t sVar3;
  byte local_124 [4];
  undefined local_120;
  undefined local_11f;
  undefined local_11e;
  undefined local_11d;
  undefined local_11c;
  undefined local_11b;
  undefined local_11a;
  undefined local_119;
  undefined8 local_118;
  undefined8 local_110;
  undefined8 local_108;
  undefined8 local_100;
  undefined8 local_f8;
  undefined8 local_f0;
  undefined8 local_e8;
  undefined8 local_e0;
  undefined8 local_d8;
  undefined8 local_d0;
  undefined8 local_c8;
  undefined8 local_c0;
  undefined8 local_b8;
  undefined8 local_b0;
  undefined8 local_a8;
  undefined8 local_a0;
  undefined8 local_98;
  undefined8 local_90;
  undefined8 local_88;
  undefined8 local_80;
  undefined8 local_78;
  undefined8 local_70;
  undefined8 local_68;
  undefined8 local_60;
  undefined8 local_58;
  undefined8 local_50;
  undefined8 local_48;
  undefined8 local_40;
  undefined8 local_38;
  undefined8 local_30;
  undefined8 local_28;
  undefined8 local_20;
  ulong local_10;
  
  local_118 = 0;
  local_110 = 0;
  local_108 = 0;
  local_100 = 0;
  local_f8 = 0;
  local_f0 = 0;
  local_e8 = 0;
  local_e0 = 0;
  local_d8 = 0;
  local_d0 = 0;
  local_c8 = 0;
  local_c0 = 0;
  local_b8 = 0;
  local_b0 = 0;
  local_a8 = 0;
  local_a0 = 0;
  local_98 = 0;
  local_90 = 0;
  local_88 = 0;
  local_80 = 0;
  local_78 = 0;
  local_70 = 0;
  local_68 = 0;
  local_60 = 0;
  local_58 = 0;
  local_50 = 0;
  local_48 = 0;
  local_40 = 0;
  local_38 = 0;
  local_30 = 0;
  local_28 = 0;
  local_20 = 0;
  local_124[0] = 0x18;
  local_124[1] = 0x1f;
  local_124[2] = 4;
  local_124[3] = 0x79;
  local_120 = 0x4f;
  local_11f = 0x5a;
  local_11e = 4;
  local_11d = 0x18;
  local_11c = 0x1a;
  local_11b = 0x1b;
  local_11a = 0x1e;
  local_119 = 0;
  printf("Enter the passcode: ");
  iVar1 = __isoc99_scanf("%255[^\n]%*[^\n]",&local_118);
  if (iVar1 == -1) {
    uVar2 = 1;
  }
  else {
    __isoc99_scanf(&DAT_0010202c);
    if ((char)local_118 == '\0') {
      printf("Invalid passcode.");
    }
    else {
      sVar3 = strlen((char *)&local_118);
      if (sVar3 < 0xb) {
        printf("Invalid passcode. Too short.");
      }
      else {
        sVar3 = strlen((char *)&local_118);
        if (sVar3 < 0xc) {
          sVar3 = strlen((char *)&local_118);
          if (sVar3 == 0xb) {
            local_10 = 0;
            while ((sVar3 = strlen((char *)local_124), local_10 < sVar3 &&
                   (*(byte *)((long)&local_118 + local_10) == (local_124[local_10] ^ 0x2a)))) {
              local_10 = local_10 + 1;
            }
            sVar3 = strlen((char *)local_124);
            if (local_10 == sVar3) {
              puts("The passcode has been verified.\n");
              printf("Flag is : flag{%s}",&local_118);
            }
            else {
              printf("Invalid passcode. Nice try.");
            }
          }
          else {
            printf("Invalid passcode.");
          }
        }
        else {
          printf("Invalid passcode. Too long.");
        }
      }
    }
    putchar(10);
    uVar2 = 0;
  }
  return uVar2;
}
