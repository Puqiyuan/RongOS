OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj int.obj fifo.obj keyboard.obj mouse.obj memory.obj

TOOLPATH = ../z_tools/
INCPATH = ../z_tools/haribote/

nask = $(TOOLPATH)nask.exe
cc1 = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
gas2nask = $(TOOLPATH)gas2nask.exe -a
obj2bim = $(TOOLPATH)obj2bim.exe
makefont = $(TOOLPATH)makefont.exe
bin2obj = $(TOOLPATH)bin2obj.exe
bim2hrb = $(TOOLPATH)bim2hrb.exe
rulefile = $(TOOLPATH)haribote/haribote.url
edimg = $(TOOLPATH)edimg.exe

default:
	make -r img

ipl10.bin: ipl10.asm
	wine $(nask) ipl10.asm ipl10.bin ipl10.lst

asmhead.bin: asmhead.asm
	wine $(nask) asmhead.asm asmhead.bin asmhead.lst

hankaku.bin: hankaku.txt
	wine $(makefont) hankaku.txt hankaku.bin

hankaku.obj: hankaku.bin
	wine $(bin2obj) hankaku.bin hankaku.obj _hankaku

bootpack.bim: $(OBJS_BOOTPACK)
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:bootpack.bim stack:3136k \
    map:bootpack.map $(OBJS_BOOTPACK)

bootpack.ros: bootpack.bim
	wine $(bim2hrb) bootpack.bim bootpack.ros 0

Rongbote.sys: asmhead.bin bootpack.ros
	cat asmhead.bin bootpack.ros > Rongbote.sys

Rongbote.img: ipl10.bin Rongbote.sys
	wine $(edimg) imgin:../z_tools/fdimg0at.tek wbinimg src:ipl10.bin \
    len:512 from:0 to:0 copy from:Rongbote.sys to:@: imgout:Rongbote.img

%.gas: %.c
	wine $(cc1) -o $*.gas $*.c

%.asm: %.gas
	wine $(gas2nask) $*.gas $*.asm

%.obj: %.asm
	wine $(nask) $*.asm $*.obj $*.lst

img:
	make -r Rongbote.img

vrun: Rongbote.img
	qemu-system-x86_64 -fda Rongbote.img

drun: Rongbote.img install clean
	sudo qemu-system-x86_64 -fda /dev/sdb

install: Rongbote.img
	sudo dd if=Rongbote.img of=/dev/sdb bs=512 count=2880
	sudo sync

reboot: install
	make clean
	reboot

clean:
	rm *.bin *.lst *.map *.obj *.gas *.ros *.img *.sys *.bim -f
	rm bootpack.asm -f
	rm dsctbl.asm -f
	rm graphic.asm -f
