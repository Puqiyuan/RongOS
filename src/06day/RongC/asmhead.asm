BOTPAK equ 0x00280000
DSKCAC equ 0x00100000
DSKCAC0	equ 0x00008000
CYLS equ 0x0ff0
LEDS equ 0x0ff1
VMODE equ 0x0ff2
SCRNX equ 0x0ff4
SCRNY equ 0x0ff6
VRAM equ 0x0ff8

org 0xc200
	mov al,0x13
	mov ah,0x00
	int 0x10
	mov BYTE [VMODE],8
	mov WORD [SCRNX],320
	mov WORD [SCRNY],200
	mov DWORD [VRAM],0x000a0000
	mov ah,0x02
	int 0x16
	mov [LEDS],al
	
	mov al,0xff
	out 0x21,al
	nop
	out 0xa1,al
	cli
	
	call waitkbdout
	mov al,0xd1
	out 0x64,al
	call waitkbdout
	mov al,0xdf			
	out 0x60,al
	call waitkbdout

[INSTRSET "i486p"]

	LGDT	[GDTR0]	
	mov eax,cr0
	and eax,0x7fffffff
	or eax,0x00000001
	mov cr0,eax
	jmp pipelineflush
pipelineflush:
	mov ax,1*8
	mov ds,ax
	mov es,ax
	mov fs,ax
	mov gs,ax
	mov ss,ax

	mov esi,bootpack
	mov edi,BOTPAK
	mov ecx,512*1024/4
	call memcpy

	mov esi,0x7c00
	mov edi,DSKCAC
	mov ecx,512/4
	call memcpy

	mov esi,DSKCAC0+512
	mov edi,DSKCAC+512
	mov ecx,0
	mov cl,BYTE [CYLS]
	imul ecx,512*18*2/4
	sub ecx,512/4
	call memcpy

	mov ebx,BOTPAK
	mov ecx,[ebx+16]
	add ecx,3	
	shr ecx,2
	jz skip
	mov esi,[ebx+20]
	add esi,ebx
	mov edi,[ebx+12]
	call memcpy
skip:
	mov esp,[ebx+12]
	jmp DWORD 2*8:0x0000001b

waitkbdout:
	in al,0x64
	and al,0x02
	jnz waitkbdout
	ret
memcpy:
	mov eax,[esi]
	add esi,4
	mov [edi],eax
	add edi,4
	sub ecx,1
	jnz memcpy
	ret
alignb	16
GDT0:
resb 8
dw 0xffff,0x0000,0x9200,0x00cf	
dw 0xffff,0x0000,0x9a28,0x0047
dw 0
GDTR0:
dw 8*3-1
dd GDT0
alignb 16
bootpack:
