		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api012.asm"] ; source file name information

global _api_refreshwin
		
		[section .text]

_api_refreshwin:                                ; void api_refreshwin(int win, int x0, int y0, int x1, int y1)
        push edi
        push esi
        push ebx
        mov edx, 12
        mov ebx, [esp + 16]             ; win
        mov eax, [esp + 20]             ; x0
        mov ecx, [esp + 24]             ; y0
        mov esi, [esp + 28]             ; x1
        mov edi, [esp + 32]                     ; y1
        int 0x40
        pop ebx
        pop esi
        pop edi
        ret