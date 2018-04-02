		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api002.asm"] ; source file name information

global _api_putstr0
		
		[section .text]

_api_putstr0:                                   ;void api_putstr0(char *s)
        push ebx                                ; prepare parameters for 0x40 interrupt
        mov edx, 2
        mov ebx, [esp + 8]              ; s
        int 0x40
        pop ebx
        ret