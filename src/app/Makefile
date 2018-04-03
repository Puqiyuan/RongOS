TOOLPATH = ../z_tools/
INCPATH = ../../z_tools/haribote/
APILIBPATH = ../../apilib/
KERNELPATH = ../../kernel/

nask = $(TOOLPATH)nask.exe
cc1 = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
gas2nask = $(TOOLPATH)gas2nask.exe -a
obj2bim = $(TOOLPATH)obj2bim.exe
makefont = $(TOOLPATH)makefont.exe
bin2obj = $(TOOLPATH)bin2obj.exe
bim2hrb = $(TOOLPATH)bim2hrb.exe
rulefile = $(TOOLPATH)haribote/haribote.url
edimg = $(TOOLPATH)edimg.exe
golib = $(TOOLPATH)golib00.exe

default:
	make $(APP).ros

$(APP).bim: $(APP).obj $(APILIBPATH)apilib.lib ../Makefile
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:$(APP).bim map:$(APP).map stack:$(STACK) $(APP).obj $(APILIBPATH)apilib.lib

$(APP).ros: $(APP).bim ../Makefile
	wine $(bim2hrb) $(APP).bim $(APP).ros $(MALLOC)

Rongbote.img: ../../kernel/ipl10.bin ../../kernel/Rongbote.sys $(APP).ros
	wine $(edimg) imgin:../z_tools/fdimg0at.tek \
	wbinimg src:../../kernel/ipl10.bin len:512 from:0 to:0 \
	copy from:../../kernel/Rongbote.sys to:@: \
	copy from:$(APP).ros to:@: \
	imgout:Rongbote.img

$(APP).gas: $(APP).c
	wine $(cc1) -o $(APP).gas $(APP).c

$(APP).asm: $(APP).gas
	wine $(gas2nask) $(APP).gas $(APP).asm

$(APP).obj: $(APP).asm Makefile
	wine $(nask) $(APP).asm $(APP).obj $(APP).lst

vrun: Rongbote.img
	qemu-system-x86_64 -fda Rongbote.img

full:
	make -C $(APILIBPATH)
	make $(APP).ros

vrun_full:
	make -C $(APILIBPATH)
	make -C $(KERNELPATH)
	make vrun

drun_full: Rongbote.img install clean
	make -C $(APILIBPATH)
	make -C ../../kernel
	sudo qemu-system-x86_64 -fda /dev/sdb

install: Rongbote.img
	make -C $(APILIBPATH)
	make -C ../../kernel
	sudo dd if=Rongbote.img of=/dev/sdb bs=512 count=2880
	sudo sync

reboot: install
	make -C $(APILIBPATH)
	make -C ../../kernel
	make clean
	reboot

clean:
	rm *.lst *.obj *.map *.bim Rongbote.img -f

src_only:
	make clean
	rm $(APP).ros -f
