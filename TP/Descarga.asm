/*
*
*	Descarga del capacitor
*
*
*/


descarga:
	//cbi PuertoLed3,PinLed3
	rcall estado3			//Descargar capacitor tanque
	rcall delay				//SIN ESTE DELAY NO FUNCIONA!!!

	//SBoton de hi a 0
	cbi PuertoBottom,PinBottom
	sbi SentidoBottom,PinBottom

	//Sslope de Vcc a GND
	cbi PuertoSlope,PinSlope


	////////////////////////////////
	//espero que Ctank vuelva a 0v 
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

	//de 0 a hi Sstop
	cbi SentidoStop,PinStop
	//De hi a 5v PuertoDrive
	rcall setear_puerto_drive
	//sbi PuertoDrive,PinDrive
	rcall setear_sentido_drive
	//sbi SentidoDrive,PinDrive
	
	cbi SentidoSlope,PinSlope

	//sbi PuertoLed3,PinLed3


	ret
