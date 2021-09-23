undefined8 main(undefined4 param_1)

{
  int iVar1;
  size_t sVar2;
  long in_FS_OFFSET;
  undefined4 local_64c;
  char local_648 [256];
  char local_548 [303];
  char acStack1049 [1033];
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  local_64c = param_1;
  setvbuf(stdout,(char *)0x0,2,0);
  setvbuf(stdin,(char *)0x0,2,0);
  setvbuf(stderr,(char *)0x0,2,0);
  puts("       Welcome to the Hotel Codeifornia");
  puts("Esteemed secure code execution service since 1969\n");
  puts("If you have a booking, please sign the guestbook below.");
  printf("Enter code> ");
  fgets(local_648,0xff,stdin);
  sVar2 = strlen(local_648);
  local_648[sVar2 - 1] = '\0';
  printf("And just sign here please, sir> ");
  fgets(acStack1049 + 1,0x400,stdin);
  sVar2 = strlen(acStack1049 + 1);
  acStack1049[sVar2] = '\0';
  iVar1 = verify_sig(local_648,acStack1049 + 1);
  if (iVar1 == 0) {
    puts("\nI\'m sorry, sir, but you don\'t appear to be on the guestbook.");
  }
  else {
    sprintf(local_548,"python -c \'%s\'",local_648);
    putchar(10);
    system(local_548);
  }
  if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
    __stack_chk_fail();
  }
  return 0;
}
