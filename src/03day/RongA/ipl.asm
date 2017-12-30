org 0x7c00

	jmp entry
db 0x90
db "ROOSBOTE"
dw 512
db 1
dw 1
db 2
dw 224
dw 2880
db 0xf0
dw 9
dw 18
dw 2
dd 0
dd 2880
db 0, 0, 0x29
dd 0xffffffff
db "ROOSBOTEOS "
db "FAT12    "
resb 18

entry:
	mov ax, 0
	mov ss, ax
	mov sp, 0x7c00
	mov ds, ax

	mov ax, 0x0820
	mov es, ax
	mov ch, 0 ; cylinder 0
	mov dh, 0 ; header 0
	mov cl, 2 ; sector 2

	mov ah, 0x01; read sector
	mov al, 1 ; continue processing one sector
	mov bx, 0
	mov dl, 0x00 ; A driver
	int 0x13 ; call interrupt 13

	jc error ; error occurs, goto error label.
	jnc correct ; no error, goto correct label.


fin:
	hlt
	jmp fin

error:
	mov si, msg
	jmp putloop
	
correct:
	mov si, msg_cor
	jmp putloop

putloop:
	mov al, [si]
	add si, 1
	cmp al, 0
	je fin
	mov ah, 0x0e
	mov bx, 15
	int 0x10

	jmp putloop

msg:
db 0x0a, 0x0a
db "load error"
db 0x0a
db 0
	
msg_cor:
db 0x0a, 0x0a
db "load OK"
db 0x0a
db 0
	
resb 0x7dfe- $
db 0x55, 0xaa