; for 72H
mov A, 70H;
mov C, Acc.0;
mov B.0, C;
mov C, Acc.1;
mov B.1, C;
mov C, Acc.2;
mov B.2, C;
mov C, Acc.3;
mov B.3, C;

;### making of B4
mov C, B.2;
mov Acc.0, C;
xrl A, 70H;

mov C, Acc.0;
mov Acc.3, C;
xrl A, 70H;

mov C, Acc.3;
mov B.4, C;


;## making of B5
mov C, B.1;
mov Acc.0, C;
xrl A, 70H;

mov C, Acc.0;
mov Acc.3, C;
xrl A, 70H;
mov C, acc.3;
mov B.5, C;


;### making of B6
mov C, B.2;
mov Acc.1, C;
xrl A, 70H;

mov C, Acc.1;
mov Acc.3, C;
xrl A, 70H;
mov C, acc.3;
mov B.6, C;


anl 72H, #80H;
clr B.7;
mov A, B;
orl 72H, A;








;## for 73H

mov A, 70H;
mov C, acc.4;
mov B.0, C;
mov C, acc.5;
mov B.1, C;
mov C, acc.6;
mov B.2, C;
mov C, acc.7;
mov B.3, C;

;### making of B4
mov C, B.2;
mov Acc.4, C;
xrl A, 70H;

mov C, Acc.4;
mov Acc.7, C;
xrl A, 70H;

mov C, Acc.7;
mov B.4, C;


;## making of B5
mov C, B.1;
mov Acc.4, C;
xrl A, 70H;

mov C, Acc.4;
mov Acc.7, C;
xrl A, 70H;

mov C, Acc.7;
mov B.5, C;


;### making of B6

mov C, B.2;
mov Acc.5, C;
xrl A, 70H;


mov C, Acc.5;
mov Acc.7, C;
xrl A, 70H;

mov C, Acc.7;
mov B.6, C;


anl 73H, #80H;
clr B.7;
mov A, B;
orl 73H, A;




;## for 74H

mov A, 71H;
mov C, Acc.0;
mov B.0, C;
mov C, Acc.1;
mov B.1, C;
mov C, Acc.2;
mov B.2, C;
mov C, Acc.3;
mov B.3, C;

;### making of B4
mov C, B.2; 
mov Acc.0, C;
xrl A, 71H;

mov C, Acc.0;
mov Acc.3, C;
xrl A, 71H;

mov C, Acc.3;
mov B.4, C;


;## making of B5
mov C, B.1;
mov Acc.0, C;
xrl A, 71H;

mov C, Acc.0;
mov Acc.3, C;
xrl A, 71H;

mov C, Acc.3;
mov B.5, C;


;### making of B6

mov C, B.2;
mov Acc.1, C;
xrl A, 71H;

mov C, Acc.1;
mov Acc.3, C;
xrl A, 71H;

mov C, Acc.3;
mov B.6, C;


anl 74H, #80H;
clr B.7;
mov A, B;
orl 74H, A;



;## for 75H





mov A, 71H;
mov C, Acc.4
mov B.0, C;
mov C, Acc.5;
mov B.1, C;
mov C, Acc.6;
mov B.2, C;
mov C, Acc.7;
mov B.3, C;

;### making of B4
mov C, B.2
mov Acc.4, C;
xrl A, 71H;

mov C, Acc.4;
mov Acc.7, C;
xrl A, 71H;

mov C, Acc.7;
mov B.4, C;


;## making of B5
mov C, B.1;
mov Acc.4, C;
xrl A, 71H;

mov C, Acc.4;
mov Acc.7, C;
xrl A, 71H;

mov C, Acc.7;
mov B.5, C;


;### making of B6

mov C, B.2;
mov Acc.5, C;
xrl A, 71H;

mov C, Acc.5;
mov Acc.7, C;
xrl A, 71H;

mov C, Acc.7;
mov B.6, C;


anl 75H, #80H;
clr B.7;
mov A, B;
orl 75H, A;

stop: sjmp stop;
	
end