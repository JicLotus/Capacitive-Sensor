/*
 * Comparador analógico:
 *
 * AIN0 -> PIN12 (+)
 * AIN1 -> PIN13 (-)
 *
 * '1' si + > -
 * '0' si - < +
 * ACO: Comparator output
 * 
 */

//
// Configura el comparador en modo no multiplexado.
//
// - void Comparator_Initialize(void)
//
Comparator_Initialize:
		push r16
		//Selecciona AIN1 para comparar como entrada (-). [Memory mapped]
		lds r16,ADCSRB
		cbr r16,(1<<ACME)
		sts ADCSRB,r16

		//Deshabilita ADC. [Memory mapped]
		lds r16,ADCSRA
		cbr r16,(1<<ADEN)
		sts ADCSRA,r16

		//Selecciona AIN0 para comparar como entrada (+).
		//Modo interrupción flanco-asc ADO
		//Interrupción habilitada.
		// Habilita la conexión con el front-end del Timer1.		
		in r16,ACSR
		sbr r16,(1<<ACIS1)|(1<<ACIS0)|(1<<ACIE)|(1<<ACIC)
		cbr r16,(1<<ACBG)
		out ACSR,r16

		//Deshabilita la entrada digital de AIN0/1
		lds r16,DIDR1
		sbr r16,(1<<AIN1D)|(1<<AIN0D)
		sts DIDR1,r16		

		pop r16
		ret
//
// Habilita el comparador.
//
// - void Comparator_Enable(void)
//
Comparator_Enable:
		push r16
		in r16,ACSR
		cbr r16,(1<<ACD)
		out ACSR,r16
		sei
		pop r16
		ret
//
// Deshabilita el comparador.
//
// - void Comparator_Disable(void)
//
Comparator_Disable:
		push r16
		in r16,ACSR
		sbr r16,(1<<ACD)
		out ACSR,r16
		cli
		pop r16
		ret


//
// Handler del comparador
//
ANA_COMP:
		
	rcall Comparator_Disable		//deshabilito el comparador			
	rcall Timer_Stop				//freno el timer
	rcall Analisis_Tactil

	reti
