//FIFO library

#include "bootpack.h"

#define FLAGS_OVERRUN 0x0001

void fifo8_init(struct FIFO8 *fifo, int size, unsigned char *buf)
// initialization of FIFO buffer
{
	fifo -> size = size;
	fifo -> buf = buf;
	fifo -> free = size; //free
	fifo -> p = 0; // write position
	fifo -> q = 0; // read position
	return ;
}

int fifo8_put(struct FIFO8 *fifo, unsigned char data)
// Send data to FIFO and store it
{
	if (fifo -> free == 0)// it was overflowing with no vacancies
		{
			fifo -> flags |= FLAGS_OVERRUN;
			return -1;
		}
	fifo -> buf[fifo -> p] = data;
	fifo -> p++;
	if (fifo -> p == fifo -> size)
		fifo -> p = 0;

	fifo -> free--;
	return 0;
}


int fifo8_get(struct FIFO8 *fifo)// one data comes from the FIFO
{
	int data;
	
	if (fifo -> free == fifo -> size) // if the buffer is empty, -1 is returned for the time being.
		return -1;

	data = fifo -> buf[fifo -> q];
	fifo -> q++;
	if (fifo -> q == fifo -> size)//wrapping
		fifo -> q = 0;

	fifo -> free++;
	return data;
}

int fifo8_status(struct FIFO8 *fifo)// report how much data is accumulated.
{
	return fifo -> size - fifo -> free;
}
