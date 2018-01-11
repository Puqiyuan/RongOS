	[FORMAT "WCOFF"]
	[INSTRSET "i486p"]
	[BITS 32]
	[FILE "naskfunc.nas"]

GLOBAL _io_hlt, _io_cli, _io_sti, _io_stihlt
GLOBAL _io_in8, _io_in16, _io_in32
GLOBAL _io_out8, _io_out16, _io_out32
GLOBAL _io_load_eflags, _io_store_eflags
GLOBAL _load_gdtr, _load_idtr
GLOBAL _asm_inthandler21, _asm_inthandler27, _asm_inthandler2c
extern _inthandler21, _inthandler27, _inthandler2c

	[SECTION .text]

_io_hlt: ;void io_hlt(void)
	hlt
	ret

_io_cli: ;void io_cli(void)
	cli
	ret

_io_sti: ;void io_sti(void)
	sti
	ret

_io_stihlt: ;void io_stihlt(void)
	sti
	hlt
	ret

_io_in8: ; int io_in8(int port)
	mov edx, [esp + 4]
	mov eax, 0
	in al, dx
	ret

_io_in16: ;int io_in16(int port)
	mov edx, [esp + 4]
	mov eax, 0
	in ax, dx
	ret

_io_in32: ;int io_in32(int port)
	mov edx, [esp + 4]
	in eax, dx
	ret

_io_out8: ;void io_out8(int port, int data)
	mov edx, [esp + 4]
	mov al, [esp + 8]
	out dx, al
	ret

_io_out16: ;void io_out16(int port, int data)
	mov edx, [esp + 4]
	mov eax, [esp + 8]
	out dx, ax
	ret

_io_out32: ;void io_out32(int port, int data)
	mov edx, [esp + 4]
	mov eax, [esp + 8]
	out dx, eax
	ret

_io_load_eflags: ;int io_load_eflags(void)
	pushfd
	pop eax
	ret

_io_store_eflags: ;void io_store_elfags(int eflags)
	mov eax, [esp + 4]
	push eax
	popfd
	ret

_load_gdtr: ;void load_gdtr(int limit, int addr);
	mov ax, [esp + 4]
	mov [esp + 6], ax
	lgdt [esp + 6]
	ret

_load_idtr: ;void load_idtr(int limit, int addr);
	mov ax, [esp + 4]
	mov [esp + 6], ax
	lidt [esp + 6]
	ret
	
_asm_inthandler21:
	push es
	push ds
	pushad
	mov eax, esp
	push eax
	mov ax, ss
	mov ds, ax
	mov es, ax
	call _inthandler21 ; in int.c
	pop eax
	popad
	pop ds
	pop es
	iretd

_asm_inthandler27:
	push es
	push ds
	pushad
	mov eax, esp
	push eax
	mov ax, ss
	mov ds, ax
	mov es, ax
	call _inthandler27
	pop eax
	popad
	pop ds
	pop es
	iretd

_asm_inthandler2c:
	push es
	push ds
	pushad
	mov eax, esp
	push eax
	mov ax, ss
	mov ds, ax
	mov es, ax
	call _inthandler2c
	pop eax
	popad
	pop ds
	pop es
	iretd