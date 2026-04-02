OUTPUT_FORMAT("elf32-littleriscv")
OUTPUT_ARCH("riscv")
ENTRY(_start)

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x04000000, LENGTH = 2M
  RAM   (rwx) : ORIGIN = 0x80000000, LENGTH = 2M
}

SECTIONS
{
  .text.init : ALIGN(64) { *(.text.init) } > FLASH

  .text : ALIGN(64)
  {
    *(.text*)
    *(.rodata*)
  } > FLASH

  . = ALIGN(16);
  PROVIDE(__global_pointer$ = .);

  .tohost : ALIGN(0x1000) { *(.tohost) } > RAM

  .data : ALIGN(16)
  {
    *(.data*)
    *(.sdata*)
  } > RAM

  .bss : ALIGN(16)
  {
    *(.bss*)
    *(.sbss*)
  } > RAM

  _end = .;
}