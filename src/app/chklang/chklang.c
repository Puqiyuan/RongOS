#include "../../header/apilib.h"

void HariMain(void)
{
	int langmode = api_getlang();

	if (langmode == 0)
		{
			api_putstr0("English ASCII mode\n");
		}
	else
		{
			api_putstr0("Chinese GB2312 mode\n");
		}
	api_end();
}
