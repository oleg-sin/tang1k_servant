OUTPUT_ARCH( "riscv" )
ENTRY(_start)
MEMORY {
  RAM (rwx) : ORIGIN = 0x00000000, LENGTH = 8k
}

SECTIONS
{
  .text : {
    *(.text)
  } > RAM

  .data : {
    *(.data)
  } > RAM

  .bss : {
    *(.bss)
    . = ALIGN(4);
    _stack_end = .;
  } > RAM
}
