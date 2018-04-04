		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "api024.asm"]

global _api_fsize

		[section .text]

_api_fsize: ; int api_fsize(int fhandle, int mode)
		mov edx, 24
		mov eax, [esp + 4] ; fhanlde
		mov ecx, [esp + 8] ; mode
		int 0x40
		ret