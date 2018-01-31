// mouse
#include "bootpack.h"

struct FIFO8 mousefifo;

void inthandler2c(int *esp)
{
	unsigned char data;
	io_out8(PIC1_OCW2, 0x64); // notify PIC 1 of IRQ-12 reception completion
	io_out8(PIC0_OCW2, 0x62); // notify PIC 0 of IRQ-02 reception completion
	data = io_in8(PORT_KEYDAT);
	fifo8_put(&mousefifo, data);
	return;
}

#define KEYCMD_SENDTO_MOUSE 0xd4
#define MOUSECMD_ENABLE 0xf4

void enable_mouse(struct MOUSE_DEC *mdec)
{
	// mouse effective
	wait_KBC_sendready();
	io_out8(PORT_KEYCMD, KEYCMD_SENDTO_MOUSE);
	wait_KBC_sendready();
	io_out8(PORT_KEYDAT, MOUSECMD_ENABLE);

	// if it works, ACK(oxfa) will be sent.
	mdec -> phase = 0; // waiting for mouse 0xfa.
	return;
}

int mouse_decode(struct MOUSE_DEC *mdec, unsigned char dat)
{
	if (mdec -> phase == 0) // waiting for mouse 0xfa
		{
			if (dat == 0xfa)
				mdec -> phase = 1;
			return 0;
		}
	if (mdec -> phase == 1) // waiting for the 1st byte of the mouse
		{
			if ((dat & 0xc8) == 0x08) // it was the correct first byte
				{
					mdec -> buf[0] = dat;
					mdec -> phase = 2;
				}
			return 0;
		}
	if (mdec -> phase == 2) // waiting for the second byte of the mouse
		{
			mdec -> buf[1] = dat;
			mdec -> phase = 3;
			return 0;
		}

	if (mdec -> phase == 3) // waiting for the 3rd byte of the mouse
		{
			mdec -> buf[2] = dat;
			mdec -> phase = 1;
			mdec -> btn = mdec -> buf[0] & 0x07;
			mdec -> x = mdec -> buf[1];
			mdec -> y = mdec -> buf[2];

			if ((mdec -> buf[0] & 0x10) != 0)
				mdec -> x |= 0xffffff00;

			if ((mdec -> buf[0] & 0x20) != 0)
				mdec -> y |= 0xffffff00;

			mdec -> y = - mdec -> y; // in mouse, sign in y direction is opposite to screen
			return 1;
		}

	return -1; // there is nothing to come here.
}
