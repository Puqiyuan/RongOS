[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_cmdline
	EXTERN	_api_fopen
	EXTERN	_api_fread
	EXTERN	_api_putchar
	EXTERN	_api_end
	EXTERN	_api_putstr0
[FILE "cat.c"]
[SECTION .data]
LC0:
	DB	"File not found.",0x0A,0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	SUB	ESP,36
	LEA	EBX,DWORD [-36+EBP]
	PUSH	30
	PUSH	EBX
	CALL	_api_cmdline
	MOV	EAX,EBX
	POP	EBX
	POP	EDX
	CMP	BYTE [-36+EBP],32
	JLE	L19
L6:
	INC	EAX
	CMP	BYTE [EAX],32
	JG	L6
L19:
	CMP	BYTE [EAX],32
	JE	L11
L21:
	PUSH	EAX
	CALL	_api_fopen
	POP	ECX
	MOV	EBX,EAX
	TEST	EAX,EAX
	JE	L12
L13:
	PUSH	EBX
	LEA	EAX,DWORD [-37+EBP]
	PUSH	1
	PUSH	EAX
	CALL	_api_fread
	ADD	ESP,12
	TEST	EAX,EAX
	JE	L17
	MOVSX	EAX,BYTE [-37+EBP]
	PUSH	EAX
	CALL	_api_putchar
	POP	EDX
	JMP	L13
L17:
	CALL	_api_end
	MOV	EBX,DWORD [-4+EBP]
	LEAVE
	RET
L12:
	PUSH	LC0
	CALL	_api_putstr0
	POP	EAX
	JMP	L17
L11:
	INC	EAX
	CMP	BYTE [EAX],32
	JE	L11
	JMP	L21
