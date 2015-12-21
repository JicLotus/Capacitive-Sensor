/*
*
*	Contador/Timer
*
*
*/


Timer_Initialize:
	push r16
	
	//Com1A = Toggle
	//Toggle OC1A/OC1B on Compare Match.
	ldi r16,1<<COM1A0
	sts TCCR1A,r16

	//OCR1A
	//Con valor tope FFFF
	//
	ldi r16,high(0xFFFF)
	sts OCR1AH,r16

	ldi r16,low(0xFFFF)
	sts OCR1AL,r16

	pop r16


Timer_Start:
	push r16

	// WGM= Toggle, Mode=ctc => no prescaler
	ldi r16, 1<<WGM12 | 1<<CS10
	sts TCCR1B,r16

	//Limpiamos el contador del timer
	clr r16
	sts TCNT1H,r16
	sts TCNT1L,r16

	pop r16

	ret


Timer_Stop:
	push r16

	ldi r16,(1<<CS12)|(1<<CS11)|(1<<CS10)
	sts TCCR1B,r16

	pop r16

	ret
