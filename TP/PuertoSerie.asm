.include <m88def.inc>


PuertoSerie_initialize:
	push r17
	push r16



	ldi r17,0
	// (12 000 000 / 9600*16)  -1 = 77,125 -> tiene error de 0,125  menos del 0,1 % de error
	ldi r16,77

	//Set baud rate
	sts UBRR0H, r17
	sts UBRR0L, r16


	//Enable receiver and transmitter
	ldi r16, (1<<RXEN0)|(1<<TXEN0)
	sts UCSR0B,r16
	//Set frame format: 8data, 1 stop bit
	ldi r16, (0<<USBS0)|(3<<UCSZ00)
	sts UCSR0C,r16

	pop r16
	pop r17

	ret


PuertoSerie_transmit:
	push r16	
	loop_puerto_serie:
	//rcall Delay			//delay para no saturar el buffer con datos
	rcall Delay
	//Wait for empty transmit buffer
	lds r16, UCSR0A
	sbrs r16, UDRE0 //Testeamos el bit udre0 del registro ucsr0a
	rjmp loop_puerto_serie

	//Put data (r25) into buffer, sends the data
	sts UDR0,PuertoSerie
	//rcall Delay			//delay para no saturar el buffer con datos
	rcall Delay
	pop r16

	ret
