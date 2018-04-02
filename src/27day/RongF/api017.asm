		[format "WCOFF"] ; mode for creating object files
        [instrset "i486p"] ; a statement that you want to use up to 486 instructions
        [bits 32] ; make machine language for 32 bit mode
        [file "api017.asm"] ; source file name information

global _api_inittimer
		
		[section .text]

_api_inittimer: ; void api_inittimer(int timer, int data)
        push ebx
        mov edx, 17
        mov ebx, [esp + 8]      ; timer
        mov eax, [esp + 12] ; data
        int 0x40
        pop ebx
        ret