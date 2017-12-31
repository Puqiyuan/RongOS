; this program read 18 sectors.

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
db "FAT12   "
resb 18

entry:
	mov ax, 0
	mov ss, ax
	mov sp, 0x7c00
	mov ds, ax

	mov ax, 0x0820
	mov es, ax
	mov ch, 0
	mov dh, 0
	mov cl, 2

readloop:
	mov si, 0

retry:
	mov ah, 0x02
	mov al, 1
	mov bx, 0
	mov dl, 0x00
	int 0x13

	jnc next ; if no error, read the next sector
	add si, 1
	cmp si, 5
	jae error

	mov ah, 0x00 ; reset and retry
	mov dl, 0x00
	int 0x13

	jmp retry


next:
	mov ax, es ; move back memory space for next sector
	add ax, 0x0020
	mov es, ax

	add cl, 1 ; add one sector
	cmp cl, 18 ; one track 18 sectors
	jbe readloop
	ja correct ; if one track, 18 sectors successfully read, jump to
	; correct

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
db "read one track, 18 sectors"
db 0x0a
db 0
	
resb 0x7dfe - $
db 0x55, 0xaa
