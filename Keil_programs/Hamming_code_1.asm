Org 0h
ljmp main; jump to label "main"
Org 100h
main:
	MOV 70H,#0FFH    ;Loading value 20h in memory location 70h
	MOV 71H,#0FFH	;Loading value 21h in memory location 71h
	
	
	// First 4 bit number to be encoded
	MOV A, 70H;
	ANL A, #0FH;
	MOV 20H, A;
	
	//Calculating bit b4, first XOR
	// b0 XOR b2
	MOV C, 20H.0;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.4, C; Moving b0 XOR b2 XOR b3 in 20H.4
	
	// Calculating b5
	// b0 XOR b1
	MOV C, 20H.0;
	ANL C,/20H.1;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.1;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b1 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.5, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Calcualting b6
	// b1 XOR b2
	MOV C, 20H.1;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.1;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0

	// b1 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.6, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Moving 20H to 72H
	MOV A,20H;
	MOV 72H, A;
	
	
	// Second 
	MOV A, 70H;
	ANL A, #0F0H;
	RR A
	RR A
	RR A
	RR A
	MOV 20H, A;

		//Calculating b4. First XOR
	// b0 XOR b2
	MOV C, 20H.0;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.4, C; Moving b0 XOR b2 XOR b3 in 20H.4
	
	// Calculating b5
	// b0 XOR b1
	MOV C, 20H.0;
	ANL C,/20H.1;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.1;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b1 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.5, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Calcualting b6
	// b1 XOR b2
	MOV C, 20H.1;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.1;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0

	// b1 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.6, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
			
	// Moving 20H to 73H
	MOV A,20H;
	MOV 73H, A;
	
	
	// Third
	MOV A, 71H;
	ANL A, #00FH;
	MOV 20H, A;
	
		//Calculating b4. First XOR
	// b0 XOR b2
	MOV C, 20H.0;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.4, C; Moving b0 XOR b2 XOR b3 in 20H.4
	
	// Calculating b5
	// b0 XOR b1
	MOV C, 20H.0;
	ANL C,/20H.1;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.1;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b1 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.5, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Calcualting b6
	// b1 XOR b2
	MOV C, 20H.1;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.1;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0

	// b1 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.6, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Moving 20H to 74H
	MOV A,20H;
	MOV 74H, A;
	
	

	// Fourth
	MOV A, 71H;
	ANL A,#0F0H;
	RR A
	RR A
	RR A
	RR A
	MOV 20H, A;
	
	//Calculating b4. First XOR
	// b0 XOR b2
	MOV C, 20H.0;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.4, C; Moving b0 XOR b2 XOR b3 in 20H.4
	
	// Calculating b5
	// b0 XOR b1
	MOV C, 20H.0;
	ANL C,/20H.1;
	MOV 21H.0, C;
	MOV C, 20H.0;
	CPL C;
	ANL C,20H.1;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0
	
	// b0 XOR b1 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.5, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Calcualting b6
	// b1 XOR b2
	MOV C, 20H.1;
	ANL C, /20H.2;
	MOV 21H.0, C;
	MOV C, 20H.1;
	CPL C;
	ANL C,20H.2;
	ORL C,21H.0;
	MOV 21H.0, C; Moving b0 XOR b2 in 21H.0

	// b1 XOR b2 XOR b3 = 21H.0 XOR b3
	MOV C, 21H.0;
	ANL C, /20H.3;
	MOV 21H.1, C;
	MOV C, 21H.0;
	CPL C;
	ANL C,20H.3;
	ORL C,21H.1;
	MOV 20H.6, C; Moving b0 XOR b2 XOR b3 in 20H.5
	
	// Moving 20H to 75H
	MOV A,20H;
	MOV 75H, A;	

HERE:SJMP HERE		
END