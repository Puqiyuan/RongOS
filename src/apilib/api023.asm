		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "apio23.asm"]

global _api_fseek

		[section .text]

_api_fseek: ; void api_fseek(int fhandle, int offset, int mode)
		push ebx
		mov edx, 23
		mov eax, [esp + 8]
		mov ecx, [esp + 16]
		mov ebx, [esp + 12]
		int 0x40
		pop ebx
		ret
		