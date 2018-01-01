	[format "WCOFF"]
	[instrset "i486p"]
	[bits 32]
	[file "naskfunc.asm"]

global _io_hlt, _write_mem8

	[section .text]

_io_hlt:
	hlt
	ret

_write_mem8:
	mov ecx, [esp + 4]
	mov al, [esp + 8]
	mov [ecx], al
	ret