		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api003.asm"] ; source file name information

global _api_putstr1
		
		[section .text]

_api_putstr1: ; void api_putstr1(char *s, int l)
		push ebx
		mov edx, 3
		mov ebx, [esp + 8]; s
		mov ecx, [esp + 12] ; l
		int 0x40
		pop ebx
		ret