/*
* Definición especial de pines.
*
* 
*/

SetUpPorts:
		push r16

		ldi r16,(1<<Q)
		out DDRC,r16		

		pop r16

 		ret

initial_setup:
	push r16	
	
	ldi r16, ciclos_calibrado			//guardo en ram ciclos de calibrado
	sts dir_ciclos_calibrado, r16
	
	ldi r16, margen_ruido_cap1			//guardo en ram los margenes de ruido
	sts dir_margen_ruido_cap1, r16

	ldi r16, margen_ruido_cap2
	sts dir_margen_ruido_cap2, r16

	sbi ddrb,1

	rcall descargar_capacitores	

	//configuramos fast pwm
	rcall PWM_setup

	//Configuramos el comparador con interrupcion
	rcall Comparator_Initialize
	///////////////////////

	//Configuramos el puerto Serie
	rcall PuertoSerie_initialize
	///////////////////////
	
	//Configuramos Timer
	rcall Timer_Initialize
	/////////////////////////


	in r16, MCUCR		;deshabilito todos los Pull-up
	ori r16,(1<<PUD)
	out MCUCR,r16
	
	//Configuracion Leds
	sbi SentidoLed1,PinLed1			
	sbi PuertoLed1,PinLed1
	sbi SentidoLed2,PinLed2
	sbi SentidoLed3,PinLed3
	
	sbi PuertoLed2,PinLed2
	sbi PuertoLed3,PinLed3


	//Como salida
	rcall setear_sentido_drive
//	sbi SentidoDrive,PinDrive		

	//Como entrada
	cbi SentidoStop,PinStop		
	cbi SentidoBottom,PinBottom	
	cbi SentidoSlope,PinSlope
	
	//En alta impedancia
	rcall limpiar_puerto_drive
	//cbi PuertoDrive,PinDrive		
	cbi PuertoStop,PinStop
	cbi PuertoBottom,PinBottom
	cbi PuertoSlope,PinSlope


	pop r16

	ret


calibrar_cap2:
	push r16
	push r17


	ldi r16, calibrado_manual_habilitado
	cpi r16, 1
	breq calibrado_manual_cap2


	ldi r17,correccion_referencia //correcion ciclos referencia
	lds r16, dir_ciclos_calibrado
	cpi r16, 1
	breq fin_calibrado
	cbi PuertoLed1,PinLed1
	dec r16
	sts dir_ciclos_calibrado, r16
	lds r16, dir_ciclos_referencia_cap2
	add r16, r17
	cp r16, r27
	brlo reemplazar_referencia
	rjmp fin_calibrado
	reemplazar_referencia:
	mov r16, r27
	sub r16, r17
	sts dir_ciclos_referencia_cap2, r16
	fin_calibrado:
	lds r16, dir_ciclos_referencia_cap2
//	mov PuertoSerie, r16			
//	rcall PuertoSerie_transmit
	rjmp fin_calibrado_cap2

	calibrado_manual_cap2:
	ldi r16, ciclos_referencia_cap2
	sts dir_ciclos_referencia_cap2, r16
	fin_calibrado_cap2:
	pop r17
	pop r16
ret

calibrar_cap1:
	push r16
	push r17

	ldi r16, calibrado_manual_habilitado
	cpi r16, 1
	breq calibrado_manual_cap1

	lds r16, dir_ciclos_calibrado
	cpi r16, 1
	breq fin_calibrado_cap1
	dec r16
	sts dir_ciclos_calibrado, r16
	lds r16, dir_ciclos_referencia_cap1
	cp r16, r27
	sbi PuertoLed1,PinLed1
	brlo reemplazar_referencia_cap1
	rjmp fin_calibrado_cap1
	reemplazar_referencia_cap1:
	sts dir_ciclos_referencia_cap1, r27
	fin_calibrado_cap1:
	lds r16, dir_ciclos_referencia_cap1
//	mov PuertoSerie, r16			
//	rcall PuertoSerie_transmit
	rjmp calibrado_finalizado_cap1


calibrado_manual_cap1:
	ldi r16, ciclos_referencia_cap1
	sts dir_ciclos_referencia_cap1, r16
calibrado_finalizado_cap1:
	pop r17
	pop r16
ret



descargar_capacitores:
	sbi SentidoBottom, PinBottom
	cbi PuertoBottom, PinBottom
	
	sbi SentidoStop, PinStop
	cbi PuertoStop, PinStop

	ldi PinDrive,pinDrive_cap1
	rcall setear_sentido_drive
	rcall limpiar_puerto_drive


	ldi PinDrive,pinDrive_cap2
	rcall setear_sentido_drive
	rcall limpiar_puerto_drive
/*	
	sbi SentidoSlope, PinSlope
	cbi PuertoSlope, PinSlope

	sbi DDRD,6
	cbi PORTD,6
*/
	rcall Delay
	rcall Delay
	rcall Delay
	rcall Delay
	rcall Delay
	rcall Delay
ret





