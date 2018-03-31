#include <stdio.h>

int api_openwin(char *buf, int xsiz, int ysiz, int col_inv, char *title);
void api_putstrwin(int win, int x, int y, int col, int len, char *str);
void api_boxfilwin(int win, int x0, int y0, int x1, int y1, int col);
void api_initmalloc(void);
char *api_malloc(int size);
int api_getkey(int mode);
int api_alloctimer(void);
void api_inittimer(int timer, int data);
void api_settimer(int timer, int time);
void api_end(void);

void HariMain(void)
{
	char *buf, s[16];
	int win, timer, sec = 0, min = 0, hou = 0, day = 0, year = 0;
	api_initmalloc();
	buf = api_malloc(150 * 50);
	win = api_openwin(buf, 160, 50, -1, "sundial");
	timer = api_alloctimer();
	api_inittimer(timer, 128);
	for (;;)
		{
			sprintf(s, "%02d:%03d:%02d:%02d:%02d", year, day, hou, min, sec);
			api_boxfilwin(win, 28, 27, 150, 43, 13);
			api_putstrwin(win, 28, 27, 3, 22, s);
			api_settimer(timer, 100); // 1 second
			if (api_getkey(1) != 128)
				{
					break;
				}
			sec++;
			if (sec == 60)
				{
					sec = 0;
					min++;
					if (min == 60)
						{
							min = 0;
							hou++;
							if (hou == 24)
								{
									hou = 0;
									day++;
									if (day == 365)
										{
											day = 0;
											year++;
										}
								}
						}
				}
		}
	api_end();
}
