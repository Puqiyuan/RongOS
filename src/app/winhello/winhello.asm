[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_openwin
	EXTERN	_api_getkey
	EXTERN	_api_end
[FILE "winhello.c"]
[SECTION .data]
LC0:
	DB	"hello",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	LC0
	PUSH	-1
	PUSH	50
	PUSH	150
	PUSH	_buf
	CALL	_api_openwin
	ADD	ESP,20
L2:
	PUSH	1
	CALL	_api_getkey
	POP	EDX
	CMP	EAX,10
	JNE	L2
	LEAVE
	JMP	_api_end
	GLOBAL	_buf
[SECTION .data]
	ALIGNB	16
_buf:
	RESB	7500
