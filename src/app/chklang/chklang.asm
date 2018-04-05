[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_getlang
	EXTERN	_api_putstr0
	EXTERN	_api_end
[FILE "chklang.c"]
[SECTION .data]
LC0:
	DB	"English ASCII mode",0x0A,0x00
LC1:
	DB	"Chinese GB2312 mode",0x0A,0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	CALL	_api_getlang
	TEST	EAX,EAX
	JNE	L2
	PUSH	LC0
L4:
	CALL	_api_putstr0
	POP	EAX
	LEAVE
	JMP	_api_end
L2:
	PUSH	LC1
	JMP	L4
