org 00H
ljmp readnibble

org 100H
	readnibble: 
	SETB P1.4
	SETB P1.5
	SETB P1.6
	SETB P1.7
	MOV R0,#20d
	MOV R1,#20d
	L1: ACALL DELAY
	DJNZ R0, L1
	MOV B,#0FFH
	MOV P1,B
	// Now the user has entered the input	
	MOV A, P1
	ANL A,#0FH
	MOV 4EH,A
	SWAP A
	MOV P1,A	
	L2: ACALL DELAY
	DJNZ R1, L2
	LJMP readnibble
	
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