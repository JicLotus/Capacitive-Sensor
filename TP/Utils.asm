/*
 * Utils.asm
 *
 *  Created: 03.09.2015 00:41:17
 *   Author: Sebas and JicLotus
 */ 

 /*
  * Retardo fijo.
  * 
  * Locals variables: i = r16, j = r17
  */

delay:
	push r16
	push r17
	push r18
	clr r16
delay1:
	inc r16			//1 ciclo
	clr r17			 //1 ciclo			
delay2:
	clr r18			// 1 ciclo

	delay3:
		inc r18			//1 ciclo		
		cpi r18,0x00	//1 ciclo
		brlo delay3		//2 ciclos

	inc r17				 //1 ciclo
	cpi r17,0x50 		 //1 ciclo    
	brlo delay2			 ///2 ciclos

	cpi r16,0xff		//1 ciclo
	brlo delay1			//2 ciclos


	pop r18
	pop r17
	pop r16			
	ret



mini_delay:
	push r16
	push r17					
	ldi r17, 5				
	loop_delay1:	ldi r16, 5	//ldi == 1 ciclo de ck
	loop_delay2:
	dec r16						//Dec == 1 ciclo de ck
	brne loop_delay2			//brne ==1/2 ciclo de ck
	dec r17						//Dec == 1 ciclo de ck
	brne loop_delay1			//brne ==1/2 ciclo de ck
	pop r17
	pop r16
	ret
