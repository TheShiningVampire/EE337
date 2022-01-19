#include <at89c5131.h>
#include <stdio.h>

//Bit definitions
sbit RS=P0^0;
sbit RW= P0^1;
sbit EN=P0^2;

sbit SW1 = P1^0;
sbit LED = P1^4;

void msdelay(unsigned int time)
{
	int i,j;	
	for(i = 0 ; i < time ; i++)
	{
		for(j = 0; j<318 ; j++)
		{}
	}	
}

void lcd_cmd(unsigned int i)
{
	RS=0;
	RW=0;
	EN=1;
	P2=i;
	msdelay(10);
	EN=0;
}
void lcd_char(unsigned char ch)
{
	RS=1;
	RW=0;
	EN=1;
	P2=ch;
	msdelay(10);
	EN=0;
}
void lcd_write_string(unsigned char *s)
{
	while(*s!='\0')		
	{
		lcd_char(*s++);
	}
}
void lcd_init(void) using 3
{
	lcd_cmd(0x38);
	msdelay(4);
	lcd_cmd(0x06);
	msdelay(4);
	lcd_cmd(0x0C);
	msdelay(4);
	lcd_cmd(0x01);
	msdelay(4);
}

void main()
{
	unsigned char mystr1[] = "Toggle SW1";
	unsigned char mystr2[] = "when LED glows";
	unsigned char mystr3[] = "Reaction Time";
	unsigned char mystr4[7];
	unsigned int count = 0;
	
	TMOD = 0x01; // In case someone clicks the switch before the led turns on
	TL0 = 0x00;
	TH0 = 0x00;
	
	P1 = 00;
	while(1)
	{
		SW1 = 1; //Make the pin as the input 
		while(SW1 != 0)
		{
		}			
		lcd_init();
		lcd_cmd(0x83);
		lcd_write_string(mystr1);
		lcd_cmd(0xC1);
		lcd_write_string(mystr2);
		msdelay(2000);
		LED = 1;	
		TMOD = 0x01;							// Timer 0, Mode 1
		TL0 = 0x00;
		TH0 = 0x00;
		TR0 = 1;
		while(SW1 != 1)
		{
			if (TF0 == 1)
			{
				count++;
				TF0 = 0;
			}
			
		}
		TR0 = 0;
		LED = 0;
		lcd_init();
		lcd_cmd(0x81);
		lcd_write_string(mystr3);
		lcd_cmd(0xC3);
		sprintf(mystr4, "%02X %02X%02X",count, (unsigned int)(TL0 & 0xFF),(unsigned int)(TH0 & 0xFF));
		lcd_write_string(mystr4);
		msdelay(5000);
		count = 0;
		lcd_init();
		
		
		// In case someone clicks the switch before the led turns on
		TL0 = 0x00;
		TH0 = 0x00;
		TF0 = 0;
	}	
}
