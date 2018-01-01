BOOT_INFO
	cyls equ 0x0ff0 
	leds equ 0x0ff1
	vmode equ 0x0ff2
	scrnx equ 0x0ff4
	scrny equ 0x0ff6
	vram equ 0x0ff8

org 0xc200 ; load these instructions to memory c200

	mov al, 0x13 ; VGA video card, 320 * 200 * 8 bit
	mov ah, 0x00
	int 0x10
	mov byte [vmode], 8 ; vmode
	
	mov word [scrnx], 320
	mov word [scrny], 200
	mov dword [vram], 0x000a0000

	;the status of keyboard 
	mov ah, 0x02
	int 0x16
	mov [leds], al
	

fin:
    hlt
    jmp fin
