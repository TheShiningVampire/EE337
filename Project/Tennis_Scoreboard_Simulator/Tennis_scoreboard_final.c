#include <at89c5131.h>
#include <stdio.h>
#include "lcd.h"		//Header file with LCD interfacing functions
#include "serial.c"	//C file with UART interfacing functions

unsigned int s1;									// Sets won by player 1
unsigned int s2;									// Sets won by player 2
unsigned int g1;									// Games won by player 1 in the current set
unsigned int g2;									// Games won by player 2 in the current set	
unsigned int p1;									// Score of player 1
unsigned int p2;									// Score of player 2

//Functions used in this program
void initialise_score(void); 			// intialises the score, games and set points
void game_update(void);						// updates the game points on the LCD
bit score_update(void);						// updates the score points on the LCD and returns if a game is completed
void set_update(void);						// Updates the set on the LCD
void setbreaker(void);						// In case of a tie-breaker the function is called, 
																	// which updates score according to the rules of the tie-breaker

void initialise_score()
{
	
	// All the values are intialised to 0
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
	
	
	if(s1+s2 == 0)   					// If none of the sets is completed
	{
		lcd_cmd(0x85);		
		lcd_write_string(game1);
		lcd_cmd(0x86);
		lcd_write_string("-");
		lcd_cmd(0x87);
		lcd_write_string(game2);		
	}
	if(s1+s2 == 1)						// If one set is completed
	{
		lcd_cmd(0x89);		
		lcd_write_string(game1);
		lcd_cmd(0x8A);
		lcd_write_string("-");
		lcd_cmd(0x8B);
		lcd_write_string(game2);		
	}
	if(s1+s2 == 2)						// If 2 sets are completed 
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
		bit game_done = 0;							// game_done captures whether the game is completed or not
		lcd_cmd(0xC7);
		if(p1>=4 || p2>=4) 							// if score is greater than 40, then the conditions for deuce need to be checked 
		{	
			if(p1 == 4 && p2<=2)					// If player 1 has won a point after his score being 40 and score of player 2 is less than 40
			{															// then player 1 has won the game
				g1++;
				lcd_write_string("00-00");
				game_update();
				game_done = 1;
			}
			
			else if(p2 == 4 && p1<=2)					// If player 2 has won a point after his score being 40 and score of player 1 is less than 40
			{															// then player 2 has won the game					
				g2++;
				lcd_write_string("00-00");
				game_update();
				game_done = 1;
			}
			
			else													// Deuce Cases
			{
				if(p1>p2)										// Player 1 leads in the score
				{
					if( p1 - p2 == 1)					// Player 1 has advantage
					{
						lcd_write_string("Ad-40");
					}
					if( p1 - p2 == 2)					// Player 1 wins if the margin is 2
					{
						g1++;
						lcd_write_string("00-00");
						game_update();
						game_done = 1;						
					}
				}
				else if(p2>p1)								// Player 2 leads the score
				{
					if( p2 - p1 == 1)						// Player 2 has advantage
					{
						lcd_write_string("40-Ad");
					}
					if( p2 - p1 == 2)						// Player 2 wins if the margin is 2 
					{
						g2++;
						lcd_write_string("00-00");
						game_update();
						game_done = 1;						
					}
				}
				else													// if p1 == p2,  the deuce stays
				{
					lcd_write_string("40-40");
				}
				
			}
			
			
		}
		
		else															// Dislaying scores of player 1 and 2 on LCD when there are no edge cases
		{
			if(p1 == 0)
			{
				lcd_write_string("00");
			}
			if(p1 == 1)
			{
				lcd_write_string("15");
			}
			if(p1 == 2)
			{
				lcd_write_string("30");
			}
			if(p1 == 3)
			{
				lcd_write_string("40");
			}
			
			lcd_cmd(0xC9);
			lcd_write_string("-");
			lcd_cmd(0xCA);
			if(p2 == 0)
			{
				lcd_write_string("00");
			}
			if(p2 == 1)
			{
				lcd_write_string("15");
			}
			if(p2 == 2)
			{
				lcd_write_string("30");
			}
			if(p2 == 3)
			{
				lcd_write_string("40");
			}			
		}	
	
	return game_done;
}

void set_update()																// Updating the set when there is no tie-breaker
{
			if(g1 >=6 || g2>=6)
				{
					if( (g1==6 && g2<=4) || (g1 == 7))		
					{
						g1 = 0;
						g2 = 0;
						s1++;
					}
					
					if((g2==6 && g1<=4) ||(g2 == 7))
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
						game_update();											// If there is no update on number of sets won, just update the game score on the LCD
					}
										
					if(g1 == 6 && g2 == 6)
					{
						setbreaker();
					}				
				}	
}

void setbreaker()													// The tie-breaker case is handled separately as the points are incremented as whole numbers 
{																				  // unlike the usual case
	bit done = 0;		
	unsigned char ch=0;
	unsigned char scores[5];
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
							
				default:transmit_string("Incorrect test. Pass correct number\r\n");
						 break;
				
			}
			
			sprintf(scores,"%02d-%02d",p1,p2);
			
			lcd_cmd(0xC7);
			lcd_write_string(scores);
			
			if(p1>=7 || p2>=7)										// Check if score of any player is more than 7
			{
				if(p1> p2)
				{
					if(p1 - p2 >=2)										// If player 1 wins by a margin of 2 and has more than 7 points, he wins 
					{
						done = 1;
						g1++;
						game_update();
					}
				}
				
				if(p2> p1)													// If player 2 wins by a margin of 2 and has more than 7 points, he wins
				{
					if(p2 - p1 >=2)
					{
						done = 1;
						g2++;
						game_update();
					}
				}	
			}
	}
	
	p1 = 0;																	//Update points after the tie-breaker is finished
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

	
	while(1) 																	// A new Tennis Match Starts
	{
		
		initialise_score();											// initialise the scores
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
		
		while(s1<2 && s2<2)											// While none of the player has won any match
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
					
				game	= score_update();						// Update the score on LCD
				if(game == 1)											// If a game has been completed then  
				{
					p1 = 0;
					p2 = 0;				
					set_update();										// Check if a set is completed and update the game points on the LCD
				}
		}
		msdelay(5000);												// After completing the match display the result for 5 seconds
	}
}
