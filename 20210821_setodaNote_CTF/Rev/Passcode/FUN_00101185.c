/* WARNING: Could not reconcile some variable overlaps */

undefined8 FUN_00101185(void)

{
  int iVar1;
  undefined8 uVar2;
  size_t sVar3;
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
  undefined8 local_18;
  undefined8 local_10;
  
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
  local_18 = 0;
  local_10 = 0;
  printf("Enter the passcode: ");
  iVar1 = __isoc99_scanf("%255[^\n]%*[^\n]",&local_108);
  if (iVar1 == -1) {
    uVar2 = 1;
  }
  else {
    __isoc99_scanf(&DAT_0010202c);
    if ((char)local_108 == '\0') {
      printf("Invalid passcode.");
    }
    else {
      sVar3 = strlen((char *)&local_108);
      if (sVar3 < 8) {
        printf("Invalid passcode. Too short.");
      }
      else {
        sVar3 = strlen((char *)&local_108);
        if (sVar3 < 9) {
          iVar1 = strcmp((char *)&local_108,"20150109");
          if (iVar1 == 0) {
            puts("The passcode has been verified.\n");
            printf("Flag is : flag{%s}",&local_108);
          }
          else {
            printf("Invalid passcode. Nice try.");
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
