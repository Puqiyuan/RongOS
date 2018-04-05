		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "api027.asm"]

global _api_getlang

		[section .text]

_api_getlang: ; int api_getlang(void)
		mov edx, 27
		int 0x40
		ret