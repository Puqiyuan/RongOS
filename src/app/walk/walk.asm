[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_initmalloc
	EXTERN	_api_malloc
	EXTERN	_api_openwin
	EXTERN	_api_boxfilwin
	EXTERN	_api_putstrwin
	EXTERN	_api_getkey
	EXTERN	_api_closewin
	EXTERN	_api_end
[FILE "walk.c"]
[SECTION .data]
LC0:
	DB	"walk",0x00
LC1:
	DB	"*",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	MOV	EDI,76
	PUSH	EBX
	MOV	ESI,56
	PUSH	EDX
	CALL	_api_initmalloc
	PUSH	16000
	CALL	_api_malloc
	PUSH	LC0
	PUSH	-1
	PUSH	100
	PUSH	160
	PUSH	EAX
	CALL	_api_openwin
	MOV	DWORD [-16+EBP],EAX
	PUSH	0
	PUSH	95
	PUSH	155
	PUSH	24
	PUSH	4
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,48
	PUSH	LC1
	PUSH	1
	PUSH	3
	PUSH	56
	PUSH	76
L10:
	PUSH	DWORD [-16+EBP]
	CALL	_api_putstrwin
	ADD	ESP,24
	PUSH	1
	CALL	_api_getkey
	PUSH	LC1
	PUSH	1
	MOV	EBX,EAX
	PUSH	0
	PUSH	ESI
	PUSH	EDI
	PUSH	DWORD [-16+EBP]
	CALL	_api_putstrwin
	ADD	ESP,28
	CMP	EBX,52
	JE	L11
L5:
	CMP	EBX,54
	JE	L12
L6:
	CMP	EBX,56
	JE	L13
L7:
	CMP	EBX,50
	JE	L14
L8:
	CMP	EBX,10
	JE	L3
	PUSH	LC1
	PUSH	1
	PUSH	3
	PUSH	ESI
	PUSH	EDI
	JMP	L10
L3:
	PUSH	DWORD [-16+EBP]
	CALL	_api_closewin
	POP	EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_api_end
L14:
	CMP	ESI,79
	JG	L8
	ADD	ESI,8
	JMP	L8
L13:
	CMP	ESI,24
	JLE	L7
	SUB	ESI,8
	JMP	L7
L12:
	CMP	EDI,147
	JG	L6
	ADD	EDI,8
	JMP	L6
L11:
	CMP	EDI,4
	JLE	L5
	SUB	EDI,8
	JMP	L5
