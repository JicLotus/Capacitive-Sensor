/*
 * PWM: Utiliza el timer para producir una cuadrada con ancho de pulso 
 *		variable.
 *
 */

PWM_setup:
	push r20

	/**********CONFIGURO FAST PWM*********/
	sbi DDRD,PIND5							//pwm sale por el pin D.6
	//configuro TCCR0A
	ori r20, (0<<COM0A1)|(0<<COM0A0)		
	ori r20, (1<<COM0B1)|(1<<COM0B0)
	ori r20, (1<<WGM01)|(1<<WGM00)
	out TCCR0A, r20
	//configuro TCCR0B
	clr r20
	ori r20, (0<<FOC0A)|(0<<FOC0B)
	ori r20, (0<<WGM02) 					//no estoy seguri si va 0 o 1
	ori r20, (0<<CS02)|(0<<CS01)|(1<<CS00)
	out TCCR0B, r20
	//configuro el valor de comparacion
	ldi r20, 0
	out OCR0B, r20

	pop r20
ret


PWM_aumentar_intencidad:
	push r20
	push r21
	
	in r20, OCR0B
//	mov PuertoSerie, r20			
//	rcall PuertoSerie_transmit		//transmito ese dato por puerto serie

	cpi r20, 250
	breq fin_aumentar_intencidad
//	sbi DDRD,PIND5
	ldi r21, incremento_pwm
	add r20, r21
	out OCR0B, r20	
	fin_aumentar_intencidad:
	
	pop r21
	pop r20
ret



PWM_disminuir_intencidad:
	push r20
	push r21
	
	in r20, OCR0B
//	mov PuertoSerie, r20			
//	rcall PuertoSerie_transmit		//transmito ese dato por puerto serie

	cpi r20,0
	breq fin_disminuir_intencidad
	ldi r21, decremento_pwm
	sub r20, r21
	out OCR0B, r20
	rjmp fin_2	
	fin_disminuir_intencidad:
//	cbi DDRD,PIND5
	fin_2:
	pop r21
	pop r20
ret
