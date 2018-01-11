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
struct KEYBUF keybuf;

void inthandler21(int *esp)
{
	unsigned char data;
	io_out8(PIC0_OCW2, 0x61);
	
	data = io_in8(PORT_KEYDAT);

	if (keybuf.flag == 0)
		{
			keybuf.data = data;
			keybuf.flag = 1;
		}
	
	return;
}


void inthandler2c(int *esp)
{
	struct BOOTINFO *binfo = (struct BOOTINFO*)ADR_BOOTINFO;
	boxfill8(binfo -> vram, binfo -> scrnx, COL8_000000, 0, 0, 32 * 8 - 1, 15);
	putfonts8_asc(binfo -> vram, binfo -> scrnx, 0, 0, COL8_FFFFFF, "INT 2c (IRQ-12): PS/2 mouse");

	for (;;)
		{
			io_hlt();
		}
}


void inthandler27(int *esp)
{
	io_out8(PIC0_OCW2, 0x67);
	return;
}
