[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_initmalloc
	EXTERN	_api_malloc
	EXTERN	_api_openwin
	EXTERN	_api_boxfilwin
	EXTERN	_rand
	EXTERN	_api_point
	EXTERN	_api_getkey
	EXTERN	_api_end
[FILE "stars.c"]
[SECTION .data]
LC0:
	DB	"stars",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	MOV	ESI,49
	PUSH	EBX
	CALL	_api_initmalloc
	PUSH	15000
	CALL	_api_malloc
	PUSH	LC0
	PUSH	-1
	PUSH	100
	PUSH	150
	PUSH	EAX
	CALL	_api_openwin
	PUSH	0
	PUSH	93
	MOV	EDI,EAX
	PUSH	143
	PUSH	26
	PUSH	6
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,48
L6:
	CALL	_rand
	MOV	EDX,137
	MOV	ECX,EDX
	CDQ
	IDIV	ECX
	LEA	EBX,DWORD [6+EDX]
	CALL	_rand
	MOV	EDX,67
	PUSH	1
	MOV	ECX,EDX
	CDQ
	IDIV	ECX
	ADD	EDX,26
	PUSH	EDX
	PUSH	EBX
	PUSH	EDI
	CALL	_api_point
	ADD	ESP,16
	DEC	ESI
	JNS	L6
L7:
	PUSH	1
	CALL	_api_getkey
	POP	EDX
	CMP	EAX,10
	JNE	L7
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_api_end
