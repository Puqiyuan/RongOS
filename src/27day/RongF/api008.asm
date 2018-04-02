		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api008.asm"] ; source file name information

global _api_initmalloc
		
		[section .text]

_api_initmalloc:                                ; void api_initmalloc(void)
        push ebx
        mov edx, 8
        mov ebx, [cs:0x0020]    ; the address of malloc space
        mov eax, ebx
        add eax, 32 * 1024              ; add 32KB
        mov ecx, [cs: 0x0000]   ; the size of data segment
        sub ecx, eax
        int 0x40
        pop ebx
        ret