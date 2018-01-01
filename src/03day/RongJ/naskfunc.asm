	[format "WCOFF"] ; format of object file
	[bits 32] ; 32 bit mode machine code

	[file "naskfunc.asm"]
global _io_hlt ; name of function

	[section .text]

_io_hlt: ; void io_hlt(void) function
	hlt
	ret
	