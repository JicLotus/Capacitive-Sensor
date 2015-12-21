Analisis_Tactil:

	push r24
	push r25
	push r26
	push r27
	push r28
	push r29

//	lds r27,ICR1L					//cargo en r27 los ciclos de maquina que demoro descargar el capacitor
 //	lds r24 ICR1H
	lds r27, TCNT1L
	lds r24, TCNT1H


	mov PuertoSerie, r27			
//	rcall PuertoSerie_transmit		//transmito ese dato por puerto serie
		
	cpi PinDrive, pinDrive_cap1
	breq cap_1						//si PinDrive=2 => salto a cap_1 sino sigo con cap_2
	
	cap_2:
//	rcall PuertoSerie_transmit
	rcall calibrar_cap2				//esta rutina prende led izquierdo
	lds r28, Estado_Actual_Cap2				//leo el estado actual
	andi r28, 0x01				//me quedo con el estado exactamente anterior
	breq cap2_esta_en_bajo	
	cap2_esta_en_alto:
		lds r26, dir_ciclos_referencia_cap2
		cp r27, r26
		brlo output_low_bajada_cap2
		cbi PuertoLed2,PinLed2
		rcall guardar_estado_alto_cap2
		rjmp continue
	output_low_bajada_cap2:
		sbi PuertoLed2,PinLed2
		rcall guardar_estado_bajo_cap2
		rjmp continue
	cap2_esta_en_bajo:
		lds r26, dir_ciclos_referencia_cap2
		ldi r25, margen_ruido_cap2
		add r26, r25
		cp r27, r26
		brlo output_low_subida_cap2
		cbi PuertoLed2,PinLed2
		rcall guardar_estado_alto_cap2
		rjmp continue
	output_low_subida_cap2:
		sbi PuertoLed2,PinLed2
		rcall guardar_estado_bajo_cap2
		rjmp continue
	



	cap_1:	//se ve el comportamiento en el led1
//	rcall PuertoSerie_transmit
	rcall calibrar_cap1
	lds r28, Estado_Actual_Cap1				//leo el estado actual
	andi r28, 0x01				//me quedo con el estado exactamente anterior
	breq cap1_esta_en_bajo	
	cap1_esta_en_alto:	
		lds r26, dir_ciclos_referencia_cap1
		cp r27, r26
		brlo output_low_bajada
		cbi PuertoLed1,PinLed1
		rcall guardar_estado_alto_cap1
		rjmp continue
		output_low_bajada:
		sbi PuertoLed1,PinLed1
		rcall guardar_estado_bajo_cap1
		rjmp continue
	cap1_esta_en_bajo:
		lds r26, dir_ciclos_referencia_cap1
		ldi r25, margen_ruido_cap1
		add r26, r25
		cp r27, r26
		brlo output_low_subida
		cbi PuertoLed1,PinLed1
		rcall guardar_estado_alto_cap1
		rjmp continue
		output_low_subida:
		sbi PuertoLed1,PinLed1
		rcall guardar_estado_bajo_cap1


	continue:
	rcall analizar_sensor_en_reposo
	rcall analizar_movimiento_encendido
	rcall analizar_movimiento_apagado
	
	
	pop r29
	pop r28
	pop r27	
	pop r26
	pop r25
	pop r24

ret
