		[format "WCOFF"]
		[instrset 'i486p']
		[bits 32]
		[file "api021.asm"]

global _api_fopen

		[section .text]

_api_fopen: ; int api_fopen(char *fname)
		push ebx
		mov edx, 21
		mov ebx, [esp + 8] ; fname
		int 0x40
		pop ebx
		ret
		