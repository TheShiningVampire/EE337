org 0h
ljmp main;
org 100h
main:
mov 60h,#0ffh
mov 61h,#0ffh

mov a,60h
rl a
mov 67h,a
anl 67h,#01h

mov a,61h
rl a
mov 68h,a
anl 68h,#01h

mov a,67h
xrl a,68h
mov 69h,a



mov a,60h
add a,61h
mov 62h,a
rl a
anl a,#01h
mov 70h,a
mov a,69h
jz loop
setb psw.5
sjmp here
loop:
mov a,68h
xrl a,70h
jz l2
clr psw.5
sjmp here
l2:setb psw.5

here: SJMP here
end