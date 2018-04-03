		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api018.asm"] ; source file name information

global _api_settimer
		
		[section .text]

_api_settimer: ; api_settimer(int timer, int time)
        push ebx
        mov edx, 18
        mov ebx, [esp + 8] ; timer
        mov eax, [esp + 12] ; time
        int 0x40
        pop ebx
        ret
