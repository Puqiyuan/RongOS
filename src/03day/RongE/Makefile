TOOLPATH = ../../../z_tools/
INCPATH = ../../../z_tools/haribote/

nask = $(TOOLPATH)nask.exe
edimg = $(TOOLPATH)edimg.exe

default:
	make -r img

ipl.bin: ipl.asm
	wine $(nask) ipl.asm ipl.bin ipl.lst

roosbote.sys: roosbote.asm Makefile
	wine $(nask) roosbote.asm roosbote.sys roosbote.lst

Rongbote.img: ipl.bin roosbote.sys Makefile
	wine $(edimg) imgin:../../../z_tools/fdimg0at.tek wbinimg src:ipl.bin \
	len:512 from:0 to:0 copy from:roosbote.sys to:@: imgout:Rongbote.img

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
	rm *.bin *.lst *.map *.obj *.gas *.rong *.img *.sys *.bim -f
	rm bootpack.nas -f
	rm dsctbl.nas -f
	rm graphic.nas -f
