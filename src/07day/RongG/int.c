// the initialization of PIC

#include "bootpack.h"
#include <stdio.h>

void init_pic(void)
{
	io_out8(PIC0_IMR, 0xff); // all interrupts are forbidden
	io_out8(PIC1_IMR, 0xff);

	io_out8(PIC0_ICW1, 0x11); // edge trigger mode
	io_out8(PIC0_ICW2, 0x20); // IRQ0 - 7 received by int20 - 27
	io_out8(PIC0_ICW3, 1 << 2); // connect PIC1 via IRQ2
	io_out8(PIC0_ICW4, 0x01); // no buffer mode

	io_out8(PIC1_ICW1, 0x11); // edge trigger mode
	io_out8(PIC1_ICW2, 0x28); // IRQ8 - 15 received by int28 - 2f
	io_out8(PIC1_ICW3, 2); // connect PIC1 via IRQ2
	io_out8(PIC1_ICW4, 0x01); // no buffer mode
	
	io_out8(PIC0_IMR, 0xfb); //11111011, all forbidden expect PIC1
	io_out8(PIC1_IMR, 0xff); // all interrupt forbidden

	return;
}

#define PORT_KEYDAT 0x0060

struct FIFO8 keyfifo;

void inthandler21(int *esp)
{
	unsigned char data;
	io_out8(PIC0_OCW2, 0x61);
	
	data = io_in8(PORT_KEYDAT);
	fifo8_put(&keyfifo, data);
	
	return;
}

struct FIFO8 mousefifo;

void inthandler2c(int *esp) // interruption from PS/2 mouse
{
	unsigned char data;
	io_out8(PIC1_OCW2, 0x64); // notify PIC1 of IRQ-12 reception completion.
	io_out8(PIC0_OCW2, 0x62); // notify PIC0 of IRQ-02 reception completion.
	data = io_in8(PORT_KEYDAT);
	fifo8_put(&mousefifo, data);
	return;
}


void inthandler27(int *esp)
{
	io_out8(PIC0_OCW2, 0x67);
	return;
}
