void io_hlt(void);
void write_mem8(int addr, int data);

void HariMain(void)
{
	int i;
	char *p = 0xa0000; // variable p, BYTE type, but for p, it's 4 byte.
	
	for (i = 0; i <= 0xffff; i++)
		{
			*(p + i)= i & 0x0f;
		}

	for (;;)
		{
			io_hlt();
		}
}
