		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "crack7.asm"]

global _HariMain

		[section .text]

_HariMain:
		mov ax, 1005 * 8;
		mov ds, ax
		cmp dword [ds:0x0004], 'Rong'
		jne fin ; it does not seem to be an application, so do not do anything
		mov ecx, [ds:0x0000] ; read the size of the data segment of this application
		mov ax, 2005 * 8
		mov ds, ax

crackloop:
		add ecx, -1
		mov byte [ds:ecx], 123
		cmp ecx, 0
		jne crackloop

fin:
		mov edx, 4
		int 0x40