TOOLPATH = ./z_tools/
INCPATH = ./z_tools/haribote/

edimg = $(TOOLPATH)edimg.exe

default:
	make full
	make -r Rongbote.img

Rongbote.img: ./kernel/ipl10.bin ./kernel/Rongbote.sys ./app/a/a.ros ./app/hello3/hello3.ros ./app/hello4/hello4.ros ./app/winhello/winhello.ros ./app/winhelo2/winhelo2.ros ./app/winhelo3/winhelo3.ros ./app/star1/star1.ros ./app/stars/stars.ros ./app/stars2/stars2.ros ./app/lines/lines.ros ./app/walk/walk.ros ./app/sundial/sundial.ros ./app/noodle/noodle.ros ./app/beepdown/beepdown.ros ./app/color/color.ros ./app/color2/color2.ros ./app/prime/prime.ros ./app/prime2/prime2.ros ./app/catipl/catipl.ros ./app/cat/cat.ros ./app/chklang/chklang.ros ./app/bball/bball.ros ./app/invader/invader.ros
	wine $(edimg) imgin:./z_tools/fdimg0at.tek wbinimg src:kernel/ipl10.bin \
    len:512 from:0 to:0 \
	copy from:./kernel/Rongbote.sys to:@: \
	copy from:./kernel/ipl10.asm to:@: \
	copy from:./Makefile to:@: \
	copy from:./app/a/a.ros to:@: \
	copy from:./app/hello3/hello3.ros to:@: \
	copy from:./app/hello4/hello4.ros to:@: \
	copy from:./app/winhello/winhello.ros to:@: \
	copy from:./app/winhelo2/winhelo2.ros to:@: \
	copy from:./app/winhelo3/winhelo3.ros to:@: \
	copy from:./app/star1/star1.ros to:@: \
	copy from:./app/stars/stars.ros to:@: \
	copy from:./app/stars2/stars2.ros to:@: \
	copy from:./app/lines/lines.ros to:@: \
	copy from:./app/walk/walk.ros to:@: \
	copy from:./app/sundial/sundial.ros to:@: \
	copy from:./app/noodle/noodle.ros to:@: \
	copy from:./app/beepdown/beepdown.ros to:@: \
	copy from:./app/color/color.ros to:@: \
	copy from:./app/color2/color2.ros to:@: \
	copy from:./app/prime/prime.ros to:@: \
	copy from:./app/prime2/prime2.ros to:@: \
	copy from:./app/catipl/catipl.ros to:@: \
	copy from:./app/cat/cat.ros to:@: \
	copy from:./font/chinese.fnt to:@: \
	copy from:./thanks.txt to:@: \
	copy from:./app/chklang/chklang.ros to:@: \
	copy from:./app/bball/bball.ros to:@: \
	copy from:./app/invader/invader.ros to:@: \
	imgout:Rongbote.img

vrun:
	make full
	qemu-system-x86_64 -fda Rongbote.img

drun: install
	sudo qemu-system-x86_64 -fda /dev/sdb

install:
	make full
	sudo dd if=Rongbote.img of=/dev/sdb bs=512 count=2880
	sudo sync
	make src_only_full

reboot: install
	reboot

full:
	make -C kernel
	make -C apilib
	make -C ./app/a
	make -C ./app/hello3
	make -C ./app/hello4
	make -C ./app/winhello
	make -C ./app/winhelo2
	make -C ./app/winhelo3
	make -C ./app/star1
	make -C ./app/stars
	make -C ./app/stars2
	make -C ./app/lines
	make -C ./app/walk
	make -C ./app/noodle
	make -C ./app/beepdown
	make -C ./app/color
	make -C ./app/color2
	make -C ./app/sundial
	make -C ./app/prime
	make -C ./app/prime2
	make -C ./app/catipl
	make -C ./app/cat
	make -C ./app/chklang
	make -C ./app/bball
	make -C ./app/invader
	make Rongbote.img

vrun_full:
	make full
	qemu-system-x86_64 -fda Rongbote.img

vrun_os:
	make -C kernel
	make vrun

src_only:
	make clean
	rm Rongbote.img

clean_full:
	make -C kernel clean
	make -C apilib clean
	make -C ./app/a clean
	make -C ./app/hello3 clean
	make -C ./app/hello4 clean
	make -C ./app/winhello clean
	make -C ./app/winhelo2 clean
	make -C ./app/winhelo3 clean
	make -C ./app/star1 clean
	make -C ./app/stars clean
	make -C ./app/stars2 clean
	make -C ./app/lines clean
	make -C ./app/walk clean
	make -C ./app/noodle clean
	make -C ./app/beepdown clean
	make -C ./app/color clean
	make -C ./app/color2 clean
	make -C ./app/sundial clean
	make -C ./app/prime clean
	make -C ./app/prime2 clean
	make -C ./app/catipl clean
	make -C ./app/cat clean
	make -C ./app/chklang clean
	make -C ./app/bball clean
	make -C ./app/invader clean
src_only_full:
	make -C kernel src_only
	make -C apilib src_only
	make -C ./app/a src_only
	make -C ./app/hello3 src_only
	make -C ./app/hello4 src_only
	make -C ./app/winhello src_only
	make -C ./app/winhelo2 src_only
	make -C ./app/winhelo3 src_only
	make -C ./app/star1 src_only
	make -C ./app/stars src_only
	make -C ./app/stars2 src_only
	make -C ./app/lines src_only
	make -C ./app/walk src_only
	make -C ./app/noodle src_only
	make -C ./app/sundial src_only
	make -C ./app/beepdown src_only
	make -C ./app/color src_only
	make -C ./app/color2 src_only
	make -C ./app/prime src_only
	make -C ./app/prime2 src_only
	make -C ./app/catipl src_only
	make -C ./app/cat src_only
	make -C ./app/chklang src_only
	make -C ./app/bball src_only
	make -C ./app/invader src_only
	rm Rongbote.img -f

refersh:
	make full
	make clean_full
	rm Rongbote.img
