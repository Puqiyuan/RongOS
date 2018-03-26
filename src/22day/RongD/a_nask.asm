		[format "WCOFF"] ; mode for creating object files
		[instrset "i486p"] ; a statement that you want to use up to 486 instructions
		[bits 32] ; make machine language for 32 bit mode
		[file "a_nask.asm"] ; source file name information

global _api_putchar
global _api_putstr0
global _api_end
		
		[section .text]

_api_putchar: ; void api_putchar(int c)
		mov edx, 1
		mov al, [esp + 4] ; c
		int 0x40
		ret

_api_putstr0: ;void api_putstr0(char *s)
		push ebx ; prepare parameters for 0x40 interrupt
		mov edx, 2
		mov ebx, [esp + 8] ; s
		int 0x40
		pop ebx
		ret
		
_api_end: ; void api_end(void)
		mov edx, 4
		int 0x40
