		[instrset "i486p"]
		[bits 32]
		mov ecx, msg
		mov edx, 1
putloop:
		mov al, [cs:ecx]
		cmp al, 0
		je fin
		int 0x40
		add ecx, 1
		jmp putloop

fin:
		retf
msg:
		db "hello", 0