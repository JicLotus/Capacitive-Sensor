/*
 * SensorCapacitor
 *
 * Creado: 18.09.2015
 *
 * Descripcion:                                                                      
 * Microcontrolador: Atmega88PA  
 *
 */ 

.include <m88def.inc>

.dseg
.org SRAM_START

/***************************/
/*****Variables Fisicas*****/
Estado_Anterior_Cap1: .BYTE 1
Estado_Actual_Cap1: .BYTE 1
Estado_Anterior_Cap2: .BYTE 1
Estado_Actual_Cap2: .BYTE 1
Flags_Estado: .BYTE 1
/***************************/

.cseg
.org 0x00

// Vectores de interrupción.
.include "InterruptVectors.asm"

// Include Files
.include "Definitions.asm"
.include "Carga.asm"
.include "Descarga.asm"
.include "SetUp.asm" 
.include "Estados.asm"
.include "Utils.asm"
.include "Comparator.asm"
.include "AnalisisTactil.asm"
.include "FuncionesTactiles.asm"
.include "PuertoSerie.asm"
.include "Timer1.asm"
.include "Timer.asm"
.include "pwm.asm"
.include "DriveTransitions.asm"


RESET:

	ldi r16, low(RAMEND)
	out spl, r16
	ldi r16, high(RAMEND)
	out sph, r16
	
	rcall initial_setup
	

CargaYDescarga:

	

	ldi PinDrive, pinDrive_cap1
	rcall carga	
	rcall descarga
	


	ldi PinDrive, pinDrive_cap2
	rcall carga	
	rcall descarga



	rjmp CargaYDescarga




