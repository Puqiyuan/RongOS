		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api014.asm"] ; source file name information

global _api_closewin
		
		[section .text]

_api_closewin: ; void api_closewin(int win)
        push ebx
        mov edx, 14
        mov ebx, [esp + 8] ; win
        int 0x40
        pop ebx
        ret