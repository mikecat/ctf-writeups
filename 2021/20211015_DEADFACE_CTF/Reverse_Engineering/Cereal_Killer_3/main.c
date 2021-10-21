/* WARNING: Function: __x86.get_pc_thunk.bx replaced with injection: get_pc_thunk_bx */

undefined4 main(void)

{
  bool bVar1;
  undefined4 uVar2;
  int iVar3;
  int *piVar4;
  int *piVar5;
  int in_GS_OFFSET;
  int local_398;
  int local_394;
  int local_390;
  int local_38c;
  int local_384;
  int local_380;
  int local_37c;
  int local_378;
  int local_35c [18];
  int local_314 [33];
  undefined local_28e [18];
  undefined local_27c;
  undefined local_27b [18];
  undefined local_269;
  undefined local_268 [33];
  undefined local_247;
  undefined local_246 [33];
  undefined local_225;
  undefined local_224 [512];
  int local_24;
  undefined *local_18;
  
  local_18 = &stack0x00000004;
  local_24 = *(int *)(in_GS_OFFSET + 0x14);
  piVar4 = &DAT_00012120;
  piVar5 = local_314;
  for (iVar3 = 0x21; iVar3 != 0; iVar3 = iVar3 + -1) {
    *piVar5 = *piVar4;
    piVar4 = piVar4 + 1;
    piVar5 = piVar5 + 1;
  }
  piVar4 = &DAT_000121c0;
  piVar5 = local_35c;
  for (iVar3 = 0x12; iVar3 != 0; iVar3 = iVar3 + -1) {
    *piVar5 = *piVar4;
    piVar4 = piVar4 + 1;
    piVar5 = piVar5 + 1;
  }
  bVar1 = false;
  local_394 = 0;
  for (local_398 = 0; local_398 < 0x24; local_398 = local_398 + 1) {
    if (local_398 % 3 == 0) {
      bVar1 = !bVar1;
    }
    if (bVar1) {
      local_28e[local_394] = (&DAT_00012020)[local_398];
      local_394 = local_394 + 1;
    }
  }
  local_27c = 0;
  for (local_38c = 0; local_38c < 0x12; local_38c = local_38c + 1) {
    for (local_390 = 0; (local_38c < 0x12 && (local_38c != local_35c[local_390]));
        local_390 = local_390 + 1) {
    }
    local_27b[local_38c] = local_28e[local_390];
  }
  local_269 = 0;
  bVar1 = false;
  local_380 = 0;
  for (local_384 = 0; local_384 < 0x42; local_384 = local_384 + 1) {
    if (local_384 % 0xb == 0) {
      bVar1 = !bVar1;
    }
    if (bVar1) {
      local_246[local_380] = (&DAT_00012048)[local_384];
      local_380 = local_380 + 1;
    }
  }
  local_225 = 0;
  for (local_378 = 0; local_378 < 0x21; local_378 = local_378 + 1) {
    for (local_37c = 0; (local_378 < 0x21 && (local_378 != local_314[local_37c]));
        local_37c = local_37c + 1) {
    }
    local_268[local_378] = local_246[local_37c];
  }
  local_247 = 0;
  FUN_000110e0("What is the best and sp00kiest breakfast cereal?");
  FUN_000110c0(&DAT_00012110,"Please enter the passphrase: ");
  FUN_00011100(&DAT_00012110,local_224);
  iVar3 = FUN_000110b0(local_224,local_27b);
  if (iVar3 == 0) {
    FUN_000110e0(local_268);
  }
  else {
    FUN_000110e0("notflag{you-guessed-it-again--this-is-not-the-flag}");
  }
  uVar2 = 0;
  if (local_24 != *(int *)(in_GS_OFFSET + 0x14)) {
    uVar2 = __stack_chk_fail_local();
  }
  return uVar2;
}
