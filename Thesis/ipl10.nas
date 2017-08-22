	CYLS equ 10
	
org 0x7c00
	jmp entry
	; The next codes specify the format of standard FAT12 floppy disk.
db 0x90 ; db is the abbreation of "define byte", it literally places that byte
	; right there in the executable.
db "RONGBOOT" ; The name of boot sector, muse be 8 byte.
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
db 0,0,0x29
dd 0xffffffff
db "RONGBOOTOS "
db "FAT12   "
resb 18
	
	
entry:
	mov ax, 0
	mov ss, ax
	mov sp, 0x7c00
	mov ds, ax
	
	mov si, msg_init
	jmp init
	

init:
	mov al, [si]
	add si, 1
	cmp al, 0
	je load
	mov ah, 0x0e
	mov bx, 15
	int 0x10
	jmp init
	

msg_init:
db 0x0a
db 0x0d
db "Copyright: GPL"
db 0x0a
db 0x0d
db "Author: Qiyuan Pu"
db 0x0a
db 0x0d
db "https://github.com/Puqiyuan/RongOS"
db 0x0a
db 0x0d
db "IPL is loading, please waiting..."
db 0x0a
db 0x0d
db "......"

	
load:

	mov ax, 0
	
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
	jnc next
	add si, 1
	cmp si, 5
	jae error
	mov ah, 0x00
	mov dl, 0x00
	int 0x13
	jmp retry

next:
	mov ax, es
	add ax, 0x0020
	mov es, ax
	add cl, 1
	cmp cl, 18
	jbe readloop
	mov cl, 1
	add dh, 1
	cmp dh, 2
	jb readloop
	mov dh, 0
	add ch, 1
	cmp ch, CYLS
	jb readloop
	jmp correct
	

fin:
	hlt
	jmp fin

	
error:
	mov si, msg
	

correct:
	mov si, msg_corr
	

putloop:
	mov al, [si]
	add si, 1
	cmp al, 0
	mov [0x0ff0], ch
	je 0xc200
	mov ah, 0x0e
	mov bx, 15
	int 0x10
	jmp putloop
	

msg_corr:
db 0x0a
db 0x0d
db 0x0a
db 0x0d
db "OK: IPL loaded"
db 0x0a
db 0x0d
db 0

	
msg:
db 0x0a
db "IPL load error"
db 0x0a
db 0
resb 0x7dfe-$

	
db 0x55, 0xaa
