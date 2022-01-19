org 0000H
ljmp start

org 100H
	start: MOV 50H,#0AH
	MOV 51H,#60H
	MOV 52H,#70H
	MOV A, #05H				; Adding numbers to the desired location. Starting number. 
	MOV R1,#60H				; Starting memory address
	MOV R6,50H				; Number of terms
	Loop1: MOV @R1, A
	INC A
	INC R1
	DJNZ R6, Loop1
	
	ACALL MEMCPY
	
	here:SJMP here

org 150H
	MEMCPY: MOV R2,50H		; Memory copying subroutine					
	MOV A, 51H
	ADD A, 50H
	DEC A
	MOV R0, A				; R0 = M1+N-1
	MOV A,52H
	ADD A,50H
	DEC A
	MOV R1, A				; R1 = M2+N-1
	LOOP: MOV A,@R0			; Copy elements
	MOV @R1, A
	DEC R0
	DEC R1
	DJNZ R2, LOOP
	RET
end