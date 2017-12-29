TOOLPATH = ../../../z_tools/

nask = $(TOOLPATH)nask.exe

ipl.img: ipl.asm
	wine $(nask) ipl.asm ipl.img ipl.lst

vrun: ipl.img
	qemu-system-x86_64 -fda ipl.img

drun: ipl.img install clean
	sudo qemu-system-x86_64 -fda /dev/sdb

install: ipl.img
	sudo dd if=ipl.img of=/dev/sdb bs=512 count=2880
	sudo sync

reboot: install
	make clean
	reboot

clean:
	rm *.bin *.lst *.map *.obj *.gas *.rong *.img *.sys *.bim -f
	rm bootpack.nas -f
	rm dsctbl.nas -f
	rm graphic.nas -f
