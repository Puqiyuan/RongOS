#include "../../header/apilib.h"

void HariMain(void)
{
	int i, timer;
	timer = api_alloctimer();
	api_inittimer(timer, 128);
	for (i = 20000000; i >= 20000; i -= i / 100)
		{
			// 20KHz ~ 20Hz:range of sound that can be heard by humans
			// i is decremented by 1%
			api_beep(i);
			api_settimer(timer, 1); // 0.01s
			if (api_getkey(1) != 128)
				{
					break;
				}
		}
	api_beep(0);
	api_end();
}
