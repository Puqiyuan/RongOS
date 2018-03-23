		[bits 32]
		mov al, 'A'
		call 2*8:0xbe3
fin:
		hlt
		jmp fin