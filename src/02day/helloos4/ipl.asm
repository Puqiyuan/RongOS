org 0x7c00 ; specify the location where to load the program.

; the format used for FAT12.
	jmp entry
db 0x90

	
db "HELLOIPL" ; the name of IPL(initial program loader, 8 bytes).
dw 512 ; the size of very sector.
db 1 ; the size of cluster, one cluster contains one sector.
dw 1 ; the start ponint of FAT, generally from the first sector began.
db 2 ; the number of FAT, must be 2.
dw 224 ; the size of root directory, generally set to 224 items.
dw 2880 ; the size of this floppy, must be 2880 sectors.
db 0xf0 ; the kind of disk, must be 0xf0, floppy disk.
dw 9 ; the length of FAT, must be 9.
dw 18 ; how many sectors in one track, must be 18 sectors.
dw 2 ; the number of headers, must be 2.
dd 0 ; do not use for paration, so it's 0.
dd 2880 ; the size of rewite.
db 0, 0, 0x29 ; no meaning, fixed.
dd 0xffffffff
db "HELLO-OS   " ; the name of disk,
db "FAT12   " ; the name of disk.
resb 18 ; reserved 18 bytes.

	
entry:
	mov ax, 0 ; initialize the register.
	mov ss, ax ; segment register can not be assign directly.
	mov sp, 0x7c00
	mov ds, ax
	mov es, ax

	mov si, msg

putloop:
	mov al, [si]
	add si, 1 ; add 1 to register si.
	cmp al, 0 ;
	je fin
	mov ah, 0x0e ; writer a letter.
	mov bx, 15 ; background color.
	int 0x10 ; call 10 interrupted.

	jmp putloop

fin:
	hlt
	jmp fin

msg:
db 0x0a, 0x0a ; twl newlines.
db "hello, world"
db 0x0a ; newline
db 0

resb 0x7dfe - $
db 0x55, 0xaa
