// console

#include "bootpack.h"
#include <stdio.h>
#include <string.h>

void console_task(struct SHEET *sheet, unsigned int memtotal)
{
	struct TIMER *timer;
	struct TASK *task = task_now();
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	int i, fifobuf[128], *fat = (int *) memman_alloc_4k(memman, 4 * 2880);
	struct CONSOLE cons;
	char cmdline[30];
	cons.sht = sheet;
	cons.cur_x = 8;
	cons.cur_y = 28;
	cons.cur_c = -1;
	*((int *) 0x0fec) = (int) &cons;
	
	fifo32_init(&task -> fifo, 128, fifobuf, task);
	timer = timer_alloc();
	timer_init(timer, &task -> fifo, 1);
	timer_settime(timer, 50);
	file_readfat(fat, (unsigned char *) (ADR_DISKIMG + 0x000200));

	// prompt display
	cons_putchar(&cons, '$', 1);

	for (;;)
		{
			io_cli();
			if (fifo32_status(&task -> fifo) == 0)
				{
					task_sleep(task);
					io_sti();
				}
			else
				{
					i = fifo32_get(&task -> fifo);
					io_sti();
					if (i <= 1) // cursor timer
						{
							if (i != 0)
								{
									timer_init(timer, &task->fifo, 0);
									if (cons.cur_c >= 0)
										{
											cons.cur_c = COL8_FFFFFF;
										}
								}
							else
								{
									timer_init(timer, &task->fifo, 1);
									if (cons.cur_c >= 0)
										{
											cons.cur_c = COL8_000000;
										}
								}
							timer_settime(timer, 50);
						}
					if (i == 2) // cursor ON
						{
							cons.cur_c = COL8_FFFFFF;
						}

					if (i == 3) // cursor OFF
						{
							boxfill8(sheet->buf, sheet->bxsize, COL8_000000, cons.cur_x, cons.cur_y, cons.cur_x + 7, cons.cur_y + 15);
							cons.cur_c = -1;
						}
						
					if (256 <= i && i <= 511) // keyboard data(via task A)
						{
							if (i == 8 + 256)
								{
									if (cons.cur_x > 16)
										{
											// erase the cursor with a space, then move the cursor back one
											cons_putchar(&cons, ' ', 0);
											cons.cur_x -= 8;
										}
								}

							else if (i == 10 + 256)
								{
									// Enter
									// delete the cursor with a space
									cons_putchar(&cons, ' ', 0);
									cmdline[cons.cur_x / 8 - 2] = 0;
									cons_newline(&cons);
									cons_runcmd(cmdline, &cons, fat, memtotal); // command execution
									cons_putchar(&cons, '$', 1);
								}
							else 
								{
							
									if (cons.cur_x < 240)
										{
											cmdline[cons.cur_x / 8 - 2] = i - 256;
											cons_putchar(&cons, i - 256, 1);
										}
								}
						}

					// cursor re-display
					if (cons.cur_c >= 0)
						{
							boxfill8(sheet->buf, sheet->bxsize, cons.cur_c, cons.cur_x, cons.cur_y, cons.cur_x + 7, cons.cur_y + 15);
						}
					sheet_refresh(sheet, cons.cur_x, cons.cur_y, cons.cur_x + 8, cons.cur_y + 16);
				}
		}
}

void cons_putchar(struct CONSOLE *cons, int chr, char move)
{
	char s[2];
	s[0] = chr;
	s[1] = 0;
	if (s[0] == 0x09) // tab
		{
			for (;;)
				{
					putfonts8_asc_sht(cons->sht, cons->cur_x, cons->cur_y, COL8_FFFFFF, COL8_000000, " ", 1);
					cons->cur_x += 8;
					if (cons->cur_x == 8 + 240)
						{
							cons_newline(cons);
						}
					if (((cons->cur_x - 8) & 0x1f) == 0)
						{
							break; // if it is divisible by 32, break
						}
				}
		}
	else if (s[0] == 0x0a)
		{
			cons_newline(cons); // new line
		}
	else if (s[0] == 0x0d) // return
		{
			// nothing to do now
		}

	else // ordinary letters
		{
			putfonts8_asc_sht(cons->sht, cons->cur_x, cons->cur_y, COL8_FFFFFF, COL8_000000, s, 1);
			if (move != 0)
				{
					// do not advance the cursor when move is 0
					cons->cur_x += 8;
					if (cons->cur_x == 8 + 240)
						{
							cons_newline(cons);
						}
				}
		}
	return;
}

void cons_newline(struct CONSOLE *cons)
{
	int x, y;
	struct SHEET *sheet = cons->sht;
	if (cons->cur_y < 28 + 112)
		{
			cons->cur_y += 16; // to the next line
		}
	else
		{
			// scroll
			for (y = 28; y < 28 + 112; y++)
				{
					for (x = 8; x < 8 + 240; x++)
						{
							sheet->buf[x + y * sheet->bxsize] = sheet->buf[x + (y + 16) * sheet->bxsize];
						}
				}
			for (y = 28 + 112; y < 28 + 128; y++)
				{
					for (x = 8; x < 8 + 240; x++)
						{
							sheet->buf[x + y * sheet->bxsize] = COL8_000000;
						}
				}
			sheet_refresh(sheet, 8, 28, 8 + 240, 28 + 128);
		}
	cons->cur_x = 8;
	return;
}

void cons_putstr0(struct CONSOLE *cons, char *s)
{
	for (; *s != 0; s++)
		{
			cons_putchar(cons, *s, 1);
		}
	return;
}

