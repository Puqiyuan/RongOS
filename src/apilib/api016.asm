		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api016.asm"] ; source file name information

global _api_alloctimer
		
		[section .text]

_api_alloctimer: ; int api_alloctimer(void)
        mov edx, 16
        int 0x40
        ret