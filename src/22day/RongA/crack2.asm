		[instrset "i486p"]
		[bits 32]
		mov eax, 1*8 ; segment number for OS
		mov ds, ax ; put it in ds
		mov byte [0x102600], 0
		mov edx, 4
		int 0x40