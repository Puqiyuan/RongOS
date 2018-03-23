		[bits 32]
		mov al, 'A'
		call 0xbe3
fin:
		hlt
		jmp fin