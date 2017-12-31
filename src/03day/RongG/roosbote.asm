org 0xc200 ; load these instructions to memory c200

mov al, 0x13 ; VGA video card, 320 * 200 * 8 bit
mov ah, 0x00
int 0x10

fin:
    hlt
    jmp fin
