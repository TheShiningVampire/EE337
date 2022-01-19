org 00H
ljmp START

org 100H
	START: MOV A,P1
	ANL A,#0FH
	MOV R0,A
	MOV R1,A
	
	CLR P1.4
	CLR P1.5
	CLR P1.6
	CLR P1.7
	
	MOV A, #00H
	
	TOGGLE:
	MOV B, R1
	MOV R0,B
	JB ACC.0, L1
	CLR P1.4
	SJMP L11
	L1: SETB P1.4
	L11: JB ACC.1, L2
	CLR P1.5
	SJMP L22
	L2: SETB P1.5
	L22: JB ACC.2, L3
	CLR P1.6
	SJMP L33
	L3: SETB P1.6
	L33: JB ACC.3, L4
	CLR P1.7
	SJMP L44
	L4: SETB P1.7
	L44: ACALL DELAY
	DJNZ R0, L44
	ADD A, #01H
	LJMP TOGGLE
		
	
org 200H
	one_milli_delay : // Subroutine for a delay of 1 milli second
	PUSH 07h
	MOV R7, #250d
	LOOP_1_MILLI : 
		NOP ; NOPs to cause delay
		NOP 
		NOP
		NOP
		NOP
		NOP
		DJNZ R7, LOOP_1_MILLI 
	POP 07h 
	RET
	
	DELAY : // Subroutine for 250ms delay
	PUSH 07h
	MOV R7, #250d
	loop_1 : 
		LCALL one_milli_delay;
		DJNZ R7, loop_1;
	POP 07h
	RET
END