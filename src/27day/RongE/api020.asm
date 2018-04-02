		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api020.asm"] ; source file name information

global _api_beep
		
		[section .text]

_api_beep: ; void api_beep(int tone)
        mov edx, 20
        mov eax, [esp + 4] ; tone
        int 0x40
        ret