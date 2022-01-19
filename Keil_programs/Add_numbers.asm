Org 0h
ljmp main; jump to label "main"
Org 100h
main:
	MOV 70H,#4EH    ;Loading value 20h in memory location 70h
	MOV 71H,#0F0H	;Loading value 21h in memory location 71h

	MOV A,70H	;Moving the content of memory location 70h to accumulator
	ADD A,71H	;Adding the content of memory location 70h to accumulator
	MOV 72H, A	;Moving the content of accumulator to the memory location 70h  
	MOV 73H, #00H
	JNC HERE;
	MOV 73H, #01H
HERE:SJMP HERE		
END