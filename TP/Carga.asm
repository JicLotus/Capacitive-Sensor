/*
*
*	Carga del capacitor
*
*
*/



carga:

	push CiclosDeCarga

	clr CiclosDeCarga

Estado1YEstado2:
	//cbi PuertoLed1,PinLed1
	rcall estado1
	//sbi PuertoLed1,PinLed1

	//cbi PuertoLed2,PinLed2
	rcall estado2		//En la rutina estado 3 estaria el punto 3 del pdf
	//sbi PuertoLed2,PinLed2
	
	inc CiclosDeCarga
	cpi CiclosDeCarga, iteraciones_carga

	brlo Estado1YEstado2

	pop CiclosDeCarga


	ret
