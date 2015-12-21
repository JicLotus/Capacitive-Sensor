.include <m88def.inc>


main:
	sbi DDRC,3
	cbi PORTC,3

	eor r19,r19		//reset registro 19
	rcall delay
	sbi PORTC,3
	eor r19,r19
	rcall delay

	rjmp main



delay:
	inc r19				//1 ciclo


///////////////////////////
	eor r18,r18			//1 ciclo			
delay1024ciclos:
	inc r18				//1 ciclo
	cpi r18,0xff		//1 ciclo     * 256  = 1024
	brlo delay2			//2 ciclos
///////////////////////////

	cpi r19,0xff		//1 ciclo
	brlo delay			//2 ciclos

						//5*256 = 1024 ciclos al final
	ret
