// keyboard 
#include "bootpach.h"

struct FIFO8 keyfifo;

void inthandler21(int *esp)
{
	unsigned char data;
	io_out8(PIC0_OCW2, 0x61); //notify PIC of IRQ-01 reception completion
}
