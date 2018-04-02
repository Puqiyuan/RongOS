OBJS_BOOTPACK = bootpack.obj naskfunc.obj hankaku.obj graphic.obj dsctbl.obj int.obj fifo.obj keyboard.obj mouse.obj memory.obj sheet.obj timer.obj mtask.obj window.obj console.obj file.obj

OBJS_API = api001.obj api002.obj api003.obj api004.obj api005.obj api006.obj api007.obj api008.obj api009.obj api010.obj api011.obj api012.obj api013.obj api014.obj api015.obj api016.obj api017.obj api018.obj api019.obj api020.obj

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
golib = $(TOOLPATH)golib00.exe

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

hello.ros: hello.asm
	wine $(nask) hello.asm hello.ros hello.lst

a.bim: a.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:a.bim map:a.map a.obj apilib.lib

a.ros: a.bim
	wine $(bim2hrb) a.bim a.ros 0

hello3.bim: hello3.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:hello3.bim map:hello3.map hello3.obj apilib.lib

hello3.ros: hello3.bim
	wine $(bim2hrb) hello3.bim hello3.ros 0

winhello.bim: winhello.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:winhello.bim stack:1k map:winhello.map winhello.obj apilib.lib

winhello.ros: winhello.bim
	wine $(bim2hrb) winhello.bim winhello.ros 0

winhelo2.bim: winhelo2.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:winhelo2.bim stack:1k map:winhelo2.map winhelo2.obj apilib.lib

winhelo2.ros: winhelo2.bim
	wine $(bim2hrb) winhelo2.bim winhelo2.ros 0

winhelo3.bim: winhelo3.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:winhelo3.bim stack:1k map:winhelo3.map winhelo3.obj apilib.lib

winhelo3.ros: winhelo3.bim
	wine $(bim2hrb) winhelo3.bim winhelo3.ros 40k

star1.bim: star1.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:star1.bim stack:1k map:star1.map star1.obj apilib.lib

star1.ros: star1.bim
	wine $(bim2hrb) star1.bim star1.ros 47k

stars.bim: stars.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:stars.bim stack:1k map:stars.map stars.obj apilib.lib

stars.ros: stars.bim
	wine $(bim2hrb) stars.bim stars.ros 47k

stars2.bim: stars2.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:stars2.bim stack:1k map:stars2.map stars2.obj apilib.lib

stars2.ros: stars2.bim
	wine $(bim2hrb) stars2.bim stars2.ros 47k

lines.bim: lines.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:lines.bim stack:1k map:lines.map lines.obj apilib.lib

lines.ros: lines.bim
	wine $(bim2hrb) lines.bim lines.ros 48k

walk.bim: walk.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:walk.bim stack:1k map:walk.map walk.obj apilib.lib

walk.ros: walk.bim
	wine $(bim2hrb) walk.bim walk.ros 48k

sundial.bim: sundial.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:sundial.bim stack:1k map:sundial.map sundial.obj apilib.lib

sundial.ros: sundial.bim
	wine $(bim2hrb) sundial.bim sundial.ros 40k

noodle.bim: noodle.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:noodle.bim stack:1k map:noodle.map noodle.obj apilib.lib

noodle.ros: noodle.bim
	wine $(bim2hrb) noodle.bim noodle.ros 40k

beepdown.bim: beepdown.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:beepdown.bim stack:1k map:beepdown.map beepdown.obj apilib.lib

beepdown.ros: beepdown.bim
	wine $(bim2hrb) beepdown.bim beepdown.ros 40k

color.bim: color.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:color.bim stack:1k map:color.map color.obj apilib.lib

color.ros: color.bim
	wine $(bim2hrb) color.bim color.ros 56k

color2.bim: color2.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:color2.bim stack:1k map:color2.map color2.obj apilib.lib

color2.ros: color2.bim
	wine $(bim2hrb) color2.bim color2.ros 56k

hello4.bim: hello4.obj apilib.lib
	wine $(obj2bim) @../z_tools/haribote/haribote.rul out:hello4.bim stack:1k map:hello4.map hello4.obj apilib.lib

hello4.ros: hello4.bim
	wine $(bim2hrb) hello4.bim hello4.ros 0

Rongbote.sys: asmhead.bin bootpack.ros
	cat asmhead.bin bootpack.ros > Rongbote.sys

apilib.lib: $(OBJS_API)
	wine $(golib) $(OBJS_API) out:apilib.lib

Rongbote.img: ipl10.bin Rongbote.sys hello.ros a.ros hello3.ros hello4.ros winhello.ros winhelo2.ros winhelo3.ros star1.ros stars.ros stars2.ros lines.ros walk.ros sundial.ros noodle.ros beepdown.ros color.ros color2.ros
	wine $(edimg) imgin:../z_tools/fdimg0at.tek wbinimg src:ipl10.bin \
    len:512 from:0 to:0 \
	copy from:Rongbote.sys to:@: \
	copy from:ipl10.asm to:@: \
	copy from:Makefile to:@: \
	copy from:hello.ros to:@: \
	copy from:a.ros to:@: \
	copy from:hello3.ros to:@: \
	copy from:hello4.ros to:@: \
	copy from:winhello.ros to:@: \
	copy from:winhelo2.ros to:@: \
	copy from:winhelo3.ros to:@: \
	copy from:star1.ros to:@: \
	copy from:stars.ros to:@: \
	copy from:stars2.ros to:@: \
	copy from:lines.ros to:@: \
	copy from:walk.ros to:@: \
	copy from:sundial.ros to:@: \
	copy from:noodle.ros to:@: \
	copy from:beepdown.ros to:@: \
	copy from:color.ros to:@: \
	copy from:color2.ros to:@: \
	imgout:Rongbote.img

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
	rm 0 -f
