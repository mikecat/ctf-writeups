undefined8 main(void)

{
  long in_FS_OFFSET;
  int local_30;
  int local_2c;
  int local_28;
  int local_24;
  FILE *local_20;
  void *local_18;
  long local_10;
  
  local_10 = *(long *)(in_FS_OFFSET + 0x28);
  setlinebuf(stdout);
  puts("hi can you plan me a tour around the world that doesn\'t make me broke thanks");
  puts("if the tour makes me happy then i\'ll give you the flag :)");
  local_2c = 0x898;
  local_28 = 0;
  do {
    if (local_2c < 0) {
      puts("aw man im broke now");
      puts("no flag for you");
LAB_00101456:
      if (local_10 != *(long *)(in_FS_OFFSET + 0x28)) {
                    /* WARNING: Subroutine does not return */
        __stack_chk_fail();
      }
      return 0;
    }
    putchar(10);
    if ((vis == 0) && (local_28 == 0)) {
      puts("i like this tour");
      puts("i guess i\'ll give you the flag now");
      local_20 = fopen("flag.txt","rb");
      if (local_20 == (FILE *)0x0) {
        puts("If this is running on the server, please contact an admin.");
      }
      else {
        local_18 = malloc(0x28);
        fread(local_18,1,0x27,local_20);
        printf("%s",local_18);
      }
      goto LAB_00101456;
    }
    puts("im not happy with the tour yet");
    puts("where to go next???");
    __isoc99_scanf(&DAT_0010214b,&local_30);
    if ((local_30 < 0) || (0xe < local_30)) {
      puts("i don\'t like that city");
    }
    else {
      local_2c = local_2c - *(int *)(cost + ((long)local_28 * 0xf + (long)local_30) * 4);
      local_28 = local_30;
      vis = vis & ~(1 << ((byte)local_30 & 0x1f));
    }
    do {
      local_24 = getchar();
      if (local_24 == 10) break;
    } while (local_24 != -1);
  } while( true );
}
