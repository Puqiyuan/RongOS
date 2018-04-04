		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "api022.asm"]
		
		global _api_fclose

		[section .text]

_api_flose: ; void api_fclose(int fhandle)
		mov edx, 22
		mov eax, [esp + 4]
		int 0x40
		ret
		