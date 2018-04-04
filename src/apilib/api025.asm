		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "api025.asm"]

global _api_fread

		[section .text]

_api_fread: ; int api_fread(char *buf, int maxsize, int fhanle)
		push ebx
		mov edx, 25
		mov eax, [esp + 16] ; fhandle
		mov ecx, [esp + 12] ; maxsize
		mov ebx, [esp + 8] ; buf
		int 0x40
		pop ebx
		ret