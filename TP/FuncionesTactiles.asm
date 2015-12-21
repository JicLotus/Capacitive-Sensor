//en Estado_Actual_Cap1 guardo estado actual del cap_1 en 300 el anterior
//en Estado_Actual_Cap2 guardo estado actual del cap_2 en 302 el anterior
//en Flags_Estado guardo los flags
guardar_estado_bajo_cap1:
	push r16					
	lds r16, Estado_Actual_Cap1				//cargo el ultimo estado del cap_1	
	sts Estado_Anterior_Cap1, r16				//lo guardo como estado anterior
	lsl r16						//creo el estado actual
	sts Estado_Actual_Cap1, r16				//guardo el estado actual en memoria
	pop r16
ret


guardar_estado_alto_cap1:			
	push r16
	lds r16, Estado_Actual_Cap1				//cargo el ultimo estado del cap_1	
	sts Estado_Anterior_Cap1, r16				//lo guardo como estado anterior
	lsl r16						//creo el estado actual
	inc r16						
	sts Estado_Actual_Cap1, r16				//guardo la nueva informacion en memoria
	
	pop r16
ret


guardar_estado_bajo_cap2:
	push r16					
	lds r16, Estado_Actual_Cap2				//cargo los ultimos estados del cap_2	
	sts Estado_Anterior_Cap2, r16
	lsl r16						//descarto el estado mas viejo y guardo el estado bajo actual
	sts Estado_Actual_Cap2, r16				//guardo la nueva informacion en memoria
	pop r16
ret


guardar_estado_alto_cap2:			
	push r16
	lds r16, Estado_Actual_Cap2				//cargo los ultimos estados del cap_2	
	sts Estado_Anterior_Cap2, r16
	lsl r16						//descarto el estado mas viejo y "hago lugar" para uno nuevo
	inc r16						//agrego el estado alto actual
	sts Estado_Actual_Cap2, r16				//guardo la nueva informacion en memoria
	pop r16
ret


analizar_sensor_en_reposo:
	push r17
	push r19
	//cargo estados actuales de cap_1 y cap_2
	lds r17, Estado_Actual_Cap1				
	lds r19, Estado_Actual_Cap2				
	//si los estados actuales son ambos 0x00 => considero estado de reposo
	or r17, r19
	breq sensor_en_reposo
	lds r19, Flags_Estado
	andi r19, FlagReposoBajo
	sts Flags_Estado, r19
	pop r19
	pop r17
	ret
	sensor_en_reposo:
	rcall setear_flags_reposo
	pop r19
	pop r17
ret

setear_flags_reposo:
	push r20
	ldi r20, FlagReposo
	sts Flags_Estado, r20
	pop r20
ret




analizar_movimiento_encendido:
	push r16
	push r17
	
	lds r16, Flags_Estado		//primero que nada miro si estoy encendiendo
	ldi r17, FlagEncendiendo
	and r17, r16
	cpi r17, FlagEncendiendo
	breq encendiendo	//si es asi chequeo el otro capacitor

	andi r16, FlagReposo	//si no hay bit de encendido miro bit de reposo
	brne en_reposo
	rcall fuera_de_reposo_chekEnc	
	pop r17
	pop r16
	ret	
	en_reposo:
	pop r17
	pop r16
	ret
	
	
	encendiendo:
	lds r16, Estado_Anterior_Cap2
	lds r17, Estado_Actual_Cap2
	sub r17, r16
	brmi encender
	pop r17
	pop r16
	ret
	encender:
	//cbi PuertoLed3,PinLed3
	rcall PWM_aumentar_intencidad
	pop r17
	pop r16
ret


fuera_de_reposo_chekEnc:
	push r17
	push r18
	lds r17, Estado_Anterior_Cap1
	lds r18, Estado_Actual_Cap1
	sub r18, r17
	brmi set_flag_encendiendo
	pop r18
	pop r17
	ret	

	set_flag_encendiendo:
	lds r17, Flags_Estado
	ori r17, 0x02 
	sts Flags_Estado, r17
	pop r18
	pop r17
ret


analizar_movimiento_apagado:
	push r16
	push r17
	
	lds r16, Flags_Estado		//primero que nada miro si estoy apagando
	ldi r17, FlagApagando
	and r17, r16
	cpi r17, FlagApagando
	breq apagando	//si es asi chequeo el otro capacitor

	andi r16, 0x01	//si no hay bit de encendido miro bit de reposo
	brne en_reposo2
	rcall fuera_de_reposo_chekap	
	pop r17
	pop r16
	ret	
	en_reposo2:
	pop r17
	pop r16
	ret
	
	
	apagando:
	lds r16, Estado_Anterior_Cap1
	lds r17, Estado_Actual_Cap1
	sub r17, r16
	brmi apagar
	pop r17
	pop r16
	ret
	apagar:
//	sbi PuertoLed3,PinLed3
	rcall PWM_disminuir_intencidad
	pop r17
	pop r16
ret


fuera_de_reposo_chekap:
	push r17
	push r18
	lds r17, Estado_Anterior_Cap2
	lds r18, Estado_Actual_Cap2
	sub r18, r17
	brmi set_flag_apagando
	pop r18
	pop r17
	ret	

	set_flag_apagando:
	lds r17, Flags_Estado
	ori r17, FlagApagando 
	sts Flags_Estado, r17
	pop r18
	pop r17
ret
