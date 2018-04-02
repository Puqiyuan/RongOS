		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api009.asm"] ; source file name information

global _api_malloc
		
		[section .text]

_api_malloc:                                    ; char *api_malloc(int size)
        push ebx
        mov edx, 9
        mov ebx, [cs:0x0020]
        mov ecx, [esp+8]                ; size
        int 0x40
        pop ebx
        ret