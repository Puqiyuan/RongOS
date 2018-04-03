		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api013.asm"] ; source file name information

global _api_linewin
		
		[section .text]

_api_linewin:                                           ;void api_linewin(int win, int x0, int y0, int x1, int y1, int col)
        push edi
        push esi
        push ebp
        push ebx
        mov edx, 13
        mov ebx, [esp + 20]                     ; win
        mov eax, [esp + 24]                     ; x0
        mov ecx, [esp + 28]                     ; y0
        mov esi, [esp + 32]                     ; x1
        mov edi, [esp + 36]                     ; y1
        mov ebp, [esp + 40]                     ; col
        int 0x40
        pop ebx
        pop ebp
        pop esi
        pop edi
        ret