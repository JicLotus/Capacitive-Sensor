/*
 * Temporizador/Contador1 (16-bit)
 *
 *
 *
 *
 *
 */

 //
 // Configura el Timer1
 //
 // - void Timer1_Initialize(void)
 //
 Timer1_Initialize: // MEMORY MAPPED CHECKED

		push r16		

		// Normal port operation, OC1A/OC1B pins disconnected
		// Clear Timer on Compare match (CTC) mode. Internal Input		
		lds r16,TCCR1A
		cbr r16,(1<<COM1A1)|(1<<COM1A0)|(1<<COM1B1)|(1<<COM1B0)|(1<<WGM11)|(1<<WGM10)	
		sts TCCR1A,r16

		// Sin filtro de ruido, ya que se usa la interrupción interna. Rising Edge.
		lds r16,TCCR1B
		sbr r16,(1<<WGM13)|(1<<WGM12)|(1<<ICES1)
		cbr r16,(1<<ICNC1)
		sts TCCR1B,r16

		// Disparado por el Comparador.
	/*	lds r16,TIMSK1
		sbr r16,(1<<ICIE1)
		sts TIMSK1,r16
	*/	
		// TOP en $FFFF
		ser r16
		sts OCR1AH,r16
		sts OCR1AL,r16
		sts OCR1BH,r16
		sts OCR1BL,r16

		pop	r16	

 		ret

//
// Inicia el Timer1 y habilita el clock del Timer1.
//
// - void Timer1_Start(void)
//
Timer1_Start: // MEMORY MAPPED CHECKED

		push r16

		// Habilita el clock para el Timer1
		lds r16,PRR
		cbr r16,(1<<PRTIM1)
		sts PRR,r16

		sei
		
		// Prescalar en x1.
		lds r16,TCCR1B
		cbr r16,(1<<CS12)|(1<<CS11)
		sbr r16,(1<<CS10)
		sts TCCR1B,r16

		pop r16

		ret

//
// Detiene y deshabilita el clock del Timer1.
//
// - void Timer1_Stop(void)
//
Timer1_Stop:

		push r16

		// No clock source.
		lds r16,TCCR1B
		cbr r16,(1<<CS12)|(1<<CS11)|(1<<CS10)
		sts TCCR1B,r16		  

		// Deshabilita el clock para el Timer1
		lds r16,PRR
		sbr r16,(1<<PRTIM1)
		sts PRR,r16

	    // Deshabilita la interrupción del Timer1.
		cli

		pop r16

		ret

//
// Timer1 Capture Handler
//
//
TIM1_CAPT:
		push r16
		push r17		

		//Salvo la cantidad de ciclos capturada.
		lds r16,ICR1L
		lds r17,ICR1H

		ldi PuertoSerie,'W'
//		rcall PuertoSerie_Transmit
				
		ldi PuertoSerie,'X'
//		rcall PuertoSerie_Transmit
		
		pop r17
		pop r16

		reti

