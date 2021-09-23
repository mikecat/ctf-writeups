undefined8 FUN_00101135(void)

{
  undefined8 local_28;
  undefined8 local_20;
  undefined local_18;
  int local_c;
  
  local_28 = 0x465d5a534f49444e;
  local_20 = 0x55494a4143494577;
  local_18 = 0;
  for (local_c = 0; local_c < 0x10; local_c = local_c + 1) {
    *(byte *)((long)&local_28 + (long)local_c) = *(byte *)((long)&local_28 + (long)local_c) ^ 0x28;
  }
  puts((char *)&local_28);
  return 0;
}
