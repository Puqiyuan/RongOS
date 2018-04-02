		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api011.asm"] ; source file name information

global _api_point
		
		[section .text]

_api_point:                                             ; void api_point(int win, int x, int y, int col)
        push edi
        push esi
        push ebx
        mov edx, 11
        mov ebx, [esp + 16]             ; win
        mov esi, [esp + 20]             ; x
        mov edi, [esp + 24]             ; y
        mov eax, [esp + 28]             ; col
        int 0x40
        pop ebx
        pop esi
        pop edi
        ret