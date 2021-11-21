/* rust_rev_1::main */

void rust_rev_1::main(void)

{
  u8 *__src;
  char extraout_AL;
  undefined8 uVar1;
  uint *this;
  void **__ptr;
  undefined auVar2 [16];
  undefined8 in_stack_ffffffffffffff68;
  int iVar3;
  undefined4 uVar4;
  undefined8 in_stack_ffffffffffffff88;
  undefined local_60 [16];
  usize uStack80;
  uint *local_48;
  alloc *paStack64;
  alloc *local_38;
  Stdin local_30;
  
  stack0xffffffffffffffa8 = (undefined  [16])0x0;
  local_60._0_8_ = (u8 *)0x1;
  local_48 = (uint *)0x1;
  paStack64 = (alloc *)0x0;
                    /* try { // try from 00108986 to 001089a6 has its CatchHandler @ 00108c76 */
  std::io::stdio::_print
            ((stdio *)&stack0xffffffffffffff70,
             (Arguments)
             CONCAT840(0x13e040,CONCAT832(in_stack_ffffffffffffff88,
                                          ZEXT2432(CONCAT816(1,ZEXT1216(CONCAT48(0x14c198,
                                                  in_stack_ffffffffffffff68)))))));
  uVar1 = std::io::stdio::stdout();
  iVar3 = (int)uVar1;
  uVar4 = (undefined4)((ulong)uVar1 >> 0x20);
  std::io::stdio::{impl#12}::flush((Stdout *)&stack0xffffffffffffff70);
  if (extraout_AL == '\x03') {
                    /* WARNING: Load size is inaccurate */
                    /* try { // try from 001089b5 to 001089b6 has its CatchHandler @ 00108c3f */
    (**__ptr[1])(*__ptr);
    if (*(long *)((long)__ptr[1] + 8) != 0) {
      std::alloc::__default_lib_allocator::__rust_dealloc(*__ptr);
    }
    std::alloc::__default_lib_allocator::__rust_dealloc(__ptr);
  }
                    /* try { // try from 001089e4 to 00108a03 has its CatchHandler @ 00108c76 */
  local_30 = (Mutex<std--io--buffered--bufreader--BufReader<std--io--stdio--StdinRaw>> *)
             std::io::stdio::stdin();
  std::io::stdio::Stdin::read_line
            ((Result<usize,std--io--error--Error> *)&stack0xffffffffffffff70,&local_30,
             (String *)local_60);
  __src = local_60._0_8_;
  if (iVar3 == 1) {
                    /* try { // try from 00108bdb to 00108bff has its CatchHandler @ 00108c58 */
    core::result::unwrap_failed
              ((&str)CONCAT412(uVar4,CONCAT48(1,in_stack_ffffffffffffff68)),
               (&dyncore--fmt--Debug)CONCAT88(paStack64,local_48));
    goto LAB_00108c3d;
  }
  if (((uStack80 == 0) || (local_60._0_8_ == (u8 *)0x0)) || (local_60._0_8_[uStack80 - 1] != 10)) {
                    /* try { // try from 00108bb4 to 00108bcc has its CatchHandler @ 00108c76 */
    core::option::expect_failed((&str)CONCAT412(uVar4,CONCAT48(iVar3,in_stack_ffffffffffffff68)));
    goto LAB_00108c3d;
  }
  paStack64 = (alloc *)(uStack80 - 1);
  if (paStack64 == (alloc *)0x0) {
    this = (uint *)0x1;
  }
  else {
    this = (uint *)std::alloc::__default_lib_allocator::__rust_alloc((usize)paStack64,1);
    if (this == (uint *)0x0) {
      alloc::alloc::handle_alloc_error
                (paStack64,(Layout)CONCAT412(uVar4,CONCAT48(iVar3,in_stack_ffffffffffffff68)));
      do {
        invalidInstructionException();
      } while( true );
    }
  }
  memcpy(this,__src,(size_t)paStack64);
  local_48 = this;
  local_38 = paStack64;
  if (paStack64 < (alloc *)&DAT_00000006) {
    if (paStack64 != (alloc *)&DAT_00000005) goto LAB_00108c23;
  }
  else {
    if (*(char *)((long)this + 5) < -0x40) {
LAB_00108c23:
      core::str::slice_error_fail
                ((str *)this,(&str)CONCAT412(uVar4,CONCAT48(iVar3,in_stack_ffffffffffffff68)),
                 (usize)paStack64,0);
      goto LAB_00108c3d;
    }
    if (((alloc *)(uStack80 - 2) < paStack64) &&
       (-0x41 < (char)*(alloc *)((long)this + (long)(alloc *)(uStack80 - 2)))) {
      if ((((*(byte *)(this + 1) ^ 0x7b | *this ^ 0x67616c66) == 0) && (uStack80 == 0x1e)) &&
         ((*(char *)(this + 7) == '}' &&
          (auVar2 = CONCAT115(-(*(char *)(this + 5) == '7'),
                              CONCAT114(-(*(char *)((long)this + 0x13) == 'd'),
                                        CONCAT113(-(*(char *)((long)this + 0x12) == '7'),
                                                  CONCAT112(-(*(char *)((long)this + 0x11) == '7'),
                                                            CONCAT111(-(*(char *)(this + 4) == '5'),
                                                                      CONCAT110(-(*(char *)((long)
                                                  this + 0xf) == '1'),
                                                  CONCAT19(-(*(char *)((long)this + 0xe) == '9'),
                                                           CONCAT18(-(*(char *)((long)this + 0xd) ==
                                                                     '6'),CONCAT17(-(*(char *)(this 
                                                  + 3) == '9'),
                                                  CONCAT16(-(*(char *)((long)this + 0xb) == 'c'),
                                                           CONCAT15(-(*(char *)((long)this + 10) ==
                                                                     'd'),CONCAT14(-(*(char *)((long
                                                  )this + 9) == '4'),
                                                  CONCAT13(-(*(char *)(this + 2) == 'e'),
                                                           CONCAT12(-(*(char *)((long)this + 7) ==
                                                                     '6'),CONCAT11(-(*(char *)((long
                                                  )this + 6) == '9'),
                                                  -(*(char *)((long)this + 5) == '3'))))))))))))))))
                    & CONCAT115(-(*(char *)((long)this + 0x1b) == 'a'),
                                CONCAT114(-(*(char *)((long)this + 0x1a) == '2'),
                                          CONCAT113(-(*(char *)((long)this + 0x19) == 'a'),
                                                    CONCAT112(-(*(char *)(this + 6) == '0'),
                                                              CONCAT111(-(*(char *)((long)this +
                                                                                   0x17) == '1'),
                                                                        CONCAT110(-(*(char *)((long)
                                                  this + 0x16) == '2'),
                                                  CONCAT19(-(*(char *)((long)this + 0x15) == '3'),
                                                           CONCAT18(-(*(char *)(this + 5) == '7'),
                                                                    CONCAT17(-(*(char *)((long)this
                                                                                        + 0x13) ==
                                                                              'd'),CONCAT16(-(*(char
                                                                                                *)((
                                                  long)this + 0x12) == '7'),
                                                  CONCAT15(-(*(char *)((long)this + 0x11) == '7'),
                                                           CONCAT14(-(*(char *)(this + 4) == '5'),
                                                                    CONCAT13(-(*(char *)((long)this
                                                                                        + 0xf) ==
                                                                              '1'),CONCAT12(-(*(char
                                                                                                *)((
                                                  long)this + 0xe) == '9'),
                                                  CONCAT11(-(*(char *)((long)this + 0xd) == '6'),
                                                           -(*(char *)(this + 3) == '9')))))))))))))
                                                  ))),
          (ushort)((ushort)(SUB161(auVar2 >> 7,0) & 1) | (ushort)(SUB161(auVar2 >> 0xf,0) & 1) << 1
                   | (ushort)(SUB161(auVar2 >> 0x17,0) & 1) << 2 |
                   (ushort)(SUB161(auVar2 >> 0x1f,0) & 1) << 3 |
                   (ushort)(SUB161(auVar2 >> 0x27,0) & 1) << 4 |
                   (ushort)(SUB161(auVar2 >> 0x2f,0) & 1) << 5 |
                   (ushort)(SUB161(auVar2 >> 0x37,0) & 1) << 6 |
                   (ushort)(SUB161(auVar2 >> 0x3f,0) & 1) << 7 |
                   (ushort)(SUB161(auVar2 >> 0x47,0) & 1) << 8 |
                   (ushort)(SUB161(auVar2 >> 0x4f,0) & 1) << 9 |
                   (ushort)(SUB161(auVar2 >> 0x57,0) & 1) << 10 |
                   (ushort)(SUB161(auVar2 >> 0x5f,0) & 1) << 0xb |
                   (ushort)(SUB161(auVar2 >> 0x67,0) & 1) << 0xc |
                   (ushort)(SUB161(auVar2 >> 0x6f,0) & 1) << 0xd |
                   (ushort)(SUB161(auVar2 >> 0x77,0) & 1) << 0xe |
                  (ushort)SUB161(auVar2 >> 0x7f,0) << 0xf) == 0xffff)))) {
        std::io::stdio::_print
                  ((stdio *)&stack0xffffffffffffff70,
                   (Arguments)
                   CONCAT840(0x13e040,CONCAT832(in_stack_ffffffffffffff88,
                                                ZEXT2432(CONCAT816(1,ZEXT1216(CONCAT48(0x14c178,
                                                  in_stack_ffffffffffffff68)))))));
      }
      else {
                    /* try { // try from 00108af7 to 00108bae has its CatchHandler @ 00108c67 */
        std::io::stdio::_print
                  ((stdio *)&stack0xffffffffffffff70,
                   (Arguments)
                   CONCAT840(0x13e040,CONCAT832(in_stack_ffffffffffffff88,
                                                ZEXT2432(CONCAT816(1,ZEXT1216(CONCAT48(0x14c188,
                                                  in_stack_ffffffffffffff68)))))));
      }
      std::alloc::__default_lib_allocator::__rust_dealloc(this);
      if (local_60._8_8_ != 0) {
        std::alloc::__default_lib_allocator::__rust_dealloc(local_60._0_8_);
      }
      return;
    }
  }
                    /* try { // try from 00108c09 to 00108c3c has its CatchHandler @ 00108c67 */
  core::str::slice_error_fail
            ((str *)this,(&str)CONCAT412(uVar4,CONCAT48(iVar3,in_stack_ffffffffffffff68)),
             (usize)paStack64,5);
LAB_00108c3d:
  do {
    invalidInstructionException();
  } while( true );
}
