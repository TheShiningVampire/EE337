#include <at89c5131.h>
#include <stdio.h>
#include "lcd.h"		//Header file with LCD interfacing functions
#include "serial.c"	//C file with UART interfacing functions

unsigned int s1;
unsigned int s2;
unsigned int g1;
unsigned int g2;
unsigned int p1;
unsigned int p2;

//Functions used in this program
void initialise_score(void);
void game_update(void);
bit score_update(void);
void set_update(void);
void setbreaker(void);

void initialise_score()
{
	p1 = 0;
	p2 = 0;
	g1 = 0;
	g2 = 0;
	s1 = 0;
	s2 = 0;
}

void game_update()
{
	unsigned char game1[1] , game2[1];

	sprintf(game1 , "%d" , g1);
	sprintf(game2 , "%d" , g2);
	
	
	if(s1+s2 == 0)
	{
		lcd_cmd(0x85);		
		lcd_write_string(game1);
		lcd_cmd(0x86);
		lcd_write_string("-");
		lcd_cmd(0x87);
		lcd_write_string(game2);		
	}
	if(s1+s2 == 1)
	{
		lcd_cmd(0x89);		
		lcd_write_string(game1);
		lcd_cmd(0x8A);
		lcd_write_string("-");
		lcd_cmd(0x8B);
		lcd_write_string(game2);		
	}
	if(s1+s2 == 2)
	{
		lcd_cmd(0x8D);		
		lcd_write_string(game1);
		lcd_cmd(0x8E);
		lcd_write_string("-");
		lcd_cmd(0x8F);
		lcd_write_string(game2);		
	}	
}

bit score_update()
{		
		bit game_done = 0;
		unsigned char scores_map[5][2] = {"00" , "15" , "30" , "40" , "Ad"};
		unsigned char score[5];
		lcd_cmd(0xC7);
		if(p1>=4 || p2>=4)
		{	
			if(p1 == 4 && p2<=2)
			{
				g1++;
				lcd_write_string("00-00");
				game_update();
				game_done = 1;
			}
			
			if(p2 == 4 && p1<=2)
			{
				g2++;
				lcd_write_string("00-00");
				game_update();
				game_done = 1;
			}
			
			else
			{
				if(p1>p2)
				{
					if( p1 - p2 == 0)
					{
						lcd_write_string("40-40");
					}
					if( p1 - p2 == 1)
					{
						lcd_write_string("Ad-40");
					}
					if( p1 - p2 == 2)
					{
						g1++;
						lcd_write_string("00-00");
						game_update();
						game_done = 1;						
					}
				}
				else if(p2>p1)
				{
					if( p2 - p1 == 1)
					{
						lcd_write_string("40-Ad");
					}
					if( p2 - p1 == 2)
					{
						g2++;
						lcd_write_string("00-00");
						game_update();
						game_done = 1;						
					}
				}
				else
				{
					lcd_write_string("40-40");
				}
				
			}
			
			
		}
		else
		{
			sprintf(score , "%s-%s",scores_map[p1] , scores_map[p2]);
			lcd_write_string(score);
		}	
	
	return game_done;
}

void set_update()
{
			if(g1 >=6 || g2>=6)
				{
					if(g1>=6 && g2<=4)
					{
						g1 = 0;
						g2 = 0;
						s1++;
					}
					
					else if(g2>=6 && g1<=4)
					{
						g1 = 0;
						g2 = 0;
						s2++;
					}

					if(s1 == 2)
					{
						lcd_cmd(0x01);
						lcd_cmd(0x81);
						lcd_write_string("Player 1 Wins");
					}
				
					else if(s2 == 2)
					{
						lcd_cmd(0x01);
						lcd_cmd(0x81);
						lcd_write_string("Player 2 Wins");
					}
					
					else
					{
						game_update();
					}
										
					if(g1 == 6 && g2 == 6)
					{
						setbreaker();
					}				
				}	
}

void setbreaker()
{
	bit done = 0;		
	unsigned char ch=0;
	unsigned char points[5];
	while(!done)
	{
		//Receive a character
			ch = receive_char();
		
    //Displays the string on the terminal software
			switch(ch)
			{
				case '1': p1++;
		 				break;
				
				case '2': p2++;
						 break;
							
				default:transmit_string("Incorrect. Pass correct number\r\n");
						 break;
				
			}
			
			sprintf(points,"%02d-%02d",p1,p2);
			//sprintf(point2,"%02d",p2);
			
			lcd_cmd(0xC7);
			lcd_write_string(points);
			/*lcd_cmd(0xC9);
			lcd_write_string("-");
			lcd_cmd(0xCA);
			lcd_write_string(point2);
			*/
			if(p1>=7 || p2>=7)
			{
				if(p1> p2)
				{
					if(p1 - p2 >=2)
					{
						done = 1;
						g1++;
						game_update();
						g1 = 0;
						g2 = 0;
						s1++;
						game_update();
					}
				}
				else
				{
					if(p2 - p1 >=2)
					{
						done = 1;
						g2++;
						game_update();
						g1 = 0;
						g2 = 0;
						s2++;
						game_update();
					}
				}	
			}
	}
	
	p1 = 0;
	p2 = 0;
	
	score_update();
	game_update();
	set_update();
}

//Main function
void main(void)
{
	unsigned char ch=0;
	bit game;
	
	//Call initialization functions
	lcd_init();
	uart_init();

	//These strings will be printed in terminal software
	transmit_string("************************\r\n");
	transmit_string("******TENNIS MATCH******\r\n");
	transmit_string("************************\r\n");
	transmit_string("Press 1 if Player 1 wins the point\r\n");
	transmit_string("Press 2 if Player 2 wins the point\r\n");

	
	while(1)
	{
		
		initialise_score();
		lcd_cmd(0x01);
		lcd_cmd(0x82);
		lcd_write_string("TENNIS MATCH");
		
		msdelay(500);
		lcd_cmd(0x01);
		lcd_cmd(0x80);
		lcd_write_string("GAME");
		lcd_cmd(0xC0);
		lcd_write_string("SCORE");
		
		score_update();
		game_update();
		
		while(s1<2 && s2<2)
		{		
				//Receive a character
				ch = receive_char();
				//Decide which test function to run based on character sent
				//Displays the string on the terminal software
				switch(ch)
				{
					case '1': p1++;	
							break;
					
					case '2': p2++;
							break;
								
					default:transmit_string("Incorrect test. Pass correct number\r\n");
							break;
					
				}
					
				game	= score_update();
				if(game == 1)
				{
					p1 = 0;
					p2 = 0;				
					set_update();
				}
		}
		msdelay(5000);		
	}
}
