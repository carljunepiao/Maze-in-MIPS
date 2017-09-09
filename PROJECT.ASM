TITLE		LOADING (COM)
			.MODEL 	SMALL
			.STACK	64
			.CODE
			ORG		100H
;-------------------------------------------
STRING 		DB 		'A$'
SPACE 		DB 		' $'
ROW 		DB 		16H
COLUMN		DB 		1H
BAR			DB	219,219,'$'
;-------------------------------------------		
A10MAIN		PROC	FAR
			MOV     AX, @code
			MOV     DS, AX
			CALL 	SET_SCREEN_BLACK
			CALL 	SET_SCREEN_BLUE
			;CALL 	SET_CURSOR_MIDDLE_MIDDLE

			CALL 	FILL_MAZE

			;CALL 	PRINT_STRING
			CALL 	GET_KEYSTROKE
			JMP 	EXIT
A10MAIN		ENDP
;-------------------------------------------
SET_SCREEN_BLACK	PROC 	NEAR
			MOV 	AX, 0600H
			MOV 	BH, 00H
			MOV 	CX, 0000H
			MOV 	DX, 184FH
			INT 	10H
			RET
SET_SCREEN_BLACK	ENDP
;-------------------------------------------
SET_SCREEN_BLUE	PROC 	NEAR
			MOV BH,17H
			MOV CX,0101H
			MOV DX,174EH
			INT 10H
			RET
SET_SCREEN_BLUE	ENDP
;-------------------------------------------
SET_CURSOR_MIDDLE_MIDDLE	PROC	NEAR
			MOV 	AH, 02H
			MOV 	BH, 00
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H
			RET
SET_CURSOR_MIDDLE_MIDDLE 	ENDP
;-------------------------------------------
PRINT_STRING	PROC 	NEAR
			MOV 	AH, 09H
			LEA 	DX, STRING
			INT 	21H
			RET
PRINT_STRING 	ENDP
;-------------------------------------------
GET_KEYSTROKE 	PROC	NEAR
			MOV 	AH, 0
			INT 	16H
			CMP 	AH, 48H
			JE 		GOUP
			CMP 	AH, 50H
			JE 		GODOWN
			CMP 	AH, 4DH
			JE 		GORIGHT
			CMP 	AH, 4BH
			JE 		GOLEFT
			JMP 	EXIT
GET_KEYSTROKE	ENDP
;-------------------------------------------
GOUP:		CALL 	DELETE_PREV
			MOV 	AH, 02H
			MOV 	BH, 00
			DEC 	ROW
			CALL 	CHECK
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H
			CALL 	PRINT_STRING
			CALL 	GET_KEYSTROKE
GODOWN:		CALL 	DELETE_PREV
			MOV 	AH, 02H
			MOV 	BH, 00
			INC 	ROW
			CALL 	CHECK
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H
			CALL 	PRINT_STRING
			CALL 	GET_KEYSTROKE
GOLEFT:		CALL	DELETE_PREV
			MOV 	AH, 02H
			MOV 	BH, 00
			DEC		COLUMN
			CALL 	CHECK
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H
			CALL 	PRINT_STRING
			CALL 	GET_KEYSTROKE
GORIGHT:	CALL 	DELETE_PREV
			MOV 	AH, 02H
			MOV 	BH, 00
			INC 	COLUMN
			CALL 	CHECK
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H
			CALL 	PRINT_STRING
			CALL 	GET_KEYSTROKE
;-------------------------------------------
CHECK:		CMP 	ROW, 00H
			JE 		FIXUP
			CMP 	ROW, 18H
			JE 		FIXDOWN
			CMP 	COLUMN, 00H
			JE	 	FIXLEFT
			CMP 	COLUMN, 4FH
			JE	 	FIXRIGHT
			RET
FIXUP:		INC 	ROW
			RET
FIXDOWN:	DEC 	ROW
			RET
FIXRIGHT: 	DEC 	COLUMN
			RET
FIXLEFT:	INC 	COLUMN
			RET
;-------------------------------------------
DELETE_PREV	PROC	NEAR
			MOV 	AH, 02H
			MOV 	BH, 00
			MOV 	DH, ROW
			MOV 	DL, COLUMN
			INT 	10H

			MOV 	AH, 09H
			LEA 	DX, SPACE
			INT 	21H
			RET
