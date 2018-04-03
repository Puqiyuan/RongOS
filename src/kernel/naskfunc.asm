		[FORMAT "WCOFF"] ; mode for creating object files
		[INSTRSET "i486p"] ; a statement that you want to use up to 486 instructions
		[BITS 32] ; make machine language for 32 bit mode
		[FILE "naskfunc.asm"] ; source file name information

global _io_hlt, _io_cli, _io_sti, _io_stihlt
global _io_in8, _io_in16, _io_in32
global _io_out8, _io_out16, _io_out32
global _io_load_eflags, _io_store_eflags
global _load_gdtr, _load_idtr
global _load_cr0, _store_cr0
global _load_tr
global _asm_inthandler20, _asm_inthandler21
global _asm_inthandler27, _asm_inthandler2c
global _asm_inthandler0c, _asm_inthandler0d
global _asm_end_app, _memtest_sub
global _farjmp, _farcall
global _asm_ros_api, _start_app
extern _inthandler20, _inthandler21
extern _inthandler27, _inthandler2c
extern _inthandler0c, _inthandler0d
extern _ros_api


		[SECTION .text]

_io_hlt: ;void io_hlt(void)
		hlt
		ret

_io_cli: ;void io_cli(void)
		cli
		ret

_io_sti: ;void io_sti(void)
		sti
		ret

_io_stihlt: ;void io_stihlt(void)
		sti
		hlt
		ret

_io_in8: ; int io_in8(int port)
		mov edx, [esp + 4]
		mov eax, 0
		in al, dx
		ret

_io_in16: ;int io_in16(int port)
		mov edx, [esp + 4]
		mov eax, 0
		in ax, dx
		ret

_io_in32: ;int io_in32(int port)
		mov edx, [esp + 4]
		in eax, dx
		ret

_io_out8: ;void io_out8(int port, int data)
		mov edx, [esp + 4]
		mov al, [esp + 8]
		out dx, al
		ret

_io_out16: ;void io_out16(int port, int data)
		mov edx, [esp + 4]
		mov eax, [esp + 8]
		out dx, ax
		ret

_io_out32: ;void io_out32(int port, int data)
		mov edx, [esp + 4]
		mov eax, [esp + 8]
		out dx, eax
		ret

_io_load_eflags: ;int io_load_eflags(void)
		pushfd
		pop eax
		ret

_io_store_eflags: ;void io_store_elfags(int eflags)
		mov eax, [esp + 4]
		push eax
		popfd
		ret

_load_gdtr: ;void load_gdtr(int limit, int addr);
		mov ax, [esp + 4]
		mov [esp + 6], ax
		lgdt [esp + 6]
		ret

_load_idtr: ;void load_idtr(int limit, int addr);
		mov ax, [esp + 4]
		mov [esp + 6], ax
		lidt [esp + 6]
		ret

_load_cr0: ; int load_cr0(void);
		mov eax, cr0
		ret

_store_cr0: ; void store_cr0(int cr0)
		mov eax, [esp + 4]
		mov cr0, eax
		ret

_load_tr: ; void load_tr(int tr);
		ltr [esp + 4] ; tr
		ret

_asm_inthandler20:
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler20
		pop eax
		popad
		pop ds
		pop es
		iretd
		
_asm_inthandler21:
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler21
		pop eax
		popad
		pop ds
		pop es
		iretd

_asm_inthandler27:
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler27
		pop eax
		popad
		pop ds
		pop es
		iretd
		

_asm_inthandler2c:
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler2c
		pop eax
		popad
		pop ds
		pop es
		iretd

_asm_inthandler0c: ; stack execption
		sti
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler0c
		cmp eax, 0
		jne _asm_end_app
		pop eax
		popad
		pop ds
		pop es
		add esp, 4
		iretd
		
_asm_inthandler0d:
		sti
		push es
		push ds
		pushad
		mov eax, esp
		push eax
		mov ax, ss
		mov ds, ax
		mov es, ax
		call _inthandler0d
		cmp eax, 0 ; 
		jne _asm_end_app
		pop eax
		popad
		pop ds
		pop es
		add esp, 4
		iretd
		
_memtest_sub: ; unsigned int memtest_sub(unsigned int start, unsigned int end)
		push edi
		push esi
		push ebx ; store the value of three registers 
		mov esi, 0xaa55aa55 ; pat0 = 0xaa55aa55
		mov edi, 0x55aa55aa ; pat1 = 0x55aa55aa
		mov eax, [esp + 12 + 4] ; i = start

mts_loop:
		mov ebx, eax
		add ebx, 0xffc ; p = i + 0xffc
		mov edx, [ebx] ; old = *p;
		mov [ebx], esi ; *p = pat0
		xor dword [ebx], 0xffffffff ; *p ^= 0xffffffff
		cmp edi, [ebx] ; if (*p != pat1) goto fin
		jne mts_fin
		xor dword [ebx], 0xffffffff ; *p ^= 0xffffffff
		cmp esi, [ebx] ; if (*p != pat0) goto fin;

		jne mts_fin
		mov [ebx], edx ; *p = old;
		add eax, 0x1000 ; i += 0x1000;
		cmp eax, [esp + 12 + 8] ; if (i <= end) goto mts_loop;
		jbe mts_loop
		pop ebx
		pop esi
		pop edi
		ret

mts_fin:
		mov [ebx], edx ; *p = old;
		pop ebx
		pop esi
		pop edi
		ret

_farjmp: ; void farjmp(int eip, int cs);
		jmp far [esp + 4] ; eip, cs
		ret

_farcall: ; void farcall(int eip, int cs)
		call far [esp+4] ; eip, cs
		ret
		
_asm_ros_api:
		sti
		push ds
		push es
		pushad ; push for storage
		pushad ; push to pass to hrb_api
		mov ax, ss
		mov ds, ax ; place the segment for OS also in ds and es
		mov es, ax
		call _ros_api
		cmp eax, 0
		jne _asm_end_app ; if eax is not 0, application termination processing
		add esp, 32
		popad
		pop es
		pop ds
		iretd
_asm_end_app:
; eax is the address of tss.esp0
		mov esp, [eax]
		mov dword [eax + 4], 0
		popad
		ret ; return cmd_app

_start_app: ; void start_app(int eip, int cs, int esp, int ds, int *tss_esp0);
		pushad ; save all 32 bit registers
		mov eax, [esp + 36] ; eip for applications
		mov ecx, [esp + 40] ; cs for applications
		mov edx, [esp + 44] ; esp for applications
		mov ebx, [esp + 48] ; ds/ss for applications
		mov ebp, [esp + 52] ; tss.esp0
		mov [ebp], esp ; esp for OS
		mov [ebp + 4], ss ; ss for OS
		mov es, bx
		mov ds, bx
		mov fs, bx
		mov gs, bx

		or ecx, 3
		or ebx, 3
		push ebx ; application ss
		push edx ; application esp
		push ecx ; application cs
		push eax ; application eip
		retf
; even if the application ends, it will not come here
		