org 0h
ljmp main;
org 100h
main:
	MOV 70h,#01Bh;
	MOV 71h,#02Dh;
	mov 20h,70h;
	mov 21h,#0h;
	
	mov c,20h.4;
	mov 21h.0,c;
	
	mov c,20h.5;
	mov 21h.1,c;
	
	mov c,20h.6;
	mov 21h.2,c;
	
	mov c,20h.7;
	mov 21h.3,c;
	
	clr 20h.4;
	clr 20h.5;
	clr 20h.6;
	clr 20h.7;
	
	mov 22h,#0h;
	mov c,20h.0;
	mov 22h.0,c;
	
	mov 23h,#0h;
	mov c,20h.1;
	mov 23h.0,c;
		
	mov 24h,#0h;
	mov c,20h.2;
	mov 24h.0,c;
	
	mov 25h,#0h;
	mov c,20h.3;
	mov 25h.0,c;
	
	mov 26h,#0h;
	mov c,21h.0;
	mov 26h.0,c;
	
	mov 27h,#0h;
	mov c,21h.1;
	mov 27h.0,c;
	
	mov 28h,#0h;
	mov c,21h.2;
	mov 28h.0,c;
	
	mov 29h,#0h;
	mov c,21h.3;
	mov 29h.0,c;
	
	mov A,22h;
	xrl A,24h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.4,c;
	
	
	mov A,22h;
	xrl A,23h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.5,c;
	
	mov A,24h;
	xrl A,23h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.6,c;
	
	mov 72h,20h;
	
	
	mov A,26h;
	xrl A,28h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.4,c;
	
	
	mov A,26h;
	xrl A,27h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.5,c;
	
	mov A,28h;
	xrl A,27h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.6,c;
	
	mov 73h,21h;
	////
	
	mov 20h,71h;
	mov 21h,#0h;
	
	mov c,20h.4;
	mov 21h.0,c;
	
	mov c,20h.5;
	mov 21h.1,c;
	
	mov c,20h.6;
	mov 21h.2,c;
	
	mov c,20h.7;
	mov 21h.3,c;
	
	clr 20h.4;
	clr 20h.5;
	clr 20h.6;
	clr 20h.7;
	
	mov 22h,#0h;
	mov c,20h.0;
	mov 22h.0,c;
	
	mov 23h,#0h;
	mov c,20h.1;
	mov 23h.0,c;
		
	mov 24h,#0h;
	mov c,20h.2;
	mov 24h.0,c;
	
	mov 25h,#0h;
	mov c,20h.3;
	mov 25h.0,c;
	
	mov 26h,#0h;
	mov c,21h.0;
	mov 26h.0,c;
	
	mov 27h,#0h;
	mov c,21h.1;
	mov 27h.0,c;
	
	mov 28h,#0h;
	mov c,21h.2;
	mov 28h.0,c;
	
	mov 29h,#0h;
	mov c,21h.3;
	mov 29h.0,c;
	
	mov A,22h;
	xrl A,24h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.4,c;
	
	
	mov A,22h;
	xrl A,23h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.5,c;
	
	mov A,24h;
	xrl A,23h;
	xrl A,25h;
	mov c,acc.0;
	mov 20h.6,c;
	
	mov 74h,20h;
	
	
	mov A,26h;
	xrl A,28h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.4,c;
	
	
	mov A,26h;
	xrl A,27h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.5,c;
	
	mov A,28h;
	xrl A,27h;
	xrl A,29h;
	mov c,acc.0;
	mov 21h.6,c;
	
	mov 75h,21h;
	
	
	
	sjmp en
	en: sjmp en
end