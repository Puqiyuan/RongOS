OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj

TOOLPATH	= ../app/z_tools/
INCPATH		= ../app/z_tools/haribote/

nask		= $(TOOLPATH)nask.exe
cc1			= $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
gas2nask	= $(TOOLPATH)gas2nask.exe -a
obj2bim		= $(TOOLPATH)obj2bim.exe
makefont	= $(TOOLPATH)makefont.exe
bin2obj		= $(TOOLPATH)bin2obj.exe
bim2hrb		= $(TOOLPATH)bim2hrb.exe
rulefile	= $(TOOLPATH)haribote/haribote.url
edimg		= $(TOOLPATH)edimg.exe

default:
	make -r ipl10.bin
	make -r Rongbote.sys

ipl10.bin: ipl10.asm
	wine $(nask) ipl10.asm ipl10.bin ipl10.lst

asmhead.bin: asmhead.asm
	wine $(nask) asmhead.asm asmhead.bin asmhead.lst

hankaku.bin: hankaku.txt
	wine $(makefont) hankaku.txt hankaku.bin

hankaku.obj: hankaku.bin
	wine $(bin2obj) hankaku.bin hankaku.obj _hankaku

bootpack.bim: $(OBJS_BOOTPACK)
	wine $(obj2bim) @../app/z_tools/haribote/haribote.rul out:bootpack.bim stack:3136k \
    map:bootpack.map $(OBJS_BOOTPACK)

bootpack.ros: bootpack.bim
	wine $(bim2hrb) bootpack.bim bootpack.ros 0

Rongbote.sys: asmhead.bin bootpack.ros
	cat asmhead.bin bootpack.ros > Rongbote.sys

%.gas: %.c
	wine $(cc1) -o $*.gas $*.c

%.asm: %.gas
	wine $(gas2nask) $*.gas $*.asm

%.obj: %.asm
	wine $(nask) $*.asm $*.obj $*.lst

clean:
	rm *.lst *.obj *.map *.bim *.ros -f
	rm asmhead.bin -f
	rm hankaku.bin -f

src_only: clean
	rm ipl10.bin -r
	rm Rongbote.sys -f
