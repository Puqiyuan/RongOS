; read ten cylinders to memory begin with 0x8200.
; read order:
	; C0-H0-S1 --- C0-H0-S18
	; C0-H1-S1 --- C0-H0-S18
	; C1-H0-S1 --- C1-H0-S18
        ; C1-H1-S1 --- C1-H1-S18
        ;          ...
	; C9-H1-S1 --- C9-H1-S18
        ; C is cylinder, H is head, S is sector.
	; total 10 * 2 * 18 * 512 = 184320Byte = 180KB.
	; begin with 0x8200, end with 0x34fff in memory.
	
	
	CYLS equ 10 ; read 10 cylinders, 
	
org 0x7c00 ; load the program to address 0x7c00.
	jmp entry
	; The next codes specify the format of standard FAT12 floppy disk.
db 0x90 ;db is the abbreation of "define byte", it literally places that byte
	; right there in the executable.
db "RONGBOOT" ;The name of boot sector, must be 8 byte.
dw 512 ; the size of every sector, must be 512 byte.
db 1 ; the size of cluster, must be 1.
dw 1 ; the start point of FAT, 1 general case.
db 2 ; the number of FAT, must be 2.
dw 224 ; the size of root directory, 224 in general.
dw 2880 ; the size of this floppy disk, must be 2880.
db 0xf0 ; the kind of disk.
dw 9 ; the length of FAT.
dw 18 ; how many sectors in one track, must be 18.
dw 2 ; the number of head, must be 2.
dd 0 ; no partion, must be 0.
dd 2880 ; the size if re-writer one time.
db 0,0,0x29 ; just fixed, no meaning.
dd 0xffffffff 
db "RONGBOOTOS " ; the name of disk.
db "FAT12   " ; the name of disk formate.
resb 18 ; reserved 18 byte.
	; end FAT12 formate.
	
entry:
	mov ax, 0 ; init the registers.
	mov ss, ax ; can not directly write ss segment register.
	mov sp, 0x7c00 ; the instructions of this program
        ; loaded to 0x7c00 in memory, so sp=0x7c00, from here
	; to execute.
	
	mov ds, ax
	
	mov si, msg_init ; show some init message.
	jmp init
	

init:
	mov al, [si]
	add si, 1 ; increment by 1.
	cmp al, 0
	je load ; if al == 0, jmp to load, the msg_init info displayed.
; the lastest character is null character, coding in 0.
	
	mov ah, 0x0e ; write a character in TTY mode.
	mov bx, 15   ; specify the color of the character.
	int 0x10 ; call BIOS function, video card is number 10.
	jmp init
	
;show some init messages.
msg_init:
db 0x0a ; new line
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
	
	mov ax, 0x0820 ; load these sectors to memory begin with 0x0820.
	mov es, ax
	mov ch, 0 ; cylinder 0.
	mov dh, 0 ; head 0.
	mov cl, 2 ; sector 2.

readloop:
	mov si, 0 ; si register is a counter, try read a sector
	; five times.

retry:
	mov ah, 0x02 ; parameter 0x02 to ah, read disk.
	mov al, 1 ; parameter 1 to al, read disk.
	mov bx, 0
	mov dl, 0x00 ; the number of driver number.
	int 0x13 ; after prepared parameters, call 0x13 interrupted.

	jnc next ; if no carry read next sector.
	add si, 1 ; tring again read sector, counter add 1.
	cmp si, 5 ; until five times
	jae error ; if tring times large than five, failed.

	; reset the status of floppy and read again.
	mov ah, 0x00 
	mov dl, 0x00
	int 0x13
	jmp retry

next:
	mov ax, es
	; we can not directly add to es register.
	add ax, 0x0020 ; add 0x0020 to ax
	mov es, ax ; the memory increase 0x0020 * 16 = 512 byte.
	; size of a sector.
	add cl, 1 ; sector number add 1.
	cmp cl, 18 ; one track have 18 sector.
	jbe readloop ; jump if below or equal 18, read the next sector.
	mov cl, 1 ; cl number reset to 1, ready to read the other side.
	add dh, 1 ; the other side of floppy.
	cmp dh, 2 ; only two sides of floppy.
	jb readloop ; if dh < 2, read 18 sectors of the other sides
	; of floppy.
	mov dh, 0 ; after finished read the other side, reset head to 0.
	add ch, 1 ; two sides of a cylinder readed, add 1 to ch.
	cmp ch, CYLS ; read 10 cylinders.
	jb readloop
	jmp correct ; if 10 cylinders readed, show correct message.
	

fin:
	hlt ; halt the cpu.
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

	
db 0x55, 0xaa ; the sector end with 0x55 0xaa, the sector is
	;boot sector.
