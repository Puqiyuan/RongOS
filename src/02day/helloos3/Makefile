TOOLPATH = ../../../z_tools/

nask = $(TOOLPATH)nask.exe

helloos.img: helloos.asm
	wine $(nask) helloos.asm helloos.img

vrun: helloos.img
	qemu-system-x86_64 -fda helloos.img

drun: helloos.img install clean
	sudo qemu-system-x86_64 -fda /dev/sdb

install: helloos.img 
	sudo dd if=helloos.img of=/dev/sdb bs=512 count=2880
	sudo sync

reboot: install
	make clean
	reboot

clean:
	rm *.bin *.lst *.map *.obj *.gas *.rong *.img *.sys *.bim -f
	rm bootpack.nas -f
	rm dsctbl.nas -f
	rm graphic.nas -f
