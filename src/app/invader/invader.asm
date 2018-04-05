[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	__alloca
	EXTERN	_api_openwin
	EXTERN	_api_boxfilwin
	EXTERN	_api_alloctimer
	EXTERN	_api_inittimer
	EXTERN	_invstr0.0
	EXTERN	_sprintf
	EXTERN	_charset
	EXTERN	_api_putstrwin
	EXTERN	_api_refreshwin
	EXTERN	_api_settimer
	EXTERN	_api_getkey
[FILE "invader.c"]
[SECTION .data]
_charset:
	DB	0
	DB	0
	DB	0
	DB	67
	DB	95
	DB	95
	DB	95
	DB	127
	DB	31
	DB	31
	DB	31
	DB	31
	DB	0
	DB	32
	DB	63
	DB	0
	DB	0
	DB	15
	DB	127
	DB	-1
	DB	-49
	DB	-49
	DB	-49
	DB	-1
	DB	-1
	DB	-32
	DB	-1
	DB	-1
	DB	-64
	DB	-64
	DB	-64
	DB	0
	DB	0
	DB	-16
	DB	-2
	DB	-1
	DB	-13
	DB	-13
	DB	-13
	DB	-1
	DB	-1
	DB	7
	DB	-1
	DB	-1
	DB	3
	DB	3
	DB	3
	DB	0
	DB	0
	DB	0
	DB	0
	DB	-62
	DB	-6
	DB	-6
	DB	-6
	DB	-2
	DB	-8
	DB	-8
	DB	-8
	DB	-8
	DB	0
	DB	4
	DB	-4
	DB	0
	DB	0
	DB	0
	DB	1
	DB	1
	DB	1
	DB	1
	DB	1
	DB	1
	DB	1
	DB	67
	DB	71
	DB	79
	DB	95
	DB	127
	DB	127
	DB	0
	DB	24
	DB	126
	DB	-1
	DB	-61
	DB	-61
	DB	-61
	DB	-61
	DB	-1
	DB	-1
	DB	-1
	DB	-25
	DB	-25
	DB	-25
	DB	-25
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-128
	DB	-128
	DB	-128
	DB	-128
	DB	-128
	DB	-128
	DB	-128
	DB	-62
	DB	-30
	DB	-14
	DB	-6
	DB	-2
	DB	-2
	DB	0
	DB	0
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	24
	DB	0
_invstr0.0:
	DB	" abcd abcd abcd abcd abcd ",0x00
	RESB	5
LC0:
	DB	"invader",0x00
LC1:
	DB	"HIGH:00000000",0x00
LC2:
	DB	"SCORE:00000000",0x00
LC3:
	DB	"efg",0x00
LC4:
	DB	"efg ",0x00
LC5:
	DB	" efg",0x00
LC8:
	DB	"h",0x00
LC9:
	DB	"%08d",0x00
LC7:
	DB	" ",0x00
LC6:
	DB	"                         ",0x00
LC10:
	DB	"GAME OVER",0x00
LC11:
	DB	"                                        ",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EAX,87964
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	LEA	EBX,DWORD [-87708+EBP]
	CALL	__alloca
	PUSH	LC0
	PUSH	-1
	PUSH	261
	PUSH	336
	PUSH	EBX
	MOV	DWORD [-87936+EBP],0
	CALL	_api_openwin
	PUSH	0
	PUSH	254
	MOV	EDI,EAX
	PUSH	329
	PUSH	27
	PUSH	6
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,44
	CALL	_api_alloctimer
	PUSH	128
	PUSH	EAX
	MOV	DWORD [-87924+EBP],EAX
	CALL	_api_inittimer
	PUSH	LC1
	PUSH	7
	PUSH	0
	PUSH	22
	PUSH	EBX
	PUSH	EDI
	MOV	DWORD [-87972+EBP],0
	CALL	_putstr
	ADD	ESP,32
L2:
	PUSH	LC2
	LEA	EBX,DWORD [-87708+EBP]
	PUSH	7
	PUSH	0
	PUSH	4
	PUSH	EBX
	PUSH	EDI
	MOV	DWORD [-87968+EBP],0
	MOV	DWORD [-87976+EBP],1
	CALL	_putstr
	PUSH	LC3
	PUSH	6
	PUSH	13
	PUSH	18
	PUSH	EBX
	PUSH	EDI
	MOV	DWORD [-87952+EBP],20
	MOV	DWORD [-87928+EBP],18
	CALL	_putstr
	LEA	EAX,DWORD [-87920+EBP]
	ADD	ESP,48
	PUSH	EAX
	PUSH	DWORD [-87924+EBP]
	PUSH	100
	CALL	_wait
	ADD	ESP,12
L3:
	LEA	EAX,DWORD [-87920+EBP]
	XOR	ESI,ESI
	PUSH	EAX
	PUSH	DWORD [-87924+EBP]
	PUSH	100
	CALL	_wait
	ADD	ESP,12
	MOV	DWORD [-87944+EBP],7
	MOV	DWORD [-87948+EBP],1
	MOV	DWORD [-87964+EBP],6
L13:
	XOR	ECX,ECX
L12:
	MOV	EBX,ESI
	LEA	EAX,DWORD [-12+EBP]
	SAL	EBX,5
	LEA	EDX,DWORD [EAX+EBX*1]
	MOV	AL,BYTE [_invstr0.0+ECX]
	MOV	BYTE [-87888+ECX+EDX*1],AL
	INC	ECX
	CMP	ECX,26
	JLE	L12
	LEA	EAX,DWORD [-87900+EBX+EBP*1]
	LEA	EBX,DWORD [1+ESI]
	PUSH	EAX
	MOV	ESI,EBX
	PUSH	2
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	EBX
	PUSH	7
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	CMP	EBX,5
	JLE	L13
	LEA	EAX,DWORD [-87920+EBP]
	MOV	EBX,DWORD [-87952+EBP]
	PUSH	EAX
	MOV	DWORD [-87956+EBP],EBX
	PUSH	DWORD [-87924+EBP]
	PUSH	100
	MOV	BYTE [-87920+EBP],0
	MOV	BYTE [-87919+EBP],0
	MOV	BYTE [-87918+EBP],0
	MOV	DWORD [-87940+EBP],0
	MOV	DWORD [-87932+EBP],0
	MOV	DWORD [-87960+EBP],1
	CALL	_wait
	ADD	ESP,12
L14:
	CMP	DWORD [-87932+EBP],0
	JE	L17
	DEC	DWORD [-87932+EBP]
	MOV	BYTE [-87918+EBP],0
L17:
	LEA	EBX,DWORD [-87920+EBP]
	PUSH	EBX
	PUSH	DWORD [-87924+EBP]
	PUSH	4
	CALL	_wait
	ADD	ESP,12
	CMP	BYTE [-87920+EBP],0
	JE	L18
	CMP	DWORD [-87928+EBP],0
	JLE	L18
	PUSH	LC4
	DEC	DWORD [-87928+EBP]
	PUSH	6
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	13
	PUSH	DWORD [-87928+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	MOV	BYTE [-87920+EBP],0
L18:
	CMP	BYTE [1+EBX],0
	JE	L19
	CMP	DWORD [-87928+EBP],36
	JG	L19
	PUSH	LC5
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	6
	PUSH	13
	PUSH	DWORD [-87928+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	INC	DWORD [-87928+EBP]
	MOV	BYTE [1+EBX],0
L19:
	CMP	BYTE [2+EBX],0
	JE	L20
	CMP	DWORD [-87932+EBP],0
	JNE	L20
	MOV	EAX,DWORD [-87928+EBP]
	INC	EAX
	MOV	DWORD [-87932+EBP],15
	MOV	DWORD [-87936+EBP],EAX
	MOV	DWORD [-87940+EBP],13
L20:
	CMP	DWORD [-87956+EBP],0
	JE	L21
	DEC	DWORD [-87956+EBP]
L22:
	CMP	DWORD [-87940+EBP],0
	JLE	L14
	CMP	DWORD [-87940+EBP],12
	JG	L32
	MOV	EBX,DWORD [-87936+EBP]
	CMP	DWORD [-87944+EBP],EBX
	JGE	L33
	MOV	EAX,DWORD [-87944+EBP]
	ADD	EAX,25
	CMP	EBX,EAX
	JGE	L33
	MOV	EAX,DWORD [-87940+EBP]
	CMP	DWORD [-87948+EBP],EAX
	JG	L33
	MOV	EAX,DWORD [-87948+EBP]
	ADD	EAX,DWORD [-87964+EBP]
	CMP	DWORD [-87940+EBP],EAX
	JGE	L33
	MOV	EAX,DWORD [-87940+EBP]
	SUB	EAX,DWORD [-87948+EBP]
	SAL	EAX,5
	LEA	EAX,DWORD [-87900+EAX+EBP*1]
	PUSH	EAX
	PUSH	2
	PUSH	DWORD [-87940+EBP]
	PUSH	DWORD [-87944+EBP]
L82:
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
L32:
	DEC	DWORD [-87940+EBP]
	CMP	DWORD [-87940+EBP],0
	JLE	L35
	PUSH	LC8
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	3
	PUSH	DWORD [-87940+EBP]
	PUSH	DWORD [-87936+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
L36:
	MOV	EBX,DWORD [-87936+EBP]
	CMP	DWORD [-87944+EBP],EBX
	JGE	L14
	MOV	EAX,DWORD [-87944+EBP]
	ADD	EAX,25
	CMP	EBX,EAX
	JGE	L14
	MOV	EAX,DWORD [-87940+EBP]
	CMP	DWORD [-87948+EBP],EAX
	JG	L14
	MOV	EAX,DWORD [-87948+EBP]
	ADD	EAX,DWORD [-87964+EBP]
	CMP	DWORD [-87940+EBP],EAX
	JGE	L14
	MOV	EAX,DWORD [-87940+EBP]
	SUB	EAX,DWORD [-87948+EBP]
	SAL	EAX,5
	LEA	EDX,DWORD [-87900+EAX+EBP*1]
	MOV	EAX,EBX
	SUB	EAX,DWORD [-87944+EBP]
	LEA	EBX,DWORD [EAX+EDX*1]
	CMP	BYTE [EBX],32
	JE	L14
	MOV	EAX,DWORD [-87976+EBP]
	LEA	ESI,DWORD [-87916+EBP]
	ADD	DWORD [-87968+EBP],EAX
	INC	EAX
	MOV	DWORD [-87976+EBP],EAX
	PUSH	DWORD [-87968+EBP]
	PUSH	LC9
	PUSH	ESI
	CALL	_sprintf
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	ESI
	PUSH	7
	PUSH	0
	PUSH	10
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	MOV	EAX,DWORD [-87968+EBP]
	ADD	ESP,36
	CMP	DWORD [-87972+EBP],EAX
	JGE	L40
	PUSH	ESI
	MOV	DWORD [-87972+EBP],EAX
	PUSH	7
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	0
	PUSH	27
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
L40:
	DEC	EBX
	CMP	BYTE [EBX],32
	JE	L74
L45:
	DEC	EBX
	CMP	BYTE [EBX],32
	JNE	L45
L74:
	MOV	ESI,1
L50:
	MOV	BYTE [ESI+EBX*1],32
	INC	ESI
	CMP	ESI,4
	JLE	L50
	MOV	EAX,DWORD [-87940+EBP]
	SUB	EAX,DWORD [-87948+EBP]
	SAL	EAX,5
	LEA	EAX,DWORD [-87900+EAX+EBP*1]
	PUSH	EAX
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	2
	PUSH	DWORD [-87940+EBP]
	PUSH	DWORD [-87944+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	CMP	DWORD [-87964+EBP],0
	JLE	L78
	MOV	EDX,DWORD [-87964+EBP]
	SAL	EDX,5
L62:
	LEA	EAX,DWORD [-87900+EDX+EBP*1]
	LEA	EBX,DWORD [-32+EAX]
	CMP	BYTE [-32+EAX],0
	JE	L80
L61:
	CMP	BYTE [EBX],32
	JNE	L60
	INC	EBX
	CMP	BYTE [EBX],0
	JNE	L61
L80:
	DEC	DWORD [-87964+EBP]
	SUB	EDX,32
	CMP	DWORD [-87964+EBP],0
	JG	L62
L78:
	MOV	EAX,DWORD [-87952+EBP]
	MOV	EDX,3
	MOV	EBX,EDX
	CDQ
	IDIV	EBX
	SUB	DWORD [-87952+EBP],EAX
	JMP	L3
L60:
	MOV	DWORD [-87940+EBP],0
	JMP	L14
L35:
	SUB	DWORD [-87976+EBP],10
	CMP	DWORD [-87976+EBP],0
	JG	L36
	MOV	DWORD [-87976+EBP],1
	JMP	L36
L33:
	PUSH	LC7
	PUSH	0
	PUSH	DWORD [-87940+EBP]
	PUSH	DWORD [-87936+EBP]
	JMP	L82
L21:
	MOV	EAX,DWORD [-87952+EBP]
	MOV	DWORD [-87956+EBP],EAX
	MOV	EAX,DWORD [-87944+EBP]
	ADD	EAX,DWORD [-87960+EBP]
	CMP	EAX,14
	JBE	L23
	MOV	EAX,DWORD [-87948+EBP]
	ADD	EAX,DWORD [-87964+EBP]
	CMP	EAX,13
	JE	L15
	PUSH	LC6
	MOV	EAX,DWORD [-87944+EBP]
	PUSH	0
	INC	EAX
	PUSH	DWORD [-87948+EBP]
	PUSH	EAX
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	EAX
	NEG	DWORD [-87960+EBP]
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	INC	DWORD [-87948+EBP]
L25:
	XOR	ESI,ESI
	CMP	ESI,DWORD [-87964+EBP]
	JGE	L22
	XOR	EBX,EBX
L30:
	LEA	EAX,DWORD [-87900+EBX+EBP*1]
	ADD	EBX,32
	PUSH	EAX
	MOV	EAX,DWORD [-87948+EBP]
	PUSH	2
	ADD	EAX,ESI
	PUSH	EAX
	INC	ESI
	PUSH	DWORD [-87944+EBP]
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	CMP	ESI,DWORD [-87964+EBP]
	JL	L30
	JMP	L22
L15:
	PUSH	LC10
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	1
	MOV	ESI,1
	PUSH	6
	PUSH	15
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	PUSH	EBX
	PUSH	DWORD [-87924+EBP]
	PUSH	0
	CALL	_wait
	ADD	ESP,36
L67:
	PUSH	LC11
	LEA	EAX,DWORD [-87708+EBP]
	PUSH	0
	PUSH	ESI
	INC	ESI
	PUSH	0
	PUSH	EAX
	PUSH	EDI
	CALL	_putstr
	ADD	ESP,24
	CMP	ESI,13
	JLE	L67
	JMP	L2
L23:
	MOV	DWORD [-87944+EBP],EAX
	JMP	L25
	GLOBAL	_putstr
_putstr:
	PUSH	EBP
	OR	ECX,-1
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,12
	MOV	EDX,DWORD [20+EBP]
	MOV	ESI,DWORD [16+EBP]
	SAL	EDX,4
	MOV	EDI,DWORD [28+EBP]
	LEA	ESI,DWORD [8+ESI*8]
	LEA	EAX,DWORD [29+EDX]
	MOV	DWORD [-24+EBP],ESI
	CLD
	MOV	DWORD [-20+EBP],EAX
	ADD	EDX,44
	XOR	EAX,EAX
	REPNE
	SCASB
	NOT	ECX
	PUSH	0
	MOV	EAX,DWORD [8+EBP]
	PUSH	EDX
	LEA	ECX,DWORD [-9+ESI+ECX*8]
	PUSH	ECX
	INC	EAX
	PUSH	DWORD [-20+EBP]
	PUSH	ESI
	LEA	EDI,DWORD [-14+EBP]
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,24
	MOV	EAX,DWORD [-20+EBP]
	MOV	EBX,DWORD [12+EBP]
	IMUL	EAX,EAX,336
	MOV	BYTE [-13+EBP],0
	ADD	EBX,EAX
L84:
	MOV	EAX,DWORD [28+EBP]
	MOV	CL,BYTE [EAX]
	MOVZX	EDX,CL
	TEST	EDX,EDX
	JE	L85
	CMP	EDX,32
	JE	L88
	LEA	EAX,DWORD [-97+EDX]
	CMP	EAX,7
	JA	L89
	SAL	EDX,4
	ADD	EBX,ESI
	ADD	EDX,_charset-1552
	XOR	ECX,ECX
L102:
	CMP	BYTE [ECX+EDX*1],0
	JNS	L94
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [EBX],AL
L94:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,64
	TEST	AL,AL
	JE	L95
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [1+EBX],AL
L95:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,32
	TEST	AL,AL
	JE	L96
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [2+EBX],AL
L96:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,16
	TEST	AL,AL
	JE	L97
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [3+EBX],AL
L97:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,8
	TEST	AL,AL
	JE	L98
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [4+EBX],AL
L98:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,4
	TEST	AL,AL
	JE	L99
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [5+EBX],AL
L99:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,2
	TEST	AL,AL
	JE	L100
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [6+EBX],AL
L100:
	MOV	AL,BYTE [ECX+EDX*1]
	AND	EAX,1
	TEST	AL,AL
	JE	L101
	MOV	AL,BYTE [24+EBP]
	MOV	BYTE [7+EBX],AL
L101:
	INC	ECX
	ADD	EBX,336
	CMP	ECX,15
	JLE	L102
	MOV	EAX,EBX
	SUB	EAX,ESI
	LEA	EBX,DWORD [-5376+EAX]
L88:
	INC	DWORD [28+EBP]
	ADD	ESI,8
	JMP	L84
L89:
	PUSH	EDI
	MOV	EAX,DWORD [8+EBP]
	PUSH	1
	INC	EAX
	PUSH	DWORD [24+EBP]
	PUSH	DWORD [-20+EBP]
	PUSH	ESI
	MOV	BYTE [-14+EBP],CL
	PUSH	EAX
	CALL	_api_putstrwin
	ADD	ESP,24
	JMP	L88
L85:
	MOV	EAX,DWORD [-20+EBP]
	ADD	EAX,16
	PUSH	EAX
	PUSH	ESI
	PUSH	DWORD [-20+EBP]
	PUSH	DWORD [-24+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_api_refreshwin
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_wait
_wait:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	ESI
	PUSH	EBX
	MOV	EBX,DWORD [8+EBP]
	MOV	ESI,DWORD [16+EBP]
	TEST	EBX,EBX
	JLE	L107
	PUSH	EBX
	MOV	EBX,128
	PUSH	DWORD [12+EBP]
	CALL	_api_settimer
	POP	ECX
	POP	EAX
L109:
	PUSH	1
	CALL	_api_getkey
	POP	EDX
	CMP	EBX,EAX
	JE	L106
	CMP	EAX,52
	JE	L116
L113:
	CMP	EAX,54
	JE	L117
L114:
	CMP	EAX,32
	JNE	L109
	MOV	BYTE [2+ESI],1
	JMP	L109
L117:
	MOV	BYTE [1+ESI],1
	JMP	L114
L116:
	MOV	BYTE [ESI],1
	JMP	L113
L106:
	LEA	ESP,DWORD [-8+EBP]
	POP	EBX
	POP	ESI
	POP	EBP
	RET
L107:
	MOV	EBX,10
	JMP	L109
