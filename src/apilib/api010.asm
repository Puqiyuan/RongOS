		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api010.asm"] ; source file name information

global _api_free
		
		[section .text]

_api_free:                                              ; void api_free(char *addr, int size)
        push ebx
        mov edx, 10
        mov ebx, [cs:0x0020]
        mov eax, [esp+8]                ; addr
        mov ecx, [esp+12]               ; size
        int 0x40
        pop ebx
        ret