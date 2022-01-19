#include <at89c5131.h>
#include <stdio.h>

sbit sound = P0^0;

void main()
{
	unsigned int i, j;
	unsigned int counter = 80;
	sound = 0;
	
	while(1)
	{
			counter = 80;
			TMOD = 0x11;            // Timer 1 in mode 1
			TL1 = 0xB0;
			TH1 = 0x3C;
			TR1 = 1;
			while(1)
			{
				TL0 = 0x0B9;
				TH0 = 0x0EF;
				TR0 = 1;
				while(TF0 == 0)
				{
				}
				TR0 = 0;
				TF0 = 0;
				sound = ~sound;
				
				if(TF1 == 1)
				{
					TF1 = 0;
					counter--;
					TL1 = 0xB0;
					TH1 = 0x3C;
					if (counter==0)
					{
						TR1 = 0;
						break;
					}
					
				}
			}
		
			counter = 80;
			TMOD = 0x11;            // Timer 0 and 1 in mode 1
			TL1 = 0xB0;
			TH1 = 0x3C;
			TR1 = 1;
			while(1)
			{
				TL0 = 0x088;
				TH0 = 0x0F1;
				TR0 = 1;
				while(TF0 == 0)
				{
				}
				TR0 = 0;
				TF0 = 0;
				sound = ~sound;
				
				if(TF1 == 1)
				{
					TF1 = 0;
					counter--;
					TL1 = 0xB0;
					TH1 = 0x3C;
					if (counter==0)
					{
						TR1 = 0;
						break;
					}			
				}
			}
		}
}