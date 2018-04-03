		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api015.asm"] ; source file name information

global _api_getkey
		
		[section .text]

_api_getkey: ; int api_getkey(int mode)
        mov edx, 15
        mov eax, [esp + 4]; mode
        int 0x40
        ret