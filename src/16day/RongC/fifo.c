//FIFO library

#include "bootpack.h"

#define FLAGS_OVERRUN 0x0001

void fifo32_init(struct FIFO32 *fifo, int size, int *buf, struct TASK *task)
// initialization of fifo buffer
{
	fifo -> size = size;
	fifo -> buf = buf;
	fifo -> free = size; //free
	fifo -> flags = 0;
	fifo -> p = 0; // write position
	fifo -> q = 0; // read position
	fifo -> task = task; // tasks wake-up when data comes in
	return ;
}

int fifo32_put(struct FIFO32 *fifo, int data)
// send data to fifo and store it
{
	if (fifo -> free == 0)// it was overflowing with no vacancies
		{
			fifo -> flags |= FLAGS_OVERRUN;
			return -1;
		}
	fifo -> buf[fifo -> p] = data; // writing position
	fifo -> p++;
	if (fifo -> p == fifo -> size) // no space for storing
		fifo -> p = 0;

	fifo -> free--;

	if (fifo -> task != 0)
		{
			if (fifo -> task -> flags != 2)// if the task is sleeping
				task_run(fifo -> task); // wake it
		}
	
	return 0;
}


int fifo32_get(struct FIFO32 *fifo)// one data comes from the FIFO
{
	int data;
	
	if (fifo -> free == fifo -> size) // if the buffer is empty, -1 is returned for the time being.
		return -1;

	data = fifo -> buf[fifo -> q]; // reading point is q
	fifo -> q++;
	if (fifo -> q == fifo -> size)//wrapping
		fifo -> q = 0;

	fifo -> free++;
	return data;
}

int fifo32_status(struct FIFO32 *fifo)// report how much data is accumulated.
{
	return fifo -> size - fifo -> free;
}
