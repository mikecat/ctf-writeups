bool verify_sig(char *param_1,undefined8 param_2)

{
  int iVar1;
  BIO_METHOD *type;
  size_t sVar2;
  char *pcVar3;
  long in_FS_OFFSET;
  bool bVar4;
  undefined8 uVar5;
  RSA *local_110;
  FILE *local_108;
  size_t local_100;
  char *local_f8;
  BIO *local_f0;
  undefined8 local_e8;
  char *local_e0;
  undefined local_d8 [16];
  undefined local_c8 [16];
  undefined local_b8 [16];
  SHA256_CTX local_a8;
  uchar local_38 [40];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_108 = fopen("pubkey.pem","r");
  fseek(local_108,0,2);
  local_100 = ftell(local_108);
  rewind(local_108);
  local_f8 = (char *)malloc(local_100);
  fread(local_f8,1,local_100,local_108);
  fclose(local_108);
  type = BIO_s_mem();
  local_f0 = BIO_new(type);
  sVar2 = strlen(local_f8);
  BIO_write(local_f0,local_f8,(int)sVar2);
  local_e8 = 0;
  local_110 = RSA_new();
  PEM_read_bio_RSA_PUBKEY(local_f0,&local_110,(undefined1 *)0x0,(void *)0x0);
  BIO_free(local_f0);
  iVar1 = SHA256_Init(&local_a8);
  if (iVar1 != 0) {
    sVar2 = strlen(param_1);
    iVar1 = SHA256_Update(&local_a8,param_1,sVar2);
    if (iVar1 != 0) {
      iVar1 = SHA256_Final(local_38,&local_a8);
      if (iVar1 != 0) {
        __gmpz_inits(local_d8,local_c8,local_b8,0);
        __gmpz_set_str(local_d8,param_2,0x10);
        pcVar3 = BN_bn2hex(local_110->e);
        __gmpz_set_str(local_c8,pcVar3,0x10);
        pcVar3 = BN_bn2hex(local_110->n);
        __gmpz_set_str(local_b8,pcVar3,0x10);
        uVar5 = 0x401394;
        __gmpz_powm(local_d8,local_d8,local_c8,local_b8);
        local_e0 = (char *)__gmpz_export(0,0,0,1,0,0,local_d8,uVar5);
        __gmpz_clears(local_d8,local_c8,local_b8,0);
        iVar1 = strncmp(local_e0,(char *)local_38,0x20);
        bVar4 = iVar1 == 0;
        goto LAB_0040141a;
      }
    }
  }
  printf("Error verifying signature.");
  free(param_1);
  bVar4 = false;
LAB_0040141a:
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return bVar4;
}
