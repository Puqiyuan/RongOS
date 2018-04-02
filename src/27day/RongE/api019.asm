		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api019.asm"] ; source file name information

global _api_freetimer
		
		[section .text]

_api_freetimer: ; void api_freetimer(int timer)
        push ebx
        mov edx, 19
        mov ebx, [esp + 8] ; timer
        int 0x40
        pop ebx
        ret