#include <at89c5131.h>
#include <stdio.h>

//Bit definitions
sbit RS=P0^0;
sbit RW=0x81;	//Also can use P0^1 or 0x80^1
sbit EN=P0^2;

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
	while(*s!='\0')		//Can use while(*s)
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
	unsigned char mystring[] = "Vinit is pro";
	lcd_init();
	lcd_cmd(0x80);
	lcd_write_string(mystring);
	while(1)
	{
	}	
}
