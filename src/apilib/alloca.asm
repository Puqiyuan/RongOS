		[format "WCOFF"]
		[instrset "i486p"]
		[bits 32]
		[file "alloca.asm"]

global __alloca

		[section .text]

__alloca:
		add eax, -4
		sub esp, eax
		jmp dword [esp + eax] ; instead of ret