void io_hlt(void); // tell compiler, the function in other file.

void HariMain(void)
{
    fin:
	io_hlt(); // execute the function io_hlt in naskfunc.asm file.
        goto fin;
}
