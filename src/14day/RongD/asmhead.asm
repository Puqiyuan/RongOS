BOTPAK equ 0x00280000 ; bootpack load destination
DSKCAC equ 0x00100000 ; disk cache location 
DSKCAC0	equ 0x00008000 ; disk cache location(real mode)
CYLS equ 0x0ff0 ; set by boot sector
LEDS equ 0x0ff1
VMODE equ 0x0ff2 ; information on color number. how many bit colors.
SCRNX equ 0x0ff4 ; resolution X
SCRNY equ 0x0ff6 ; resolution Y
VRAM equ 0x0ff8 ; graphic buffer start address.

org 0xc200 ; where will this program load?
	mov bx,0x4101 ; VGA graphics, 320 * 200 * 8 bit color.
	mov ax,0x4f02
	int 0x10
	mov BYTE [VMODE],8 ; record mode graphics(C language)
	mov WORD [SCRNX],640
	mov WORD [SCRNY],480
	mov DWORD [VRAM],0xe0000000

; have the BIOS tell the status of the keyboard.
	mov ah,0x02
	int 0x16 ; keyboard BIOS
	mov [LEDS],al

; make sure that PIC does not accept any interrupts
; with AT compatible machine specifications, if you initialize PIC.
; Hang up occasionally if you do not do this before CLI.
; Initialize PIC later.
	mov al,0xff
	out 0x21,al
	nop ; if the out command is executed continuously, some models will not work normally.
	out 0xa1,al
	cli ; in addition, interrupt disabled even at CPU level.

	; set A20GATE so that CPU can access 1 MB or more of memory.
	call waitkbdout
	mov al,0xd1
	out 0x64,al
	call waitkbdout
	mov al,0xdf ; enable A20
	out 0x60,al
	call waitkbdout

	; transition to protect mode
	[INSTRSET "i486p"] ; a statement that you want to use up to 486 instructions.

	LGDT	[GDTR0] ; set interim GDT
	mov eax,cr0
	and eax,0x7fffffff ; set bit 31 to 0(because paging is prohibited)
	or eax,0x00000001 ; set bit 0 to 1(for protect mode transition)
	mov cr0,eax
	jmp pipelineflush
pipelineflush:
	mov ax,1*8 ; readable / writable segment 32 bits.
	mov ds,ax
	mov es,ax
	mov fs,ax
	mov gs,ax
	mov ss,ax

; transfer bootpack
	mov esi,bootpack
	mov edi,BOTPAK
	mov ecx,512*1024/4
	call memcpy

; also transfer disk data to its original position
; first from the boot sector
	mov esi,0x7c00 ; transfer source
	mov edi,DSKCAC ; forwarding destination
	mov ecx,512/4
	call memcpy

; all remaining
	mov esi,DSKCAC0+512 ; transfer source
	mov edi,DSKCAC+512 ; forwarding destination
	mov ecx,0
	mov cl,BYTE [CYLS]
	imul ecx,512*18*2/4 ; convert from cylinder number to byte number / 4
	sub ecx,512/4 ; subtract as musch as IPL.
	call memcpy

; since asmead has finished everything we have to do, I will leave it to bootpack.
; start bootpack
	
	mov ebx,BOTPAK
	mov ecx,[ebx+16]
	add ecx,3	 ; exc += 3
	shr ecx,2 ; ecx /= 4
	jz skip ; there is nothing to transfer
	mov esi,[ebx+20] ; transfer source
	add esi,ebx
	mov edi,[ebx+12] ; transfer destination
	call memcpy
skip:
	mov esp,[ebx+12] ; stack initial value.
	jmp DWORD 2*8:0x0000001b

waitkbdout:
	in al,0x64
	and al,0x02
	jnz waitkbdout ; if and result is not 0, go to waitkbdout.
	ret
memcpy:
	mov eax,[esi]
	add esi,4
	mov [edi],eax
	add edi,4
	sub ecx,1
	jnz memcpy ; if the subtraction result is not 0, go to memcpy.
	ret
alignb	16
GDT0:
resb 8 ; null selector
dw 0xffff,0x0000,0x9200,0x00cf ; readable / writable segment 32 bits.
dw 0xffff,0x0000,0x9a28,0x0047 ; executable segment 32 bits(for ootpack)
dw 0
GDTR0:
dw 8*3-1
dd GDT0
alignb 16
bootpack:
