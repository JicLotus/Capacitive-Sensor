/*
 * SensorCapacitor.asm
 *
 * Creado: 18.09.2015
 *
 * Descripcion:                                                                      
 * Microcontrolador: Atmega88PA  
 *
 * Historial:
 *
 * Estructura vacia				18.09.2015 
 *
 *   
 */ 

.include <m88def.inc>

.dseg
.org SRAM_START



.cseg
.org $00

/*
 * Vectores de interrupción.
 */

.include "InterruptVectors.asm"

/*
 * Include Files
 */

.include "SetUp.asm"
.include "Utils.asm"
.include "Comparator.asm"
.include "Timer1.asm"

RESET:
		//Stack Pointer al final de la SRAM
		ldi r16,low(RAMEND)
		out	SPL,r16
		ldi r16,high(RAMEND)
		out SPH,r16	
		
		rcall SetUpPorts
main:		

		cbi PORTC,Q
		
		rcall SerialPort_Initialize
		
		rcall Comparator_Initialize

		rcall Comparator_Enable
		
		//ldi r16,$F1
		//rcall Timer1_Initialize

		//rcall Timer1_Start



		// DEBUG interrupción set ACI a mano.
		
		//++++++++++++++++++++++


		rjmp main