DELETE_PREV	ENDP
;-------------------------------------------
FILL_MAZE	PROC NEAR

	;014D - ROW COLUMN

	;row 1 column 1 - FILLED W/ 70 CHARACTERS
	MOV DX, 0101H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,46H
	CALL PRINT_BAR
	
	;row 1 column 73 - FILLED W/ 6 CHARACTERS
	MOV DX, 0149H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,6H
	CALL PRINT_BAR


	;------------------------ROW 2-----------------------------
	;row 2 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0201H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0206H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR


	;row 2 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 021CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0226H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0235H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 64 - FILLED W/ 2 CHARACTERS
	MOV DX, 023FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 69 - FILLED W/ 2 CHARACTERS
	MOV DX, 0245H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 2 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 024DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 3-----------------------------
	;row 3 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0301H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,3H
	CALL PRINT_BAR

	;row 3 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0306H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,6H
	CALL PRINT_BAR

	;row 3 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0310H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,0AH
	CALL PRINT_BAR

	;row 3 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0323H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,9H
	CALL PRINT_BAR

	;row 3 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0335H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,7H
	CALL PRINT_BAR

	;row 3 column 69 - FILLED W/ 2 CHARACTERS
	MOV DX, 0345H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 3 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 034DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 4-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0401H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 040EH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,04H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 041CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 042FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 64 - FILLED W/ 2 CHARACTERS
	MOV DX, 043FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 69 - FILLED W/ 2 CHARACTERS
	MOV DX, 0445H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 044DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 5-----------------------------
	;row 5 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0501H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,0BH
	CALL PRINT_BAR

	;row 5 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0515H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,5H
	CALL PRINT_BAR

	;row 5 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0526H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,7H
	CALL PRINT_BAR

	;row 5 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 052FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 5 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0535H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR


	;row 5 column 64 - FILLED W/ 2 CHARACTERS
	MOV DX, 053FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 5 column 69 - FILLED W/ 2 CHARACTERS
	MOV DX, 0545H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 054DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 6-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0601H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 060EH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,9H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 061CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,8H
	CALL PRINT_BAR

	;row 6 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 062FH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0626H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0639H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,12H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 064DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 7-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0701H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,0FH
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0719H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 071CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0726H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0735H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,6H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 074DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 8-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0801H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0812H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,5H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 081CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,17H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0826H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0839H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,12H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 084DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 9-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0901H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0907H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,8H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0926H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 092AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR


	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0935H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 094DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 10-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A12H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,5H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A19H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,5H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A20H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,08H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A35H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,16H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0A4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 11-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B2AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,09H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B35H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0B4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 12-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C12H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,8H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C20H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,08H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C35H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,16H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 13-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,6H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C39H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,14H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0C4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 14-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D2AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,09H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D39H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0D4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 15-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E12H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,8H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E05H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E20H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,08H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E35H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,16H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0E4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 16-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F01H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F09H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F0DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F1CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F26H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,11H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F35H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 0F4DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR
	
	;------------------------ROW 17-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1001H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1009H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 100DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 1012H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,8H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1005H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR


	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 101CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1020H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,08H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1026H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1039H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,14H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 104DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 18-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1101H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1109H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,0BH
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1126H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 112AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,09H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1135H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 114DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 19-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1201H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1216H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,02H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1209H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1205H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 121CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1220H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,08H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1226H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1235H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,16H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 124DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 19-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1301H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1309H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,0DH
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 131CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1316H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 132AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,09H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1335H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 134DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 20-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1401H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1405H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1416H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 141CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1422H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1426H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1435H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,16H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 144DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 21-----------------------------
	;row 4 column 1 - FILLED W/ 2 CHARACTERS
	MOV DX, 1501H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,13H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 150FH;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,5H
	CALL PRINT_BAR

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1516H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 28 - FILLED W/ 2 CHARACTERS
	MOV DX, 151CH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 152AH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,09H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1535H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 154DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;------------------------ROW 21-----------------------------

	;row 4 column 6 - FILLED W/ 2 CHARACTERS
	MOV DX, 1616H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 38 - FILLED W/ 2 CHARACTERS
	MOV DX, 1626H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1639H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1642H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR

	;row 4 column 48 - FILLED W/ 2 CHARACTERS
	MOV DX, 1649H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR


	;row 4 column 76 - FILLED W/ 2 CHARACTERS
	MOV DX, 164DH	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,2H
	CALL PRINT_BAR


	;------------------------ROW 22-----------------------------
	;row 1 column 1 - FILLED W/ 70 CHARACTERS
	MOV DX, 1701H	;coordinates where the cursor is set
	CALL SET_CURSOR
	MOV CX,4FH
	CALL PRINT_BAR
	

	RET
FILL_MAZE ENDP
;-----------------------------------------
PRINT_BAR	PROC NEAR
	MOV BX,0071H
	MOV AL,BAR
	MOV AH,0AH
	INT 10H
	RET
PRINT_BAR ENDP
;----------------------------------------
SET_CURSOR PROC NEAR
	
	MOV BH, 00
	MOV AH,02H
	INT 10H
	RET
SET_CURSOR ENDP
;--------------------------------







EXIT:		MOV		AX, 4C00H
			INT		21H		
			END 	A10MAIN
