[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_fopen
	EXTERN	_api_end
	EXTERN	_api_fread
	EXTERN	_api_putchar
[FILE "catipl.c"]
[SECTION .data]
LC0:
	DB	"ipl10.asm",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	PUSH	ECX
	PUSH	LC0
	CALL	_api_fopen
	POP	EDX
	MOV	EBX,EAX
	TEST	EAX,EAX
	JNE	L3
L2:
	CALL	_api_end
	MOV	EBX,DWORD [-4+EBP]
	LEAVE
	RET
L3:
	PUSH	EBX
	LEA	EAX,DWORD [-5+EBP]
	PUSH	1
	PUSH	EAX
	CALL	_api_fread
	ADD	ESP,12
	TEST	EAX,EAX
	JE	L2
	MOVSX	EAX,BYTE [-5+EBP]
	PUSH	EAX
	CALL	_api_putchar
	POP	EAX
	JMP	L3