void cons_putstr1(struct CONSOLE *cons, char *s, int l)
{
	int i;
	for (i = 0; i < l; i++)
		{
			cons_putchar(cons, s[i], 1);
		}
	return;
}

void cons_runcmd(char *cmdline, struct CONSOLE *cons, int *fat, unsigned int memtotal)
{
	if (strcmp(cmdline, "mem") == 0)
		{
			cmd_mem(cons, memtotal);
		}
	else if (strcmp(cmdline, "cls") == 0)
		{
			cmd_cls(cons);
		}
	else if (strcmp(cmdline, "ls") == 0)
		{
			cmd_ls(cons);
		}
	else if (strncmp(cmdline, "cat ", 4) == 0)
		{
			cmd_cat(cons, fat, cmdline);
		}
	else if (cmdline[0] != 0)
		{
			if (cmd_app(cons, fat, cmdline) == 0)
				{
					// it is not a command, it is not even a blank line
					cons_putstr0(cons, "Command not found.\n\n");
				}
		}
	return;
}

void cmd_mem(struct CONSOLE *cons, unsigned int memtotal)
{
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	char s[60];
	sprintf(s, "total %dMB\nfree %dKB\n\n", memtotal / (1024 * 1024), memman_total(memman) / 1024);
	cons_putstr0(cons, s);
	return;
}

void cmd_cls(struct CONSOLE *cons)
{
	int x, y;
	struct SHEET *sheet = cons->sht;
	for (y = 28; y < 28 + 128; y++)
		{
			for (x = 8; x < 8 + 240; x++)
				{
					sheet->buf[x + y * sheet->bxsize] = COL8_000000;
				}
		}
	sheet_refresh(sheet, 8, 28, 8 + 240, 28 + 128);
	cons->cur_y = 28;
	return;
}

void cmd_ls(struct CONSOLE *cons)
{
	struct FILEINFO *finfo = (struct FILEINFO *) (ADR_DISKIMG + 0x002600);
	int i, j;
	char s[30];
	for (i = 0; i < 224; i++)
		{
			if (finfo[i].name[0] == 0x00)
				{
					break;
				}
			if (finfo[i].name[0] != 0xe5)
				{
					if ((finfo[i].type & 0x18) == 0)
						{
							sprintf(s, "filename.ext %7d", finfo[i].size);
							for (j = 0; j < 8; j++)
								{
									s[j] = finfo[i].name[j];
								}
							s[9] = finfo[i].ext[0];
							s[10] = finfo[i].ext[1];
							s[11] = finfo[i].ext[2];
							putfonts8_asc_sht(cons->sht, 8, cons->cur_y, COL8_FFFFFF, COL8_000000, s, 30);
							cons_newline(cons);
						}
				}
		}
	cons_newline(cons);
	return;
}

void cmd_cat(struct CONSOLE *cons, int *fat, char *cmdline)
{
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	struct FILEINFO *finfo = file_search(cmdline + 4, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
	char *p;
	int i;
	if (finfo != 0)
		{
			// when a file is found
			p = (char *) memman_alloc_4k(memman, finfo->size);
			file_loadfile(finfo->clustno, finfo->size, p, fat, (char *) (ADR_DISKIMG + 0x003e00));
			for (i = 0; i < finfo->size; i++)
				{
					cons_putchar(cons, p[i], 1);
				}
			memman_free_4k(memman, (int) p, finfo->size);
		}
	else
		{
			// if the file can not be found
			cons_putstr0(cons, "File not found.\n");
		}
	cons_newline(cons);
	return;
}

int cmd_app(struct CONSOLE *cons, int *fat, char *cmdline)
{
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	struct FILEINFO *finfo;
	struct SEGMENT_DESCRIPTOR *gdt = (struct SEGMENT_DESCRIPTOR *) ADR_GDT;
	char name[18], *p;
	int i;

	// generate file name from the command line
	for (i = 0; i < 13; i++)
		{
			if (cmdline[i] <= ' ')
				{
					break;
				}
			name[i] = cmdline[i];
		}
	name[i] = 0; // in the meantime, set the end of the file name to 0

	finfo = file_search(name, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
	if (finfo == 0 && name[i - 1] != '.')
		{
			// add ".ROS" to the back and try searching again
			name[i] = '.';
			name[i + 1] = 'R';
			name[i + 2] = 'O';
			name[i + 3] = 'S';
			name[i + 4] = 0;
			finfo = file_search(name, (struct FILEINFO *) (ADR_DISKIMG + 0x002600), 224);
		}
								
	
	if (finfo != 0)
		{
			// when a file is found
			p = (char *) memman_alloc_4k(memman, finfo->size);
			*((int *) 0xfe8) = (int) p;
			file_loadfile(finfo->clustno, finfo->size, p, fat, (char *) (ADR_DISKIMG + 0x003e00));
			set_segmdesc(gdt + 1003, finfo->size - 1, (int) p, AR_CODE32_ER);
			farcall(0, 1003 * 8);
			memman_free_4k(memman, (int) p, finfo->size);
			cons_newline(cons);
			return 1;
		}
	// if the file can not be found
	return 0;
}

void ros_api(int edi, int esi, int ebp, int esp, int ebx, int edx, int ecx, int eax)
{
	int cs_base = *((int *) 0xfe8);
	struct CONSOLE *cons = (struct CONSOLE *) *((int *) 0x0fec);
	if (edx == 1)
		{
			cons_putchar(cons, eax & 0xff, 1);
		}
	else if (edx == 2)
		{
			cons_putstr0(cons, (char *) ebx + cs_base);
		}
	else if (edx == 3)
		{
			cons_putstr1(cons, (char *) ebx + cs_base, ecx);
		}
	return;
}
