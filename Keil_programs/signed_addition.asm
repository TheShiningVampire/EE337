org 0000H
ljmp start

org 100H
	start: MOV 60H, #7FH
	MOV 61H, #7FH
	MOV A, 60H
	ADD A, 61H
	MOV 62H,A
	CLR PSW.5
	JB OV,here
	SETB PSW.5
	here:SJMP here
end