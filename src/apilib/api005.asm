		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api005.asm"] ; source file name information

global _api_openwin
		
		[section .text]

_api_openwin:                                   ; int api_openwin(char *buf, int xsiz, int ysiz, int col_inv, char *title);
        push edi
        push esi
        push ebx
        mov edx, 5
        mov ebx, [esp + 16]             ; buf
        mov esi, [esp + 20]             ; xsiz
        mov edi, [esp + 24]             ; ysiz
        mov eax, [esp + 28]             ; col_inv
        mov ecx, [esp + 32]             ; title
        int 0x40
        pop ebx
        pop esi
        pop edi
        ret