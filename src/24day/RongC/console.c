// console

#include "bootpack.h"
#include <stdio.h>
#include <string.h>

void console_task(struct SHEET *sheet, unsigned int memtotal)
{
	struct TASK *task = task_now();
	struct MEMMAN *memman = (struct MEMMAN *) MEMMAN_ADDR;
	int i, fifobuf[128], *fat = (int *) memman_alloc_4k(memman, 4 * 2880);
	struct CONSOLE cons;
	char cmdline[30];
	cons.sht	= sheet;
	cons.cur_x	= 8;
	cons.cur_y	= 28;
	cons.cur_c	= -1;
	*((int *) 0x0fec) = (int) &cons;
	
	fifo32_init(&task -> fifo, 128, fifobuf, task);
	cons.timer = timer_alloc();
	timer_init(cons.timer, &task -> fifo, 1);
	timer_settime(cons.timer, 50);
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
									timer_init(cons.timer, &task->fifo, 0);
									if (cons.cur_c >= 0)
										{
											cons.cur_c = COL8_FFFFFF;
										}
								}
							else
								{
									timer_init(cons.timer, &task->fifo, 1);
									if (cons.cur_c >= 0)
										{
											cons.cur_c = COL8_000000;
										}
								}
							timer_settime(cons.timer, 50);
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
	char name[18], *p, *q;
	struct TASK *task = task_now();
	int i, segsiz, datsiz, esp, datros;
	struct SHTCTL *shtctl;
	struct SHEET *sht;

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
			name[i]		= '.';
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
			file_loadfile(finfo->clustno, finfo->size, p, fat, (char *) (ADR_DISKIMG + 0x003e00));
			if (finfo->size >= 36 && strncmp(p + 4, "Rong", 4) == 0 && *p == 0x00)
				{
					segsiz	= *((int *) (p + 0x0000));
					esp		= *((int *) (p + 0x000c));
					datsiz	= *((int *) (p + 0x0010));
					datros	= *((int *) (p + 0x0014));
					q = (char*) memman_alloc_4k(memman, segsiz);
					*((int *) 0xfe8) = (int) q;
					set_segmdesc(gdt + 1003, finfo->size - 1, (int) p, AR_CODE32_ER + 0x60);
					set_segmdesc(gdt + 1004, segsiz - 1, (int) q, AR_DATA32_RW + 0x60);
					for (i = 0; i < datsiz; i++)
						{
							q[esp + i] = p[datros + i];
						}
					start_app(0x1b, 1003 * 8, esp, 1004 * 8, &(task->tss.esp0));
					shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
					for (i = 0; i < MAX_SHEETS; i++)
						{
							sht = &(shtctl -> sheets0[i]);
							if (sht -> flags != 0 && sht -> task == task)
								{
									sheet_free(sht); // close
								}
						}
					memman_free_4k(memman, (int) q, segsiz);
				}
			else
				{
					cons_putstr0(cons, ".ros file format error,Rong tag does not exist.\n");
				}
			memman_free_4k(memman, (int) p, finfo->size);
			cons_newline(cons);
			return 1;
		}
	// if the file can not be found
	return 0;
}

