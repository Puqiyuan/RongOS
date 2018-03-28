		[format "WCOFF"] ; mode for creating object files
		[instrset "i486p"] ; a statement that you want to use up to 486 instructions
		[bits 32] ; make machine language for 32 bit mode
		[file "a_nask.asm"] ; source file name information

global _api_putchar
global _api_putstr0
global _api_end
global _api_openwin
global _api_putstrwin
global _api_boxfilwin
						
		[section .text]

_api_putchar: ; void api_putchar(int c)
		mov edx, 1
		mov al, [esp + 4] ; c
		int 0x40
		ret

_api_putstr0: ;void api_putstr0(char *s)
		push ebx ; prepare parameters for 0x40 interrupt
		mov edx, 2
		mov ebx, [esp + 8] ; s
		int 0x40
		pop ebx
		ret
		
_api_end: ; void api_end(void)
		mov edx, 4
		int 0x40

_api_openwin: ; int api_openwin(char *buf, int xsiz, int ysiz, int col_inv, char *title);
		push edi
		push esi
		push ebx
		mov edx, 5
		mov ebx, [esp + 16] ; buf
		mov esi, [esp + 20] ; xsiz
		mov edi, [esp + 24] ; ysiz
		mov eax, [esp + 28] ; col_inv
		mov ecx, [esp + 32] ; title
		int 0x40
		pop ebx
		pop esi
		pop edi
		ret

_api_putstrwin: ; void api_putstrwin(int win, int x, int y, int col, int len, char *str)
		push edi
		push esi
		push ebp
		push ebx
		mov edx, 6
		mov ebx, [esp + 20] ; win
		mov esi, [esp + 24] ; x
		mov edi, [esp + 28] ; y
		mov eax, [esp + 32] ; col
		mov ecx, [esp + 36] ; len
		mov ebp, [esp + 40] ; str
		int 0x40
		pop ebx
		pop ebp
		pop esi
		pop edi
		ret

_api_boxfilwin: ; void api_boxfilwin(int win, int x0, int y0, int x1, int y1, int col)
		push edi
		push esi
		push ebp
		push ebx
		mov edx, 7
		mov ebx, [esp + 20] ; win
		mov eax, [esp + 24] ; x0
		mov ecx, [esp + 28] ; y0
		mov esi, [esp + 32] ; x1
		mov edi, [esp + 36] ; y1
		mov ebp, [esp + 40] ; col
		int 0x40
		pop ebx
		pop ebp
		pop esi
		pop edi
		ret
		