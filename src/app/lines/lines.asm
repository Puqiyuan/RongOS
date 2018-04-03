[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_initmalloc
	EXTERN	_api_malloc
	EXTERN	_api_openwin
	EXTERN	_api_linewin
	EXTERN	_api_refreshwin
	EXTERN	_api_getkey
	EXTERN	_api_closewin
	EXTERN	_api_end
[FILE "lines.c"]
[SECTION .data]
LC0:
	DB	"lines",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	EDI,EDI
	PUSH	EBX
	XOR	ESI,ESI
	PUSH	ECX
	CALL	_api_initmalloc
	PUSH	16000
	CALL	_api_malloc
	PUSH	LC0
	PUSH	-1
	PUSH	100
	PUSH	160
	PUSH	EAX
	CALL	_api_openwin
	ADD	ESP,24
	MOV	DWORD [-16+EBP],EAX
L6:
	PUSH	ESI
	LEA	EAX,DWORD [26+EDI]
	PUSH	EAX
	PUSH	77
	PUSH	26
	PUSH	8
	MOV	EBX,DWORD [-16+EBP]
	INC	EBX
	PUSH	EBX
	CALL	_api_linewin
	LEA	EAX,DWORD [88+EDI]
	PUSH	ESI
	ADD	EDI,9
	PUSH	89
	INC	ESI
	PUSH	EAX
	PUSH	26
	PUSH	88
	PUSH	EBX
	CALL	_api_linewin
	ADD	ESP,48
	CMP	ESI,7
	JLE	L6
	PUSH	90
	PUSH	154
	PUSH	26
	PUSH	6
	PUSH	DWORD [-16+EBP]
	CALL	_api_refreshwin
	ADD	ESP,20
L7:
	PUSH	1
	CALL	_api_getkey
	POP	EDX
	CMP	EAX,10
	JNE	L7
	PUSH	DWORD [-16+EBP]
	CALL	_api_closewin
	POP	EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_api_end
