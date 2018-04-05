[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	__alloca
	EXTERN	_api_getlang
	EXTERN	_api_cmdline
	EXTERN	_api_putstr0
	EXTERN	_api_end
	EXTERN	_strtol
	EXTERN	_api_openwin
	EXTERN	_api_boxfilwin
	EXTERN	_api_fopen
	EXTERN	_api_fsize
	EXTERN	_api_fread
	EXTERN	_api_fclose
	EXTERN	_api_getkey
	EXTERN	_api_refreshwin
	EXTERN	_api_putstrwin
[FILE "tview.c"]
[SECTION .data]
LC0:
	DB	" >tview file [-w30 -h10 -t4]",0x0A,0x00
LC1:
	DB	"tview",0x00
LC2:
	DB	"file open error.",0x0A,0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EAX,1021000
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	XOR	EDI,EDI
	PUSH	EBX
	LEA	EBX,DWORD [-1020972+EBP]
	CALL	__alloca
	MOV	DWORD [-1020980+EBP],30
	MOV	DWORD [-1020984+EBP],10
	MOV	DWORD [-1020988+EBP],4
	MOV	DWORD [-1020992+EBP],1
	MOV	DWORD [-1020996+EBP],1
	CALL	_api_getlang
	PUSH	30
	PUSH	EBX
	MOV	DWORD [-1021004+EBP],EAX
	MOV	DWORD [-1021008+EBP],0
	MOV	DWORD [-1021012+EBP],0
	CALL	_api_cmdline
	MOV	ECX,EBX
	POP	ESI
	MOV	DWORD [-1020976+EBP],EBX
	POP	EAX
	CMP	BYTE [-1020972+EBP],32
	JLE	L95
	LEA	EDX,DWORD [-1020971+EBP]
L6:
	MOV	EAX,EDX
	MOV	DWORD [-1020976+EBP],EDX
	LEA	EDX,DWORD [2+ECX]
	MOV	ECX,EAX
	CMP	BYTE [-1+EDX],32
	JG	L6
L95:
	MOV	EAX,DWORD [-1020976+EBP]
	CMP	BYTE [EAX],0
	JE	L97
	PUSH	DWORD [-1020976+EBP]
	CALL	_skipspace
	POP	EBX
	MOV	EDX,EAX
	MOV	DWORD [-1020976+EBP],EAX
	MOV	CL,BYTE [EAX]
	CMP	CL,45
	JE	L108
	TEST	EDI,EDI
	JE	L109
L23:
	PUSH	LC0
	CALL	_api_putstr0
	CALL	_api_end
	POP	ESI
	JMP	L95
L109:
	MOV	EDI,EAX
	CMP	CL,32
	JLE	L99
L30:
	MOV	EDX,DWORD [-1020976+EBP]
	LEA	EAX,DWORD [1+EDX]
	MOV	DWORD [-1020976+EBP],EAX
	CMP	BYTE [1+EDX],32
	JG	L30
L99:
	MOV	EAX,DWORD [-1020976+EBP]
	MOV	DWORD [-1021012+EBP],EAX
	JMP	L95
L108:
	MOV	AL,BYTE [1+EAX]
	CMP	AL,119
	JE	L110
	CMP	AL,104
	JE	L111
	CMP	AL,116
	JNE	L23
	PUSH	0
	LEA	EAX,DWORD [-1020976+EBP]
	PUSH	EAX
	LEA	EAX,DWORD [2+EDX]
	PUSH	EAX
	CALL	_strtol
	ADD	ESP,12
	TEST	EAX,EAX
	MOV	DWORD [-1020988+EBP],EAX
	JG	L95
	MOV	DWORD [-1020988+EBP],4
	JMP	L95
L111:
	PUSH	0
	LEA	EAX,DWORD [-1020976+EBP]
	PUSH	EAX
	LEA	EAX,DWORD [2+EDX]
	PUSH	EAX
	CALL	_strtol
	ADD	ESP,12
	TEST	EAX,EAX
	MOV	DWORD [-1020984+EBP],EAX
	JLE	L112
L17:
	CMP	DWORD [-1020984+EBP],45
	JLE	L95
	MOV	DWORD [-1020984+EBP],45
	JMP	L95
L112:
	MOV	DWORD [-1020984+EBP],1
	JMP	L17
L110:
	PUSH	0
	LEA	EAX,DWORD [-1020976+EBP]
	PUSH	EAX
	LEA	EAX,DWORD [2+EDX]
	PUSH	EAX
	CALL	_strtol
	ADD	ESP,12
	CMP	EAX,19
	MOV	DWORD [-1020980+EBP],EAX
	JG	L13
	MOV	DWORD [-1020980+EBP],20
L13:
	CMP	DWORD [-1020980+EBP],126
	JLE	L95
	MOV	DWORD [-1020980+EBP],126
	JMP	L95
L97:
	TEST	EDI,EDI
	JE	L23
	MOV	ESI,DWORD [-1020984+EBP]
	MOV	EBX,DWORD [-1020980+EBP]
	SAL	ESI,4
	PUSH	LC1
	SAL	EBX,3
	PUSH	-1
	LEA	EAX,DWORD [37+ESI]
	ADD	ESI,30
	PUSH	EAX
	LEA	EAX,DWORD [16+EBX]
	PUSH	EAX
	ADD	EBX,9
	LEA	EAX,DWORD [-775180+EBP]
	PUSH	EAX
	CALL	_api_openwin
	PUSH	7
	PUSH	ESI
	PUSH	EBX
	MOV	DWORD [-1021000+EBP],EAX
	PUSH	27
	PUSH	6
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,44
	MOV	ECX,DWORD [-1021012+EBP]
	MOV	BYTE [ECX],0
	PUSH	EDI
	CALL	_api_fopen
	POP	EBX
	MOV	EDI,EAX
	TEST	EAX,EAX
	JNE	L33
	PUSH	LC2
	CALL	_api_putstr0
	CALL	_api_end
	POP	ECX
L33:
	PUSH	0
	PUSH	EDI
	CALL	_api_fsize
	MOV	ESI,EAX
	POP	EAX
	POP	EDX
	CMP	ESI,245758
	JLE	L34
	MOV	ESI,245758
L34:
	PUSH	EDI
	LEA	EBX,DWORD [-1020939+EBP]
	PUSH	ESI
	PUSH	EBX
	MOV	BYTE [-1020940+EBP],10
	CALL	_api_fread
	PUSH	EDI
	MOV	EDI,EBX
	CALL	_api_fclose
	MOV	BYTE [-1020939+EBP+ESI*1],0
	ADD	ESP,16
	MOV	DWORD [-1020976+EBP],EBX
	CMP	BYTE [-1020939+EBP],0
	JE	L101
L40:
	MOV	EAX,DWORD [-1020976+EBP]
	MOV	AL,BYTE [EAX]
	CMP	AL,13
	JE	L37
	MOV	BYTE [EDI],AL
	INC	EDI
L37:
	MOV	EDX,DWORD [-1020976+EBP]
	LEA	EAX,DWORD [1+EDX]
	MOV	DWORD [-1020976+EBP],EAX
	CMP	BYTE [1+EDX],0
	JNE	L40
L101:
	LEA	EAX,DWORD [-1020939+EBP]
	MOV	BYTE [EDI],0
	MOV	DWORD [-1020976+EBP],EAX
L41:
	PUSH	DWORD [-1021004+EBP]
	PUSH	DWORD [-1020988+EBP]
	PUSH	DWORD [-1020976+EBP]
	PUSH	DWORD [-1021008+EBP]
	PUSH	DWORD [-1020984+EBP]
	PUSH	DWORD [-1020980+EBP]
	PUSH	DWORD [-1021000+EBP]
	CALL	_textview
	PUSH	1
	CALL	_api_getkey
	ADD	ESP,32
	MOV	EDI,EAX
	CMP	EAX,81
	JE	L45
	CMP	EAX,113
	JE	L45
L44:
	LEA	ECX,DWORD [-65+EDI]
	CMP	ECX,5
	JA	L46
	MOV	DWORD [-1020992+EBP],1
	SAL	DWORD [-1020992+EBP],CL
L46:
	LEA	ECX,DWORD [-97+EDI]
	CMP	ECX,5
	JA	L47
	MOV	DWORD [-1020996+EBP],1
	SAL	DWORD [-1020996+EBP],CL
L47:
	CMP	EDI,60
	JE	L113
L48:
	CMP	EDI,62
	JE	L114
L49:
	CMP	EDI,52
	JE	L51
L50:
	CMP	EDI,54
	JE	L57
L56:
	CMP	EDI,56
	JE	L62
L61:
	CMP	EDI,50
L107:
	JNE	L41
	XOR	ESI,ESI
	CMP	ESI,DWORD [-1020996+EBP]
	JGE	L82
L92:
	MOV	EDI,DWORD [-1020976+EBP]
	MOV	AL,BYTE [EDI]
	TEST	AL,AL
	JE	L86
	CMP	AL,10
	JE	L86
L90:
	INC	EDI
	MOV	AL,BYTE [EDI]
	TEST	AL,AL
	JE	L86
	CMP	AL,10
	JNE	L90
L86:
	CMP	BYTE [EDI],0
	JE	L82
	LEA	EAX,DWORD [1+EDI]
	INC	ESI
	MOV	DWORD [-1020976+EBP],EAX
	CMP	ESI,DWORD [-1020996+EBP]
	JL	L92
L82:
	PUSH	0
	CALL	_api_getkey
	POP	EDX
	CMP	EAX,50
	JMP	L107
L62:
	XOR	ESI,ESI
	CMP	ESI,DWORD [-1020996+EBP]
	JGE	L66
L75:
	LEA	EAX,DWORD [-1020939+EBP]
	MOV	EDX,DWORD [-1020976+EBP]
	CMP	EDX,EAX
	JE	L66
	LEA	EAX,DWORD [-1+EDX]
	MOV	DWORD [-1020976+EBP],EAX
	CMP	BYTE [-1+EAX],10
	JE	L104
L74:
	MOV	EAX,DWORD [-1020976+EBP]
	DEC	EAX
	MOV	DWORD [-1020976+EBP],EAX
	CMP	BYTE [-1+EAX],10
	JNE	L74
L104:
	INC	ESI
	CMP	ESI,DWORD [-1020996+EBP]
	JL	L75
L66:
	PUSH	0
	CALL	_api_getkey
	POP	ECX
	CMP	EAX,56
	JE	L62
	JMP	L61
L57:
	MOV	ECX,DWORD [-1020992+EBP]
	PUSH	0
	ADD	DWORD [-1021008+EBP],ECX
	CALL	_api_getkey
	CMP	EAX,54
	POP	EBX
	JE	L57
	JMP	L56
L51:
	MOV	EAX,DWORD [-1020992+EBP]
	SUB	DWORD [-1021008+EBP],EAX
	JS	L115
L54:
	PUSH	0
	CALL	_api_getkey
	POP	ESI
	CMP	EAX,52
	JE	L51
	JMP	L50
L115:
	MOV	DWORD [-1021008+EBP],0
	JMP	L54
L114:
	CMP	DWORD [-1020988+EBP],255
	JG	L49
	SAL	DWORD [-1020988+EBP],1
	JMP	L49
L113:
	CMP	DWORD [-1020988+EBP],1
	JLE	L48
	MOV	EAX,DWORD [-1020988+EBP]
	MOV	EDX,2
	MOV	ECX,EDX
	CDQ
	IDIV	ECX
	MOV	DWORD [-1020988+EBP],EAX
	JMP	L48
L45:
	CALL	_api_end
	JMP	L44
	GLOBAL	_skipspace
_skipspace:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	EAX,DWORD [8+EBP]
	CMP	BYTE [EAX],32
	JE	L121
L123:
	POP	EBP
	RET
L121:
	INC	EAX
	CMP	BYTE [EAX],32
	JE	L121
	JMP	L123
	GLOBAL	_textview
_textview:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,24
	MOV	EAX,DWORD [8+EBP]
	MOV	EDX,DWORD [12+EBP]
	MOV	DWORD [-16+EBP],EAX
	MOV	ESI,DWORD [16+EBP]
	MOV	EAX,DWORD [20+EBP]
	MOV	DWORD [-20+EBP],EDX
	MOV	DWORD [-24+EBP],EAX
	MOV	EDX,DWORD [24+EBP]
	MOV	EAX,DWORD [28+EBP]
	MOV	DWORD [-28+EBP],EDX
	MOV	DWORD [-32+EBP],EAX
	MOV	EDX,DWORD [32+EBP]
	MOV	EAX,ESI
	MOV	DWORD [-36+EBP],EDX
	SAL	EAX,4
	PUSH	7
	ADD	EAX,28
	PUSH	EAX
	MOV	EDX,DWORD [-20+EBP]
	LEA	EAX,DWORD [7+EDX*8]
	PUSH	EAX
	PUSH	29
	PUSH	8
	MOV	EAX,DWORD [-16+EBP]
	INC	EAX
	PUSH	EAX
	CALL	_api_boxfilwin
	ADD	ESP,24
	TEST	ESI,ESI
	JLE	L131
	MOV	EDI,29
	MOV	EBX,ESI
L129:
	PUSH	DWORD [-36+EBP]
	PUSH	DWORD [-32+EBP]
	PUSH	DWORD [-28+EBP]
	PUSH	DWORD [-24+EBP]
	PUSH	EDI
	ADD	EDI,16
	PUSH	DWORD [-20+EBP]
	PUSH	DWORD [-16+EBP]
	CALL	_lineview
	ADD	ESP,28
	DEC	EBX
	MOV	DWORD [-28+EBP],EAX
	JNE	L129
L131:
	SAL	ESI,4
	MOV	EDX,DWORD [-20+EBP]
	MOV	DWORD [16+EBP],29
	LEA	EAX,DWORD [29+ESI]
	MOV	DWORD [24+EBP],EAX
	LEA	EAX,DWORD [8+EDX*8]
	MOV	DWORD [20+EBP],EAX
	MOV	EAX,DWORD [-16+EBP]
	MOV	DWORD [12+EBP],8
	MOV	DWORD [8+EBP],EAX
	LEA	ESP,DWORD [-12+EBP]
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	JMP	_api_refreshwin
	GLOBAL	_lineview
_lineview:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	SUB	ESP,144
	MOV	EDI,DWORD [20+EBP]
	MOV	ESI,DWORD [12+EBP]
	MOV	EDX,EDI
	MOV	EBX,DWORD [24+EBP]
	NEG	EDX
L133:
	MOV	AL,BYTE [EBX]
	TEST	AL,AL
	JE	L134
	CMP	AL,10
	JE	L163
	CMP	DWORD [32+EBP],0
	JNE	L138
	CMP	AL,9
	JE	L164
	TEST	EDX,EDX
	JS	L141
	CMP	EDX,ESI
	JGE	L141
	MOV	BYTE [-156+EBP+EDX*1],AL
L141:
	INC	EDX
L140:
	INC	EBX
L138:
	CMP	DWORD [32+EBP],1
	JE	L165
L142:
	CMP	DWORD [32+EBP],2
	JNE	L133
	MOV	CL,BYTE [EBX]
	CMP	CL,9
	JE	L166
	LEA	EAX,DWORD [95+ECX]
	CMP	AL,93
	JBE	L167
	TEST	EDX,EDX
	JS	L160
	CMP	EDX,ESI
	JGE	L160
	MOV	BYTE [-156+EBP+EDX*1],CL
L160:
	INC	EDX
	INC	EBX
	JMP	L133
L167:
	CMP	EDX,-1
	JE	L168
L156:
	TEST	EDX,EDX
	JS	L157
	LEA	EAX,DWORD [-1+ESI]
	CMP	EDX,EAX
	JGE	L157
	MOV	BYTE [-156+EBP+EDX*1],CL
	MOV	AL,BYTE [1+EBX]
	MOV	BYTE [-155+EBP+EDX*1],AL
L157:
	LEA	EAX,DWORD [-1+ESI]
	CMP	EDX,EAX
	JE	L169
L158:
	ADD	EDX,2
	ADD	EBX,2
	JMP	L133
L169:
	MOV	BYTE [-156+EBP+EDX*1],32
	JMP	L158
L168:
	MOV	BYTE [-156+EBP],32
	JMP	L156
L166:
	PUSH	DWORD [28+EBP]
	LEA	EAX,DWORD [-156+EBP]
	INC	EBX
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	PUSH	EDX
	CALL	_puttab
	ADD	ESP,20
	MOV	EDX,EAX
	JMP	L133
L165:
	MOV	CL,BYTE [EBX]
	CMP	CL,9
	JE	L170
	LEA	EAX,DWORD [127+ECX]
	CMP	AL,30
	JBE	L146
	LEA	EAX,DWORD [32+ECX]
	CMP	AL,28
	JA	L145
L146:
	CMP	EDX,-1
	JE	L171
L147:
	TEST	EDX,EDX
	JS	L148
	LEA	EAX,DWORD [-1+ESI]
	CMP	EDX,EAX
	JGE	L148
	MOV	BYTE [-156+EBP+EDX*1],CL
	MOV	AL,BYTE [1+EBX]
	MOV	BYTE [-155+EBP+EDX*1],AL
L148:
	LEA	EAX,DWORD [-1+ESI]
	CMP	EDX,EAX
	JE	L172
L149:
	ADD	EDX,2
	ADD	EBX,2
	JMP	L142
L172:
	MOV	BYTE [-156+EBP+EDX*1],32
	JMP	L149
L171:
	MOV	BYTE [-156+EBP],32
	JMP	L147
L145:
	TEST	EDX,EDX
	JS	L151
	CMP	EDX,ESI
	JGE	L151
	MOV	BYTE [-156+EBP+EDX*1],CL
L151:
	INC	EDX
	INC	EBX
	JMP	L142
L170:
	PUSH	DWORD [28+EBP]
	LEA	EAX,DWORD [-156+EBP]
	INC	EBX
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	PUSH	EDX
	CALL	_puttab
	ADD	ESP,20
	MOV	EDX,EAX
	JMP	L142
L164:
	PUSH	DWORD [28+EBP]
	LEA	EAX,DWORD [-156+EBP]
	PUSH	EAX
	PUSH	EDI
	PUSH	ESI
	PUSH	EDX
	CALL	_puttab
	ADD	ESP,20
	MOV	EDX,EAX
	JMP	L140
L163:
	INC	EBX
L134:
	CMP	EDX,ESI
	JLE	L161
	MOV	EDX,ESI
L161:
	TEST	EDX,EDX
	JLE	L162
	LEA	EAX,DWORD [-156+EBP]
	PUSH	EAX
	MOV	EAX,DWORD [8+EBP]
	PUSH	EDX
	INC	EAX
	PUSH	0
	PUSH	DWORD [16+EBP]
	PUSH	8
	PUSH	EAX
	MOV	BYTE [-156+EBP+EDX*1],0
	CALL	_api_putstrwin
	ADD	ESP,24
L162:
	LEA	ESP,DWORD [-12+EBP]
	MOV	EAX,EBX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
	GLOBAL	_puttab
_puttab:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	MOV	ECX,DWORD [8+EBP]
	MOV	EDI,DWORD [16+EBP]
	MOV	ESI,DWORD [20+EBP]
	MOV	EBX,DWORD [24+EBP]
L174:
	TEST	ECX,ECX
	JS	L177
	CMP	ECX,DWORD [12+EBP]
	JGE	L177
	MOV	BYTE [ECX+ESI*1],32
L177:
	INC	ECX
	LEA	EAX,DWORD [EDI+ECX*1]
	CDQ
	IDIV	EBX
	TEST	EDX,EDX
	JNE	L174
	POP	EBX
	MOV	EAX,ECX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