int* ros_api(int edi, int esi, int ebp, int esp, int ebx, int edx, int ecx, int eax)
{
	int ds_base = *((int *) 0xfe8);
	struct TASK *task = task_now();
	struct CONSOLE *cons = (struct CONSOLE *) *((int *) 0x0fec);
	struct SHTCTL *shtctl = (struct SHTCTL *) *((int *) 0x0fe4);
	struct SHEET *sht;
	int *reg = &eax + 1; // next address of eax
	int i;
	if (edx == 1)
		{
			cons_putchar(cons, eax & 0xff, 1);
		}
	else if (edx == 2)
		{
			cons_putstr0(cons, (char *) ebx + ds_base);
		}
	else if (edx == 3)
		{
			cons_putstr1(cons, (char *) ebx + ds_base, ecx);
		}
	else if (edx == 4)
		{
			return &(task->tss.esp0);
		}
	else if (edx == 5)
		{
			sht = sheet_alloc(shtctl);
			sht -> task = task;
			sheet_setbuf(sht, (char *) ebx + ds_base, esi, edi, eax);
			make_window8((char *) ebx + ds_base, esi, edi, (char *) ecx + ds_base, 0);
			sheet_slide(sht, 100, 50);
			sheet_updown(sht, 3);
			reg[7] = (int) sht;
		}
	else if (edx == 6)
		{
			sht = (struct SHEET *) (ebx & 0xfffffffe);
			putfonts8_asc(sht->buf, sht->bxsize, esi, edi, eax, (char *)ebp + ds_base);
			if ((ebx & 1) == 0)
				{
					sheet_refresh(sht, esi, edi, esi + ecx * 8, edi + 16);
				}
		}
	else if (edx == 7)
		{
			sht = (struct SHEET *) (ebx & 0xfffffffe);
			boxfill8(sht->buf, sht->bxsize, ebp, eax, ecx, esi, edi);
			if ((ebx & 1) == 0)
				{
					sheet_refresh(sht, eax, ecx, esi + 1, edi + 1);
				}
		}
	else if (edx == 8)
		{
			memman_init((struct MEMMAN *) (ebx + ds_base));
			ecx &= 0xfffffff0; // in units of 16 bytes
			memman_free((struct MEMMAN *) (ebx + ds_base), eax, ecx);
		}
	else if (edx == 9)
		{
			ecx = (ecx + 0x0f) & 0xfffffff0; // in units of 16 bytes
			reg[7] = memman_alloc((struct MEMMAN *) (ebx + ds_base), ecx);
		}
	else if (edx == 10)
		{
			ecx = (ecx + 0x0f) & 0xfffffff0; // in units of 16 bytes
			memman_free((struct MEMMAN *) (ebx + ds_base), eax, ecx);
		}
	else if (edx == 11)
		{
			sht = (struct SHEET *) (ebx & 0xfffffffe);
			sht->buf[sht->bxsize * edi + esi] = eax;
			if ((ebx & 1) == 0)
				{
					sheet_refresh(sht, esi, edi, esi + 1, edi + 1);
				}
		}
	else if (edx == 12)
		{
			sht = (struct SHEET *) ebx;
			sheet_refresh(sht, eax, ecx, esi, edi);
		}
	else if (edx == 13)
		{
			sht = (struct SHEET *) (ebx & 0xfffffffe);
			ros_api_linewin(sht, eax, ecx, esi, edi, ebp);
			if ((ebx & 1) == 0)
				{
					sheet_refresh(sht, eax, ecx, esi + 1, esi + 1);
				}
		}
	else if (edx == 14)
		{
			sheet_free((struct SHEET *) ebx);
		}
	else if (edx == 15)
		{
			for (;;)
				{
					io_cli();
					if (fifo32_status(&task->fifo) == 0)
						{
							if (eax != 0)
								{
									task_sleep(task); // FIFO is empty, sleep and wait
								}
							else
								{
									io_sti();
									reg[7] = -1;
									return 0;
								}
						}
					i = fifo32_get(&task->fifo);
					io_sti();
					if (i <= 1) // cursor Timer
						{
							// since the cursor will not appear during application execution, always order 1 for display next time
							timer_init(cons->timer, &task->fifo, 1); // next 1
							timer_settime(cons->timer, 50);
						}
					if (i == 2) // cursor ON
						{
							cons->cur_c = COL8_FFFFFF;
						}
					if (i == 3) // cursor OFF
						{
							cons->cur_c = -1;
						}
					if (256 <= i && i <= 511) // keyboard data
						{
							reg[7] = i - 256;
							return 0;
						}
				}
		}
	return 0 ;
}

int* inthandler0c(int *esp)
{
	struct CONSOLE *cons = (struct CONSOLE *) *((int *) 0x0fec);
	struct TASK *task = task_now();
	char s[30];
	cons_putstr0(cons, "\nINT 0C :\n Stack Exception.\n");
	sprintf(s, "EIP = %08X\n", esp[11]);
	cons_putstr0(cons, s);
	return &(task->tss.esp0);
}
	
int* inthandler0d(int *esp)
{
	struct CONSOLE *cons = (struct CONSOLE *) *((int *) 0x0fec);
	struct TASK *task = task_now();
	cons_putstr0(cons, "\nINT 0D :\n General Protected Exception.\n");
	return &(task->tss.esp0); // abnormal termination
}

void ros_api_linewin(struct SHEET *sht, int x0, int y0, int x1, int y1, int col)
{
	int i, x, y, len, dx, dy;

	dx = x1 - x0;
	dy = y1 - y0;
	x = x0 << 10;
	y = y0 << 10;
	if (dx < 0)
		{
			dx = -dx;
		}
	if (dy < 0)
		{
			dy = -dy;
		}
	if (dx >= dy)
		{
			len = dx + 1;
			if (x0 > x1)
				{
					dx = -1024;
				}
			else
				{
					dx = 1024;
				}
			if (y0 <= y1)
				{
					dy = ((y1 - y0 + 1) << 10) / len;
				}
			else
				{
					dy = ((y1 - y0 - 1) << 10) / len;
				}
		}
	else
		{
			len = dy + 1;
			if (y0 > y1)
				{
					dy = -1024;
				}
			else
				{
					dy = 1024;
				}
			if (x0 <= x1)
				{
					dx = ((x1 - x0 + 1) << 10) / len;
				}
			else
				{
					dx = ((x1 - x0 - 1) << 10) / len;
				}
		}

	for (i = 0; i < len; i++)
		{
			sht->buf[(y >> 10) * sht->bxsize + (x >> 10)] = col;
			x += dx;
			y += dy;
		}

	return;
}