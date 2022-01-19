; This subroutine writes characters on the LCD
LCD_data equ P2    ;LCD Data port
LCD_rs   equ P0.0  ;LCD Register Select
LCD_rw   equ P0.1  ;LCD Read/Write
LCD_en   equ P0.2  ;LCD Enable

org 00H
ljmp START

org 100H
	START:
	// Take the input from 70H and 71H
	MOV 70H,#0ABH
	MOV 71H,#0CDH
	
	//Init for delay
	MOV R1,#0C3H
	MOV R0,#50H	
	ACALL COMPLEMENT_2
	
	// PAM representation
	
	MOV A, 70H
	ANL A, #0FH
	MOV R4, A
	MOV A, 70H
	ANL A, #0F0H
	RR A
	RR A
	RR A
	RR A
	MOV R5, A
	MOV A, 71H
	ANL A, #0FH
	MOV R6, A
	MOV A, 71H
	ANL A, #0F0H
	RR A
	RR A
	RR A
	RR A
	MOV R7, A	
	
	; Initial delay for LCD to power up
	MOV R2,#10D
	H1: ACALL DELAY
	DJNZ R2, H1
	
	ACALL lcd_init; Initialise LCD
	MOV R2,#10D
	H2: ACALL DELAY
	DJNZ R2, H2

PAM:
// PAM level 1

	MOV P3, R4 // Moving data to Port 3
	
	
	MOV A, #82H
	ACALL lcd_command
	ACALL DELAY
	MOV DPTR, #my_string1
	ACALL lcd_sendstring
	ACALL DELAY

	MOV A, R4
	MOV R3, A
	ACALL DISP	
	
// delay for 1 second	
	MOV R2,#40d	
H3: ACALL DELAY
	DJNZ R2, H3


	MOV A, #01H
	ACALL lcd_command
	ACALL DELAY
// PAM level 2
	MOV P3, R5 // Moving data to Port 3
	
	
	MOV A, #82H
	ACALL lcd_command
	ACALL DELAY
	MOV DPTR, #my_string2
	ACALL lcd_sendstring
	ACALL DELAY
	
	MOV A, R5
	MOV R3, A
	
	ACALL DISP	
	
// delay for 1 second	
	MOV R2,#40d	
H4: ACALL DELAY
	DJNZ R2, H4


	MOV A, #01H
	ACALL lcd_command
	ACALL DELAY

// PAM level 3
	MOV P3, R6 // Moving data to Port 3
	
	
	MOV A, #82H
	ACALL lcd_command
	ACALL DELAY
	MOV DPTR, #my_string3
	ACALL lcd_sendstring
	ACALL DELAY
	
	MOV A, R6
	MOV R3, A
	
	ACALL DISP	
	
// delay for 1 second	
	MOV R2,#40d	
H5: ACALL DELAY
	DJNZ R2, H5


	MOV A, #01H
	ACALL lcd_command
	ACALL DELAY

// PAM level 4
	MOV P3, R7 // Moving data to Port 3
	
	
	MOV A, #82H
	ACALL lcd_command
	ACALL DELAY
	MOV DPTR, #my_string4
	ACALL lcd_sendstring
	ACALL DELAY
	
	MOV A, R7
	MOV R3, A
	
	ACALL DISP	
	
// delay for 1 second	
	MOV R2,#40d	
H6: ACALL DELAY
	DJNZ R2, H6

	
	MOV A, #01H
	ACALL lcd_command
	ACALL DELAY

	LJMP PAM
	

;------------------------2's complement subrouitne------------------------------------------------------
org 200H
	COMPLEMENT_2:
	MOV A, R1
	CPL A
	MOV R1, A	
	MOV A, R0
	CPL A
	ADD A, #01H
	MOV R0, A
	MOV A, R1
	ADDC A,#00H
	MOV R1, A
	// 2's complement is stored in R0 and R1
	RET

org 300H
;------------------------Delay subrouitne -------------------------------------------------------------
	DELAY:
	MOV TMOD, #01b
	MOV TL0, R0
	MOV TH0, R1
	SETB TR0
Loop:JNB TF0, Loop
	CLR TR0
	CLR TF0
	RET	
	k: sjmp k


org 400H
;------------------------Display subrouitne -----------------------------------------------------------
DISP:
	MOV A,#0C4H
	ACALL lcd_command
	ACALL DELAY
		
	// fourth bit
	MOV A, R3
	RR A
	RR A
	RR A
	ANL A,#01H
	ADD A, #30H
	ACALL lcd_senddata
	ACALL DELAY
	

	//third bit 
	MOV A, R3
	RR A
	RR A
	ANL A,#01H
	ADD A, #30H
	ACALL lcd_senddata
	ACALL DELAY
	
	
	// second bit
	MOV A, R3
	RR A
	ANL A,#01H
	ADD A, #30H
	ACALL lcd_senddata
	ACALL DELAY
	
	// first bit
	MOV A, R3
	ANL A, #01H
	ADD A, #30H
	ACALL lcd_senddata
	ACALL DELAY
	
	RET
	
	
	
org 500H
;------------------------LCD Initialisation routine----------------------------------------------------
lcd_init:
         mov   LCD_data,#38H  ;Function set: 2 Line, 8-bit, 5x7 dots
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
	     acall delay

         mov   LCD_data,#0CH  ;Display on, Curson off
         clr   LCD_rs         ;Selected instruction register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay
         mov   LCD_data,#01H  ;Clear LCD
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         
		 acall delay

         mov   LCD_data,#06H  ;Entry mode, auto increment with no shift
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en

		 acall delay
         
         ret                  ;Return from routine


;-----------------------command sending routine-------------------------------------
 lcd_command:
         mov   LCD_data,A     ;Move the command to LCD port
         clr   LCD_rs         ;Selected command register
         clr   LCD_rw         ;We are writing in instruction register
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
		 acall delay
    
         ret  
;-----------------------data sending routine-------------------------------------		     
 lcd_senddata:
         mov   LCD_data,A     ;Move the command to LCD port
         setb  LCD_rs         ;Selected data register
         clr   LCD_rw         ;We are writing
         setb  LCD_en         ;Enable H->L
		 acall delay
         clr   LCD_en
         acall delay
		 acall delay
         ret                  ;Return from busy routine

;-----------------------text strings sending routine-------------------------------------
lcd_sendstring:
	push 0e0h
	lcd_sendstring_loop:
	 	 clr   a                 ;clear Accumulator for any previous data
	         movc  a,@a+dptr         ;load the first character in accumulator
	         jz    exit              ;go to exit if zero
	         acall lcd_senddata      ;send first char
	         inc   dptr              ;increment data pointer
	         sjmp  LCD_sendstring_loop    ;jump back to send the next character
exit:    pop 0e0h
         ret                     ;End of routine

;------------- ROM text strings---------------------------------------------------------------
my_string1:
         DB   "  Level 1 ", 00H
my_string2:
         DB   "  Level 2 ", 00H
my_string3:
         DB   "  Level 3 ", 00H
my_string4:
         DB   "  Level 4 ", 00H		
END