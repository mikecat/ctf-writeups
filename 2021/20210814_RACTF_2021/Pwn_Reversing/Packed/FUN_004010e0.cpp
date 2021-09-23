void FUN_004010e0(void)

{
  char *pcVar1;
  char cVar2;
  uint uVar3;
  uint uVar4;
  int iVar5;
  char *pcVar6;
  undefined *puVar7;
  char *pcVar8;
  uint uVar9;
  undefined auStack260 [10];
  byte local_fa;
  char local_f8 [64];
  undefined local_b8 [52];
  char local_84 [52];
  char local_50 [68];
  uint local_c;
  
  local_c = DAT_00405004 ^ (uint)auStack260;
  local_fa = FUN_00401010();
  FUN_00401380();
  std::basic_istream<char,struct_std::char_traits<char>_>::get
            ((basic_istream<char,struct_std::char_traits<char>_> *)cin_exref,local_f8,0x40);
  std::basic_istream<char,struct_std::char_traits<char>_>::ignore
            ((basic_istream<char,struct_std::char_traits<char>_> *)cin_exref,1,-1);
  FUN_00401380();
  std::basic_istream<char,struct_std::char_traits<char>_>::get
            ((basic_istream<char,struct_std::char_traits<char>_> *)cin_exref,local_50,0x40);
  uVar9 = 0;
  memset(local_b8,0,0x32);
  pcVar6 = local_f8;
  pcVar8 = (char *)0x0;
  do {
    cVar2 = *pcVar6;
    pcVar6 = pcVar6 + 1;
  } while (cVar2 != '\0');
  if (pcVar6 != local_f8 + 1) {
    puVar7 = local_b8;
    do {
      uVar3 = FUN_00401010();
      uVar4 = (uint)pcVar8 & 0x80000001;
      if ((int)uVar4 < 0) {
        uVar4 = (uVar4 - 1 | 0xfffffffe) + 1;
      }
      if (uVar4 == (uVar3 & 0xff)) {
        uVar9 = uVar9 + 0x3d;
        iVar5 = tolower(local_f8[(int)pcVar8] + -0x61);
        iVar5 = toupper((int)(char)((char)(iVar5 % 0x19) + '`' + local_fa));
        *puVar7 = (char)iVar5;
        puVar7 = puVar7 + 1;
      }
      pcVar6 = local_f8;
      do {
        cVar2 = *pcVar6;
        pcVar6 = pcVar6 + 1;
      } while (cVar2 != '\0');
      pcVar1 = local_f8 + (int)pcVar8;
      iVar5 = -(int)pcVar8;
      pcVar8 = pcVar8 + 1;
      uVar9 = (uVar9 ^ (int)*pcVar1) +
              (int)(char)(&stack0xffffff07)
                         [(int)(pcVar6 + -(int)(local_f8 + 1) + (iVar5 - (uint)local_fa))];
    } while (pcVar8 < pcVar6 + -(int)(local_f8 + 1));
  }
  FUN_004015f0(local_84,"RA-%d-%s",uVar9,local_b8);
  pcVar6 = local_84;
  pcVar8 = (char *)0x0;
  do {
    cVar2 = *pcVar6;
    pcVar6 = pcVar6 + 1;
  } while (cVar2 != '\0');
  if (pcVar6 != local_84 + 1) {
    do {
      if (local_84[(int)pcVar8] != local_50[(int)pcVar8]) {
        FUN_00401380();
        FUN_00401653();
        return;
      }
      pcVar8 = pcVar8 + 1;
    } while (pcVar8 < pcVar6 + -(int)(local_84 + 1));
  }
  FUN_00401380();
  FUN_00401653();
  return;
}
